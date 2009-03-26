From: Jay Vosburgh <fubar@us.ibm.com>
In-reply-to: <20090325174405.GM3437@psychotron.englab.brq.redhat.com>
References: <20090313183303.GF3436@psychotron.englab.brq.redhat.com>
	<20090325151937.GI3437@psychotron.englab.brq.redhat.com>
	<28445.1237998713@death.nxdomain.ibm.com>
	<20090325174405.GM3437@psychotron.englab.brq.redhat.com>
Date: Wed, 25 Mar 2009 17:34:07 -0700
Message-ID: <8854.1238027647@death.nxdomain.ibm.com>
Subject: Re: [Bridge] [PATCH] bonding: allow bond in mode balance-alb to
	work properly in bridge -try3
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jiri Pirko <jpirko@redhat.com>
Cc: mschmidt@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, bonding-devel@lists.sourceforge.net, jgarzik@pobox.com, dada1@cosmosbay.com, davem@davemloft.net

Jiri Pirko <jpirko@redhat.com> wrote:

>Wed, Mar 25, 2009 at 05:31:53PM CET, fubar@us.ibm.com wrote:
[...]
>>> #if defined(CONFIG_BRIDGE) || defined (CONFIG_BRIDGE_MODULE)
>>> /* These hooks defined here for ATM */
>>> struct net_bridge;
>>>@@ -2251,10 +2258,12 @@ int netif_receive_skb(struct sk_buff *skb)
>>> 	null_or_orig = NULL;
>>> 	orig_dev = skb->dev;
>>> 	if (orig_dev->master) {
>>>-		if (skb_bond_should_drop(skb))
>>>+		if (skb_bond_should_drop(skb)) {
>>> 			null_or_orig = orig_dev; /* deliver only exact match */
>>>-		else
>>>+		} else {
>>> 			skb->dev = orig_dev->master;
>>>+			bond_change_dest_hook(skb);
>>
>>	Since you put the hook outside of the skb_bond_should_drop
>>function, does the VLAN accelerated receive path do the right thing if,
>>e.g., there's a VLAN on top of bonding and that VLAN is part of the
>>bridge?

	Jiri: not trying to be pushy, but you didn't address the above
question about the VLAN path, and I just want to make sure that you saw
it (it was at the bottom of a long email, so I fear you may not have
seen it).

	-J

---
	-Jay Vosburgh, IBM Linux Technology Center, fubar@us.ibm.com
