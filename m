From: "Gareth Wheelton" <gareth@hasslemonkey.net>
Subject: RE: [Bridge] SUSE 8.1 build failure
Date: Tue, 17 Aug 2004 01:35:42 +0100
Message-ID: <000f01c483f2$20f35a00$ba00a8c0@hasslemonkey.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <023e01c482d1$d7915c20$ba00a8c0@hasslemonkey.net>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Does anyone know where 'HZ' is declared in the 2.4.xx source?


Cheers gareth

-----Original Message-----
From: bridge-bounces@lists.osdl.org [mailto:bridge-bounces@lists.osdl.org]
On Behalf Of Gareth Wheelton
Sent: 15 August 2004 15:12
To: bridge@lists.osdl.org
Subject: [Bridge] SUSE 8.1 build failure

Hi

RE: bridge-utils-1.0.4, linux 2.4.21-241-athlon


I'm receiving the following groan when I attempt to build bridge-utils on
SUSE 8.1(linux 2.4.21-241-athlon)

Any help most appreciated.


for x in libbridge brctl doc; do make  -C $x ; done
make[1]: Entering directory `/home/gareth/bridge-utils-1.0.4/libbridge'
gcc -Wall -g -I/usr/src/linux/include  -c libbridge_devif.c
In file included from libbridge_devif.c:28:
libbridge_private.h: In function `__tv_to_jiffies':
libbridge_private.h:68: `HZ' undeclared (first use in this function)
libbridge_private.h:68: (Each undeclared identifier is reported only once
libbridge_private.h:68: for each function it appears in.)
libbridge_private.h: In function `__jiffies_to_tv':
libbridge_private.h:75: `HZ' undeclared (first use in this function)
make[1]: *** [libbridge_devif.o] Error 1
make[1]: Leaving directory `/home/gareth/bridge-utils-1.0.4/libbridge'
make[1]: Entering directory `/home/gareth/bridge-utils-1.0.4/brctl'
gcc -Wall -g -O2 -I../libbridge -I/usr/src/linux/include  -c brctl.c
gcc -Wall -g -O2 -I../libbridge -I/usr/src/linux/include  -c brctl_cmd.c
gcc -Wall -g -O2 -I../libbridge -I/usr/src/linux/include  -c brctl_disp.c
make[1]: *** No rule to make target `../libbridge/libbridge.a', needed by
`brctl'.  Stop.
make[1]: Leaving directory `/home/gareth/bridge-utils-1.0.4/brctl'
make[1]: Entering directory `/home/gareth/bridge-utils-1.0.4/doc'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/home/gareth/bridge-utils-1.0.4/doc'


cheers gareth




