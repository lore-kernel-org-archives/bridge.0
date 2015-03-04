Return-Path: <joerg@higgsboson.tk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=higgsboson.tk;
	s=default; t=1425456808;
	bh=Jo7eIUG4d5he6KxCHJKz/Z0sB4O+tjjQNkKClyb7Uic=;
	h=Date:From:To:Cc:Subject:From;
	b=mLJvvKO7l8VeOHqjX1S7QRleUyXIF6HdMjgdK1m20dkK3OvuZbzv+FvMXWWRSObeg
	8BL5VKnYKjEv0CmqTkthQiTC9srg1wt8kgZsek55zY1cT9y3oNDyosQbTx7/l6FTrd
	/T3s70OzboM1rnlFYYinqxV4/08s13JyRfVT7vIs=
Date: Wed, 4 Mar 2015 09:13:26 +0100
From: =?UTF-8?B?SsO2cmc=?= Thalheim <joerg@higgsboson.tk>
Message-ID: <20150304091326.4e0fd519@turingmachine>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/_jLXdiLaRXG_XyMkxBVdb0c";
	protocol="application/pgp-signature"
Subject: [Bridge] [PATCH] bridge: add ageing_time, stp_state,
	priority over netlink
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: bridge@lists.linux-foundation.org

--Sig_/_jLXdiLaRXG_XyMkxBVdb0c
Content-Type: multipart/mixed; boundary="MP_/uV_jK1oPkm9uGAFHEQgyppN"

--MP_/uV_jK1oPkm9uGAFHEQgyppN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


Signed-off-by: J=C3=B6rg Thalheim <joerg@higgsboson.tk>
---
 include/uapi/linux/if_link.h |  3 +++
 net/bridge/br_netlink.c      | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)


--MP_/uV_jK1oPkm9uGAFHEQgyppN
Content-Type: text/x-patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename=0001-bridge-add-ageing_time-stp_state-priority-over-netli.patch

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index dfd0bb2..ca5d838 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -224,6 +224,9 @@ enum {
 	IFLA_BR_FORWARD_DELAY,
 	IFLA_BR_HELLO_TIME,
 	IFLA_BR_MAX_AGE,
+	IFLA_BR_AGEING_TIME,
+	IFLA_BR_STP_STATE,
+	IFLA_BR_PRIORITY,
 	__IFLA_BR_MAX,
 };
=20
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 3de0eef..13ffb66 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -728,6 +728,9 @@ static const struct nla_policy br_policy[IFLA_BR_MAX + =
1] =3D {
 	[IFLA_BR_FORWARD_DELAY]	=3D { .type =3D NLA_U32 },
 	[IFLA_BR_HELLO_TIME]	=3D { .type =3D NLA_U32 },
 	[IFLA_BR_MAX_AGE]	=3D { .type =3D NLA_U32 },
+	[IFLA_BR_AGEING_TIME] =3D { .type =3D NLA_U32 },
+	[IFLA_BR_STP_STATE] =3D { .type =3D NLA_U32 },
+	[IFLA_BR_PRIORITY] =3D { .type =3D NLA_U16 },
 };
=20
 static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
@@ -757,6 +760,24 @@ static int br_changelink(struct net_device *brdev, str=
uct nlattr *tb[],
 			return err;
 	}
=20
+	if (data[IFLA_BR_AGEING_TIME]) {
+		u32 ageing_time =3D nla_get_u32(data[IFLA_BR_AGEING_TIME]);
+
+		br->ageing_time =3D clock_t_to_jiffies(ageing_time);
+	}
+
+	if (data[IFLA_BR_STP_STATE]) {
+		u32 stp_enabled =3D nla_get_u32(data[IFLA_BR_STP_STATE]);
+
+		br_stp_set_enabled(br, stp_enabled);
+	}
+
+	if (data[IFLA_BR_PRIORITY]) {
+		u32 priority =3D nla_get_u16(data[IFLA_BR_PRIORITY]);
+
+		br_stp_set_bridge_priority(br, priority);
+	}
+
 	return 0;
 }
=20
@@ -765,6 +786,9 @@ static size_t br_get_size(const struct net_device *brde=
v)
 	return nla_total_size(sizeof(u32)) +	/* IFLA_BR_FORWARD_DELAY  */
 	       nla_total_size(sizeof(u32)) +	/* IFLA_BR_HELLO_TIME */
 	       nla_total_size(sizeof(u32)) +	/* IFLA_BR_MAX_AGE */
+	       nla_total_size(sizeof(u32)) +    /* IFLA_BR_AGEING_TIME */
+	       nla_total_size(sizeof(u32)) +    /* IFLA_BR_STP_STATE */
+	       nla_total_size(sizeof(u16)) +    /* IFLA_BR_PRIORITY */
 	       0;
 }
=20
@@ -774,10 +798,16 @@ static int br_fill_info(struct sk_buff *skb, const st=
ruct net_device *brdev)
 	u32 forward_delay =3D jiffies_to_clock_t(br->forward_delay);
 	u32 hello_time =3D jiffies_to_clock_t(br->hello_time);
 	u32 age_time =3D jiffies_to_clock_t(br->max_age);
+	u32 ageing_time =3D jiffies_to_clock_t(br->ageing_time);
+	u32 stp_enabled =3D br->stp_enabled;
+	u16 priority =3D (br->bridge_id.prio[0] << 8) | br->bridge_id.prio[1];
=20
 	if (nla_put_u32(skb, IFLA_BR_FORWARD_DELAY, forward_delay) ||
 	    nla_put_u32(skb, IFLA_BR_HELLO_TIME, hello_time) ||
-	    nla_put_u32(skb, IFLA_BR_MAX_AGE, age_time))
+	    nla_put_u32(skb, IFLA_BR_MAX_AGE, age_time) ||
+	    nla_put_u32(skb, IFLA_BR_AGEING_TIME, ageing_time) ||
+	    nla_put_u32(skb, IFLA_BR_STP_STATE, stp_enabled) ||
+	    nla_put_u16(skb, IFLA_BR_PRIORITY, priority))
 		return -EMSGSIZE;
=20
 	return 0;

--MP_/uV_jK1oPkm9uGAFHEQgyppN--

--Sig_/_jLXdiLaRXG_XyMkxBVdb0c
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU9r6mAAoJEMpBBrjXzHn6z7oIAKdTQeu2jobmJZFdnHp6sjAp
eiFWBNrK6PDutMKGn3B7TGyB8sSvNF++xgYaGjAdaRjaLNcwkEXaFVIE0Q8bC4Im
Gdz8AFl2ZVIPNjQCQrHrE5pjDPyoL7GeVJ94CiMdFr+c6Q462zT8rzvksJDXn1iw
5JBBtPH4TNZaYribdqFs+iXtgzVG1n9+uOfyExJDO7dUaUeAB8FL4iGuQt9uUwmk
f+ZhPuhylFMRmB+IYBZ4AvHBH1Avif/ZAAGD26JE+KfB2lCjFYPUl8gHhlZeJrYD
+Ww2e/jaFNX6Yn5f6Wq9UwBS52ITirY7fTu0uQLBqTUrI1nd5lJmc4vqFI442T0=
=1Kql
-----END PGP SIGNATURE-----

--Sig_/_jLXdiLaRXG_XyMkxBVdb0c--
