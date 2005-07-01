Message-ID: <42C59E66.8050906@ntbox.com>
Date: Fri, 01 Jul 2005 12:49:58 -0700
From: North Antara <north@ntbox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] bridge-utils + Linksys WET11
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

So, I'm setting up my first bridge, and I'm running into an interesting
issue.

I have a 4 port NIC (formerly 4 seperate /29 and /28 LANs) and an
onboard NIC (to my ISP).

I've setup the bridge using the script included at the bottom of this
email (modified from Gentoo for Aurora).

When the WET11 (the WET11 is a simple ethernet to wireless bridge) is
unplugged, the bridge works wonderfully.  I'm able to connect out to the
internet, and clients are able to talk to each other.

When the WET11 is plugged in is when things start acting up.  Every
client (including those behind the WET11) are able to connect out to the
internet, but clients cannot talk to each other.  If Client A(port 1)
tries to connect to Client B(port 2), `brctl showmacs br100` shows that
Client B moved to port 4(port 4 is where the WET11 is plugged in.  If I
change the WET11 port, the port Client B moves to is also changed), and
the router can no longer ping Client B.

[root@deadbeef root]# brctl showmacs br100
port no mac addr                is local?       ageing timer
  2     00:02:a5:d3:a2:a9       no                19.71
  1     00:04:5a:6f:f4:66       no                 0.01
  4     00:12:17:47:90:43       no                 0.43
  4     00:13:10:16:1e:19       no                 8.43
  1     08:00:20:ad:0b:58       yes                0.00
  2     08:00:20:ad:0b:59       yes                0.00
  3     08:00:20:ad:0b:5a       yes                0.00
  4     08:00:20:ad:0b:5b       yes                0.00

after pinging Client B from Client A...Client B moves.

[root@deadbeef root]# brctl showmacs br100
port no mac addr                is local?       ageing timer
  4     00:02:a5:d3:a2:a9       no                 0.10   <-- note the port change
  1     00:04:5a:6f:f4:66       no                 0.00
  4     00:12:17:47:90:43       no                 0.49
  4     00:13:10:16:1e:19       no                12.76
  1     08:00:20:ad:0b:58       yes                0.00
  2     08:00:20:ad:0b:59       yes                0.00
  3     08:00:20:ad:0b:5a       yes                0.00
  4     08:00:20:ad:0b:5b       yes                0.00


I've read in the archives that wireless NICs would cause issues, but
that shouldn't be the case here, since the router doesn't even know it's
wireless, should it?

Is this some sort of stp issue?

Any suggestions would be much appreciated.  I'm out of ideas.


#!/bin/bash
#
bridge="br100"
bridge_br100_devices="eth1 eth2 eth3 eth4"
bridge_br100_ip="192.168.1.1"

return=$rc_done
case "$1" in

    start)
        for b in ${bridge}
        do
                echo "Create Bridge ${b}"
                /usr/sbin/brctl addbr ${b} || {
                        retval=$?
                        echo ${retval} "Failed to create bridge ${b}"
                        continue
                }
                for i in $(eval echo \$\{bridge_${b}_devices\})
                do
                        /usr/sbin/brctl addif ${b} ${i} || {
                                retval=$?
                                echo ${retval} "Failed to add interface
${i}"
                                continue
                        }
                        ifconfig ${i} 0.0.0.0 promisc || \
                                echo $? "Failed to set up interface ${i}"
                done
                ifconfig $b $(eval echo \$\{bridge_${b}_ip\})

                brctl setbridgeprio ${b} 0

                brctl sethello ${b} 1
                brctl setmaxage ${b} 4
                brctl setfd ${b} 4
                brctl stp ${b} on
        done

        echo -e "$return"
        ;;
    [snip]the rest of the script isn't relevant[/snip]
esac

