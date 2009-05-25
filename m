From: Vitaly Demyanec <vitas@nppfactor.kiev.ua>
Date: Mon, 25 May 2009 19:06:59 +0300
References: <200905251848.03023.vitas@nppfactor.kiev.ua>
In-Reply-To: <200905251848.03023.vitas@nppfactor.kiev.ua>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200905251906.59864.vitas@nppfactor.kiev.ua>
Subject: [Bridge] [PATCH 2/2] rstpd: Display port role with rstpctl
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

This patch is against rstpd v.0.21 (get it here: 
https://lists.linux-foundation.org/pipermail/bridge/2009-February/006178.html).

Description:
Adds port role (Backup, Alternate, Root etc) to the output of "rstpctl 
showport" and "rstpctl showportdetail" output.

Signed-off-by: Vitaly Demyanec <vitas at nppfactor.kiev.ua>
---

diff -ur a/ctl_main.c b/ctl_main.c
--- a/ctl_main.c	2009-05-25 18:37:52.000000000 +0300
+++ b/ctl_main.c	2009-05-25 18:40:24.000000000 +0300
@@ -173,6 +173,38 @@
 		_str;							\
 	})
 
+#define ROLE_STR(_role)			\
+	({					\
+		int _r = _role;		\
+		char *_str = "Unknown";		\
+		switch ((Role)_r)			\
+		{					     \
+		case RootPort: _str = "Root"; break; \
+		case DesignatedPort:   _str = "Designated"; break; \
+		case AlternatePort: _str = "Alternate"; break; \
+		case BackupPort: _str = "Backup"; break; \
+		case DisabledPort: _str = "Disabled"; break; \
+		default: ; \
+		}							\
+		_str;							\
+	})
+
+#define SHORT_ROLE_STR(_role)			\
+	({					\
+		int _r = _role;		\
+		char *_str = "Unkn";		\
+		switch ((Role)_r)			\
+		{					     \
+		case RootPort: _str = "Root"; break; \
+		case DesignatedPort:   _str = "Desg"; break; \
+		case AlternatePort: _str = "Altn"; break; \
+		case BackupPort: _str = "Back"; break; \
+		case DisabledPort: _str = "Disa"; break; \
+		default: ; \
+		}							\
+		_str;							\
+	})
+
 
 int detail = 0;
 
@@ -193,7 +225,7 @@
 
 	if (detail) {
 		printf("%s (%u)\n", port_name, (s.id & 0xfff));
-		printf(" enabled\t\t%4s\n", BOOL_STR(s.enabled));
+		printf(" enabled\t\t%4s\t\t\trole\t\t%15s\n", BOOL_STR(s.enabled), 
ROLE_STR(s.role_));
 		printf(" port id\t\t%04x\t\t\tstate\t\t%15s\n",
 		       s.id, STATE_STR(s.state));
 		printf(" path cost\t%12d\t\t\tadmin path cost\t%12d\n", 
@@ -213,7 +245,7 @@
 		printf("\t\t\tadmin point to point\t%4s\n",
 		       ADMIN_P2P_STR(s.admin_p2p));
 	} else {
-		printf("%c%c %4s %04x %4s " BR_ID_FMT " " BR_ID_FMT " %04x\n",
+		printf("%c%c %4s %04x %4s " BR_ID_FMT " " BR_ID_FMT " %04x %4s\n",
 		       (s.oper_p2p) ? ' ' : '*',
 		       (s.oper_edge_port) ? 'E' : ' ',
 		       port_name,
@@ -221,7 +253,8 @@
 		       s.enabled?SHORT_STATE_STR(s.state):"down",
 		       BR_ID_ARGS(s.designated_root),
 		       BR_ID_ARGS(s.designated_bridge),
-		       s.designated_port);
+		       s.designated_port,
+		       SHORT_ROLE_STR(s.role_));
 	}
 	return 0;
 }
Only in b: ctl_main.c.orig
diff -ur a/rstp.c b/rstp.c
--- a/rstp.c	2009-05-25 18:37:52.000000000 +0300
+++ b/rstp.c	2009-05-25 18:40:24.000000000 +0300
@@ -271,19 +271,6 @@
   Disabled
 } InfoType;
 
-// We accomodate the port role encoding in BPDUs as per 9.2.9
-// into this type, defining an extra value of AltBackupPort valid
-// only in a BPDU.
-typedef enum _Role {
-  UnknownPort = 0,
-  AltBackupPort = 1,
-  RootPort = 2,
-  DesignatedPort = 3,
-  AlternatePort,
-  BackupPort,
-  DisabledPort
-} Role;
-
 typedef enum _BPDUType {
   BPDUTypeConfig = 0,
   BPDUTypeRST = 2,
@@ -2947,6 +2934,8 @@
 
   status->admin_p2p = adminPointToPointMAC;
   status->oper_p2p = operPointToPointMAC;
+
+  status->role_ = role;
 }
 
 
Only in b: rstp.c.orig
diff -ur a/rstp.h b/rstp.h
--- a/rstp.h	2009-05-25 18:37:52.000000000 +0300
+++ b/rstp.h	2009-05-25 18:40:24.000000000 +0300
@@ -149,6 +149,19 @@
 
 /****** Status ******/
 
+/* We accomodate the port role encoding in BPDUs as per 9.2.9
+  into this type, defining an extra value of AltBackupPort valid
+  only in a BPDU. */
+typedef enum _Role {
+    UnknownPort = 0,
+    AltBackupPort = 1,
+    RootPort = 2,
+    DesignatedPort = 3,
+    AlternatePort,
+    BackupPort,
+    DisabledPort
+} Role;
+
 typedef struct STP_BridgeStatus_
 {
   unsigned char bridge_id[8];
@@ -197,6 +210,7 @@
                         */
   unsigned int admin_p2p;
   unsigned int oper_p2p;
+  unsigned int role_;
 } STP_PortStatus;
 
 void STP_IN_get_port_status(STP_Port *, STP_PortStatus *);

-- 
With Best Regards,
Vitaly Demyanec
