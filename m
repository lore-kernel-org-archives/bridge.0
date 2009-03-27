Message-ID: <49CC948B.8020005@trash.net>
Date: Fri, 27 Mar 2009 09:55:39 +0100
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
References: <20090313183303.GF3436@psychotron.englab.brq.redhat.com>
	<20090326155205.GA28868@psychotron.englab.brq.redhat.com>
	<20090327.003819.234492275.davem@davemloft.net>
	<49CC85E9.7070903@trash.net>
	<20090327084138.GA4582@psychotron.englab.brq.redhat.com>
In-Reply-To: <20090327084138.GA4582@psychotron.englab.brq.redhat.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bonding: allow bond in mode balance-alb to
 work	properly in bridge -try4
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jiri Pirko <jpirko@redhat.com>
Cc: fubar@us.ibm.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mschmidt@redhat.com, bonding-devel@lists.sourceforge.net, jgarzik@pobox.com, dada1@cosmosbay.com, David Miller <davem@davemloft.net>

Jiri Pirko wrote:
> Fri, Mar 27, 2009 at 08:53:13AM CET, kaber@trash.net wrote:
>> >
>> > Me neither, but I don't think this approach can be done without the
>> > hook. While I still find it questionable whether this mode really
>> > needs to be supported for a bridge at all
> 
> Well there is I think nothing unusual in this net scheme. And by for example
> the increasing setups with kvm/bridging it will be needed more and more.

Mangling ARP packets for load-balancing purposes seems quite unusual.

>> , an alternative approach
>> would be to have bonding add FDB entries for all secondary MACs to
>> make bridging treat them as local.
> 
> Yes - that is the clear way. But there's not really straihtforward way to do
> this. The clear approach would be to extend struct net_device for list of these
> mac addresses and let the drivers (binding) fill it and bridge to process it.
> But I don't know.

We have a list of secondary unicast addresses, but that might not
be suitable in this case since the addresses are (mostly) intended
not to be visible to the stack if I understood correctly.
