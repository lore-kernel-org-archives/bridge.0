Return-Path: <cmelanson@blackberry.com>
From: Corey Melanson <cmelanson@blackberry.com>
Date: Fri, 4 Nov 2016 20:44:48 +0000
Message-ID: <E5B11A06AD89DB429345609918715652FBF2FF58@XMB121CNC.rim.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] Force IGMP membership
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

Hello,

I'm trying to add a bridge port to a multicast group manually to work aroun=
d the situation where VMs that are live migrated lose their IGMP membership=
. We have IGMP snooping enabled on the bridge, and during this example ther=
e were other VMs on the same bridge/vlan which are part of this multicast g=
roup address sending/receiving traffic. These systems are running Ubuntu 14=
.04 (kernel 3.13).

Prior to live migration, I see the IGMP group membership on the kvm hypervi=
sor:
$ bridge -d mdb | grep vnet8
dev br.128 port vnet8 grp 239.236.15.150 temp

After the live migration, multicast traffic to 239.236.15.150 stops as expe=
cted. If I try to manually add the multicast group membership:
# bridge mdb add dev br.128 port vnet3 grp 239.236.15.150 temp    =20
# bridge mdb list | grep vnet3
dev onebr.128 port vnet3 grp 239.236.15.150 temp

The multicast traffic does not resume until the VM sends a IGMP membership =
report after receiving an IGMP query from the switch, which takes too long =
most of the time (over a minute).=20

I haven't been able to find anyone online in this situation, so any help wo=
uld be greatly appreciated.

Thank you,
Corey Melanson
