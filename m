Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=UywVHfIXA8Il15KCHtfEgZv5xfnhEZ34vLyTargXKlk=;
 b=TkeqJE48gZCnOXcVOxTCrulvm2g32F0N95QRYIoHW8IUD1AEDNjNqxLopGWCXJc9vH
 Bs8lRfpcJpieitfTEOJ86r1RIsZqRRaiPMWTTYQougcp2aFv0I0cArcZOK0J+CzoE56M
 aUxSqECi9itQJP1u61fNWMplURkFXuG3W2YIyNPMBVh9aQ4Wbo5b2WYx3k2r+XSEct5e
 Z2SGaeTIxGNX/AdHR7PqPmobVQUolTpkNPpCPC0h8opJGonwl1af9yDM0t54/LaJmz0W
 ty27zSlpkch6V65rdOaEF6cTEjWMpcZ8tKQmkfpq+wtU7ueoxoxB6tHQY28JYNEWpXKW
 1QAg==
Date: Mon, 5 Jul 2021 12:57:27 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210705095727.w7iigb3goaorzef5@skbuf>
References: <20210703115705.1034112-1-vladimir.oltean@nxp.com>
 <20210705042018.137390-1-dqfext@gmail.com>
 <87v95p6u0r.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v95p6u0r.fsf@waldekranz.com>
Subject: Re: [Bridge] [RFC PATCH v2 net-next 00/10] Allow forwarding for the
 software bridge data path to be offloaded to capable devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Ido Schimmel <idosch@idosch.org>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Alexander Duyck <alexander.duyck@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>, DENG Qingfang <dqfext@gmail.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Mon, Jul 05, 2021 at 10:32:04AM +0200, Tobias Waldekranz wrote:
> > Many DSA taggers use port bit field in their TX tags, which allows
> > replication in hardware. (multiple bits set = send to multiple ports)
> > I wonder if the tagger API can be updated to support this.
>
> I think you could, but it would be tricky.
>
> The bridge does not operate using vectors/bitfields, rather it is
> procedural code that you have to loop through before knowing the set of
> destination ports.
>
> This series just sends the skb to the first port in the hardware domain
> and trusts the HW to calculate the same port set as the code in
> br_forward.c would have.
>
> To do what you suggest, the bridge would have to translate each nbp into
> a position in a bitfield (or call out to the underlying driver to do it)
> as it is looping through ports, then send the aggregated mask along with
> the skb. Knowing if a port is the first one you have come across for a
> given domain is very easy (just maintain a bitfield), knowing if it is
> the last one is harder. So you would likely end up having to queue up
> the actual transmission until after the loop has been executed, which
> hard to combine with the "lazy cloning" that you really want to get
> decent performance.

In addition to changing the bridge in order to get the entire bit mask,
one also has to somehow propagate that bit mask per skb down to the
driver which might be tricky in itself. There is currently no bridge
specific data structure passed between the bridge and the switchdev
driver, it is just the struct net_device *sb_dev. A hacky solution I
might imagine is for the bridge to kzalloc() a small data structure
like:

struct bridge_fwd_offload_accel_priv {
	struct net_device *sb_dev; /* Must be first! */
	unsigned long port_mask;
};

and call as follows:

int br_dev_queue_push_xmit(struct net *net, struct sock *sk, struct sk_buff *skb)
{
	struct bridge_fwd_offload_accel_priv *accel_priv = NULL;

	if (br_switchdev_accels_skb(skb)) {
		accel_priv = kzalloc(sizeof(*accel_priv), GFP_ATOMIC);
		if (!accel_priv)
			return -ENOMEM;

		accel_priv->sb_dev = BR_INPUT_SKB_CB(skb)->brdev;
		accel_priv->port_mask = port_mask;
	}

	dev_queue_xmit_accel(skb, accel_priv);
}

This way, the code in net/core/dev.c can be left unmodified. We give it
an accel_priv pointer but it can think it is only looking at a sb_dev
pointer, since that is the first element in the structure.

But then the switchdev driver must kfree(accel_priv) in the xmit function.

Not really nice, but for a cuter solution, I think we would need to extend struct sk_buff.
