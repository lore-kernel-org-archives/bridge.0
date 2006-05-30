From: "JPP" <jpp1@frws.com>
Date: Tue, 30 May 2006 15:28:05 -0600
Message-Id: <20060530211957.M59995@frws.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: [Bridge] Building 1.1 ?
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org
Content-Transfer-Encoding: quoted-printable

Good day Folks!

Working on a bridging firewall/gateway and attempting to solve the age-old =

mystery of whether I can get NAT to work across a gateway that has 2 NICs a=
nd=20
requires a bridge...

Upside is, I have the gateway working, bridging works (as does OpenVPN usin=
g=20
that bridge). But NAT does not in Fedora Core 4...
From dmesg: Linux version 2.6.11-1.1369_FC4

So I went to the website and downloaded the 1.1 source to build it. It need=
ed=20
libsysfs.h and it was not on my server.
Went to the libsysfs website and downloaded 2.0 and built it with no obviou=
s=20
issues. The .h file is now there.
Back to brctl and building it.

./configure --prefix=3D/usr
Works like a champ. No errors.

make (errors - looks like one big one)

for x in libbridge brctl doc; do make  -C $x ; done
make[1]: Entering directory `/software/bridge/bridge-utils-1.1/libbridge'
gcc -Wall -g -I/usr/src/linux/include  -c libbridge_devif.c
In file included from libbridge_devif.c:28:
libbridge_private.h:39:2: error: #error Using wrong kernel headers if_bridg=
e.h
libbridge_private.h:43:2: error: #error Using wrong kernel headers sockios.=
h=20
is
libbridge_devif.c: In function =E2br_get_bridge_info=E2:
libbridge_devif.c:196: error: =E2SYSFS_BRIDGE_ATTR=E2 undeclared (first use=
 in=20
this
libbridge_devif.c:196: error: (Each undeclared identifier is reported only =

once
libbridge_devif.c:196: error: for each function it appears in.)
libbridge_devif.c:196: error: syntax error before string constant
libbridge_devif.c:197: error: syntax error before string constant
libbridge_devif.c:198: error: syntax error before string constant
libbridge_devif.c:199: error: syntax error before string constant
libbridge_devif.c:200: error: syntax error before string constant
libbridge_devif.c:201: error: syntax error before string constant
libbridge_devif.c:202: error: syntax error before string constant
libbridge_devif.c:203: error: syntax error before string constant
libbridge_devif.c:204: error: syntax error before string constant
libbridge_devif.c:205: error: syntax error before string constant
libbridge_devif.c:206: error: syntax error before string constant
libbridge_devif.c:207: error: syntax error before string constant
libbridge_devif.c:208: error: syntax error before string constant
libbridge_devif.c:210: error: syntax error before string constant
libbridge_devif.c:212: error: syntax error before string constant
libbridge_devif.c:213: error: syntax error before string constant
libbridge_devif.c:214: error: syntax error before string constant
libbridge_devif.c:216: error: syntax error before string constant
libbridge_devif.c: In function =E2br_get_port_info=E2:
libbridge_devif.c:296: error: =E2SYSFS_BRIDGE_PORT_ATTR=E2 undeclared (firs=
t use=20
in
libbridge_devif.c:296: error: syntax error before string constant
libbridge_devif.c:297: error: syntax error before string constant
libbridge_devif.c:298: error: syntax error before string constant
libbridge_devif.c:299: error: syntax error before string constant
libbridge_devif.c:300: error: syntax error before string constant
libbridge_devif.c:301: error: syntax error before string constant
libbridge_devif.c:302: error: syntax error before string constant
libbridge_devif.c:303: error: syntax error before string constant
libbridge_devif.c:304: error: syntax error before string constant
libbridge_devif.c:305: error: syntax error before string constant
libbridge_devif.c:306: error: syntax error before string constant
libbridge_devif.c:308: error: syntax error before string constant
libbridge_devif.c:310: error: syntax error before string constant
libbridge_devif.c: In function =E2br_read_fdb=E2:
libbridge_devif.c:468: error: =E2SYSFS_BRIDGE_FDB=E2 undeclared (first use =
in this
make[1]: *** [libbridge_devif.o] Error 1
make[1]: Leaving directory `/software/bridge/bridge-utils-1.1/libbridge'
make[1]: Entering directory `/software/bridge/bridge-utils-1.1/brctl'
make[1]: *** No rule to make target `../libbridge/libbridge.a', needed by=20
`brct
make[1]: Leaving directory `/software/bridge/bridge-utils-1.1/brctl'
make[1]: Entering directory `/software/bridge/bridge-utils-1.1/doc'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/software/bridge/bridge-utils-1.1/doc'

Apparently it does not like something...
Any ideas?
Did a make clean and configure again
Re-downloaded and unpacked the source - same error(s).

Would like to get some form of NAT working between this kernel, iptables 1.=
3.0=20
and bridge utils.
Any help would be appreciated!

Thank you.
Jerome

--
FRWS WebMail (http://www.frws.com)
Cause you deserve Spam and Virus free email...

