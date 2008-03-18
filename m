Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Mar 2008 13:38:12 +1100
Message-ID: <96CF49BD8B56384395D698BA99007FA32FA187@exchange.pacwire.local>
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
 Let me make sure I understand your situation properly:

You have an interface on which you have two vlans:

Vconfig add in 2
Vconfig add in 3

You have created a bridge and assigned interface out and interface in.2
to the bridge:

Brctl addbr br0
Brctl addif br0 out
Brctl addif br0 in.2
Ifconfig out up
Ifconfig in.2 up

Then, when you add in.3 to the bridge with this command,

Brctl addif br0 in.3

Things start to break, and devices connected to in.3 cannot talk to
devices on interface 'out'.

Does this look correct?


I'm presuming that the MAC of interest is 00:18:18:62:3e:80

I suspect that your bridge is seeing this mac coming in, VLAN tagged, on
interface 'in', and is learning it on that interface, before you add
in.3 to the bridge. Once that happens, any replies coming in on
interface 'out' will not be sent to in.3, as they should.

I recall reading somewhere that if you add an ebtables rule to 'in',
which drops all VLAN tagged packets, it will then be redirected to the
correct sub-interface (ie in.3). I envisage it would be something like=20

Ebtables -t broute -A BROUTING -p 8021_Q -I in -J DROP

Have a good look at this post if you need further details:

 http://osdir.com/ml/linux.drivers.vlan/2006-07/msg00011.html


Hope this helps.
Regards,
             Leigh
=20
Leigh Sharpe
Network Systems Engineer
Pacific Wireless
Ph +61 3 9584 8966
Mob 0408 009 502
Helpdesk 1300 300 616
email lsharpe@pacificwireless.com.au
web www.pacificwireless.com.au

=20

-----Original Message-----
From: bridge-bounces@lists.linux-foundation.org
[mailto:bridge-bounces@lists.linux-foundation.org] On Behalf Of Jonathan
Thibault
Sent: Thursday, 13 March 2008 4:44 AM
To: bridge@lists.osdl.org
Subject: Re: [Bridge] bridge, vlan and *no* stp/bpdu

Hello Leigh,

I did a quick test this morning on a machine that always reliably=20
exhibits the problem.  First and foremost, the machine was always in=20
brctl showmacs so sorry, that was probably me imagining things.  Or=20
rather, me assuming it from what I'll describe below.  It is always on=20
interface 2, which is in.2.

Thankfully, this is a very quiet machine, so I only filtered for its mac

address and did tcpdumps on in, in.2 and on another box connected=20
directly to the trunk through a hub through eth1, which is dedicated to=20
sniffing this traffic.  It's a test box, so sorry about the clock being=20
wrong on that one, I know it looks bad ;)

Anyway.  This goes to show that this only seems to affects ARP.  Once=20
the machine has learned the gateway's MAC, it will talk to the rest of=20
the net just fine, even if in.3 is back on the bridge.

Could you be more specific as to the ebtables rules you'd need me to=20
run?  Just match for arp replies to my 'test' host for both in.2 and=20
in.3 and see which one hits?  Sounds a bit redundant given our tcpdump=20
output now, but I'll give it a shot.

Thanks a bunch,

Jonathan

Here are the tcpdump outputs, they start with in.3 on the bridge and=20
confirming that the machine's MAC is still on port 2:

 # tcpdump -n -i in ether host 08:10:17:0D:70:61
tcpdump: WARNING: in: no IPv4 address assigned
tcpdump: verbose output suppressed, use -v or -vv for full protocol
decode
listening on in, link-type EN10MB (Ethernet), capture size 68 bytes
11:15:57.726790 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
19986, seq 0, length 64
11:15:57.726808 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
19986, seq 0, length 64
11:15:57.764616 arp who-has 207.134.8.1 tell 207.134.9.17
11:15:57.765116 arp reply 207.134.8.1 is-at 00:18:18:62:3e:80
11:15:58.727808 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
19986, seq 1, length 64
11:15:59.727964 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
19986, seq 2, length 64
11:16:00.729381 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
19986, seq 3, length 64
11:16:01.728932 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
19986, seq 4, length 64
11:16:02.730502 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
19986, seq 5, length 64
11:16:03.729910 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
19986, seq 6, length 64
11:16:10.246543 IP 24.64.96.74.30516 > 207.134.9.17.1026: UDP, length
484
11:16:10.246641 IP 24.64.96.74.30516 > 207.134.9.17.1027: UDP, length
484
11:16:10.247735 IP 24.64.96.74.30516 > 207.134.9.17.1028: UDP, length
484
------ removed in.3 11:16:42 ------
11:17:19.743994 arp reply 207.134.8.1 is-at 00:18:18:62:3e:80
11:17:20.402770 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
22802, seq 0, length 64
11:17:20.438702 arp reply 207.134.8.1 is-at 00:18:18:62:3e:80
11:17:21.403648 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
22802, seq 1, length 64
11:17:22.404685 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
22802, seq 2, length 64
11:17:23.404257 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
22802, seq 3, length 64
------ in.3 added 11:17:48, forwarding at 11:18:03 ------
11:18:31.522164 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
24338, seq 0, length 64
11:18:31.522182 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
24338, seq 0, length 64
11:18:32.522671 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
24338, seq 1, length 64
11:18:33.522717 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
24338, seq 2, length 64
11:18:41.372052 arp who-has 207.134.9.90 tell 207.134.9.17
11:18:47.366774 arp who-has 207.134.9.90 tell 207.134.9.17
------ removed in.3 11:18:50 ------
11:18:56.050233 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
24594, seq 0, length 64
11:18:57.050744 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
24594, seq 1, length 64
11:18:58.050867 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
24594, seq 2, length 64
^C
28 packets captured
28 packets received by filter
0 packets dropped by kernel

# tcpdump -n -i in.2 ether host 08:10:17:0D:70:61
tcpdump: WARNING: in.2: no IPv4 address assigned
tcpdump: verbose output suppressed, use -v or -vv for full protocol
decode
listening on in.2, link-type EN10MB (Ethernet), capture size 68 bytes
11:15:57.726800 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
19986, seq 0, length 64
11:15:57.764576 arp who-has 207.134.8.1 tell 207.134.9.17
11:15:57.765109 arp reply 207.134.8.1 is-at 00:18:18:62:3e:80
11:15:58.727798 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
19986, seq 1, length 64
11:15:59.727956 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
19986, seq 2, length 64
11:16:00.729372 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
19986, seq 3, length 64
11:16:01.728923 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
19986, seq 4, length 64
11:16:02.730493 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
19986, seq 5, length 64
11:16:03.729900 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
19986, seq 6, length 64
11:16:10.246534 IP 24.64.96.74.30516 > 207.134.9.17.1026: UDP, length
484
11:16:10.246636 IP 24.64.96.74.30516 > 207.134.9.17.1027: UDP, length
484
11:16:10.247729 IP 24.64.96.74.30516 > 207.134.9.17.1028: UDP, length
484
------ removed in.3 11:16:42 ------
11:17:19.743488 arp who-has 207.134.8.1 tell 207.134.9.17
11:17:19.743988 arp reply 207.134.8.1 is-at 00:18:18:62:3e:80
11:17:20.402761 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
22802, seq 0, length 64
11:17:20.437712 arp who-has 207.134.8.1 tell 207.134.9.17
11:17:20.438696 arp reply 207.134.8.1 is-at 00:18:18:62:3e:80
11:17:20.468842 IP 207.134.9.17 > 66.38.210.117: ICMP echo reply, id=20
22802, seq 0, length 64
11:17:21.403639 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
22802, seq 1, length 64
11:17:21.433356 IP 207.134.9.17 > 66.38.210.117: ICMP echo reply, id=20
22802, seq 1, length 64
11:17:22.404675 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
22802, seq 2, length 64
11:17:22.439420 IP 207.134.9.17 > 66.38.210.117: ICMP echo reply, id=20
22802, seq 2, length 64
11:17:23.404249 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
22802, seq 3, length 64
11:17:23.434231 IP 207.134.9.17 > 66.38.210.117: ICMP echo reply, id=20
22802, seq 3, length 64
------ in.3 added 11:17:48, forwarding at 11:18:03 ------
11:18:31.522176 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
24338, seq 0, length 64
11:18:31.559476 IP 207.134.9.17 > 66.38.210.117: ICMP echo reply, id=20
24338, seq 0, length 64
11:18:32.522663 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
24338, seq 1, length 64
11:18:32.554809 IP 207.134.9.17 > 66.38.210.117: ICMP echo reply, id=20
24338, seq 1, length 64
11:18:33.522708 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
24338, seq 2, length 64
11:18:33.558038 IP 207.134.9.17 > 66.38.210.117: ICMP echo reply, id=20
24338, seq 2, length 64
11:18:41.372035 arp who-has 207.134.9.90 tell 207.134.9.17
11:18:41.393845 arp reply 207.134.9.90 is-at 00:16:d4:dd:6f:4e
11:18:47.366759 arp who-has 207.134.9.90 tell 207.134.9.17
11:18:47.386445 arp reply 207.134.9.90 is-at 00:16:d4:dd:6f:4e
------ removed in.3 11:18:50 ------
11:18:53.374862 arp who-has 207.134.9.90 tell 207.134.9.17
11:18:56.050224 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
24594, seq 0, length 64
11:18:56.090664 IP 207.134.9.17 > 66.38.210.117: ICMP echo reply, id=20
24594, seq 0, length 64
11:18:57.050736 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
24594, seq 1, length 64
11:18:57.081345 IP 207.134.9.17 > 66.38.210.117: ICMP echo reply, id=20
24594, seq 1, length 64
11:18:58.050859 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
24594, seq 2, length 64
11:18:58.081524 IP 207.134.9.17 > 66.38.210.117: ICMP echo reply, id=20
24594, seq 2, length 64
^C
41 packets captured
44 packets received by filter
0 packets dropped by kernel

# tcpdump -i eth1 -n ether host 08:10:17:0D:70:61
tcpdump: WARNING: eth1: no IPv4 address assigned
tcpdump: verbose output suppressed, use -v or -vv for full protocol
decode
listening on eth1, link-type EN10MB (Ethernet), capture size 68 bytes
08:20:44.448485 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
19986, seq 0, length 64
08:20:44.448658 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
19986, seq 0, length 64
08:20:44.486159 arp who-has 207.134.8.1 tell 207.134.9.17
08:20:44.486261 arp who-has 207.134.8.1 tell 207.134.9.17
------ removed in.3 11:16:42 ------
08:22:06.430604 arp who-has 207.134.8.1 tell 207.134.9.17
08:22:06.431239 arp reply 207.134.8.1 is-at 00:18:18:62:3e:80
08:22:07.089746 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
22802, seq 0, length 64
08:22:07.124543 arp who-has 207.134.8.1 tell 207.134.9.17
08:22:07.125847 arp reply 207.134.8.1 is-at 00:18:18:62:3e:80
08:22:07.155719 IP 207.134.9.17 > 66.38.210.117: ICMP echo reply, id=20
22802, seq 0, length 64
08:22:08.090204 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
22802, seq 1, length 64
08:22:08.119830 IP 207.134.9.17 > 66.38.210.117: ICMP echo reply, id=20
22802, seq 1, length 64
08:22:09.091002 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
22802, seq 2, length 64
08:22:09.125404 IP 207.134.9.17 > 66.38.210.117: ICMP echo reply, id=20
22802, seq 2, length 64
08:22:10.089973 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
22802, seq 3, length 64
08:22:10.119863 IP 207.134.9.17 > 66.38.210.117: ICMP echo reply, id=20
22802, seq 3, length 64
------ in.3 added 11:17:48, forwarding at 11:18:03 ------
08:23:18.179485 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
24338, seq 0, length 64
08:23:18.179499 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
24338, seq 0, length 64
08:23:18.216403 IP 207.134.9.17 > 66.38.210.117: ICMP echo reply, id=20
24338, seq 0, length 64
08:23:19.179382 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
24338, seq 1, length 64
08:23:19.211428 IP 207.134.9.17 > 66.38.210.117: ICMP echo reply, id=20
24338, seq 1, length 64
08:23:20.179009 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
24338, seq 2, length 64
08:23:20.214195 IP 207.134.9.17 > 66.38.210.117: ICMP echo reply, id=20
24338, seq 2, length 64
08:23:28.024814 arp who-has 207.134.9.90 tell 207.134.9.17
08:23:28.025045 arp who-has 207.134.9.90 tell 207.134.9.17
08:23:28.046767 arp reply 207.134.9.90 is-at 00:16:d4:dd:6f:4e
08:23:34.017173 arp who-has 207.134.9.90 tell 207.134.9.17   <---=20
Re-added in.3 Somewhere around here.
08:23:34.017252 arp who-has 207.134.9.90 tell 207.134.9.17
08:23:34.036851 arp reply 207.134.9.90 is-at 00:16:d4:dd:6f:4e
08:23:40.022739 arp who-has 207.134.9.90 tell 207.134.9.17
------ removed in.3 11:18:50 ------
08:23:42.697280 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
24594, seq 0, length 64
08:23:42.737416 IP 207.134.9.17 > 66.38.210.117: ICMP echo reply, id=20
24594, seq 0, length 64
08:23:43.697339 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
24594, seq 1, length 64
08:23:43.727680 IP 207.134.9.17 > 66.38.210.117: ICMP echo reply, id=20
24594, seq 1, length 64
08:23:44.696936 IP 66.38.210.117 > 207.134.9.17: ICMP echo request, id=20
24594, seq 2, length 64
08:23:44.727440 IP 207.134.9.17 > 66.38.210.117: ICMP echo reply, id=20
24594, seq 2, length 64

36 packets captured
40 packets received by filter
0 packets dropped by kernel

Leigh Sharpe wrote:
> Hi Jonathan,
>
> So, you're seeing the ARP reply come in, untagged, but not seeing it
> exit the tagged interface? Check to see that the bridge has definitely
> learned that MAC on the correct interface.
>
> I am wondering if your are coming up against this issue:
>
> ---
> (From http://ebtables.sourceforge.net/brnf-faq.html )
>
> How do I let vlan-tagged traffic go through a vlan bridge port and the
> other traffic through a non-vlan bridge port?=20
>
> Suppose eth0 and eth0.15 are ports of br0. Without countermeasures all
> traffic, including traffic vlan-tagged with tag 15, entering the
> physical device eth0 will go through the bridge port eth0. To make the
> 15-tagged traffic go through the eth0.15 bridge port, use the
following
> ebtables rule:=20
> ebtables -t broute -A BROUTING -i eth0 --vlan-id 15 -j DROP
>
> With the above rule, 15-tagged traffic will enter the bridge on the
> physical device eth0, will then be brouted and enter the bridge port
> eth0.15, the vlan header will be stripped, after which the packet is
> bridged. The packet thus enters the BROUTING chain twice, the first
time
> with input device eth0 and the second time with input device eth0.15.
> The other chains are only traversed once. All other traffic will be
> bridged with input device eth0.=20
> ----
>
> Somewhere I have seen a mailing list archive with a far better
> explanation, but I just can't seem to find it right now.
>
> Can you run TCPdump on 'in', as well as 'in.2' and see if the packets
> are disappearing somewhere between the two?
> Alternatively, put an ebtables rule on each interface, with a target
of
> CONTINUE, and then do a ebtables -L --Lc to see which rules are
> matching, so you can get an ide of which interface the bridge is
trying
> to spit out the replies you are looking for.
>
>
> Leigh.
> =20
>
> -----Original Message-----
> From: bridge-bounces@lists.linux-foundation.org
> [mailto:bridge-bounces@lists.linux-foundation.org] On Behalf Of
Jonathan
> Thibault
> Sent: Wednesday, 12 March 2008 2:44 AM
> To: bridge@lists.osdl.org
> Subject: Re: [Bridge] bridge, vlan and *no* stp/bpdu
>
> Hello Leigh,
>
> This was one of the first things I looked at when I noticed that it=20
> didn't reach the client.  As far as I can tell, no, the mac isn't on
the
>
> wrong port.  Come to think of it, I think the problem might have to do

> with the bridge not learning the affected machine's MAC at all until I

> removed in.3 from the bridge completely.  I'll do further tests and=20
> confirm this shortly, especially if you think there is something to
it.
>
> Also of note, since I monitor the trunk itself (and I only filter by
mac
>
> when I do), I would have seen the reply if it went to the wrong vlan=20
> anyway, or is that logic wrong?
>
> Anyway, if the problem is that the bridge stops learning a specific=20
> machine's MAC, is there a way for me to manually add the MAC to the=20
> bridge table and see if it solves the problem?  If such is the case,=20
> it's not really a solution, but it would certainly narrow down the
scope
>
> of the problem.
>
> Jonathan
>
>
> Leigh Sharpe wrote:
>  =20
>> Can you do a brctl showmacs br0, and see if the machines which are
not
>> receiving an ARP response are being seen by the bridge as being on
the
>> wrong VLAN?
>>
>>
>> Ie, I'm wondering if the bridge sees their MAC address on an
interface
>> other than the one they are really connected to. If that's the case,
>>    =20
> the
>  =20
>> bridge would send their response out of the wrong interface, which
may
>> result in the symptoms you are describing. I think there may be some
>> ebtables rules which could help here, but my memory fails me at this
>> point.
>>
>> Regards,
>>              Leigh
>> =20
>> Leigh Sharpe
>> Network Systems Engineer
>> Pacific Wireless
>> Ph +61 3 9584 8966
>> Mob 0408 009 502
>> Helpdesk 1300 300 616
>> email lsharpe@pacificwireless.com.au
>> web www.pacificwireless.com.au
>> =20
>>  =20
>>    =20
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>  =20

_______________________________________________
Bridge mailing list
Bridge@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/bridge
