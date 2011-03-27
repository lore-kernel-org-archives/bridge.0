Message-ID: <4D8F3A6A.2080103@mclink.it>
Date: Sun, 27 Mar 2011 15:23:54 +0200
From: Mauro Condarelli <mc5686@mclink.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Bridge] bridging problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,
I have a small home-office network built like this:


Internet
 |
Firewall(192.169.1.254) GREEN ---+-----------+----------+-----
(192.168.56.254)                 |           |          |
DMZ                        (192.168.1.5)    PC1        PC2
 |                            Server
WebServer                  (192.168.2.254)
                               WLAN
                                 |
                                 +-----------+----------+-----
                                 |           |          |
                                PCa         PCb        PCc

Firewall is DHCP and DNS server for everyone else.
Firewall is default gateway for everybody.
This arrangement works but requires a static route on firewall and, for
machines on WLAN to talk with wired ones (and vice versa) requires going
to firewall and back.

Is there some way to bridge together the two LANs (GREEN and WLAN) so
they can act as a single subnet (192.168.1.0/24)?

I tried some configurations, but they simply didn't work and I know too
little about bridging to troubleshot them.

Can someone help me, please?
Mauro
