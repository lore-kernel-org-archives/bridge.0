From: Vitaly Demyanec <vitas@nppfactor.kiev.ua>
Date: Tue, 26 May 2009 11:05:12 +0300
References: <200905251848.03023.vitas@nppfactor.kiev.ua>
	<200905251906.59864.vitas@nppfactor.kiev.ua>
In-Reply-To: <200905251906.59864.vitas@nppfactor.kiev.ua>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4K6GKLTo6TolfB1"
Message-Id: <200905261105.12952.vitas@nppfactor.kiev.ua>
Subject: Re: [Bridge] [PATCH 2/2] rstpd: Display port role with rstpctl
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--Boundary-00=_4K6GKLTo6TolfB1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Oh, sorry, my mailer has deformed inlined patch, so send it again, now as 
attachment.

BTW, what about that .depend file in repository? It is not used in Makefile, 
and anyway its content is out-of-date. Maybe it should be removed from 
repository?

-- 
With Best Regards,
Vitaly Demyanec

--Boundary-00=_4K6GKLTo6TolfB1
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="add_role_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="add_role_patch"

diff -ur a/ctl_main.c b/ctl_main.c
--- a/ctl_main.c	2009-05-26 10:50:04.000000000 +0300
+++ b/ctl_main.c	2009-05-26 10:50:24.000000000 +0300
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
+		printf(" enabled\t\t%4s\t\t\trole\t\t%15s\n", BOOL_STR(s.enabled), ROLE_STR(s.role_));
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
diff -ur a/rstp.c b/rstp.c
--- a/rstp.c	2009-05-26 10:50:04.000000000 +0300
+++ b/rstp.c	2009-05-26 10:50:24.000000000 +0300
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
 
 
diff -ur a/rstp.h b/rstp.h
--- a/rstp.h	2009-05-26 10:50:04.000000000 +0300
+++ b/rstp.h	2009-05-26 10:50:24.000000000 +0300
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

--Boundary-00=_4K6GKLTo6TolfB1--
