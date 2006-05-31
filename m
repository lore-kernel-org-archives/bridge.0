From: "JPP" <jpp1@frws.com>
Date: Tue, 30 May 2006 18:16:39 -0600
Message-Id: <20060531000606.M43398@frws.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Subject: [Bridge] WAS Building 1.1? Now - can we get a NAT over a bridge
	working yet?
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hey All

Thanks - I have gotten the 1.1 brctl to build and its installed and the server 
rebooted.

NAT is still in its un-working state using iptables and NAT rules that run 
normally without the bridge.

I understand that firewalling/bridging and in turn, NAT is really something 
that should not happen. But my question is: Can Fedora C4 and iptables 1.3 
along with the newest bridging code provide for a NAT solution on a 2 NIC 
gateway/router/bridge/firewall ???
If not - any suggestions?

Logs show that the br0 interface is getting the traffic destined for the NAT'd 
machines, so its apparent that adding the newest bridge with the old iptables 
rules does not do the trick.
Log excerpt:
May 30 18:10:34 gw-ccfo kernel: IPT FORWARD packet died: IN=eth0 OUT=br0 
PHYSOUT=eth1 SRC=XXX.XXX.105.11 DST=192.168.68.200 LEN=66 TOS=0x00 PREC=0x00 
TTL=60 ID=60954 DF PROTO=TCP SPT=80 DPT=3665 WINDOW=8576 RES=0x00 ACK PSH 
URGP=0

IPTABLES basic NAT rule:
iptables -t nat -A PREROUTING -d XXX.194.217.191 -p tcp \
  -j DNAT --to 192.168.68.200
iptables -t nat -A PREROUTING -d XXX.194.217.191 -p udp \
  -j DNAT --to 192.168.68.200

iptables -t nat -A POSTROUTING -s 192.168.68.200 -o $EXTIF \
      -j SNAT --to-source XXX.194.217.191

Thanks in advance for any help.

Regards,
Jerome


--
FRWS WebMail (http://www.frws.com)
Cause you deserve Spam and Virus free email...

