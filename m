From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 07 May 2008 11:22:01 +0200
Message-Id: <1210152122.32216.95.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Subject: [Bridge] STP bug, loop not detetcted
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bridge@lists.linux-foundation.org

Got a bridge with 4 optical VLAN interfaces, eth1.1, eth1.2, eth1.3 and
eth1.4, attached and the builtin STP enabled. eth1 is connected to
a "switch" with 4 real interfaces, each real interface maps to one of
the above mentioned VLANs.  

If I loop two or more interfaces by connecting each interface's output
to its own input, I get a loop that STP doesn't detect.
Looping by connecting an output from one interface to another interface
input works fine.

Bug or limitation in STP? If limitation, would RSTP help here?

Kernel 2.6.25

 Jocke  
