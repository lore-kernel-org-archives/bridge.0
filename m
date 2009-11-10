Date: Tue, 10 Nov 2009 16:57:16 +0100
From: Jasper Spaans <spaans@fox-it.com>
Message-ID: <20091110155716.GA20467@spaans64.fox.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Subject: [Bridge] [PATCH] Add upstream debian patches
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: Santiago Garcia Mantinan <bridge@manty.net>

Hello list,

Debian has had these patches by Santiago Garcia Mantinan for ages [0][1],
and they have not been applied yet.  We're trying to run a 32-bit brctl on a
64-bit system, and got bitten by this.  Can you apply the patches below so
other distributions can also benefit from this?

Thanks,
Jasper

[0] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=496491
[1] https://lists.linux-foundation.org/pipermail/bridge/2008-August/006011.html
---
 brctl/brctl.c               |    2 +-
 doc/FAQ                     |    2 +-
 doc/FIREWALL                |    5 ++---
 libbridge/libbridge_devif.c |    2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/brctl/brctl.c b/brctl/brctl.c
index 454b8dd..79f07b2 100644
--- a/brctl/brctl.c
+++ b/brctl/brctl.c
@@ -69,7 +69,7 @@ int main(int argc, char *const* argv)
 	argc -= optind;
 	argv += optind;
 	if ((cmd = command_lookup(*argv)) == NULL) {
-		fprintf(stderr, "never heard of command [%s]\n", argv[1]);
+		fprintf(stderr, "never heard of command [%s]\n", argv[0]);
 		goto help;
 	}
 	
diff --git a/doc/FAQ b/doc/FAQ
index 3e04d2c..76ba0ce 100644
--- a/doc/FAQ
+++ b/doc/FAQ
@@ -1,4 +1,4 @@
 The FAQ is now located at
 
-	http://bridge.sourceforge.net/faq.html
+	http://www.linux-foundation.org/en/Net:Bridge
 
diff --git a/doc/FIREWALL b/doc/FIREWALL
index b0ea705..30280ff 100644
--- a/doc/FIREWALL
+++ b/doc/FIREWALL
@@ -7,10 +7,9 @@ care.
 How do bridging and firewalling go together?  First of all, you need a
 kernel patch against the 2.4 kernel to actually make firewalling bridged
 packets possible.  You need to apply this patch to your kernel and recompile
-it, or alternatively, download a pre-patched Red Hat 7.2 kernel RPM and use
-that.  The patch and kernel RPM are located at:
+it. The patch is maintained at:
 
-	http://bridge.sourceforge.net/devel/bridge-nf/
+	http://ebtables.sourceforge.net/
 
 Now if you boot with this kernel, you can use the regular iptables
 firewalling as if you were doing routing.  So, rules for forwarding are
diff --git a/libbridge/libbridge_devif.c b/libbridge/libbridge_devif.c
index 34e3cc8..086a399 100644
--- a/libbridge/libbridge_devif.c
+++ b/libbridge/libbridge_devif.c
@@ -286,7 +286,7 @@ static int br_set(const char *bridge, const char *name,
 	char path[SYSFS_PATH_MAX];
 	FILE *f;
 
-	snprintf(path, SYSFS_PATH_MAX, SYSFS_CLASS_NET "%s/%s", bridge, name);
+	snprintf(path, SYSFS_PATH_MAX, SYSFS_CLASS_NET "%s/bridge/%s", bridge, name);
 
 	f = fopen(path, "w");
 	if (f) {
-- 
1.6.3.3
