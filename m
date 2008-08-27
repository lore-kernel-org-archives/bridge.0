Date: Thu, 28 Aug 2008 00:20:54 +0200
From: Santiago Garcia Mantinan <bridge@manty.net>
Message-ID: <20080827222054.GA3225@dis.manty.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] Patches on Debian not yet on git
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi!

I have just added a patch on Debian to fix http://bugs.debian.org/496491 and
have seen that other patches are yet unapplied on git, so I'm adding them
here.

For http://bugs.debian.org/496491 It resulted that the problem was bigger
than what the user reports and almost all setting commands, if not all, were
failing. The problem seems to be with the path as the user reported.

diff -ru bridge-utils/libbridge/libbridge_devif.c bridge-utils-1.4/libbridge/libbridge_devif.c
--- bridge-utils/libbridge/libbridge_devif.c	2008-08-27 23:37:29.000000000 +0200
+++ bridge-utils-1.4/libbridge/libbridge_devif.c	2008-08-27 23:38:11.000000000 +0200
@@ -282,7 +282,7 @@
 	char path[SYSFS_PATH_MAX];
 	FILE *f;
 
-	snprintf(path, SYSFS_PATH_MAX, SYSFS_CLASS_NET "%s/%s", bridge, name);
+	snprintf(path, SYSFS_PATH_MAX, SYSFS_CLASS_NET "%s/bridge/%s", bridge, name);
 
 	f = fopen(path, "w");
 	if (f) {

For http://bugs.debian.org/431860 segfault if a bridge is called bridge:

diff -ru bridge-utils/libbridge/libbridge_init.c bridge-utils-1.4/libbridge/libbridge_init.c
--- bridge-utils/libbridge/libbridge_init.c	2008-08-27 23:37:29.000000000 +0200
+++ bridge-utils-1.4/libbridge/libbridge_init.c	2008-08-27 23:38:11.000000000 +0200
@@ -49,6 +49,9 @@
 	char path[SYSFS_PATH_MAX];
 	struct stat st;
 
+	if(entry->d_name[0] == '.')
+		return 0;
+
 	snprintf(path, SYSFS_PATH_MAX, SYSFS_CLASS_NET "%s/bridge", entry->d_name);
 	return stat(path, &st) == 0 && S_ISDIR(st.st_mode);
 }

For http://bugs.debian.org/406907 wrong printing when command not understood:

diff -ru bridge-utils/brctl/brctl.c bridge-utils-1.4/brctl/brctl.c
--- bridge-utils/brctl/brctl.c	2008-08-27 23:37:29.000000000 +0200
+++ bridge-utils-1.4/brctl/brctl.c	2008-08-27 23:38:11.000000000 +0200
@@ -69,7 +69,7 @@
 	argc -= optind;
 	argv += optind;
 	if ((cmd = command_lookup(*argv)) == NULL) {
-		fprintf(stderr, "never heard of command [%s]\n", argv[1]);
+		fprintf(stderr, "never heard of command [%s]\n", argv[0]);
 		goto help;
 	}
 	
Patch for some bugs on the documentation:

diff -ru bridge-utils/doc/FAQ bridge-utils-1.4/doc/FAQ
--- bridge-utils/doc/FAQ	2008-08-27 23:37:29.000000000 +0200
+++ bridge-utils-1.4/doc/FAQ	2008-08-27 23:38:11.000000000 +0200
@@ -1,4 +1,4 @@
 The FAQ is now located at
 
-	http://bridge.sourceforge.net/faq.html
+	http://www.linux-foundation.org/en/Net:Bridge
 
diff -ru bridge-utils/doc/FIREWALL bridge-utils-1.4/doc/FIREWALL
--- bridge-utils/doc/FIREWALL	2008-08-27 23:37:29.000000000 +0200
+++ bridge-utils-1.4/doc/FIREWALL	2008-08-27 23:38:11.000000000 +0200
@@ -7,10 +7,9 @@
 How do bridging and firewalling go together?  First of all, you need a
 kernel patch against the 2.4 kernel to actually make firewalling bridged
 packets possible.  You need to apply this patch to your kernel and recompile
-it, or alternatively, download a pre-patched Red Hat 7.2 kernel RPM and use
-that.  The patch and kernel RPM are located at:
+it. The patch is maitained at:
 
-	http://bridge.sourceforge.net/devel/bridge-nf/
+	http://ebtables.sourceforge.net/
 
 Now if you boot with this kernel, you can use the regular iptables
 firewalling as if you were doing routing.  So, rules for forwarding are

Hope that helps!

Regards...
-- 
Manty/BestiaTester -> http://manty.net
