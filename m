From: Riccardo Cazzola <r.cazzola@it-d.com>
Content-Type: text/plain
Message-Id: <1090407877.2062.11.camel@netforce2.gonetforce.com>
Mime-Version: 1.0
Date: Wed, 21 Jul 2004 13:04:38 +0200
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Bridge ipaddress stop responding
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello,
I'm trying to use bridge to connect my wireless lan with my wired lan.
I configured an ip adress on the br0 interface to reach the linux box.
At the beginning all proceed as I suppose: the bridge is operative and I
can ping (and also ssh connect) my linux box.
After a night, the bridge is still functioning (the client obtain an
address from dhcp, surf the web, check mail, etc.) but if I ping the
address of the bridge I only obtain a request timed out.
I nedd to reach the bridge to use it as a vpn concentrator for my
roadwarriors
I'm using slackware 10, but the same problem I had with knoppix/debian


