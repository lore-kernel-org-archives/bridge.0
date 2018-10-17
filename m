Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=v7DIcjsivyPNW/o35VTCR9PvcSPdlUzBVgzZAPs2JuU=;
	b=jHUM/PlEzrj1IvXHSopb417sT0AkQ/Bq4433LZi54O0bRPDAOK4+fFIRCF+Y89Hnwvx5U1UVJ25+lcSz+33GnoptUETyRWjKOn8gadqMegg+uwvruPH/LaP/jn9fWJmNQkZMjbW+iadrac24vueN4AFNDMlie91CaFXHBcga6w4=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 17 Oct 2018 08:53:12 +0000
Message-ID: <20181017085215.26607-7-idosch@mellanox.com>
References: <20181017085215.26607-1-idosch@mellanox.com>
In-Reply-To: <20181017085215.26607-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 06/18] inet: Refactor
	INET_ECN_decapsulate()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>, Ido Schimmel <idosch@mellanox.com>, "vivien.didelot@savoirfairelinux.com" <vivien.didelot@savoirfairelinux.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Jiri Pirko <jiri@mellanox.com>, mlxsw <mlxsw@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

Drivers that support tunnel decapsulation (IPinIP or NVE) need to
configure the underlying device to conform to the behavior outlined in
RFC 6040 with respect to the ECN bits.

This behavior is implemented by INET_ECN_decapsulate() which requires an
skb to be passed where the ECN CE bit can be potentially set. Since
these drivers do not need to mark an skb, but only configure the device
to do so, factor out the business logic to __INET_ECN_decapsulate() and
potentially perform the marking in INET_ECN_decapsulate().

This allows drivers to invoke __INET_ECN_decapsulate() and configure the
device.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Suggested-by: Petr Machata <petrm@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 include/net/inet_ecn.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/net/inet_ecn.h b/include/net/inet_ecn.h
index 482a1b705362..c8e2bebd8d93 100644
--- a/include/net/inet_ecn.h
+++ b/include/net/inet_ecn.h
@@ -183,8 +183,7 @@ static inline int INET_ECN_set_ce(struct sk_buff *skb)
  *          1 if something is broken and should be logged (!!! above)
  *          2 if packet should be dropped
  */
-static inline int INET_ECN_decapsulate(struct sk_buff *skb,
-				       __u8 outer, __u8 inner)
+static inline int __INET_ECN_decapsulate(__u8 outer, __u8 inner, bool *set=
_ce)
 {
 	if (INET_ECN_is_not_ect(inner)) {
 		switch (outer & INET_ECN_MASK) {
@@ -198,10 +197,21 @@ static inline int INET_ECN_decapsulate(struct sk_buff=
 *skb,
 		}
 	}
=20
-	if (INET_ECN_is_ce(outer))
+	*set_ce =3D INET_ECN_is_ce(outer);
+	return 0;
+}
+
+static inline int INET_ECN_decapsulate(struct sk_buff *skb,
+				       __u8 outer, __u8 inner)
+{
+	bool set_ce =3D false;
+	int rc;
+
+	rc =3D __INET_ECN_decapsulate(outer, inner, &set_ce);
+	if (!rc && set_ce)
 		INET_ECN_set_ce(skb);
=20
-	return 0;
+	return rc;
 }
=20
 static inline int IP_ECN_decapsulate(const struct iphdr *oiph,
--=20
2.17.2

