Message-ID: <00b801c38796$38abc050$7005640a@internal.watertech.com>
From: "Chris Shaw" <chriss@watertech.com>
References: <002901c3876b$bae6bc80$6700a8c0@fredrik>
Subject: Re: [Bridge] Strange, my transparent squid stoped working
Date: Tue, 30 Sep 2003 14:02:55 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00B4_01C3875B.8BFBE220"
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: =?iso-8859-1?Q?G=F6teborgs_DataAkut_-_Fredrik_Win=E4s?= <fredrik@winas.com>
Cc: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------=_NextPart_000_00B4_01C3875B.8BFBE220
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Are you saying that REDIRECT hasn't been or that it has suddenly stopped
working?

My guess would be that it hasn't been working. Here's why:

The REDIRECT target is in the NAT table because it is designed to redirect
the port of packets destined for the interface they arrived on.

If I understand right your situation is like this:

(Users) -----> (eth2) <Bridge (192.168.0.3)> (eth1)  -------> Router ------>
DSL

Packets arrive on your bridge machine at eth2 (The left-hand side of your
network) they are destined for www.excite.com on TCP port 80. However, the
gateway on your network is Router through eth1 NOT the bridge. Since the
next hop is the gateway machine and NOT the bridge machine, the bridging
code sends the packet directly out to eth1 and to the router. The packets do
go through NAT, that's why the counters are going up, but in this case NAT
will ignore the packet because it's next hop is another machine.

I could be totally wrong on this, but I've tried what you're trying and I
get the same results.

Is there some reason why you want to use the router box instead of Linux's
NAT code on the bridge? It would really really simplify your life.

If not, you need to use EBTABLES. What you want to do is have any TCP
packets that come into either side of the bridge destined for port 80
redirected so that their destination is the IP for the bridge box and not
the router/gateway box. Then the packets will behave themselves in the
manner you want them to.



-Chris


----- Original Message -----
From: "G=F6teborgs DataAkut - Fredrik Win=E4s" <fredrik@winas.com>
To: <bridge@math.leidenuniv.nl>
Sent: Tuesday, September 30, 2003 8:58 AM
Subject: [Bridge] Strange, my transparent squid stoped working


> This is strange...
>
> I had my Linux box setup as a bridge with two lan cards, that filterd out
> all port 80 packets and sent them to squid to get a real transparent
> webcache.
> I shut the machine down, moved it from my test bench to the server room,
> strted it up and it worked yust fine, i tested to pull the powercord to it
> and see if it could start ok after that (using ext3 filesystem), and it
> worked yust fine.
>
> until today when i checked the squid logs, and it wasn't logging
anything...
>
> so i tried to access squid directly, and it works yust fine from any
> webbrowser, but the REDIRECT doesnt work.
>
> i tried iptables -t nat -L -nv and i saw that there had been packets going
> through the REDIRECT table, then i used iptables -t nat -F and then added
> the same rules again, but no new packets...
>
> i tried to restart the machine, but it didn't do a thing.. still no hits
on
> the REDIRECT...
>
>
> proxy:~# uname -a
> Linux proxy 2.4.22 #1 SMP Wed Sep 24 17:11:16 CEST 2003 i686 unknown
>
> proxy:~# dmesg | grep -A1 Bridge
> NET4: Ethernet Bridge 008 for NET4.0
> Bridge firewalling registered
> kjournald starting.  Commit interval 5 seconds
>
> proxy:~# iptables -t nat -L -nv
> Chain PREROUTING (policy ACCEPT 373 packets, 25762 bytes)
>  pkts bytes target     prot opt in     out     source
> destination
>     0     0 REDIRECT   tcp  --  eth1   *       0.0.0.0/0
> 0.0.0.0/0          tcp dpt:80 redir ports 3128
>     0     0 REDIRECT   tcp  --  eth2   *       0.0.0.0/0
> 0.0.0.0/0          tcp dpt:80 redir ports 3128
>
> Chain POSTROUTING (policy ACCEPT 149 packets, 12928 bytes)
>  pkts bytes target     prot opt in     out     source
> destination
>
> Chain OUTPUT (policy ACCEPT 92 packets, 5628 bytes)
>  pkts bytes target     prot opt in     out     source
> destination
>
>
> proxy:~# iptables -L -nv
> Chain INPUT (policy ACCEPT 2332 packets, 656K bytes)
>  pkts bytes target     prot opt in     out     source
> destination
>     0     0 ACCEPT     tcp  --  eth2   *       0.0.0.0/0
> 192.168.0.3        tcp dpt:3128 state NEW,ESTABLISHED
>   597  173K ACCEPT     tcp  --  eth1   *       0.0.0.0/0
> 192.168.0.3        tcp dpt:3128 state NEW,ESTABLISHED
>
> Chain FORWARD (policy ACCEPT 128 packets, 13644 bytes)
>  pkts bytes target     prot opt in     out     source
> destination
>
> Chain OUTPUT (policy ACCEPT 3684 packets, 956K bytes)
>  pkts bytes target     prot opt in     out     source
> destination
>
>
> proxy:~# cat /proc/sys/net/ipv4/ip_forward
> 1
>
>
> ADSL modem<--->ROUTER SWITCH<--->[eth1]Linux[eth2]<--->SWITCH<--->USERS
>                      |
>                      --> USERS
>
>
>
> _______________________________________________
> Bridge mailing list
> Bridge@math.leidenuniv.nl
> http://www.math.leidenuniv.nl/mailman/listinfo/bridge

------=_NextPart_000_00B4_01C3875B.8BFBE220--
