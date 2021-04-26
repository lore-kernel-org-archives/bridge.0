Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Is2SDw8WeN8XVXoywR6GIkJzDlR3VcflqryG4qw9d8I=;
 b=ueRq8J2oOg2cDQawuLIidmcLpsWVOn320XQbHevQDQFX1pqUMprNUFGbR23FVS3nTE
 Uc4qQs2befSyroRSuplHhB0omOiXVJCP1fvYP3UaoyaijKoG7KYyLRyaGdvzALeELsZK
 GfTbZnHlX8cgz3L9NpiaFj0cJmzb7zeWSfA331y50C6TPL401IUVkivlNKAloSjkAvxd
 zhU1D6vM9q5MQ/1JzQ0+2HVlenqXYpZCflgkCeda7NOqkyaprjlQJL/O/YrYeUteHMKr
 0jI6+q1Uq+ZQAQgeDj+ER/xsnHtcnTEAiddGXRpldDhA27/dOoQ6eKh2Wu/xE7Uh/WhR
 L+2A==
Date: Mon, 26 Apr 2021 22:40:26 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210426194026.3sr22rqyf2srrwtq@skbuf>
References: <20210426170411.1789186-1-tobias@waldekranz.com>
 <20210426170411.1789186-6-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426170411.1789186-6-tobias@waldekranz.com>
Subject: Re: [Bridge] [RFC net-next 5/9] net: dsa: Track port PVIDs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, idosch@idosch.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hi Tobias,

On Mon, Apr 26, 2021 at 07:04:07PM +0200, Tobias Waldekranz wrote:
> In some scenarios a tagger must know which VLAN to assign to a packet,
> even if the packet is set to egress untagged. Since the VLAN
> information in the skb will be removed by the bridge in this case,
> track each port's PVID such that the VID of an outgoing frame can
> always be determined.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---

Let me give you this real-life example:

#!/bin/bash

ip link add br0 type bridge vlan_filtering 1
for eth in eth0 eth1 swp2 swp3 swp4 swp5; do
	ip link set $eth up
	ip link set $eth master br0
done
ip link set br0 up

bridge vlan add dev eth0 vid 100 pvid untagged
bridge vlan del dev swp2 vid 1
bridge vlan del dev swp3 vid 1
bridge vlan add dev swp2 vid 100
bridge vlan add dev swp3 vid 100 untagged

reproducible on the NXP LS1021A-TSN board.
The bridge receives an untagged packet on eth0 and floods it.
It should reach swp2 and swp3, and be tagged on swp2, and untagged on
swp3 respectively.

With your idea of sending untagged frames towards the port's pvid,
wouldn't we be leaking this packet to VLAN 1, therefore towards ports
swp4 and swp5, and the real destination ports would not get this packet?
