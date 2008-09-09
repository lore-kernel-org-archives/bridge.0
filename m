Message-ID: <ef6cbd7b0cc8d867f0702b0494896b60.squirrel@www.arcoscom.com>
Date: Tue, 9 Sep 2008 10:29:37 +0200 (CEST)
From: "ArcosCom Linux User" <linux@arcoscom.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Help with multiple IP networks over an ethernet one
Reply-To: linux@arcoscom.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, linux-net@vger.kernel.org, netfilter@vger.kernel.org

Hello people,
   I have a little problem with one linux box that route some local IP
networks between them and internet.
   An schema from the IP point of view is this:
        (3 uplinks)
  INTERNET <---> route <---> LANS

  From ethernet point of view is this:

  INET link 1 <--->        <---> INET link 3
  INET link 2 <---> router <---> LANs

  Physically there are 3 ethernet networks, one for the uplink 1, other
for uplink 2, and the third is for the lans and the uplink 3.
  I forced to share the ethernet for the LANs and uplink 3.

  The router has 4 interfaces, eth1 for uplink 1, eth2 for uplink 2, eth3
for uplink 3 and eth0 for the LANs.

  The problem I have is that, without a constant time or reason, sometimes
I detect latences between uplink 3 and the router, and other times
between the router and LAN hosts.

  I think that I need to configure something in eth3 config files
(/proc/sys/net/ipv4/conf/eth3) to disallow local frames and allow only
the router and uplink 3 gateway comunication, but I don't found anything
that help me.

  I tried with arp_filter, rp_filter, and many of them, but without
success (I don't found many documentation about it, and I review lartc
and googled about that parameters).

  I think that only allowing arp traffic betwen eth3 and uplink 3 gateway
(using arptables) will solve this, but I don't know if arptables will be
the solution or not.

  Do anybody help me a bit?

  Thanks!!


