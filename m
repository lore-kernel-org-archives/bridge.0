From: "Fernando Rodriguez" <frod@aitelecom.net>
Date: Sat, 24 Feb 2007 10:50:32 -0600
Message-ID: <007a01c75833$e59349c0$978086c9@sam>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Problem on bridge
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org


Hello, 

I have set up a bridge with the following script that starts after the
network interfaces are started

BRIDGENAME="BRQ"
GATEWAY="192.168.0.1"
BRIDGE_IP="192.168.0.122"
BRIDGE_NETMASK="255.255.255.0"
STP_ON="yes"
STP_PRIO="1"
RETVAL=0

start() {
        echo "Starting service bridge"
       ifconfig eth2 promisc up
        ifconfig eth3 promisc up
        brctl addbr $BRIDGENAME  ||  return=$rc_failed
        brctl addif $BRIDGENAME eth2  ||  return=$rc_failed
        brctl addif $BRIDGENAME eth3  ||  return=$rc_failed
        ifconfig eth2 0.0.0.0  ||  return=$rc_failed
        ifconfig eth3 0.0.0.0  ||  return=$rc_failed
        brctl sethello $BRIDGENAME 1  ||  return=$rc_failed
        brctl setmaxage $BRIDGENAME 4  ||  return=$rc_failed
        brctl setfd $BRIDGENAME 4  ||  return=$rc_failed
        brctl stp $BRIDGENAME $STP_ON
        brctl setbridgeprio $BRIDGENAME $STP_PRIO
        ifconfig $BRIDGENAME $BRIDGE_IP netmask $BRIDGE_NETMASK up

        ip route flush cache
        ip route add default via $GATEWAY

But the problem i have is that i am not able to contact the bridge on its IP
192.168.0.122 i am running Centos 4.4 on a 2.6.18 kernel, i have tested this
setup on 3 different sets of network cards tg3, b44, via-rhine and in all of
them i have the same results no connection, i know the bridge is working
otherwise packets couldnt flow on the network, im using bridge utils 1.0.4-4

If any one knows what could be wrong??

Thanks


