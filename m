Message-ID: <3F81CF75.5050802@candelatech.com>
Date: Mon, 06 Oct 2003 13:24:21 -0700
From: Ben Greear <greearb@candelatech.com>
MIME-Version: 1.0
References: <200310062204.07230.bdschuym@pandora.be>
In-Reply-To: <200310062204.07230.bdschuym@pandora.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH/RFC] Let {ip,
 arp}tables "see" bridged VLAN tagged {I, AR}P packets
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: netdev@oss.sgi.com, vlan@wanfear.com, bridge <bridge@osdl.org>, Stephen Hemminger <shemminger@osdl.org>

Bart De Schuymer wrote:
> - add some code in vlan_dev.c::vlan_dev_hard_start_xmit():
> skb->protocol = __constant_htons(ETH_P_8021Q);
> skb->mac.raw -= VLAN_HLEN;
> skb->nh.raw -= VLAN_HLEN;

I wonder if this is what was messing up the tcpdump packet capture
as well?

It would be fine with me if you un-conditionally exported the
vlan hard-start-xmit pointer, but I don't feel strongly either way.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


