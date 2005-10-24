Date: Tue, 25 Oct 2005 01:02:30 +0200
From: Michel Pastor <K@codefx.org>
Message-Id: <20051025010230.2d6f330f.K@codefx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] single briged network internet access problems
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi,

I've some problems with this network :

[ host1 eth0: 10.22.2.4/8 ]        [ host2 eth0:10.22.2.5/8 default route host3]
                                         \      /
                                       SWITCH                           internet
                                            |                                       |
                                            |                                       |
                             [ host3 eth0-eth1: 10.22.2.3/8 -- eth2: 8X.242.21.225/8 ]
                                                    |
                                                    |
                                     [ host4 eth0:10.22.2.2/8 default route host3]

On host3 I use this rule to translate addresses of packets going through eth2 to the internet:
# iptables -t nat -A POSTROUTING -o eth2 -j MASQUERADE

If host1 default route is set to host2, no problem but when host4 is used as default route, see:

host1# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
10.0.0.0          *                      255.0.0.0       U     0      0        0 eth0
default            10.22.2.2         0.0.0.0         UG    0      0        0 eth0

host1# ping 195.101.94.80
PING 195.101.94.80 (195.101.94.80): 56 data bytes
92 bytes from 10.22.2.2 (10.22.2.2): Redirect Host(New addr: 10.22.2.3)
Vr HL TOS  Len   ID Flg  off TTL Pro  cks      Src      Dst
 4  5  00 0054 0777   0 0000  3f  01 4662 10.22.2.4  195.101.94.80 


--- janus-2-20.x-echo.com ping statistics ---
2 packets transmitted, 0 packets received, 100% packet loss


iptables -t filter -A FORWARD -p icmp -j LOG --log-ip-options --log-prefix --FILTER-FORWARD--
iptables -t filter -A PREROUTING -p icmp -j LOG --log-ip-options --log-prefix --NAT-PREROUTING--
iptables -t filter -A POSTROUTING -p icmp -j LOG --log-ip-options --log-prefix --NAT-POSTROUTING--

Oct 25 00:19:42 host3 --NAT-PREROUTING--IN=bridge OUT= PHYSIN=eth0 MAC=00:e0:4c:ff:02:5e:00:0a:95:f5:1b:fc:08:00 SRC=10.22.2.4 DST=212.27.33.225 LEN=84 TOS=0x00 PREC=0x00 TTL=64 ID=2197 PROTO=ICMP TYPE=8 CODE=0 ID=233 SEQ=0 
Oct 25 00:19:42 host3 --FILTER-FORWARD--IN=bridge OUT=bridge PHYSIN=eth0 PHYSOUT=eth1 SRC=10.22.2.4 DST=212.27.33.225 LEN=84 TOS=0x00 PREC=0x00 TTL=64 ID=2197 PROTO=ICMP TYPE=8 CODE=0 ID=233 SEQ=0 
Oct 25 00:19:42 host3 --NAT-POSTROUTING--IN= OUT=bridge PHYSIN=eth0 PHYSOUT=eth1 SRC=10.22.2.4 DST=212.27.33.225 LEN=84 TOS=0x00 PREC=0x00 TTL=64 ID=2197 PROTO=ICMP TYPE=8 CODE=0 ID=233 SEQ=0
Oct 25 00:19:42 host3 --FILTER-FORWARD--IN=bridge OUT=eth2 PHYSIN=eth1 SRC=10.22.2.4 DST=212.27.33.225 LEN=84 TOS=0x00 PREC=0x00 TTL=62 ID=2197 PROTO=ICMP TYPE=8 CODE=0 ID=233 SEQ=0 
Oct 25 00:19:43 host3 --FILTER-FORWARD--IN=bridge OUT=bridge PHYSIN=eth0 PHYSOUT=eth1 SRC=10.22.2.4 DST=212.27.33.225 LEN=84 TOS=0x00 PREC=0x00 TTL=64 ID=2199 PROTO=ICMP TYPE=8 CODE=0 ID=233 SEQ=1

As you can see packets doesnt pass through POSTROUTING when routed to internet. I think that's the problem. But why do they pass through it when host2 is the default route and not when it is host4 ?

ohoh, weird, I launched "tcpdump -i bridge icmp" to see what's happening and it is working when tcpdump is listening !
If I kill tcpdump it  stops working...

Oct 25 00:46:14 host3 --NAT-PREROUTING--IN=bridge OUT= PHYSIN=eth0 MAC=00:50:22:b1:0d:19:00:50:22:b0:90:98:08:00 SRC=10.22.2.4 DST=152.2.210.81 LEN=84 TOS=0x00 PREC=0x00 TTL=63 ID=1882 PROTO=ICMP TYPE=8 CODE=0 ID=231 SEQ=0 
Oct 25 00:46:14 host3 --FILTER-FORWARD--IN=bridge OUT=eth2 PHYSIN=eth0 SRC=10.22.2.4 DST=152.2.210.81 LEN=84 TOS=0x00 PREC=0x00 TTL=62 ID=1882 PROTO=ICMP TYPE=8 CODE=0 ID=231 SEQ=0 
Oct 25 00:46:14 host3 --NAT-POSTROUTING--IN= OUT=eth2 PHYSIN=eth0 SRC=10.22.2.4 DST=152.2.210.81 LEN=84 TOS=0x00 PREC=0x00 TTL=62 ID=1882 PROTO=ICMP TYPE=8 CODE=0 ID=231 SEQ=0 
Oct 25 00:46:14 host3 --FILTER-FORWARD--IN=eth2 OUT=bridge PHYSOUT=eth0 SRC=152.2.210.81 DST=10.22.2.4 LEN=84 TOS=0x00 PREC=0x00 TTL=45 ID=54251 PROTO=ICMP TYPE=0 CODE=0 ID=231 SEQ=0 
Oct 25 00:46:15 host3 --NAT-PREROUTING--IN=bridge OUT= PHYSIN=eth0 MAC=00:50:22:b1:0d:19:00:0a:95:f5:1b:fc:08:00 SRC=10.22.2.4 DST=152.2.210.81 LEN=84 TOS=0x00 PREC=0x00 TTL=64 ID=1886 PROTO=ICMP TYPE=8 CODE=0 ID=231 SEQ=1 
Oct 25 00:46:15 host3 --FILTER-FORWARD--IN=bridge OUT=eth2 PHYSIN=eth0 SRC=10.22.2.4 DST=152.2.210.81 LEN=84 TOS=0x00 PREC=0x00 TTL=63 ID=1886 PROTO=ICMP TYPE=8 CODE=0 ID=231 SEQ=1 
Oct 25 00:46:15 host3 --NAT-POSTROUTING--IN= OUT=eth2 PHYSIN=eth0 SRC=10.22.2.4 DST=152.2.210.81 LEN=84 TOS=0x00 PREC=0x00 TTL=63 ID=1886 PROTO=ICMP TYPE=8 CODE=0 ID=231 SEQ=1 
Oct 25 00:46:15 host3 --FILTER-FORWARD--IN=eth2 OUT=bridge PHYSOUT=eth0 SRC=152.2.210.81 DST=10.22.2.4 LEN=84 TOS=0x00 PREC=0x00 TTL=45 ID=54252 PROTO=ICMP TYPE=0 CODE=0 ID=231 SEQ=1

Do you have any idea ? Do you need more informations ?
Thanks in advance.

- Michel
