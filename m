Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=CorYWTYS+AZSVl2A6eCbkMb9gbO0BA3m9gMbqC/pL4k=;
 b=kpdTDoEnwi54KR6A65rYlFI4JLgphFiQMz8WR15BXIM8F/Jz5Frc/Hnk77CxAUCi+W
 Pt1Z1xWy/Od95f4IINaC8d2nHz8GemWFzxFuO5uHqGUsM/W8ejBJzJbHcWJGSFBwADo2
 IfRZnaq0YL37YWhWrcUt+fEqa/D5+BMDNP8oNDY5y2TQR/w3VqheUPwvRlNQFMlDr6k8
 kl+aqtQ7SpuoQRiQXlejWIQNjMIcIAmA8OQugmLCvrNsIXv9WFuYQPyz4ecB5ISTsHBZ
 oJw+dA+Wo4O86rO7/WV8vPdaCacvmwwNtTidTHKM8XZ+X7zNLcUi3x3DlWqGiXdrexnW
 wqcA==
Date: Mon, 19 Jul 2021 10:41:48 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210719074148.xlm7syfm76fuzsxy@skbuf>
References: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
 <20210718214434.3938850-16-vladimir.oltean@nxp.com>
 <7c2b81e8-db72-4665-fe81-7254cba1e797@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c2b81e8-db72-4665-fe81-7254cba1e797@gmail.com>
Subject: Re: [Bridge] [PATCH v4 net-next 15/15] net: dsa: tag_dsa: offload
 the bridge forwarding process
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, bridge@lists.linux-foundation.org, Jiri Pirko <jiri@resnulli.us>, DENG Qingfang <dqfext@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Ido Schimmel <idosch@idosch.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Marek Behun <kabel@blackhole.sk>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

On Sun, Jul 18, 2021 at 07:47:22PM -0700, Florian Fainelli wrote:
> On 7/18/2021 2:44 PM, Vladimir Oltean wrote:
> > From: Tobias Waldekranz <tobias@waldekranz.com>
> >
> > Allow the DSA tagger to generate FORWARD frames for offloaded skbs
> > sent from a bridge that we offload, allowing the switch to handle any
> > frame replication that may be required. This also means that source
> > address learning takes place on packets sent from the CPU, meaning
> > that return traffic no longer needs to be flooded as unknown unicast.
> >
> > Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>
> This looks pretty complicated to but if this is how it has to work, it has
> to. For tag_brcm.c we can simply indicate that the frame to be transmitted
> should have a specific bitmask of egress ports.

Complicated in the sense that we need to nail the VLAN ID so that
the FDB / MDB is looked up correctly by the accelerator, to ensure that
it produces a result that is in sync with the software tables?

What you are proposing is not really TX forwarding offload but TX
replication offload. A CPU-injected packet targeting multiple egress
ports is still a control plane packet nonetheless, with all features
that characterize one:
- Ingress stage of the CPU port is bypassed (no hardware address
  learning for that MAC SA)
- FDB lookup is bypassed (we trust the software). This is also perhaps
  an advantage, because for example, if we have a MAC address learned
  towards the CPU port, and then we inject a packet from the CPU towards
  that destination MAC address, then a data plane packet would be
  dropped due to source port pruning (source == destination port), but a
  control plane packet would be sent regardless.
- Can inject into a BLOCKING egress port (we trust the software not to
  do that)

Whereas this patch set is really about laying the ground for data plane
packets to be safely created and sent by the network stack. There are
switches which have a clear distinction between the control plane and
the data plane, and injecting a control packet is a fairly expensive
operation. So it would be very good to support this operating mode,
regardless of whatever else we do.

I can look into adding support for your use case with just the
replication offload, since it should be possible nonetheless, and if you
really don't have the option to send a data plane packet then it is a
valid approach too, however I believe that the brick wall will be where
to encode the destination bit mask in the egress skb. For the full TX
forwarding offload we managed to dodge that because we already had
skb->offload_fwd_mark, but that's just one bit and we would need more.
I'm thinking we would need to add another bit (skb->offload_tx_replication)
and then add a struct list_head tx_dev to the skb which contains all the
net devices that the packet was not cloned to?
