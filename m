Date: Fri, 04 Feb 2005 10:55:28 -0800 (PST)
From: Jordan Eunson <maillist@heteromail.com>
Message-id: <33113.24.85.247.221.1107543328.squirrel@heteromail.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8bit
Subject: [Bridge] Wireless bridge
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

This isn't a question directly about brctl per se. I have a WRT54G linksys
box on one side of my office and a linux router with an Atheros G card
running madwifi on the other. I want the linux box to be a bridge between
the hard wired clients connect to the linux router and wireless linksys
box on the other side of the office. So what I did was, on the linux box
told it the essid and MAC address to connect to. This was tested by
assigning an ip the atheros interface and ping the linksys box, test came
back good. I zero'd the IP on the atheros card and bridge the atheros and
the local eth0 together. I connect a my laptop to the eth0 port and try
ping the linksys box, but the pings wont flow. This is the problem, now
maybe I'm expecting something that just isn't going to happen because of
the way wifi works, but that's why I'm posting.


