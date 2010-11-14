MIME-Version: 1.0
In-Reply-To: <AANLkTi=uyEveZf7+XLo0+mV48CFjsuzrTmkTi5Xbn_Dr@mail.gmail.com>
References: <AANLkTi=uyEveZf7+XLo0+mV48CFjsuzrTmkTi5Xbn_Dr@mail.gmail.com>
Date: Sun, 14 Nov 2010 19:45:31 +0200
Message-ID: <AANLkTim5+RLN6_R-KhWwvwC2ey3nKuSvR0XFqxJrzyAE@mail.gmail.com>
From: Kfir Lavi <lavi.kfir@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Testing bridge setup with packet generator and qemu
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,
I would like to test a simple bridge setup.
br0 have eth0 and eth1
I want to create a fake traffic and see it crossing the bridge.
My main goal is to write a local script that will run tests locally on
the ebtables rules as I change them.
Lets say i'm generating arp packet with nemesis:
nemesis arp -v -d eth0 -S $SRC -D $DST -h $SRC_MAC -m $DST_MAC # request
nemesis arp -v -r -d eth0 -S $DST -D $SRC -h $DST_MAC -m $SRC_MAC # reply

This shows on eth0 tcpdump but not on eth1 tcpdump
Why the bridge doesn't forward to eth1 the arp packets?

I have a gentoo rootfs.
qemu nics are define like this:
=C2=A0-net nic,model=3Drtl8139,vlan=3D0 -net user,vlan=3D0 \
=C2=A0-net nic,model=3Drtl8139,vlan=3D1

Regards,
Kfir
