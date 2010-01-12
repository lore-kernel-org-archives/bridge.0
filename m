MIME-Version: 1.0
Date: Tue, 12 Jan 2010 16:13:01 +0100
Message-ID: <8cad0aa1001120713h55bcde41p56bcd1771030e7ec@mail.gmail.com>
From: Jean-Michel Hautbois <jhautbois@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bridge] Bridging LACP (802.3ad) frames not working
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi there !

I have connected two ethernet 1000Mbps interfaces to my routers, and I
have built a bridge between them :
eth1 <---> br0 <---> eth2

When I am transmitting UDP, ADP, ARP or any other type of frames, I
don't have any problem.
But when, the router sends LACP packets, it is not transmitted
(neither from eth1 to eth2 than from eth2 to eth1).

I can't figure out why, so if you have an idea, thanks in advance for
your help !

Best Regards !
JM
