Message-ID: <001a01c38799$8f8b4140$3601a8c0@lappis>
From: =?iso-8859-1?Q?Fredrik_Win=E4s?= <fredrik@winas.com>
References: <002901c3876b$bae6bc80$6700a8c0@fredrik>
	<00b801c38796$38abc050$7005640a@internal.watertech.com>
Subject: Re: [Bridge] Strange, my transparent squid stoped working
Date: Tue, 30 Sep 2003 23:26:47 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Chris Shaw <chriss@watertech.com>
Cc: bridge@lists.osdl.org


hmm, i found what was wrong later today... someone had been trying to clean
up all the wires be the switch.. and then they missed my Linux box... so
they disconnected eth1...

so the router went straight to the switch... but as eth2 was still connected
i could still access the proxy manualy and by ssh...

now the machine works as it should again.


This is my network right now.

DSLmodem
  |
Router-switch(Netgear 4port) (192.168.0.1)
 | |
 | |---> (3 computers located next to the router)
 |
 |--> (eth1 no ip) Bridge (eth2 no ip)--|
                                        |
                                        |
   (users)<----Switch-------------------|


br0 is 192.168.0.3 def GW 192.168.0.1


the reason that i dont use my Linux machine as a router is that it's
supposed to be a test machine only.
We have some customers that we think that we can sell this machine to, and
it should be as little configuration as possible with it, and it should fit
everyone.

ex. a company that wants to speed up their internet connection a bit should
be able to yust hook in the cables and nothing more. and they can still
configure their little router by it's webinterface.

i hope that i can make squid check the contents for viruses too.


i knew that it worked before, as i was tailing the access.log from squid,
and i could see that it was logging the requests i made with my webbrowser.


> Are you saying that REDIRECT hasn't been or that it has suddenly stopped
> working?
>
> My guess would be that it hasn't been working. Here's why:
>
> The REDIRECT target is in the NAT table because it is designed to redirect
> the port of packets destined for the interface they arrived on.
>
> If I understand right your situation is like this:
>
> (Users) -----> (eth2) <Bridge (192.168.0.3)> (eth1)  ------->
Router ------>
> DSL
>
> Packets arrive on your bridge machine at eth2 (The left-hand side of your
> network) they are destined for www.excite.com on TCP port 80. However, the
> gateway on your network is Router through eth1 NOT the bridge. Since the
> next hop is the gateway machine and NOT the bridge machine, the bridging
> code sends the packet directly out to eth1 and to the router. The packets
do
> go through NAT, that's why the counters are going up, but in this case NAT
> will ignore the packet because it's next hop is another machine.
>
>
> I could be totally wrong on this, but I've tried what you're trying and I
> get the same results.

Well i got that result at first too, but then someone told me that i needed
to run 2.5.x kernel or apply a patch to my 2.4.x kernel, the bridge-nf patch
(http://ebtables.sourceforge.net/)

with that installed the packets take the extra path through the PREROUTING
table in nat



>
> Is there some reason why you want to use the router box instead of Linux's
> NAT code on the bridge? It would really really simplify your life.
>
> If not, you need to use EBTABLES. What you want to do is have any TCP
> packets that come into either side of the bridge destined for port 80
> redirected so that their destination is the IP for the bridge box and not
> the router/gateway box. Then the packets will behave themselves in the
> manner you want them to.
>
>
>
> -Chris
>
>
> ----- Original Message -----
> From: "G=F6teborgs DataAkut - Fredrik Win=E4s" <fredrik@winas.com>
> To: <bridge@math.leidenuniv.nl>
> Sent: Tuesday, September 30, 2003 8:58 AM
> Subject: [Bridge] Strange, my transparent squid stoped working
>
>
> > This is strange...
> >
> > I had my Linux box setup as a bridge with two lan cards, that filterd
out
> > all port 80 packets and sent them to squid to get a real transparent
> > webcache.
> > I shut the machine down, moved it from my test bench to the server room,
> > strted it up and it worked yust fine, i tested to pull the powercord to
it
> > and see if it could start ok after that (using ext3 filesystem), and it
> > worked yust fine.
> >
> > until today when i checked the squid logs, and it wasn't logging
> anything...
> >
> > so i tried to access squid directly, and it works yust fine from any
> > webbrowser, but the REDIRECT doesnt work.
> >
> > i tried iptables -t nat -L -nv and i saw that there had been packets
going
> > through the REDIRECT table, then i used iptables -t nat -F and then
added
> > the same rules again, but no new packets...
> >
> > i tried to restart the machine, but it didn't do a thing.. still no hits
> on
> > the REDIRECT...
> >
> >
> > proxy:~# uname -a
> > Linux proxy 2.4.22 #1 SMP Wed Sep 24 17:11:16 CEST 2003 i686 unknown
> >
> > proxy:~# dmesg | grep -A1 Bridge
> > NET4: Ethernet Bridge 008 for NET4.0
> > Bridge firewalling registered
> > kjournald starting.  Commit interval 5 seconds
> >
> > proxy:~# iptables -t nat -L -nv
> > Chain PREROUTING (policy ACCEPT 373 packets, 25762 bytes)
> >  pkts bytes target     prot opt in     out     source
> > destination
> >     0     0 REDIRECT   tcp  --  eth1   *       0.0.0.0/0
> > 0.0.0.0/0          tcp dpt:80 redir ports 3128
> >     0     0 REDIRECT   tcp  --  eth2   *       0.0.0.0/0
> > 0.0.0.0/0          tcp dpt:80 redir ports 3128
> >
> > Chain POSTROUTING (policy ACCEPT 149 packets, 12928 bytes)
> >  pkts bytes target     prot opt in     out     source
> > destination
> >
> > Chain OUTPUT (policy ACCEPT 92 packets, 5628 bytes)
> >  pkts bytes target     prot opt in     out     source
> > destination
> >
> >
> > proxy:~# iptables -L -nv
> > Chain INPUT (policy ACCEPT 2332 packets, 656K bytes)
> >  pkts bytes target     prot opt in     out     source
> > destination
> >     0     0 ACCEPT     tcp  --  eth2   *       0.0.0.0/0
> > 192.168.0.3        tcp dpt:3128 state NEW,ESTABLISHED
> >   597  173K ACCEPT     tcp  --  eth1   *       0.0.0.0/0
> > 192.168.0.3        tcp dpt:3128 state NEW,ESTABLISHED
> >
> > Chain FORWARD (policy ACCEPT 128 packets, 13644 bytes)
> >  pkts bytes target     prot opt in     out     source
> > destination
> >
> > Chain OUTPUT (policy ACCEPT 3684 packets, 956K bytes)
> >  pkts bytes target     prot opt in     out     source
> > destination
> >
> >
> > proxy:~# cat /proc/sys/net/ipv4/ip_forward
> > 1
> >
> >
> > ADSL modem<--->ROUTER SWITCH<--->[eth1]Linux[eth2]<--->SWITCH<--->USERS
> >                      |
> >                      --> USERS
> >
> >
> >
> > _______________________________________________
> > Bridge mailing list
> > Bridge@math.leidenuniv.nl
> > http://www.math.leidenuniv.nl/mailman/listinfo/bridge
>


