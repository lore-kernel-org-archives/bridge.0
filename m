Message-ID: <564DE4477544D411AD2C00508BDF0B6A1ED3BE39@USAHM018.amer.corp.eds.com>
From: "Small, Jim" <jim.small@eds.com>
Date: Thu, 8 Apr 2004 09:44:58 -0400 
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] (no subject)
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Thanks to Santiago (Santi) Leon for providing the following fix to me to
enable bridging on the Sparc64 platform.  I have tested it under Debian
unstable, using Kernel 2.4.25, and bridge-utils-0.9.6.tar.gz.

The fix is as follows:
Download bridge-utils-0.9.6.tar.gz source from bridge.sourceforge.net, untar
it, edit 
bridge-utils/libbridge/libbridge_devif.c and search for a line that has
this:
  return ioctl(br_socket_fd, SIOCDEVPRIVATE + 3, &ifr);
and replace it with this:
  return ioctl(br_socket_fd, SIOCDEVPRIVATE, &ifr);
(basically just remove the +3)... run make and again and try:

(After you rebuild the bridge utilities, these should work beautifully!)
bridge-utils/brctl/brctl addbr br0
bridge-utils/brctl/brctl adddif br0 eth0
bridge-utils/brctl/brctl show

Santi mentioned that the newer kernels don't make SIOCDEVPRIVATE+3 a 64-bit
compatible 
ioctl and that's why it doesn't work on the Sparc64 architecture.  He also
mentioned that the same fix works for the PowerPC64 Architecture so it might
help for other 64bit architecture platforms.

Note also that this is not scheduled to be fixed in bridge-tuils-0.9.7, so
for now this seems to be the best work around for 64bit platforms.

Here is a diff too:
# diff -Nru bridge-utils/libbridge/libbridge_devif.c
bridge-utils/libbridge/libbridge_devif.c.orig 
--- bridge-utils/libbridge/libbridge_devif.c    2004-04-01
21:10:55.000000000 -0500
+++ bridge-utils/libbridge/libbridge_devif.c.orig       2002-01-16
07:04:45.000000000 -0500
@@ -56,7 +56,7 @@
        memcpy(ifr.ifr_name, br->ifname, IFNAMSIZ);
        ((unsigned long long *)(&ifr.ifr_data))[0] = (unsigned long
long)(unsigned long)args;
 
-       return ioctl(br_socket_fd, SIOCDEVPRIVATE, &ifr);
+       return ioctl(br_socket_fd, SIOCDEVPRIVATE + 3, &ifr);
 }
 #endif

Thanks again Santi,
   <> Jim

