Date: Wed, 9 Mar 2005 14:12:25 +0100
From: Camus Moire <cm@afm-koeln.de>
Message-Id: <20050309141225.3bdffb66@camus.afm-intra.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] has incomplete type ...
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Helo list,

i get some build errors with this setup:

gcc version 2.95.3 20010315 (release)
glibc-2.1.3
kernel-2.4.29
bridge-utils-1.0.4

my compile problem is:

for x in libbridge brctl doc; do make  -C $x ; done
make[1]: Entering directory `/root/bridge-utils-1.0.4/libbridge'
gcc -Wall -g -I/usr/src/linux/include  -c libbridge_devif.c
In file included from libbridge_devif.c:27:
libbridge.h:36: field `max_age' has incomplete type
libbridge.h:37: field `hello_time' has incomplete type
libbridge.h:38: field `forward_delay' has incomplete type
libbridge.h:39: field `bridge_max_age' has incomplete type
libbridge.h:40: field `bridge_hello_time' has incomplete type
libbridge.h:41: field `bridge_forward_delay' has incomplete type
libbridge.h:46: field `ageing_time' has incomplete type
libbridge.h:47: field `hello_timer_value' has incomplete type
libbridge.h:48: field `tcn_timer_value' has incomplete type
libbridge.h:49: field `topology_change_timer_value' has incomplete type
libbridge.h:50: field `gc_timer_value' has incomplete type
libbridge.h:58: field `ageing_timer_value' has incomplete type
libbridge.h:74: field `message_age_timer_value' has incomplete type
libbridge.h:75: field `forward_delay_timer_value' has incomplete type
libbridge.h:76: field `hold_timer_value' has incomplete type
make[1]: *** [libbridge_devif.o] Error 1
make[1]: Leaving directory `/root/bridge-utils-1.0.4/libbridge'
...

I suppose some kernel-includes case.

Thanks in advance for any proposals.

Camus Moire

PS: bridge-0.9.6 code compile fine.
