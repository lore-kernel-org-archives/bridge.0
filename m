Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Mar 2008 09:07:13 +1100
Message-ID: <96CF49BD8B56384395D698BA99007FA32FA171@exchange.pacwire.local>
From: "Leigh Sharpe" <lsharpe@pacificwireless.com.au>
Subject: Re: [Bridge] bridge, vlan and *no* stp/bpdu
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jonathan Thibault <jonathan@navigue.com>, bridge@lists.osdl.org

Hi Jonathan,

So, you're seeing the ARP reply come in, untagged, but not seeing it
exit the tagged interface? Check to see that the bridge has definitely
learned that MAC on the correct interface.

I am wondering if your are coming up against this issue:

---
(From http://ebtables.sourceforge.net/brnf-faq.html )

How do I let vlan-tagged traffic go through a vlan bridge port and the
other traffic through a non-vlan bridge port?=20

Suppose eth0 and eth0.15 are ports of br0. Without countermeasures all
traffic, including traffic vlan-tagged with tag 15, entering the
physical device eth0 will go through the bridge port eth0. To make the
15-tagged traffic go through the eth0.15 bridge port, use the following
ebtables rule:=20
ebtables -t broute -A BROUTING -i eth0 --vlan-id 15 -j DROP

With the above rule, 15-tagged traffic will enter the bridge on the
physical device eth0, will then be brouted and enter the bridge port
eth0.15, the vlan header will be stripped, after which the packet is
bridged. The packet thus enters the BROUTING chain twice, the first time
with input device eth0 and the second time with input device eth0.15.
The other chains are only traversed once. All other traffic will be
bridged with input device eth0.=20
----

Somewhere I have seen a mailing list archive with a far better
explanation, but I just can't seem to find it right now.

Can you run TCPdump on 'in', as well as 'in.2' and see if the packets
are disappearing somewhere between the two?
Alternatively, put an ebtables rule on each interface, with a target of
CONTINUE, and then do a ebtables -L --Lc to see which rules are
matching, so you can get an ide of which interface the bridge is trying
to spit out the replies you are looking for.


Leigh.
=20

-----Original Message-----
From: bridge-bounces@lists.linux-foundation.org
[mailto:bridge-bounces@lists.linux-foundation.org] On Behalf Of Jonathan
Thibault
Sent: Wednesday, 12 March 2008 2:44 AM
To: bridge@lists.osdl.org
Subject: Re: [Bridge] bridge, vlan and *no* stp/bpdu

Hello Leigh,

This was one of the first things I looked at when I noticed that it=20
didn't reach the client.  As far as I can tell, no, the mac isn't on the

wrong port.  Come to think of it, I think the problem might have to do=20
with the bridge not learning the affected machine's MAC at all until I=20
removed in.3 from the bridge completely.  I'll do further tests and=20
confirm this shortly, especially if you think there is something to it.

Also of note, since I monitor the trunk itself (and I only filter by mac

when I do), I would have seen the reply if it went to the wrong vlan=20
anyway, or is that logic wrong?

Anyway, if the problem is that the bridge stops learning a specific=20
machine's MAC, is there a way for me to manually add the MAC to the=20
bridge table and see if it solves the problem?  If such is the case,=20
it's not really a solution, but it would certainly narrow down the scope

of the problem.

Jonathan


Leigh Sharpe wrote:
> Can you do a brctl showmacs br0, and see if the machines which are not
> receiving an ARP response are being seen by the bridge as being on the
> wrong VLAN?
>
>
> Ie, I'm wondering if the bridge sees their MAC address on an interface
> other than the one they are really connected to. If that's the case,
the
> bridge would send their response out of the wrong interface, which may
> result in the symptoms you are describing. I think there may be some
> ebtables rules which could help here, but my memory fails me at this
> point.
>
> Regards,
>              Leigh
> =20
> Leigh Sharpe
> Network Systems Engineer
> Pacific Wireless
> Ph +61 3 9584 8966
> Mob 0408 009 502
> Helpdesk 1300 300 616
> email lsharpe@pacificwireless.com.au
> web www.pacificwireless.com.au
> =20
>  =20

_______________________________________________
Bridge mailing list
Bridge@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/bridge
