Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F3D384235
	for <bridge@lists.linux.dev>; Fri,  3 Jul 2026 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783061668; cv=none; b=MsXJvAK+2fbC83uM9wXWnVRRm4YK+aGJrPmQs/pmRyzJj+aXTgB5XvjECe1CHe0izKLdJO7+vHXqkgH29/T1d9FGeEuCPs1rHdHknVOi+AO1hvXfxFoVRZa2ehwWf63HIFEZyqpF0q1qPO33a3ugX9MtJK98yiayNFqBKCK1QOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783061668; c=relaxed/simple;
	bh=xvkP1kA16svAHfpR5XQQZqGBXhb54N/3v9yky1IBVCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OPvBSE2gwmB1TTauprDAcHla2WZl4+YI4ze+hAMOhpMNuKym8AytY+y4I4gQF2J4V3Zjzsje96/z50yWkmzAe3XZNnMXaXhY9B87ea/YWtYQdyIjpWZlsJ8CCBdE5/zbGmLmmzY3CDtdJDVqjRh9odKAxpEzJrv0JtNX61Ge8DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=zlcpKr0o; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="zlcpKr0o"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id C823160964;
	Fri,  3 Jul 2026 02:54:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783061665; bh=CC3zPmFwqSxCLyeNcq15vNFk6UO9NOvqsI2ewkJBfQs=;
	h=From:Date:Subject:To:Cc:From;
	b=zlcpKr0o4/jfxpxfKG0svevf+vZzT37NHfuLaBRffYMK3+9GLmYBacszuFoLtgUAp
	 zuSsw9vSqfXV8CjCG5fkmCKI7PIpW5wG5CHYI+HNV5aDQn5aZjwNbTWbsUMhJZqgSx
	 PZAJeYljslmkp2Q9NPOg/J9Barf4U/tPzhhIvEWE6BLyj4sjvA+f8+7Q65deuStI+X
	 1otAxDbRjEDQM+LuL53WdLcKldpFraxJf0siJPi7QfNsnnzHBMwQLzcYl68SmE70II
	 gGfGGN3reUD8Dx9zuFMA98sdUu8yt3+y2IMJfLAj6/JkmIGy53nhWLKxSwAaFgKgk2
	 mGRnZHjiqNoZA==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 16:54:14 +1000
Subject: [PATCH RFC net-next] net: bridge: add BRIDGE_VLAN_INFO_DYNAMIC
 flag
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-vlan-dynamic-entry-v1-1-c2cbb134036c@padl.com>
X-B4-Tracking: v=1; b=H4sIAJVcR2oC/yWMQQ6CMBBFr0Jm7SS1RAS3Jh7ALXFRy1fH6GjaS
 iCEu1t0+X7+exNFBEGkXTFRQC9RXpphvSrI35xewdJlJmtsZbam5P7hlLtR3VM8Q1MYeVM5Y2v
 UTWNAWXwHXGT4RVs6HvbLpkisGBKd/of4Od/h05Kmef4CEmwpTYcAAAA=
X-Change-ID: 20260703-vlan-dynamic-entry-56a028e8990e
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
 Simon Horman <horms@kernel.org>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org, 
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783061661; l=4578;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=xvkP1kA16svAHfpR5XQQZqGBXhb54N/3v9yky1IBVCs=;
 b=tJLfFaJKEL2MaEo+C2e0lodCGWWWyqBUANHGLIAvbkI1YIJ0QTe8QUOaPSgKIPghedG0syUzg
 E1Mvz0NG9MuCrBayb86UR1e4H1LIel7YwbGLpvLKhbc8p/J1FR/B/2v
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=

Dynamic VLAN entries as specified in IEEE Std 802.1Q-2022,
Clause 8.8.5. These allow a user-space VLAN registration
protocol such as MVRP to mark a bridge's VLAN entries as
dynamic, so they can be distinguished from administratively
configured static entries.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Luke Howard <lukeh@padl.com>
---
This patch adds support for Dynamic VLAN Entries, as specified
in 802.1Q. I have marked it as RFC as a similar patch to add
support for Dynamic Reservation Entries to the FDB was rejected
on the argument that the dynamic bit should be stored separately.

Our MVRP implementation [1] will use this flag if available.

[1] https://github.com/PADL/OpenSRP
---
 include/uapi/linux/if_bridge.h |  1 +
 net/bridge/br_netlink.c        |  6 ++++++
 net/bridge/br_vlan.c           | 18 ++++++++++++++----
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 21a700c02ef76..a3abbfe79694b 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -134,6 +134,7 @@ enum {
 #define BRIDGE_VLAN_INFO_RANGE_END	(1<<4) /* VLAN is end of vlan range */
 #define BRIDGE_VLAN_INFO_BRENTRY	(1<<5) /* Global bridge VLAN entry */
 #define BRIDGE_VLAN_INFO_ONLY_OPTS	(1<<6) /* Skip create/delete/flags */
+#define BRIDGE_VLAN_INFO_DYNAMIC	(1<<7) /* 802.1Q Dynamic VLAN Registration Entry */
 
 struct bridge_vlan_info {
 	__u16 flags;
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index b2cd4e39326d0..90f2e103f53d5 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -388,6 +388,9 @@ static int br_fill_ifvlaninfo_compressed(struct sk_buff *skb,
 		if (v->flags & BRIDGE_VLAN_INFO_UNTAGGED)
 			flags |= BRIDGE_VLAN_INFO_UNTAGGED;
 
+		if (v->flags & BRIDGE_VLAN_INFO_DYNAMIC)
+			flags |= BRIDGE_VLAN_INFO_DYNAMIC;
+
 		if (vid_range_start == 0) {
 			goto initvars;
 		} else if ((v->vid - vid_range_end) == 1 &&
@@ -440,6 +443,9 @@ static int br_fill_ifvlaninfo(struct sk_buff *skb,
 		if (v->flags & BRIDGE_VLAN_INFO_UNTAGGED)
 			vinfo.flags |= BRIDGE_VLAN_INFO_UNTAGGED;
 
+		if (v->flags & BRIDGE_VLAN_INFO_DYNAMIC)
+			vinfo.flags |= BRIDGE_VLAN_INFO_DYNAMIC;
+
 		if (nla_put(skb, IFLA_BRIDGE_VLAN_INFO,
 			    sizeof(vinfo), &vinfo))
 			goto nla_put_failure;
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 5560afcaaca32..e6bc59e3a4c4f 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -54,9 +54,11 @@ static void __vlan_delete_pvid(struct net_bridge_vlan_group *vg, u16 vid)
 	vg->pvid = 0;
 }
 
-/* Update the BRIDGE_VLAN_INFO_PVID and BRIDGE_VLAN_INFO_UNTAGGED flags of @v.
- * If @commit is false, return just whether the BRIDGE_VLAN_INFO_PVID and
- * BRIDGE_VLAN_INFO_UNTAGGED bits of @flags would produce any change onto @v.
+/* Update the BRIDGE_VLAN_INFO_PVID, BRIDGE_VLAN_INFO_UNTAGGED and
+ * BRIDGE_VLAN_INFO_DYNAMIC flags of @v.
+ * If @commit is false, return just whether the BRIDGE_VLAN_INFO_PVID,
+ * BRIDGE_VLAN_INFO_UNTAGGED and BRIDGE_VLAN_INFO_DYNAMIC bits of @flags
+ * would produce any change onto @v.
  */
 static bool __vlan_flags_update(struct net_bridge_vlan *v, u16 flags,
 				bool commit)
@@ -71,7 +73,8 @@ static bool __vlan_flags_update(struct net_bridge_vlan *v, u16 flags,
 
 	/* check if anything would be changed on commit */
 	change = !!(flags & BRIDGE_VLAN_INFO_PVID) == !!(vg->pvid != v->vid) ||
-		 ((flags ^ v->flags) & BRIDGE_VLAN_INFO_UNTAGGED);
+		 ((flags ^ v->flags) & (BRIDGE_VLAN_INFO_UNTAGGED |
+					BRIDGE_VLAN_INFO_DYNAMIC));
 
 	if (!commit)
 		goto out;
@@ -86,6 +89,11 @@ static bool __vlan_flags_update(struct net_bridge_vlan *v, u16 flags,
 	else
 		v->flags &= ~BRIDGE_VLAN_INFO_UNTAGGED;
 
+	if (flags & BRIDGE_VLAN_INFO_DYNAMIC)
+		v->flags |= BRIDGE_VLAN_INFO_DYNAMIC;
+	else
+		v->flags &= ~BRIDGE_VLAN_INFO_DYNAMIC;
+
 out:
 	return change;
 }
@@ -1874,6 +1882,8 @@ static bool br_vlan_fill_vids(struct sk_buff *skb, u16 vid, u16 vid_range,
 		info.flags |= BRIDGE_VLAN_INFO_UNTAGGED;
 	if (flags & BRIDGE_VLAN_INFO_PVID)
 		info.flags |= BRIDGE_VLAN_INFO_PVID;
+	if (flags & BRIDGE_VLAN_INFO_DYNAMIC)
+		info.flags |= BRIDGE_VLAN_INFO_DYNAMIC;
 
 	if (nla_put(skb, BRIDGE_VLANDB_ENTRY_INFO, sizeof(info), &info))
 		goto out_err;

---
base-commit: 2bb62a85aff6d4c14a62a476dfabaada3c1cc014
change-id: 20260703-vlan-dynamic-entry-56a028e8990e

Best regards,
--  
Luke Howard <lukeh@padl.com>

