Date: Wed, 2 Jul 2008 19:09:17 -0400
From: Solomon Peachy <solomon@linux-wlan.com>
Message-ID: <20080702230917.GD21344@linux-wlan.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
Content-Disposition: inline
Subject: [Bridge] [patch] rstpd crashes with GARP/GMRP packets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Srinivas M.A." <srinivas.aji@gmail.com>
Cc: bridge@lists.linux-foundation.org


--5gxpn/Q6ypwruk0T
Content-Type: multipart/mixed; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The attached patch, against Shrinivas's May 7, 2008 snapshot, fixes a=20
null pointer dereference that occurs when we receive a packet from the=20
brige interface that bears the STP MACADDR, but is *not* a STP packet.

Specifically, I was receiving GMRP packets (see 802.1D-2004 10.1) from a=20
3Com switch.

I don't know what we should do with these -- but crashing isn't it.  I=20
can send over a packet dump and more debugging info if desired.

 - Solomon
--=20
Solomon Peachy                        solomon@linux-wlan.com
AbsoluteValue Systems                 http://www.linux-wlan.com
721-D North Drive                     +1 (321) 259-0737  (office)
Melbourne, FL 32934                   +1 (321) 259-0286  (fax)

--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rstp_fixes.diff"
Content-Transfer-Encoding: quoted-printable

diff --git a/packages/foss/rstp/brmon.c b/packages/foss/rstp/brmon.c
index d29e7f5..db0d3bb 100644
--- a/packages/foss/rstp/brmon.c
+++ b/packages/foss/rstp/brmon.c
@@ -153,7 +153,7 @@ static int dump_msg(const struct sockaddr_nl *who, stru=
ct nlmsghdr *n,
           int newlink =3D (n->nlmsg_type =3D=3D RTM_NEWLINK);
           int up =3D 0;
           if (newlink && tb[IFLA_OPERSTATE]) {
-            int state =3D *(int*)RTA_DATA(tb[IFLA_OPERSTATE]);
+            int state =3D *(uint8_t*)RTA_DATA(tb[IFLA_OPERSTATE]);
             up =3D (state =3D=3D IF_OPER_UP) || (state =3D=3D IF_OPER_UNKN=
OWN);
           }
=20
diff --git a/packages/foss/rstp/brstate.c b/packages/foss/rstp/brstate.c
index 1fe792e..c31a647 100644
--- a/packages/foss/rstp/brstate.c
+++ b/packages/foss/rstp/brstate.c
@@ -42,7 +42,7 @@ static int br_set_state(struct rtnl_handle *rth, unsigned=
 ifindex, __u8 state)
 	req.ifi.ifi_family =3D AF_BRIDGE;
 	req.ifi.ifi_index =3D ifindex;
=20
-	addattr32(&req.n, sizeof(req.buf), IFLA_PROTINFO, state);
+	addattr8(&req.n, sizeof(req.buf), IFLA_PROTINFO, state);
=20
 	return rtnl_talk(rth, &req.n, 0, 0, NULL, NULL, NULL);
 }
diff --git a/packages/foss/rstp/include/libnetlink.h b/packages/foss/rstp/i=
nclude/libnetlink.h
index 63cc3c8..35d76f0 100644
--- a/packages/foss/rstp/include/libnetlink.h
+++ b/packages/foss/rstp/include/libnetlink.h
@@ -33,6 +33,7 @@ extern int rtnl_talk(struct rtnl_handle *rtnl, struct nlm=
sghdr *n, pid_t peer,
 extern int rtnl_send(struct rtnl_handle *rth, const char *buf, int);
=20
=20
+extern int addattr8(struct nlmsghdr *n, int maxlen, int type, __u8 data);
 extern int addattr32(struct nlmsghdr *n, int maxlen, int type, __u32 data);
 extern int addattr_l(struct nlmsghdr *n, int maxlen, int type, const void =
*data, int alen);
 extern int addraw_l(struct nlmsghdr *n, int maxlen, const void *data, int =
len);
diff --git a/packages/foss/rstp/libnetlink.c b/packages/foss/rstp/libnetlin=
k.c
index 7752236..aaae102 100644
--- a/packages/foss/rstp/libnetlink.c
+++ b/packages/foss/rstp/libnetlink.c
@@ -508,6 +508,24 @@ int addattr32(struct nlmsghdr *n, int maxlen, int type=
, __u32 data)
 	return 0;
 }
=20
+int addattr8(struct nlmsghdr *n, int maxlen, int type, __u8 data)
+{
+	int len =3D RTA_LENGTH(1);
+	struct rtattr *rta;
+	if (NLMSG_ALIGN(n->nlmsg_len) + len > maxlen) {
+		fprintf(stderr,
+			"addattr32: Error! max allowed bound %d exceeded\n",
+			maxlen);
+		return -1;
+	}
+	rta =3D NLMSG_TAIL(n);
+	rta->rta_type =3D type;
+	rta->rta_len =3D len;
+	memcpy(RTA_DATA(rta), &data, 1);
+	n->nlmsg_len =3D NLMSG_ALIGN(n->nlmsg_len) + len;
+	return 0;
+}
+
 int addattr_l(struct nlmsghdr *n, int maxlen, int type, const void *data,
 	      int alen)
 {

--69pVuxX8awAiJ7fD--

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFIbAqdhinxHf95MjYRAmwLAKCNdCrVyYwCwIE1XmOykyWnWi+dWACbBOD5
CKmlPsJg0wq9nNvFGNAIbM0=
=YDUN
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--
