Date: Thu, 26 Mar 2009 12:12:14 +0100
From: Jiri Pirko <jpirko@redhat.com>
Message-ID: <20090326111213.GA3471@psychotron.englab.brq.redhat.com>
References: <20090313183303.GF3436@psychotron.englab.brq.redhat.com>
	<20090325151937.GI3437@psychotron.englab.brq.redhat.com>
	<28445.1237998713@death.nxdomain.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28445.1237998713@death.nxdomain.ibm.com>
Subject: Re: [Bridge] [PATCH] bonding: allow bond in mode balance-alb to
	work	properly in bridge -try3
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jay Vosburgh <fubar@us.ibm.com>
Cc: mschmidt@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, bonding-devel@lists.sourceforge.net, jgarzik@pobox.com, dada1@cosmosbay.com, davem@davemloft.net

Wed, Mar 25, 2009 at 05:31:53PM CET, fubar@us.ibm.com wrote:
>>@@ -2251,10 +2258,12 @@ int netif_receive_skb(struct sk_buff *skb)
>> 	null_or_orig = NULL;
>> 	orig_dev = skb->dev;
>> 	if (orig_dev->master) {
>>-		if (skb_bond_should_drop(skb))
>>+		if (skb_bond_should_drop(skb)) {
>> 			null_or_orig = orig_dev; /* deliver only exact match */
>>-		else
>>+		} else {
>> 			skb->dev = orig_dev->master;
>>+			bond_change_dest_hook(skb);
>
>	Since you put the hook outside of the skb_bond_should_drop
>function, does the VLAN accelerated receive path do the right thing if,
>e.g., there's a VLAN on top of bonding and that VLAN is part of the
>bridge?

Don't worry :) I did not forget about this - just needed a bit time to
investigate...

Yeah, this look's like a problem. In __vlan_hwaccel_rx there is following line:
	skb->dev = vlan_group_get_device(grp, vlan_tci & VLAN_VID_MASK);
This rewrites the dev so latter on when netif_receive_skb is called the hook
will be not called (because dev->master will not be set).

Ok I will put the hook inside the skb_bond_should_drop() - it seems like a
correct solution...

Thanks for pointing this out.
>
>	-J
>
>---
>	-Jay Vosburgh, IBM Linux Technology Center, fubar@us.ibm.com
