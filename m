Content-Type: text/plain; charset="iso-8859-1"
Date: Sun, 10 Dec 2006 03:20:20 +0100
From: M.Rennt@gmx.net
Message-ID: <20061210022020.94000@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Linux Bridge + STP + VLAN
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hi,

we're running the standard linux bridge setup (redundant bridge) for 5 year=
s now. So first of all, thanks to everyone involved for implementing the br=
idging feature in Linux.

Now I'm trying to bridge hosts connected to VLAN'ed Cisco switches using li=
nux bridge.

I'm testing the following setup (Kernel 2.6.19, bridge-utils 1.2 on both br=
idges)

http://i147.photobucket.com/albums/r293/mrennt/BridgeProblem.jpg

The diagram shows how everything is setup. I'm not happy with the block of =
eth0 on BRIDGE2, although I'm able to reach the IP configured on the bridge=
 interface, I'm not sure if this is the correct STP behaviour, because eth0=
 is blocked, thus it shouldn't respond!?

Both Cisco switches (2950) have VLANs 1,10,20,31,32,33,34,50 configured.

Here's what I've done so far:

- Changed the multicast address on both bridges in order to not conflict wi=
th the Cisco switches spanning tree (as described in http://lists.osdl.org/=
pipermail/bridge/2005-October/001116.html)
- Enabled the bpdufilter on the trunk connections of both switches
- On the bridges: filtering requests originating in one VLAN going into ano=
ther VLAN
  i.e. ebtables -A FORWARD -i vlan10 -o ! eth0 -j DROP

Here's the output of brctl of both bridges.

I'm not sure about the attachement policy in this mailinglist, so I'm not p=
osting the output below as attachement, sorry if it's hard to read. :/
Let me know if a copy via mail is better.


ON SERVER "BRDIGE1"
---------------------------------------------------------
# brctl show br0
bridge name     bridge id               STP enabled     interfaces
br0             0000.000423c1e5f2       yes             eth0
                                                        vlan10
                                                        vlan20
                                                        vlan30
                                                        vlan31
                                                        vlan32
                                                        vlan33
                                                        vlan34
                                                        vlan50


# brctl showstp br0
br0
 bridge id              0000.000423c1e5f2
 designated root        0000.000423c1e5f2
 root port                 0                    path cost                  0
 max age                   4.00                 bridge max age             =
4.00
 hello time                1.00                 bridge hello time          =
1.00
 forward delay             4.00                 bridge forward delay       =
4.00
 ageing time             300.00
 hello timer               0.25                 tcn timer                  =
0.00
 topology change timer     0.00                 gc timer                   =
0.06
 flags                 =20


eth0 (0)
 port id                0000                    state                forwar=
ding
 designated root        0000.000423c1e5f2       path cost                100
 designated bridge      0000.000423c1e5f2       message age timer          =
0.00
 designated port        8001                    forward delay timer        =
0.00
 designated cost           0                    hold timer                 =
0.48
 flags                 =20

vlan10 (0)
 port id                0000                    state                forwar=
ding
 designated root        0000.000423c1e5f2       path cost                  1
 designated bridge      0000.000423c1e5f2       message age timer          =
0.00
 designated port        8002                    forward delay timer        =
0.00
 designated cost           0                    hold timer                 =
0.24
 flags                  CONFIG_PENDING=20

vlan20 (0)
 port id                0000                    state                forwar=
ding
 designated root        0000.000423c1e5f2       path cost                  1
 designated bridge      0000.000423c1e5f2       message age timer          =
0.00
 designated port        8003                    forward delay timer        =
0.00
 designated cost           0                    hold timer                 =
0.24
 flags                 =20

vlan30 (0)
 port id                0000                    state                forwar=
ding
 designated root        0000.000423c1e5f2       path cost                  1
 designated bridge      0000.000423c1e5f2       message age timer          =
0.00
 designated port        8004                    forward delay timer        =
0.00
 designated cost           0                    hold timer                 =
0.24
 flags                 =20

vlan31 (0)
 port id                0000                    state                forwar=
ding
 designated root        0000.000423c1e5f2       path cost                  1
 designated bridge      0000.000423c1e5f2       message age timer          =
0.00
 designated port        8005                    forward delay timer        =
0.00
 designated cost           0                    hold timer                 =
0.24
 flags                 =20

vlan32 (0)
 port id                0000                    state                forwar=
ding
 designated root        0000.000423c1e5f2       path cost                  1
 designated bridge      0000.000423c1e5f2       message age timer          =
0.00
 designated port        8006                    forward delay timer        =
0.00
 designated cost           0                    hold timer                 =
0.24
 flags                 =20

vlan33 (0)
 port id                0000                    state                forwar=
ding
 designated root        0000.000423c1e5f2       path cost                  1
 designated bridge      0000.000423c1e5f2       message age timer          =
0.00
 designated port        8007                    forward delay timer        =
0.00
 designated cost           0                    hold timer                 =
0.24
 flags                 =20

vlan34 (0)
 port id                0000                    state                forwar=
ding
 designated root        0000.000423c1e5f2       path cost                  1
 designated bridge      0000.000423c1e5f2       message age timer          =
0.00
 designated port        8008                    forward delay timer        =
0.00
 designated cost           0                    hold timer                 =
0.24
 flags                 =20

vlan50 (0)
 port id                0000                    state                forwar=
ding
 designated root        0000.000423c1e5f2       path cost                  1
 designated bridge      0000.000423c1e5f2       message age timer          =
0.00
 designated port        8009                    forward delay timer        =
0.00
 designated cost           0                    hold timer                 =
0.24
 flags                  CONFIG_PENDING=20

---------------------------------------------------------

vlan50 is always CONFIG_PENDING (after the very first state change).

The port id is 0000 (all zeroes) on all ports, it used to be 8000 some time=
 ago, not sure when it changed. Is this correct, doesn't look correct to me=
 to have 0000 on all ports.




ON SERVER "BRDIGE2"
---------------------------------------------------------
#  brctl show br0
bridge name     bridge id               STP enabled     interfaces
br0             0064.00116b333a97       yes             eth0
                                                        vlan10
                                                        vlan20
                                                        vlan30
                                                        vlan31
                                                        vlan32
                                                        vlan33
                                                        vlan34
                                                        vlan50


#  brctl showstp br0
br0
 bridge id              0064.00116b333a97
 designated root        0000.000423c1e5f2
 root port                 2                    path cost                 19
 max age                   4.00                 bridge max age             =
4.00
 hello time                1.00                 bridge hello time          =
1.00
 forward delay             4.00                 bridge forward delay       =
4.00
 ageing time             300.00
 hello timer               0.00                 tcn timer                  =
0.00
 topology change timer     0.00                 gc timer                   =
0.06
 flags                 =20


eth0 (0)
 port id                0000                    state                  bloc=
king
 designated root        0000.000423c1e5f2       path cost                100
 designated bridge      0000.000423c1e5f2       message age timer          =
3.35
 designated port        8001                    forward delay timer        =
0.00
 designated cost           0                    hold timer                 =
0.00
 flags                 =20

vlan10 (0)
 port id                0000                    state                forwar=
ding
 designated root        0000.000423c1e5f2       path cost                 19
 designated bridge      0000.000423c1e5f2       message age timer          =
3.11
 designated port        8002                    forward delay timer        =
0.00
 designated cost           0                    hold timer                 =
0.00
 flags                 =20

vlan20 (0)
 port id                0000                    state                  bloc=
king
 designated root        0000.000423c1e5f2       path cost                 19
 designated bridge      0000.000423c1e5f2       message age timer          =
3.11
 designated port        8003                    forward delay timer        =
0.00
 designated cost           0                    hold timer                 =
0.00
 flags                 =20

vlan30 (0)
 port id                0000                    state                  bloc=
king
 designated root        0000.000423c1e5f2       path cost                 19
 designated bridge      0000.000423c1e5f2       message age timer          =
3.11
 designated port        8004                    forward delay timer        =
0.00
 designated cost           0                    hold timer                 =
0.00
 flags                 =20

vlan31 (0)
 port id                0000                    state                  bloc=
king
 designated root        0000.000423c1e5f2       path cost                 19
 designated bridge      0000.000423c1e5f2       message age timer          =
3.11
 designated port        8005                    forward delay timer        =
0.00
 designated cost           0                    hold timer                 =
0.00
 flags                 =20

vlan32 (0)
 port id                0000                    state                  bloc=
king
 designated root        0000.000423c1e5f2       path cost                 19
 designated bridge      0000.000423c1e5f2       message age timer          =
3.11
 designated port        8006                    forward delay timer        =
0.00
 designated cost           0                    hold timer                 =
0.00
 flags                 =20

vlan33 (0)
 port id                0000                    state                  bloc=
king
 designated root        0000.000423c1e5f2       path cost                 19
 designated bridge      0000.000423c1e5f2       message age timer          =
3.11
 designated port        8007                    forward delay timer        =
0.00
 designated cost           0                    hold timer                 =
0.00
 flags                 =20

vlan34 (0)
 port id                0000                    state                  bloc=
king
 designated root        0000.000423c1e5f2       path cost                 19
 designated bridge      0000.000423c1e5f2       message age timer          =
3.11
 designated port        8008                    forward delay timer        =
0.00
 designated cost           0                    hold timer                 =
0.00
 flags                 =20

vlan50 (0)
 port id                0000                    state                  bloc=
king
 designated root        0000.000423c1e5f2       path cost                 19
 designated bridge      0000.000423c1e5f2       message age timer          =
3.11
 designated port        8009                    forward delay timer        =
0.00
 designated cost           0                    hold timer                 =
0.00
 flags                 =20

---------------------------------------------------------

Same thing about the port ids on "BRIDGE2"

In order to achived the desired setup (as shown in the diagram), I thought =
all vlan ports would be blocked and eth0 would be unblocked. Really weird w=
hy vlan10 is not blocked, it's configured on both cisco switches and a on B=
RIDGE1.



Here's an abstract of the startscript I'm using (on BRIDGE1):

---------------------------------------------------------
BR_IF_DMZ=3Deth0
BR_IF_MZ=3Deth1
BR_NAME=3Dbr0
BR_PRIO=3D1
BR_IF_DMZ_COST=3D100
BR_IF_MZ_COST=3D1
VLAN=3D/etc/vlan.conf # one vlan id per line


echo 1 > /proc/sys/net/ipv4/ip_forward

/sbin/ifconfig $BR_IF_DMZ down
/sbin/ifconfig $BR_IF_MZ down

# /sbin/ifconfig $BR_IF_DMZ 0.0.0.0 promisc || return=3D$rc_failed
# /sbin/ifconfig $BR_IF_MZ 0.0.0.0 promisc || return=3D$rc_failed
/sbin/ifconfig $BR_IF_DMZ 0.0.0.0 up || return=3D$rc_failed
/sbin/ifconfig $BR_IF_MZ 0.0.0.0 up || return=3D$rc_failed

$BRCTL addbr $BR_NAME || return=3D$rc_failed
$BRCTL addif $BR_NAME $BR_IF_DMZ || return=3D$rc_failed

# Basic Settings

sleep 1

$BRCTL sethello $BR_NAME 1 || return=3D$rc_failed
$BRCTL setmaxage $BR_NAME 4 || return=3D$rc_failed
$BRCTL setfd $BR_NAME 4 || return=3D$rc_failed
$BRCTL stp $BR_NAME on || return=3D$rc_failed
$BRCTL setbridgeprio $BR_NAME $BR_PRIO || return=3D$rc_failed
$BRCTL setpathcost $BR_NAME $BR_IF_DMZ $BR_IF_DMZ_COST || return=3D$rc_fail=
ed
echo "$BRCTL setpathcost $BR_NAME $BR_IF_DMZ $BR_IF_DMZ_COST"

for file in $BR_NAME $BR_IF_DMZ $BR_IF_MZ;
do
	echo "1" > /proc/sys/net/ipv4/conf/${file}/proxy_arp;
	echo "1" > /proc/sys/net/ipv4/conf/${file}/forwarding;
done;

# Setup VLAN Interfaces

# Use vlan<id> name type
$VCONFIG set_name_type VLAN_PLUS_VID_NO_PAD

while read conf ; do
         case "$conf" in
        \#*|"") ;;              # Ignore empty lines and comments
        *)
          pattern=3D[[:space:]]*\#*
          vlan=3D"${conf%%$pattern}"  # Remove Whitespaces and comments

          # Add VLAN to internal interface
          $VCONFIG add $BR_IF_MZ $vlan

          # Add VLAN to brdige
          $BRCTL addif $BR_NAME vlan$vlan || return=3D$rc_failed

          sleep 1

          $BRCTL setpathcost $BR_NAME vlan$vlan $BR_IF_MZ_COST || return=3D=
$rc_failed
          # /sbin/ifconfig vlan$vlan 0.0.0.0 promisc || return=3D$rc_failed
          /sbin/ifconfig vlan$vlan 0.0.0.0 up || return=3D$rc_failed

          # VLAN zu VLAN Verkehr mit ebtables bereits auf L2 unterbinden
          $EBTABLES -A FORWARD -i vlan$vlan -o ! $BR_IF_DMZ -j DROP || retu=
rn=3D$rc_failed

	  echo "1" > /proc/sys/net/ipv4/conf/vlan$vlan/proxy_arp;
	  echo "1" > /proc/sys/net/ipv4/conf/vlan$vlan/forwarding;

        esac
done < $VLAN

# End VLAN Setup

sleep 5

ifconfig br0 192.168.1.93 netmask 255.255.255.0

---------------------------------------------------------

Here's ebtables output:

Bridge chain: FORWARD, entries: 8, policy: ACCEPT
-i vlan10 -o ! eth0 -j DROP=20
-i vlan20 -o ! eth0 -j DROP=20
-i vlan30 -o ! eth0 -j DROP=20
-i vlan31 -o ! eth0 -j DROP=20
-i vlan32 -o ! eth0 -j DROP=20
-i vlan33 -o ! eth0 -j DROP=20
-i vlan34 -o ! eth0 -j DROP=20
-i vlan50 -o ! eth0 -j DROP=20


No rules in iptables so far.

-------------------------

So is the behaviour of STP correct or is this wrong?

Thanks to anyone taking the time reading this through. ;)

Best,

Michael
--=20
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!=20
Ideal f=FCr Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
