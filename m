Message-ID: <40D72643.5020400@xepa.nl>
Date: Mon, 21 Jun 2004 20:17:39 +0200
From: Michiel Brandenburg <bridge@xepa.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] NAT on a bridge (solved sortof)
Reply-To: bridge@xepa.nl
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: t.luettgert@pressestimmen.de
Cc: bridge@lists.osdl.org

Torsten,

I suffered a similar problem and was wondering if you found a better 
solution to the problem of dnatting on a transparent bridge.

My setup: INTERNET <-> ROUTER <-> (linux)BRIDGE <-> INTERNAL NETWORK

Solution: setup a bridge with ip x.x.x.51 and alias another ip to the 
bridge x.x.x.50 ( using a /16 network at home )  Now get the router to 
send all incomming traffic to .50
DNAT traffic you want on your bridge to .51 and other traffic to say 
.101 Now it works .. very strange, hey works here.

<-------------------- rules ------------------------------>
iptables -t nat -N toZeus
iptables -t nat -I toZeus -m physdev --physdev-in eth1 \
	-s ! x.x.0.0/16 -j DNAT --to x.x.x.51
iptables -t nat -N toHerc
iptables -t nat -I toHerc -m physdev --physdev-in eth1 \
	-s ! x.x.0.0/16 -j DNAT --to x.x.x.101
iptables -t nat -I PREROUTING -p tcp -m multiport  \
	-d x.x.x.50 --destination-ports \ 					 
ftp,sftp,ssh,smtp,ssmtp,http,pop3,pop3s,imap,imaps \
	-j toZeus
iptables -t nat -I PREROUTING -p udp -m multiport \
	-d x.x.x.50 --destination-ports 41111 -j toHerc
iptables -t nat -I PREROUTING -p tcp -m multiport \
	-d x.x.x.50 --destination-ports 41111 -j toHerc
<-------------------- end rules --------------------------->

I just joined this list sorry, if I missed the solution.

Michiel Brandenburg
