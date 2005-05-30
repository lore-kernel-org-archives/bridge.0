From: Jaime Nebrera <jnebrera@eneotecnologia.com>
Content-Type: text/plain
Date: Mon, 30 May 2005 09:25:23 +0200
Message-Id: <1117437923.32764.9.camel@buttercup>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Strange problem, please help
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

  Hi all,

  We are experiencing a very strange problem and would need some help.
We have a Leaf based box (actually a Lince box kernel 2.4.26) running as
a bridge with 8 gigabit ethernets, PIV 3Ghz, 2GB RAM. 4 of them share
the same PCI Express and the other 4 a different PCI bus. We have NAPI
enabled on all ethernets and IRQ moderation enabled (dynamic)

  Some ASCII art before proceeding.

     Router 1               Router 2
        |                       |
        --------- Switch --------
                     |
                     |
                  Firewall

 
   WAN  LAN Empty Empty Empty Empty Empty Empty
    |    |     |     |     |     |     |     |
   eth0 eth1 eth2  eth3  eth4   eth5  eth6  eth7
    -----------------      -------------------
          PCI-X                     PCI

  Both routers use HSRP from Cisco to share information about who is
alive. This app uses multicast UDP packets to 224.0.0.1 address, port
1985.

  The problem is, after a while (1 or 2 minutes) the CPU reaches 100%
(0.99 load 99% System) with the process ksoftirqd_CPU0 reaching 99%.
Using iptraf we discover ethernets 4 to 7 (the ones that share the PCI
bus) are at full speed. The traffic is on port 1985 and comes from the 2
virtual IP from the redundant routers. It seems they enter an infinite
loop and completely kill the system. BTW, the only used ethernets are 0
and 1, both on the PCI-X bus, and eth2 and eth3 seem unaffected (no
traffic). Bear in mind, real traffic on eth0 and eth1 doesnt surpass
1Mbps. Also, no service is provided at this point, not even firewalling.

  The problem appears with and without STP activated and we have
verified there is not a loop in the network.

  If we disable ethernets from 4 to 7 (ip link set ethx down) the
problem seems to disappear, but we are not sure as we didnt want to
disturb the client more time (actually, for 15 minutes the problem didnt
appear, while the other way it appeared in much less than 5 minutes). In
this case, even activating things like a Netflow probe in eth0 didnt
disturb at all the system.

  The same problem seems to appear with a Via 1Ghz box with 4 realtek
ethernets and around 4Mbps of traffic (this system was placed under
heavier load, and as the problem appeared, we tested with the big box 
the same afternoon). When the problem appeared this box was so slow 
we could not even make a ssh session so we dont know if this is the 
same problem (but bet it is).

  So, some questions:

  1) Is this related to running as a bridge? Would this problem
disappear if we used a pseudo bridge (proxy ARP)?

  2) Can such a beast sustain 8 ethernets as a single bridge? Bear in
mind they dont have gigabit traffic, they just use gigabit ethernets :)
Whats the limit for a linux bridge? Would be better to break it into two
bridges?

  3) As this traffic is only needed on both routers but doesnt need to
pass trough the firewall, will dropping it on eth0 solve the problem?
(That way there is no way the packets enter into other ethernet ports)
What would happen with other multicast based apps? Would they need to be
dropped too?

  Very thankful in advance. Regards.

-- 
Jaime Nebrera - jnebrera@eneotecnologia.com
Consultor TI - ENEO Tecnologia SL
Telf.- 95 455 40 62 - 619 04 55 18

