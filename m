From: nick black <dank@suburbanjihad.net>
Date: Thu, 1 Jul 2004 08:20:20 +0000 (UTC)
Message-ID: <slrnce7ia4.ot2.dank@hoist.localnet>
References: <BAY19-F21HzvB6zLEoS000bee2d@hotmail.com>
Sender: news <news@sea.gmane.org>
Subject: [Bridge] Re: Bringing up bridge at boot (properly)
Reply-To: dank@reflexsecurity.com
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

On 2004-06-30, Adam Hewgill <ahewgill@hotmail.com> wrote:
> If you are using a machine as an ethernet bridge how are you
> configuring it (include distro specific stuff) to create and enable the
> bridge during the boot process?

Here's a simple setup borrowed from my home firewall, snipped to show only
the bridge-related setup.  I have a four-port tulip and one half of a dual
eepro100 forming a broadcast medium via a brouter.  relevant init.d/firewall:

BRBIN=brctl
BRIDGE=br0
INTERNAL_NETMASK=24
INTERNAL_IP=192.168.0.1
BR_ADDR="$INTERNAL_IP/$INTERNAL_NETMASK"
for i in `seq 1 5`
BR_IFACES="eth1 eth2 eth3 eth4 eth5"

case "$1" in
  start)
        $BRBIN addbr $BRIDGE
        for i in $BR_IFACES ; do
                $BRBIN addif $BRIDGE $i
                ip l set up dev $i
        done
        ip l set up dev $BRIDGE
        ip a a $BR_ADDR dev $BRIDGE
        ;;
  stop)
        ip a d $BR_ADDR dev $BRIDGE
        ip l set down dev $BRIDGE
        for i in $BR_IFACES ; do
                ip l set down dev $i
                $BRBIN delif $BRIDGE $i
        done
        $BRBIN delbr $BRIDGE
        ;;
esac

with debian, man update-rc.d to get it going.  i try to hit right
after interface naming and before firewall setup.   do remember that
default behavior will allow any ip on the machine to be hit through
the bridge (at least by my experience in 2.[46]), so firewall things
well.

-- 
nick black <dank@reflexsecurity.com>
"np:  nondeterministic polynomial-time
the class of dashed hopes and idle dreams." - the complexity zoo

