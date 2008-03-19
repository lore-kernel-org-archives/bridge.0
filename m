Message-ID: <47E12A1B.9020201@navigue.com>
Date: Wed, 19 Mar 2008 10:58:35 -0400
From: Jonathan Thibault <jonathan@navigue.com>
MIME-Version: 1.0
References: <96CF49BD8B56384395D698BA99007FA32FA187@exchange.pacwire.local>
In-Reply-To: <96CF49BD8B56384395D698BA99007FA32FA187@exchange.pacwire.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge, vlan and *no* stp/bpdu
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.osdl.org

Leigh Sharpe wrote:
> Hi Jonathan,
>  Let me make sure I understand your situation properly:
>
> You have an interface on which you have two vlans:
>
> Vconfig add in 2
> Vconfig add in 3
>
> You have created a bridge and assigned interface out and interface in.2
> to the bridge:
>
> Brctl addbr br0
> Brctl addif br0 out
> Brctl addif br0 in.2
> Ifconfig out up
> Ifconfig in.2 up
>
> Then, when you add in.3 to the bridge with this command,
>
> Brctl addif br0 in.3
>
>   
Correct until now.
> Things start to break, and devices connected to in.3 cannot talk to
> devices on interface 'out'.
>
> Does this look correct?
>
>   
No.  There are no devices connected to in.3 at all.  Devices connected 
to in.2 stop being able to reach the gateway which is connected to 
'out'.  Actually, it's more a matter of being unable to ARP the gateway 
connected to 'out'.  The arp request reaches the gateway, but the reply 
never reaches the machine connected to in.2.  If the machine on in.2 
already has the gateway's mac in its arp table, then it can talk to it 
fine.  So far, the only thing that doesn't work with my setup is *arp 
replies*.
> I'm presuming that the MAC of interest is 00:18:18:62:3e:80
>
> I suspect that your bridge is seeing this mac coming in, VLAN tagged, on
> interface 'in', and is learning it on that interface, before you add
> in.3 to the bridge. Once that happens, any replies coming in on
> interface 'out' will not be sent to in.3, as they should.
>
>   
That's interesting.  Interface 'in' is not part of the bridge however, 
in.2 is (and at that point, in.3).  My assumption was that a 'vlan 
interface' spits out packets untagged rather than the raw (tagged) 
packets coming on the real physical interface, which would make logical 
sense.

Also of note is that I do see the reply show up on in.2 (you see it in 
my tcpdump -i in.2 log) as it should be with tcpdump, so I don't think 
the problem is that it goes to the wrong interface.  The problem is that 
it doesn't come *out* of the physical interface at all, tagged or not, 
onto the vlan trunk.  If it came out on vlan3 or untagged, I would still 
see it.

It shows up locally if I tcpdump -i in, but it never shows up on the 
wire (tcpdump -i eth1 on a box connected to the trunk right next to the 
bridge, no vlan switch involved, just a dumb hub acting as a repeater so 
I can sniff the traffic).  And that is before it gets to any vlan-aware 
switch.  So the problem at that point is not a matter of a switch not 
knowing how to deal with this peculiar situation.


              |   bridge   |       +-| 00:18:18:62:3e:80 & all other |
gateway-|(out)|out-br0-in.2|(in)|-hub
        |     |      +-in.3|    |  +-|(eth1)                         |
        | linux box with bridge |    | linux box used to sniff trunk |

The arp reply, from the gatway, shows up on 'in.2', it shows up on 'in', 
but it never shows up on 'eth1'.  I seriously doubt the hub is smart 
enough to notice that in.3 has been added to the bridge and suddently 
stop passing *only* arp replies as I see all other traffic just fine. I 
also see those arp replies when in.3 isn't part of the bridge.  So my 
fair assumption is that the arp reply packets never make it onto the hub 
at all.

As far as I can tell, they vanish between 'in' and the hub.

> I recall reading somewhere that if you add an ebtables rule to 'in',
> which drops all VLAN tagged packets, it will then be redirected to the
> correct sub-interface (ie in.3). I envisage it would be something like 
>
> Ebtables -t broute -A BROUTING -p 8021_Q -I in -J DROP
>
>   
I will give that a try for sure.  From reading the post you refer to, it 
makes a bit of sense, but I'm not entirely sure it covers the whole 
problem.  A problem such as what it refers to seems like it would affect 
all traffic instead of just arp replies.

Thanks a bunch, I will update you on my results with that ebtables rule 
shortly.

Jonathan
> Have a good look at this post if you need further details:
>
>  http://osdir.com/ml/linux.drivers.vlan/2006-07/msg00011.html
>
>
> Hope this helps.
> Regards,
>              Leigh
>  
> Leigh Sharpe
> Network Systems Engineer
> Pacific Wireless
> Ph +61 3 9584 8966
> Mob 0408 009 502
> Helpdesk 1300 300 616
> email lsharpe@pacificwireless.com.au
> web www.pacificwireless.com.au
>
>  
>
> -----Original Message-----
> From: bridge-bounces@lists.linux-foundation.org
> [mailto:bridge-bounces@lists.linux-foundation.org] On Behalf Of Jonathan
> Thibault
> Sent: Thursday, 13 March 2008 4:44 AM
> To: bridge@lists.osdl.org
> Subject: Re: [Bridge] bridge, vlan and *no* stp/bpdu
>
> Hello Leigh,
>
> I did a quick test this morning on a machine that always reliably 
> exhibits the problem.  First and foremost, the machine was always in 
> brctl showmacs so sorry, that was probably me imagining things.  Or 
> rather, me assuming it from what I'll describe below.  It is always on 
> interface 2, which is in.2.
>
> Thankfully, this is a very quiet machine, so I only filtered for its mac
>
> address and did tcpdumps on in, in.2 and on another box connected 
> directly to the trunk through a hub through eth1, which is dedicated to 
> sniffing this traffic.  It's a test box, so sorry about the clock being 
> wrong on that one, I know it looks bad ;)
>
> Anyway.  This goes to show that this only seems to affects ARP.  Once 
> the machine has learned the gateway's MAC, it will talk to the rest of 
> the net just fine, even if in.3 is back on the bridge.
>
> Could you be more specific as to the ebtables rules you'd need me to 
> run?  Just match for arp replies to my 'test' host for both in.2 and 
> in.3 and see which one hits?  Sounds a bit redundant given our tcpdump 
> output now, but I'll give it a shot.
>
> Thanks a bunch,
>
> Jonathan
>
> Here are the tcpdump outputs, they start with in.3 on the bridge and 
> confirming that the machine's MAC is still on port 2:
>
>  ...
>   

