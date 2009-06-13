Message-ID: <4A33A4AF.8090101@navigue.com>
Date: Sat, 13 Jun 2009 09:07:59 -0400
From: Jonathan Thibault <jonathan@navigue.com>
MIME-Version: 1.0
References: <1244842010-24945-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<2e59e6970906122139h676b76f5s64d3b8074065d6c3@mail.gmail.com>
In-Reply-To: <2e59e6970906122139h676b76f5s64d3b8074065d6c3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] [bridge] Add split horizon
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

I also use multiple vlans as part of a bridge with no loop and it works 
rather well except for one very strange thing.  If I have two separate 
tagged vlans on the same switch port, the bridge will stop relaying some 
arp replies to those two vlans.  The current network layout doesn't 
require me to have more than one tagged vlan on any switch port except 
the one headed into the bridge interface, so I can work around the issue 
but to date I have not found the cause of this.  We tried different 
NICs, different kernel versions, etc.

As far as the bridge is concerned, arp replies do go through.  But if I 
sniff traffic out of its switch facing interface (with a hub), the 
replies never actually make it onto the wire.

So while I agree that it works for most people, there are situations 
where having multiple vlans bridged might not do what you expect.

Jonathan

richardvoigt@gmail.com wrote:
> On Fri, Jun 12, 2009 at 4:26 PM, Joakim
> Tjernlund<Joakim.Tjernlund@transmode.se> wrote:
>> Currently the bridge does not impl. split horizon which will easily
>> cause loops when 2 or more VLANs are added from the same physical interface.
> 
> I call shenanigans.  Got multiple VLANs from the same physical
> interface added to a bridge and no loops, almost no trouble of any
> sort.  A second bridge on the same router has loops, uses spanning
> tree to shut one VLAN down selectively (to automatically bypass a
> traffic shaper appliance with a history of failure) and the only
> trouble is that the PDUs sent by spanning tree cause klog warnings
> when they come back to the other VLAN of the same physical interface.
> 
> And I don't think split horizon means what you think it does.
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge

