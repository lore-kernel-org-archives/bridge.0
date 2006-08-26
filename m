Date: Sat, 26 Aug 2006 19:41:28 +0200
From: Santiago Garcia Mantinan <bridge@manty.net>
Message-ID: <20060826174128.GA5052@pul.manty.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] patch for a message bug
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hi!

Jens Seidel reported a bug to Debian about a wrong message on brctl, you can
see it at http://bugs.debian.org/383938, it is kind of the continuation of
the ENODEV bug #348617 that was already patched by Stephen on the git.

I have applied the same solution that Stephen applied for the first one,
follows the patch against git plus a minor exclamation mark modification I
did so that all ENODEV messages were exclamative (Stephen patch had missed
that mark).

Regards...
-- 
Manty/BestiaTester -> http://manty.net

diff -u -r bridge-utils.old/brctl/brctl_cmd.c bridge-utils-1.1/brctl/brctl_cmd.c
--- bridge-utils.old/brctl/brctl_cmd.c	2006-08-26 19:31:23.000000000 +0200
+++ bridge-utils-1.1/brctl/brctl_cmd.c	2006-08-26 19:31:49.000000000 +0200
@@ -99,7 +99,7 @@
 			if (if_nametoindex(ifname) == 0)
 				fprintf(stderr, "interface %s does not exist!\n", ifname);
 			else
-				fprintf(stderr, "bridge %s does not exist\n", brname);
+				fprintf(stderr, "bridge %s does not exist!\n", brname);
 			break;
 
 		case EBUSY:
@@ -139,8 +139,10 @@
 			continue;
 
 		case ENODEV:
-			fprintf(stderr, "interface %s does not exist!\n", 
-				ifname);
+			if (if_nametoindex(ifname) == 0)
+				fprintf(stderr, "interface %s does not exist!\n", ifname);
+			else
+				fprintf(stderr, "bridge %s does not exist!\n", brname);
 			break;
 
 		case EINVAL:
