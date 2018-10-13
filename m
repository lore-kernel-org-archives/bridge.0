Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=V4oU3Qa7hWvRhxBQEItEDU0ftoe1XxvN5Ac4aHW+QQI=;
	b=IRnf2BHwlIX0kU7CWnNe9NRUKY0W8iizx26ip40qgiVgF8lUNc32xTLQyrjUgjAZHqLqKVBZ/+s2c503X3fvNm/2VtkypPovyO4rifIs3ch/5HsdD2qhmIOiE1+xJWqBJksdOBdjF7vQO5BmgrHnVVgmC+vgR8UQ6p4CEH9q2Tw=
From: Ido Schimmel <idosch@mellanox.com>
Date: Sat, 13 Oct 2018 17:18:28 +0000
Message-ID: <20181013171725.3261-6-idosch@mellanox.com>
References: <20181013171725.3261-1-idosch@mellanox.com>
In-Reply-To: <20181013171725.3261-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 05/18] vxlan: Export address checking
	functions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, mlxsw <mlxsw@mellanox.com>, Ido Schimmel <idosch@mellanox.com>, "vivien.didelot@savoirfairelinux.com" <vivien.didelot@savoirfairelinux.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

Drivers that support VxLAN offload need to be able to sanitize the
configuration of the VxLAN device and accept / reject its offload.

For example, mlxsw requires that the local IP of the VxLAN device be set
and that packets be flooded to unicast IP(s) and not to a multicast
group.

Expose the functions that perform such checks.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 drivers/net/vxlan.c | 26 --------------------------
 include/net/vxlan.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index fb0cdbba8d76..a646aa8e98ff 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -103,22 +103,6 @@ bool vxlan_addr_equal(const union vxlan_addr *a, const=
 union vxlan_addr *b)
 		return a->sin.sin_addr.s_addr =3D=3D b->sin.sin_addr.s_addr;
 }
=20
-static inline bool vxlan_addr_any(const union vxlan_addr *ipa)
-{
-	if (ipa->sa.sa_family =3D=3D AF_INET6)
-		return ipv6_addr_any(&ipa->sin6.sin6_addr);
-	else
-		return ipa->sin.sin_addr.s_addr =3D=3D htonl(INADDR_ANY);
-}
-
-static inline bool vxlan_addr_multicast(const union vxlan_addr *ipa)
-{
-	if (ipa->sa.sa_family =3D=3D AF_INET6)
-		return ipv6_addr_is_multicast(&ipa->sin6.sin6_addr);
-	else
-		return IN_MULTICAST(ntohl(ipa->sin.sin_addr.s_addr));
-}
-
 static int vxlan_nla_get_addr(union vxlan_addr *ip, struct nlattr *nla)
 {
 	if (nla_len(nla) >=3D sizeof(struct in6_addr)) {
@@ -151,16 +135,6 @@ bool vxlan_addr_equal(const union vxlan_addr *a, const=
 union vxlan_addr *b)
 	return a->sin.sin_addr.s_addr =3D=3D b->sin.sin_addr.s_addr;
 }
=20
-static inline bool vxlan_addr_any(const union vxlan_addr *ipa)
-{
-	return ipa->sin.sin_addr.s_addr =3D=3D htonl(INADDR_ANY);
-}
-
-static inline bool vxlan_addr_multicast(const union vxlan_addr *ipa)
-{
-	return IN_MULTICAST(ntohl(ipa->sin.sin_addr.s_addr));
-}
-
 static int vxlan_nla_get_addr(union vxlan_addr *ip, struct nlattr *nla)
 {
 	if (nla_len(nla) >=3D sizeof(struct in6_addr)) {
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index 7ef15179f263..dd3d72ce64b6 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -370,4 +370,36 @@ static inline unsigned short vxlan_get_sk_family(struc=
t vxlan_sock *vs)
 	return vs->sock->sk->sk_family;
 }
=20
+#if IS_ENABLED(CONFIG_IPV6)
+
+static inline bool vxlan_addr_any(const union vxlan_addr *ipa)
+{
+	if (ipa->sa.sa_family =3D=3D AF_INET6)
+		return ipv6_addr_any(&ipa->sin6.sin6_addr);
+	else
+		return ipa->sin.sin_addr.s_addr =3D=3D htonl(INADDR_ANY);
+}
+
+static inline bool vxlan_addr_multicast(const union vxlan_addr *ipa)
+{
+	if (ipa->sa.sa_family =3D=3D AF_INET6)
+		return ipv6_addr_is_multicast(&ipa->sin6.sin6_addr);
+	else
+		return IN_MULTICAST(ntohl(ipa->sin.sin_addr.s_addr));
+}
+
+#else /* !IS_ENABLED(CONFIG_IPV6) */
+
+static inline bool vxlan_addr_any(const union vxlan_addr *ipa)
+{
+	return ipa->sin.sin_addr.s_addr =3D=3D htonl(INADDR_ANY);
+}
+
+static inline bool vxlan_addr_multicast(const union vxlan_addr *ipa)
+{
+	return IN_MULTICAST(ntohl(ipa->sin.sin_addr.s_addr));
+}
+
+#endif /* IS_ENABLED(CONFIG_IPV6) */
+
 #endif
--=20
2.17.2

