Date: Thu, 18 Dec 2003 09:46:13 +0100 (CET)
From: Hakan Stensby <hst@nsc.liu.se>
Message-ID: <Pine.LNX.4.44.0312180938040.30335-100000@papput.nsc.liu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] RH 9 problems iptbles + bridge
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hi,

I've been running RH 7.2 with a kernel-2.4.9-13brnf0.0.3 for a very long ti=
me=20
and works just fine.

A couple of weeks ago I thought I'd install a new fresh installation with r=
h9=20
and load the bridge module that comes with the rh kernel ( 2.4.20-24.9 ).

The bridge itself works just fine but the firewalling dont.
There is no packets passing the FORWARD chain... Have I missed something re=
ally=20
essential here?
The same iptable script works just fine on the old box...

Thanks in advance

bridge name     bridge id               STP enabled     interfaces
br0             8000.0002b332cd6a       yes             eth0
                                                        eth1
Chain FORWARD (policy DROP 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destina=
tion        =20
    0     0 SGI3K      all  --  *      *       0.0.0.0/0            SOMEIPA=
DD
    0     0 ACCEPT     icmp --  eth0   *       0.0.0.0/0            0.0.0.0=
/0    icmp type 0 limit: avg 3/sec burst 5=20
    0     0 ACCEPT     icmp --  eth0   *       0.0.0.0/0            0.0.0.0=
/0          icmp type 3=20
    0     0 ACCEPT     icmp --  eth0   *       0.0.0.0/0            0.0.0.0=
/0          icmp type 4=20
    0     0 ACCEPT     icmp --  eth0   *       0.0.0.0/0            0.0.0.0=
/0          icmp type 11=20
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0=
/0          icmp type 8 limit: avg 3/sec burst 5=20
    0     0 ACCEPT     tcp  --  eth0   eth1    0.0.0.0/0            0.0.0.0=
/0          tcp dpt:113=20
    0     0 ACCEPT     all  --  eth1   eth0    0.0.0.0/0            0.0.0.0=
/0         =20
    0     0 LOG        all  --  *      *       0.0.0.0/0            0.0.0.0=
/0          LOG flags 0 level 4 prefix `FORWARD chain po
--=20
H=E5kan Stensby
E-mail: hst(at)nsc(dot)liu(dot)se=20

