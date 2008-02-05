Message-ID: <47A8BF49.2020004@navigue.com>
Date: Tue, 05 Feb 2008 14:55:53 -0500
From: Jonathan Thibault <jonathan@navigue.com>
MIME-Version: 1.0
Subject: Re: [Bridge] Bridged vlan issue.
References: <47A0D6F8.5010600@navigue.com>
In-Reply-To: <47A0D6F8.5010600@navigue.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.osdl.org

Anybody with input on this?  We're certainly willing to pay to get this 
one fixed if that's an incentive.

Jonathan
> I have a strange issue with bridged vlan interfaces.  I've discussed 
> it at length in the ebtables mailing list and have gotten a fair bit 
> of valuable feedback from there.  It is still a bit unclear where the 
> problem resides but it definitely seems ARP related.
>
> First of all, this is kernel 2.6.23.  I have two tg3 gigabit 
> interfaces on the box, conveniently named:  'out' and 'in'.  The vlans 
> are on the 'in' side of the bridge, so in.2, in.3, in.4 ... in.6 while 
> the 'out' interface is plain untagged ethernet.
>
> As it is now, I only use ebtables to filter out anything that isn't 
> ipv4 or arp, I do the rest of my filtering through iptables.  There is 
> also no STP on the bridge or anywhere in our network, though we might 
> use it once I get this fixed.
>
> In its current, working condition, the bridge (br0) has interfaces 
> 'in.2' and 'out' with the clients on the 'in' side of the bridge, and 
> the internet gateway on the 'out' side.  Does the job brilliantly.
>
> I start having problems when in.3 is added to the bridge (it exists 
> and is up on the box, just not on the bridge).  There are still no 
> clients in vlan 3, but when I add it to the bridge, the bridge won't 
> relay ARP replies from the gateway to some of my clients in vlan2, 
> effectively disabling their internet.
>
> The strange thing is that I see the reply come into the 'out' 
> interface (with tcpdump), I see it on the 'br0' interface, and I also 
> see it on the in.2 interface where it should be on its way to the 
> customer.  But putting a hub between the customer and the bridge box, 
> I never see it.  It's as if the arp reply just vanished just before it 
> got fed to the ethernet cable.  To the linux box, it's been sent, but 
> it never shows up on the trunk.
>
> I've also validated this by testing when only 'in.2' and 'out' are on 
> the bridge, I see both requests and replies for affected customers go 
> through the hub and everything works.
>
> I know the tg3 driver does some vlan acceleration of sorts, that might 
> have something to do with it, but something tells me I'd have the same 
> problem with just one vlan interface on the bridge then.
>
> As I said before, this only manifests in our production environment, 
> so I have to be pretty careful with scheduling tests and what not, but 
> I'd very much love some ideas to figure out where the vanishing 
> packets go.
>
> Jonathan
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge

