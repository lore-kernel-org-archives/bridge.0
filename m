Date: Tue, 23 Mar 2004 11:59:31 -0700
From: Mike Snitzer <msnitzer@lnxi.com>
Message-ID: <20040323115931.B21457@lnxi.com>
References: <20040316082837.1797.qmail@daitarn.register.it>
	<20040316110702.589a76e8@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <20040316110702.589a76e8@dell_ss3.pdx.osdl.net>;
	from shemminger@osdl.org on Tue, Mar 16, 2004 at 11:07:02AM -0800
Subject: [Bridge] Re: Strange DHCP behaviour with bridging
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@osdl.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 16 2004 at 12:07,
Stephen Hemminger <shemminger@osdl.org> wrote:

> On Tue, 16 Mar 2004 09:28:37 +0100
> <a.fiorino@chibacity.it> wrote:
> > Here is the scenario: I have one server with kernel 2.4.24 with a
> > bridge br0 made of 2 interfaces, eth0 and tap0 (the last is an OpenVPN
> > tunnel), and one remote computer connetting through tap0. 
> > 
> > If I assign a static IP to the remote computer, the bridge works perfecly 
> > (so I think the problem is not OpenVPN-related). If I start a DHCPd on the
> > server and I configure the remote client to get the IP from it,
> > something strange happens: if I "sniff" on the br0 interface, I can
> > see the DHCP requests coming from the client (from 0.0.0.0.bootpc to
> > 255.255.255.bootps) and the DHCPd answers going back from
> > ip.of.the.server.bootps to 255.255.255.255.bootpc; also sniffing on
> > eth0 gives the same result, but if I sniff on the tap0 interface, I
> > don't see the replies! So the client never get its own IP. What I'm
> > doing wrong? To add some mistery, sometimes (one try out of 10) the
> > reply flows correctly to the remote client. All the three interfaces
> > (eth0, br0, tap0) doesn't have firewalling enabled, and under /proc
> > ip_forwarding is enabled and rp_filter is disabled for all
> > interfaces. brctl showmacs br0 correctly shows the remote virtual
> > interface MAC address as not local.Both eth0 and tap0 have been
> > configured with ifconfig 0.0.0.0 promisc up.
> 
> So the packet makes it into the tap0 device, but the bridge doesn't know
> where to send the output.  Are you running spanning tree protocol or not?
> Look at the contents of the forwarding table (brctl showmacs br0)
> Spanning tree does take a while to settle on startup so it could be that
> you need to wait about a minute till the bridge starts running.
> 
> Or may the tap device doesn't have a real hardware mac
> address is confusing it.

Hello,

I have been trying to get bridging with tap devices working for a few
days; it would appear as though the bridge is unable to properly forward
traffic to the remote end of a tap device from another tap (specifically
between 2 UMLs).  

If I enslave 2 tap devices to the bridge and then start 2 UMLs that supply
the remote (non-local) ends of the tap the bridge shows:

snitm@amstel:~> sudo brctl showmacs br0
port no mac addr                is local?       ageing timer
  1     00:ff:33:9f:43:45       yes                0.00
  2     00:ff:91:17:3a:d5       yes                0.00
  1     fe:fd:c0:a8:00:02       no                30.74
  2     fe:fd:c0:a8:00:03       no                 0.27

NOTE:
local #1 is tap0
local #2 is tap1
non-local #1 is uml0's eth0
non-local #2 is uml1's eth0

From within either guest UML I can ping the host but I cannot ping the
other guest UML.  On the host I can ping each eth0 interface of the guest
UMLs.  If I go ahead and enslave an ethernet device on the host (making
other machines available through that device) the UML guests can't ping
those machines either.  Meanwhile the bridge (host/umlhost) is able to
ping all enslaved members of the switch (local or non-local).

I even have iptables MASQ going on the host so that traffic from br0 is
routed out eth0 to the greater internet; the guest UMLs can get out to the
net fine.  

SO ultimately attempts to communicate through a tap device to other
members of the ethernet bridge fail (except for the bridge's IP and other
physical devices on the host machine).

My findings with pinging other machines that are available through a eth
device that I enslave closely mirror what was describved earlier on this
list:

http://lists.osdl.org/pipermail/bridge/2004-February/000188.html

Any insight into the bridging code's ability to _really_ work with tap
devices would be greatly appreciated.

I've attached a script that I use to easily start and stop the bridge and
tap devices; maybe it could help others trying to reproduce these tap
issues with bridging.

Regards,
Mike

FYI.
I've subscribed to the bridge list but haven't been approved yet.

--T4sUOijqQbZv57TR
Content-Type: application/x-sh
Content-Disposition: attachment; filename="bridge.sh"

#!/bin/bash

# UML Bridge HOWTO: http://edeca.net/articles/bridging/index.html

set -ex

IPTABLES="iptables"

DMZ_IF=""
OUT_IF="eth0"
USE_NAT=1

BRIDGE="br0"
BRIDGE_IP="192.168.0.1"
BRIDGE_NET="192.168.0.0/24"

# Connect $NUM_TAPS to the bridge (for use with UML)
# each UML will need to assign itself an IP from 192.168.1.X
# ... add as many uml tap devices as you like ... 
# set $NUM_TAPS starting with 0, so for 3: NUM_TAPS=2
NUM_TAPS=1
TAP_NAME="tap"
MYUSER="snitm"

bridge_start() {    
    # BUILD THE BRIDGE:    
    brctl addbr $BRIDGE
    brctl setfd $BRIDGE 0
    brctl sethello $BRIDGE 0
    brctl stp $BRIDGE off
    ifconfig $BRIDGE $BRIDGE_IP up
    if [ -n "$DMZ_IF" ] ; then
	# Bridge is taking over an internal interface
	ifconfig $DMZ_IF 0.0.0.0 promisc up
	brctl addif $BRIDGE $DMZ_IF
    fi

    # CONNECT TAP DEVICES TO THE BRIDGE:
    for NUM in `seq 0 ${NUM_TAPS}` ; do
	tunctl -u $MYUSER -t ${TAP_NAME}${NUM}
	ifconfig ${TAP_NAME}${NUM} 0.0.0.0 promisc up
	brctl addif $BRIDGE ${TAP_NAME}${NUM}
    done

    if [ "$USE_NAT" = "1" ] ; then
        # SETUP THE NAT'd FIREWALL:
        # based on: http://www.suse.com/~kraxel/uml/howto.html
        # reset tables
	$IPTABLES -t filter -F
	$IPTABLES -t mangle -F
	$IPTABLES -t nat    -F
	
	# so enslaved devices don't use NAT to reach each other
	$IPTABLES -t nat -A POSTROUTING -s $BRIDGE_NET -d $BRIDGE_NET -j ACCEPT
	$IPTABLES -t nat -A POSTROUTING -s $BRIDGE_NET -j MASQUERADE

        # mark packages which we want NAT
	$IPTABLES -t mangle -A FORWARD -i $BRIDGE -o $OUT_IF -j MARK --set-mark 1

        # allow forward for marked (+related) packages
	$IPTABLES -t filter -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
	$IPTABLES -t filter -A FORWARD -m mark --mark 1 -j ACCEPT
	$IPTABLES -t filter -P FORWARD DROP

        # translate marked packages
        $IPTABLES -t nat -A POSTROUTING -m mark --mark 1 -j MASQUERADE

        # enable IP forwarding
        echo 1 > /proc/sys/net/ipv4/ip_forward
    fi
}

bridge_stop() {
    # TEAR DOWN THE BRIDGE:
    ifconfig $BRIDGE down
    [ -n "$DMZ_IF" ] && brctl delif $BRIDGE $DMZ_IF
    
    for NUM in `seq 0 ${NUM_TAPS}` ; do
	ifconfig ${TAP_NAME}${NUM} down
	brctl delif $BRIDGE ${TAP_NAME}${NUM}
        tunctl -d ${TAP_NAME}${NUM}
    done

    brctl delbr $BRIDGE

    if [ "$USE_NAT" = "1" ] ; then
        # REMOVE THE FIREWALL RULES:
	$IPTABLES -t filter -F
	$IPTABLES -t mangle -F
	$IPTABLES -t nat    -F
    fi 

    if [ -n "$DMZ_IF" ] ; then
	# restore DMZ_IF interface
	ifconfig $DMZ_IF $BRIDGE_IP
    fi
}

case "$1" in
  start)
    bridge_start
    ;;
  stop)
    bridge_stop   
    ;;
  restart|force-reload)
    bridge_stop
    bridge_start
    ;;
  *)
    echo "Usage: /etc/init.d/bridge {start|stop|restart|force-reload}"
    exit 1
    ;;
esac

exit 0

--T4sUOijqQbZv57TR--
