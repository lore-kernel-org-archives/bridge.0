Date: Fri, 30 Jun 2006 13:59:10 +0200
From: Marc Weber <marco-oweber@gmx.de>
Message-ID: <20060630115910.GC6638@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] Some newbe questions
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

[desktop] ----- lan ----eth0 [notebook] eth1
                  192.168.?.?           ` ----- wlan ---- [speedport(hub and router)] -- internet
					           192.168.2.x

So on my laptop I have eth0 beeing lan, eth1 beeing wlan ethernet card.

When only using eth0/1  everything is fine.
Now I want to be able to use internet from both [desktop] and
[notebook].

Typically you set up a bridge with

brctl addbr br1
brctl addif br1 eth0
brctl addif br1 eth1
ifconfig eth0 0.0.0.0 up
ifconfig eth1 0.0.0.0 up
ifconfig br1 up
, right?

When do I have to set the iwconfig settings? (Web password, essid?)
When I also want use the internet (connect to desktop via vnc) from the
notebook I have to assign an ip to the bridge, correct?
ifconfig br1 192.168.x.y up

eth1 connects to lan having ips of from 192.168.2.x
Because I want to connect from desktop to speedport (using the bridge)
This network (192.168.?.?) has to be 192.168.2.x, too. Correct?

Can you recommend a networking documentation which explains these
things?

Marc
