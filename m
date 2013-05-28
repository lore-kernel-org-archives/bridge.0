Return-Path: <jelledejong@powercraft.nl>
Message-ID: <51A53977.1090106@powercraft.nl>
Date: Wed, 29 May 2013 01:10:47 +0200
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] bond-mode 4 bridge-utils 3.x kernel not fully working
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello everybody,

I also sent this email to bonding-devel@lists.sourceforge.net

I spent ours debugging and finding out what points to the problem.

I run kvm quests with bridged networking on a bonding lacp set-up,
with the 2.6 kernel this has been working fine for years. But with the
3.x kernel this doesn?t work any more.

Traffic comes out the KVM quests but doesn?t come in. If I disable
bonding everything just works again.

# working with 2.6 not working with 3.x
cat /etc/network/interfaces
auto lo
  iface lo inet loopback

auto bond0
  iface bond0 inet manual
  slaves eth0 eth1
  bond-mode 4
  bond-miimon 100
  pre-up /sbin/ifconfig bond0 mtu 9000

auto br0
  iface br0 inet dhcp
  bridge_fd 0
  bridge_stp on
  bridge_ports bond0

# working with 3.x but no bonding!!
cat /etc/network/interfaces
auto lo
  iface lo inet loopback

auto eth0
  iface eth0 inet manual
  mtu 900

auto br0
  iface br0 inet dhcp
  bridge_fd 0
  bridge_stp on
  bridge_ports eth0

# uname -a
Linux viktoriya 3.2.0-4-amd64 #1 SMP Debian 3.2.41-2+deb7u2 x86_64
GNU/Linux

bridge-utils version  1.5-6

I already checked iptabls, ebtables there are no running rules and the
bellow on zero or one doesn't make a difference either also disabling
bridge_stp off or bridge_maxwait 0 doesn't seem to help.

/bin/echo "0" > /proc/sys/net/bridge/bridge-nf-call-arptables
/bin/echo "0" > /proc/sys/net/bridge/bridge-nf-call-ip6tables
/bin/echo "0" > /proc/sys/net/bridge/bridge-nf-call-iptables

Any ideas?

Kind regards,

Jelle de Jong
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iJwEAQECAAYFAlGlOXMACgkQ1WclBW9j5HkK/wP+Mtu5FB9gU1tAlDnHBDH9x98p
1hGhXTOY81wuDdN3WzjlOLvlIevRuFiVm2b+HrhFqI5Bvh9SHb06FPoaHW92WdNj
Xh32N/a2ghR161tATlltAxbSUuLT9+SuNA2GQ8zdEG7u+uKMBOeecPgBccqRa1NV
lHDEGUKqlhA40c0lRY0=
=kJ2M
-----END PGP SIGNATURE-----
