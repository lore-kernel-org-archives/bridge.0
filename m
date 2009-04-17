MIME-Version: 1.0
Date: Fri, 17 Apr 2009 15:48:45 +0530
Message-ID: <26bd38970904170318u1258868etbd6ff9225ec7c677@mail.gmail.com>
From: Jon Vincent <jon.bvincent@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Help on configuring ports for RSTP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, "Srinivas M.A." <srinivas.aji@gmail.com>

Hello,
I'm testing the userspace RSTPD daemon using the source from:

https://lists.linux-foundation.org/pipermail/bridge/2009-February/006178.html

The switch setup under testing is pictured below:


  Uplink               Uplink
    |                    |
    |u1                  |u2
    |           T        |
[Eth.Switch]---------[Eth.Switch]
   ES1                  ES2
    |                    |
    |c1                  |c2
    |                    |
   CPU1                 CPU2

The ethernet switch is from Marvell and supports distributed switching
architecture (DSA). The control interface to the switch is from the
CPU and the rstpd is run on the CPU. The CPU's ethernet port is also
connected to the ethernet switch but it does not participate for STP
and is not bridged.

Each CPU has two pseudo network interfaces (u1 and T) that are bridged
and RSTP is run on the bridge. When both uplinks u1 and u2 are
connected to an external switch, rstpd detects the loop and puts one
of the uplink to discarding mode. Here are the port states and
configurations that i'm using for the above setup:

Switch        Port      AutoEdge   P2P   AdminEdge
ES1           u1        Yes        Yes   No
              T         No         Yes   No
ES2           u2        Yes        Yes   No
              T         No         Yes   No

rstpd's computed port states:
             Switch        Port      State
Root bridge  ES1           u1        forwarding
                           T         forwarding
             ES2           u2        discarding
Root port                  T         forwarding

I'm trying to ping CPU2 from CPU1 which works. Given the above state
table, the packets are sent through the link T from CPU1 to CPU2 and i
do not have packet drops. When trying to ping CPU1 from CPU2, there
are around 50% packet drops. In this case too, the packets can only be
sent through T since the link u2 is in discarding mode.

I suspected it could be a configuration issue in the ethernet switch
and to test that, i stopped the rstpd and the ping works fine in both
the directions. If the network interface u2 is down'ed (by plugging
out the cable), the ping happens smoothly without packet drops. The
only scenario where the packet drop seems to happen is when the
non-root bridge has one of its port in discarding mode.

It would be really helpful if someone could let me know if i'm wrong
in any of the configuration to be done for RSTP.

Thanks,
Jon
