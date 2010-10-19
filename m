MIME-Version: 1.0
Date: Tue, 19 Oct 2010 10:46:38 -0700
Message-ID: <AANLkTinBfvrkb6Oe832h8QFO8B7i4bzdYo9YzsimCrY+@mail.gmail.com>
From: Erik Schweigert <ejschweigert@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bridge] VLAN traffic through an Ethernet Bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello all,

I have configured a transparent ethernet bridge containing two network
interfaces: eth0, eth1 in br0.  IP forwarding is enabled i.e. cat
/proc/sys/net/ipv4/ip_forward = 1.

All traffic destined through my Linux machine has the 802.1Q tag
(VLAN).  However, only ARP with the VLAN tags passes through the
machine correctly (100% of the time) and broadcast and multicast
appears to work.  It 'seems' IP layer and above is being dropped if it
is unicast, or intermittently works ( +/- 1 of 10 ICMP passes
through).

All non-VLAN'd traffic passes through my machine flawlessly.

arptables, ebtables, and IPtables are all flushed, so there is no
possibility of any traffic being blocked.

Is there a caveat with ethernet bridging that does not permit VLAN'd traffic?

Any help or suggestions is greatly appreciated!

Thanks,

Erik
