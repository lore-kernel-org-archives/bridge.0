Message-ID: <564DE4477544D411AD2C00508BDF0B6A1E7E362A@USAHM018.amer.corp.eds.com>
From: "Small, Jim" <jim.small@eds.com>
Subject: RE: [Bridge] br_add_bridge: Package not installed
Date: Mon, 29 Mar 2004 12:28:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Feierfeil, Jeff" <firefly@netapp.com>, bridge@osdl.org

If you do an lsmod, is the bridge module getting loaded?  If not, is it
compiled into your kernel?  If not, you will need to rebuild your kernel
with bridging support.

In the kernel configuration menu, go to Networking Options, 802.1d Ethernet
Bridging.  Make sure this is Yes or M and then rebuild your kernel.

<> Jim

-----Original Message-----
I am having a tough time simply getting the bridging to work with RedHat.=A0
Any help would be greatly appreciated.
=A0
[root@redman root]# brctl addbr br0
br_add_bridge: Package not installed
=A0
[root@redman temp]# uname -a
Linux redman 2.4.21-9.0.1.EL #1 Mon Feb 9 22:44:14 EST 2004 i686 i686 i386
GNU/Linux
=A0
[root@redman root]# rpm -q --all 'kernel*'
kernel-2.4.21-9.0.1.EL
kernel-source-2.4.21-9.0.1.EL
kernel-pcmcia-cs-3.1.31-13
kernel-utils-2.4-8.37.1
=A0
[root@redman temp]# rpm -q --all 'bridge*'
bridge-utils-0.9.6-1
=A0
=A0
[root@redman root]# brctl
commands:
addbr=A0=A0<bridge> add bridge
addif=A0=A0<bridge> <device> add interface to bridge
delbr <bridge> delete bridge
delif <bridge> <device> delete interface from bridge
show show a list of bridges
showmacs <bridge> show a list of mac addrs
showstp <bridge> show bridge stp info
setageing <bridge> <time> set ageing time
setbridgeprio <bridge> <prio> set bridge priority
setfd <bridge> <time> set bridge forward delay
setgcint <bridge> <time> set garbage collection interval
sethello <bridge> <time> set hello time
setmaxage <bridge> <time> set max message age
setpathcost <bridge> <port> <cost> set path cost
setportprio <bridge> <port> <prio> set port priority
stp <bridge> <state> turn stp on/off
[root@redman root]#
thanks........
=A0
Jeff Feierfeil - Sales Engineer GE
Network Appliance, Inc.
firefly@netapp.com
Office: (248) 263-3239
Cell: (248) 514-1248
=A0

