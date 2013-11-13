Return-Path: <glenn.feunteun@orange.com>
From: <glenn.feunteun@orange.com>
Date: Wed, 13 Nov 2013 16:26:12 +0000
Message-ID: <14922_1384359973_5283A825_14922_2941_1_F30F0A0ED6964F42A271F6E9495DDBD0B2E641@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Content-Language: fr-FR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH] Mirroring function
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

Userspace patch for the mirroring function made against bridge-utils 1.5 :

---------------------------------------------------------------------------=
---------------

diff -urBb old/brctl/brctl_cmd.c new1/brctl/brctl_cmd.c
--- old/brctl/brctl_cmd.c	2013-11-13 10:37:48.635728832 +0100
+++ new1/brctl/brctl_cmd.c	2013-11-13 10:59:58.915775559 +0100
@@ -438,6 +438,56 @@
 	return err !=3D 0;
 }
=20
+static int br_cmd_mirror(int argc, char *const* argv)
+{
+ 	int mirror_state =3D 0, err;
+ 	const char *brname =3D *++argv;
+ 	const char *ifname =3D *++argv;
+ 	const char *ifmode =3D *++argv;
+=20
+ 	if (!strcmp(ifmode, "dst") || !strcmp(ifmode, "destination")
+ 	    || !strcmp(ifmode, "4"))
+ 		mirror_state |=3D BR_MIRROR_DST ;
+=20
+ 	else if (!strcmp(ifmode, "both") || !strcmp(ifmode, "all")
+ 	    || !strcmp(ifmode, "3"))
+ 		mirror_state |=3D (BR_MIRROR_RX | BR_MIRROR_TX);
+=20
+ 	else if (!strcmp(ifmode, "tx") || !strcmp(ifmode, "egress")
+ 	    || !strcmp(ifmode, "2"))
+ 		mirror_state |=3D BR_MIRROR_TX;
+=20
+ 	else if (!strcmp(ifmode, "rx") || !strcmp(ifmode, "ingress")
+ 	    || !strcmp(ifmode, "1"))
+ 		mirror_state |=3D BR_MIRROR_RX;
+=20
+ 	else if (!strcmp(ifmode, "off") || !strcmp(ifmode, "no")
+ 		 || !strcmp(ifmode, "0"))
+ 		mirror_state &=3D BR_MIRROR_OFF;
+=20
+ 	else {
+ 		fprintf(stderr, "expect rx/tx/both/off/dst for argument\n");
+ 		return 1;
+ 	}
+ 	if (if_nametoindex(ifname) =3D=3D 0) {
+ 		fprintf(stderr, "interface %s does not exist!\n",
+ 			ifname);
+ 		return 1;
+ 	} else if (if_nametoindex(brname) =3D=3D 0) {
+ 		fprintf(stderr, "bridge %s does not exist!\n",
+ 			brname);
+ 		return 1;
+ 	}
+=20
+ 	err =3D br_set_mirror_state(brname, ifname, mirror_state);
+=20
+ 	if (err) {
+ 		fprintf(stderr, "can't set %s to %s state on bridge %s: %s\n",
+ 			ifname,ifmode,brname, strerror(err));
+ 	}
+	return err !=3D 0;
+}
+
 static const struct command commands[] =3D {
 	{ 1, "addbr", br_cmd_addbr, "<bridge>\t\tadd bridge" },
 	{ 1, "delbr", br_cmd_delbr, "<bridge>\t\tdelete bridge" },
@@ -469,6 +519,8 @@
 	  "<bridge>\t\tshow bridge stp info"},
 	{ 2, "stp", br_cmd_stp,
 	  "<bridge> {on|off}\tturn stp on/off" },
+	{ 3, "mirror", br_cmd_mirror,
+	  "<bridge> <interface> {rx|tx|both|off|dst}\tset interface mirroring sta=
te" },
 };
=20
 const struct command *command_lookup(const char *cmd)
diff -urBb old/libbridge/libbridge_devif.c new1/libbridge/libbridge_devif.c
--- old/libbridge/libbridge_devif.c	2013-11-13 10:37:39.767722700 +0100
+++ new1/libbridge/libbridge_devif.c	2013-11-13 11:05:23.431777935 +0100
@@ -272,6 +272,7 @@
 	fetch_tv(path, "forward_delay_timer", &info->forward_delay_timer_value);
 	fetch_tv(path, "hold_timer", &info->hold_timer_value);
 	info->hairpin_mode =3D fetch_int(path, "hairpin_mode");
+	info->mirror_state =3D fetch_int(path, "mirror_state");
=20
 	closedir(d);
=20
@@ -388,6 +389,11 @@
 	return port_set(bridge, port, "hairpin_mode", hairpin_mode, 0);
 }
=20
+int br_set_mirror_state(const char *bridge, const char *port, int mirror_s=
tate)
+{
+	return port_set(bridge, port, "mirror_state", mirror_state, 0);
+}
+
 static inline void __copy_fdb(struct fdb_entry *ent,=20
 			      const struct __fdb_entry *f)
 {
diff -urBb old/libbridge/libbridge.h new1/libbridge/libbridge.h
--- old/libbridge/libbridge.h	2013-11-13 10:51:53.359776785 +0100
+++ new1/libbridge/libbridge.h	2013-11-13 11:09:32.159787057 +0100
@@ -82,8 +82,14 @@
 	struct timeval forward_delay_timer_value;
 	struct timeval hold_timer_value;
 	unsigned char hairpin_mode;
+	unsigned char mirror_state;
 };
=20
+#define BR_MIRROR_OFF 0x00
+#define BR_MIRROR_RX 0x01
+#define BR_MIRROR_TX 0x02
+#define BR_MIRROR_DST 0x04
+
 extern int br_init(void);
 extern int br_refresh(void);
 extern void br_shutdown(void);
@@ -117,4 +123,6 @@
 		       unsigned long skip, int num);
 extern int br_set_hairpin_mode(const char *bridge, const char *dev,
 			       int hairpin_mode);
+extern int br_set_mirror_state(const char *brname, const char *dev,
+                               int mirror_state);
 #endif

___________________________________________________________________________=
______________________________________________

Ce message et ses pieces jointes peuvent contenir des informations confiden=
tielles ou privilegiees et ne doivent donc
pas etre diffuses, exploites ou copies sans autorisation. Si vous avez recu=
 ce message par erreur, veuillez le signaler
a l'expediteur et le detruire ainsi que les pieces jointes. Les messages el=
ectroniques etant susceptibles d'alteration,
Orange decline toute responsabilite si ce message a ete altere, deforme ou =
falsifie. Merci.

This message and its attachments may contain confidential or privileged inf=
ormation that may be protected by law;
they should not be distributed, used or copied without authorisation.
If you have received this email in error, please notify the sender and dele=
te this message and its attachments.
As emails may be altered, Orange is not liable for messages that have been =
modified, changed or falsified.
Thank you.

