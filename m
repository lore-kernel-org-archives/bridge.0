Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=g9frEwzbQdtp2pIYSY0lHpkIaw2YK5YeWDtzUeh3LJo=;
 b=YW8ujBQd5Y2ib1rY1s0oCo5I4Gk2J9cvJzhFA7N9/bnCJo3e2mT4VsdllVnZJ7wj3E
 iTzevAY+YxPHERoDhsltnqkqAk1Tdqc8cxZkJtom2Cy/TsJUykIQrAVAh5mdjgdZ5TQ+
 0PEuuCbnaugdhvpcI7n0K4usinvTxVvDgR5slcXDqaxfvfKA1GgYkvtVC2nNrntUlvC4
 0FHoR93hpkjuYyUENEmwIq+34cQvR7rK6tvTF2nWXkgwqrwIQFJbFkT6tWiqTK8hipeB
 Ko33bAOcvssV3ExDRi1mACftgPGIhVpnLTbBRbxj4X4lveSzc1YBE++4gFFPxoIrteAI
 esNw==
Date: Tue, 15 Mar 2022 18:44:41 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220315164441.sz5jyooa3glnym5p@skbuf>
References: <20220315002543.190587-1-tobias@waldekranz.com>
 <20220315002543.190587-13-tobias@waldekranz.com>
 <20220315164249.sjgi6wbdpgehc6m6@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315164249.sjgi6wbdpgehc6m6@skbuf>
Subject: Re: [Bridge] [PATCH v4 net-next 12/15] net: dsa: Handle MST state
	changes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 06:42:49PM +0200, Vladimir Oltean wrote:
> Is there a requirement in br_mst_set_state() to put the switchdev
> notifier at the end instead of at the beginning?
> 
> I'm tempted to ask you to introduce br_mst_get_state(), then assign
> old_state = br_mst_get_state(dsa_port_bridge_dev_get(dp), state->msti),

dsa_port_to_bridge_port(dp), excuse me.

> then perform the VLAN fast age only on the appropriate state transitions,
> just like the regular fast age.
