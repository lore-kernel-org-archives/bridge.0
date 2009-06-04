MIME-Version: 1.0
Date: Thu, 4 Jun 2009 13:58:12 +0530
Message-ID: <a8e2ebfb0906040128p25fa2960j1c78045caadfc9b6@mail.gmail.com>
From: Ramasamy Chandramouli <ramasamycmouli@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Problem in mixing RSTP/STP configuration
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello,

I'm using rstpd application over two switches and they are connected
to another Nortel switch which operates STP rather than RSTP. They are
all connected by a 10/100 ethernet switch which does not process
BPDUs. Here is a simplified diagram when the system is up and running.

  +-------------+    R
  | Root-Bridge o--------+
  +-------------+    STP |
                         |
             +-----------o--------------+
             |      STP_SW_NORTEL       |
             +-----------o--------------+
                         |
                       L | STP
                         |
                   +-----o-----+
  +------+         |           |   10/100 ethernet
  | Host o---------o           |   switch
  +------+         |           |   (no BPDU processing)
                   +--o-----o--+
                      |     |
              STP     |     |    STP
           +----------+     +----------+
        p0 |                           | p0
     +-----o-----+               +-----o-----+
     |           | p1         p1 |           |
     | RSTP_SW1  o---------------o  RSTP_SW2 |
     |           |     RSTP      |           |
     +-----------+               +-----------+

The MACs of the bridges and the root bridge to which they are all
synced with are:

    Root bridge:     00:11:22:xx:xx:xx
    STP_SW_NORTEL:   00:11:58:xx:xx:xx
    RSTP_SW1:        02:e0:xx:xx:44:01
    RSTP_SW2:        02:e0:xx:xx:42:01

The STP_SW_NORTEL carries the root bridge identifier in its STP BPDU
and the RSTP algorithm on RSTP_SW1 and RSTP_SW2 migrates the p0 port
to perform STP transactions. After a brief TopologyChange transaction,
the port states were as follows:

   Switch    Port    Root-Bridge         Designated-Bridge   Role/State
  RSTP_SW1    p0     00:11:22:xx:xx:xx   02:e0:xx:xx:44:01   Root,Fwd
              p1     00:11:22:xx:xx:xx   02:e0:xx:xx:44:01   Altn,Disc

  RSTP_SW2    p0     00:11:22:xx:xx:xx   02:e0:xx:xx:42:01   Root,Fwd
              p1     00:11:22:xx:xx:xx   02:e0:xx:xx:42:01   Desg,Fwd

  p0 - auto-p2p, non-edge
  p1 - auto-p2p, auto-edge

The cost and port/bridge priorities are not modified and are left to
defaults assigned by the rstpd application. Sniffing the BPDUs from
the host reveals that after a while only STP_SW_NORTEL switch is
sending out the hello packets, and the bridges RSTP_SW1 and RSTP_SW2
are in sync with it.

I'm facing the following problem:

If the link L is removed, the switch RSTP_SW1 and RSTP_SW2 ends up
forming a loop. The port RSTP_SW1::p1 comes to forwarding state before
blocking the port RSTP_SW1::p0. The following are the sequence of
ports states:

                       RSTP_SW1           RSTP_SW2
[before L is connected]
                  p0:  altn/disc          desg/fwd
                  p1:  root/fwd           desg/fwd

[after L is connected]
                  p0:  root/fwd           root/fwd
                  p1:  altn/disc          desg/fwd

[after L is disconnected]
                  p0:  desg/fwd           root/fwd
                  p1:  root/disc          desg/fwd

                  p0:  desg/fwd           root/fwd
                  p1:  root/learn         desg/fwd

                  p0:  desg/fwd           root/fwd
                  p1:  root/fwd           desg/fwd

After disconnecting link L, the RSTP port moves through the
learning/forwarding states that puts the bridge to loop.

If the mediating ethernet switch is removed and if the switches
RSTP_SW1 and RSTP_SW2 are directly connected to  STP_SW_NORTEL switch,
the switches RSTP_SW1 and RSTP_SW2 loops up, if the root bridge link,
R is removed. The sequence seems to be:

       1.  RSTP_SW2::p0 sends out a TC BPDU with its own bridge ID as
root bridge id.
       2.  RSTP_SW1::p0 sends out a TC BPDU with the root bridge as
the lost root bridge's ID.
       3.  The above when received by RSTP_SW2::p0, thinks that it has
received a superior bridge and tries to sync up with the root bridge
ID sent by its neighbour: RSTP_SW1.

After the above sequence, the port RSTP_SW1::p1 ends up in
learning/forwarding sequence which eventually forms a loop before
migrating any of the other STP ports to blocking/discarding mode.

It would be of great help if some one could provide an insight into
what could be going wrong.

Regards,
Ramasamy
