Message-ID: <425186C2.6@beep.mine.nu>
Date: Mon, 04 Apr 2005 20:26:10 +0200
From: Beppe <bridge@beep.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Some clients are unable to connect fully to the other side.
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi list,

I have setup our router/firewall with bridging.
The bridge is there because we have an other router with a ipsec tunnel.
The traffic from that i don't trust, i have seen a lot of noise that 
needs to be dropped(ports like 135,137,138,445 etc)

It all works just fine except for some clients.

 From my client(winxpp sp1) i can browse web servers, receive and send 
mail on networks behind the bridge and ipsec tunnel.
So the bridge works (for me at least)
The problem on some clients is that for an example.
If i telnet to the mail server pop3, i'm able to log in
and list the inbox, but when i do "RETR 1" nothing more happens.

it feels like there is some issue with larger package from the other side.

tcpdump from a bad client unable to get mail shows:

19:47:50.946266 IP (tos 0x0, ttl 127, id 19315, offset 0, flags [DF], 
length: 48) client.1815 > server.110: S [tcp sum ok] 
3838110372:3838110372(0) win 65535 <mss 1460,nop,nop,sackOK>

19:47:50.989986 IP (tos 0x0, ttl 127, id 24652, offset 0, flags [DF], 
length: 48) server.110 > client.1815: S [tcp sum ok] 
376748423:376748423(0) ack 3838110373 win 65535 <mss 1400,nop,nop,sackOK>

19:47:50.990126 IP (tos 0x0, ttl 127, id 19316, offset 0, flags [DF], 
length: 40) client.1815 > server.110: . [tcp sum ok] 1:1(0) ack 1 win 65535

19:47:51.034310 IP (tos 0x0, ttl 127, id 24656, offset 0, flags [DF], 
length: 140) server.110 > client.1815: P 1:101(100) ack 1 win 65535

19:47:51.034561 IP (tos 0x0, ttl 127, id 19317, offset 0, flags [DF], 
length: 74) client.1815 > server.110: P 1:35(34) ack 101 win 65435

19:47:51.078620 IP (tos 0x0, ttl 127, id 24657, offset 0, flags [DF], 
length: 45) server.110 > client.1815: P [tcp sum ok] 101:106(5) ack 35 
win 65501

19:47:51.078840 IP (tos 0x0, ttl 127, id 19318, offset 0, flags [DF], 
length: 55) client.1815 > server.110: P 35:50(15) ack 106 win 65430

19:47:51.130881 IP (tos 0x0, ttl 127, id 24666, offset 0, flags [DF], 
length: 74) server.110 > client.1815: P 106:140(34) ack 50 win 65486

19:47:51.131129 IP (tos 0x0, ttl 127, id 19319, offset 0, flags [DF], 
length: 46) client.1815 > server.110: P [tcp sum ok] 50:56(6) ack 140 
win 65396

19:47:51.181633 IP (tos 0x0, ttl 127, id 24668, offset 0, flags [DF], 
length: 54) server.110 > client.1815: P [tcp sum ok] 140:154(14) ack 56 
win 65480

19:47:51.182402 IP (tos 0x0, ttl 127, id 19320, offset 0, flags [DF], 
length: 48) client.1815 > server.110: P [tcp sum ok] 56:64(8) ack 154 
win 65382

19:47:52.613277 IP (tos 0x0, ttl 127, id 19337, offset 0, flags [DF], 
length: 48) client.1815 > server.110: P [tcp sum ok] 56:64(8) ack 154 
win 65382

19:47:52.662321 IP (tos 0x0, ttl 127, id 24718, offset 0, flags [DF], 
length: 40) server.110 > client.1815: . [tcp sum ok] 1554:1554(0) ack 64 
win 65472

the two last package with hex dump

19:45:33.909104 IP (tos 0x0, ttl 127, id 18214, offset 0, flags [DF], 
length: 48) client.1808 > server.110: P [tcp sum ok] 56:64(8) ack 154 
win 65382
0x0000: 4500 0030 4726 4000 7f06 0fc4 0a10 888c  E..0G&@.........
0x0010: 0a10 0832 0710 006e e2af ddd2 1456 405f  ...2...n.....V@_
0x0020: 5018 ff66 1af7 0000 5245 5452 2031 0d0a  P..f....RETR.1..

19:45:33.968763 IP (tos 0x0, ttl 127, id 20411, offset 0, flags [DF], 
length: 40) server.110 > client.1808: . [tcp sum ok] 1554:1554(0) ack 64 
win 65472
0x0000: 4500 0028 4fbb 4000 7f06 0737 0a10 0832  E..(O.@....7...2
0x0010: 0a10 888c 006e 0710 1456 45d7 e2af ddda  .....n...VE.....
0x0020: 5010 ffc0 e8ff 0000 0000 0000 0000       P.............


The ghost in me says that it can be some thing with MTU, can it be that?
I'm not an IP TCP expert, but a brief analyze of good and bad client , 
the first SYN on good client has "mss 1260" while bad client has "mss 1460".
Generally the bad client is Win98se and win2k,
but there is some winxpp with the same issue.


setup:
Linux dist Gentoo 2004.3
Kernel 2.6.11-gentoo-r4
kernel patched with
	linux-2.6.11-mppe-mppc-1.3
	patch-o-matic-ng-20050322 CLASSIFY
	patch-o-matic-ng-20050322 ownercmd
	patch-o-matic-ng-20050322 psd
	patch-o-matic-ng-20050322 time
	patch-o-matic-ng-20050322 IPMARK
	patch-o-matic-ng-20050322 TARPIT
	patch-o-matic-ng-20050322 XOR
	patch-o-matic-ng-20050322 ipp2p
iptables-1.3.1
bridge-utils-0.9.6-r1


Iterface desc:
eth0:  External network (internet)
eth1:  Local network (office)
eth2:  DMZ
eth3:  Local network (ipsec)
ppp+:  Dial-in VPN
tun01: gre tunnel
br0:   Bridge network eth1 and eth3


Directions how to counter this problem is warmly welcome,

take care,
::Beppe
