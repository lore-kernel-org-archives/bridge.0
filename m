Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9795C40BF8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 536DE40166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Io+ImuS3b07MnnII6pXyXtb80xF9L+WnhTul4DWibg4=;
 b=tDgHJ9ZxdmPZjT9l6ris9R6nbmAI6vr/FqcCe4O/7OKW31Fes2gT8YfhP8qM3v6chF4qmdreZvsVsgKWk9NovTgbp/+EK6QxRdeHTIgZv5WnwV7dbZZGb/8A3l4uOCZUZq7pXoDcnZYykfqK6W6kHW+KkHvKpQmsp8Njn1Wm5dm/bJqTfIcfPGcHgS8L9ju4RJnABljdMYd6sAFZoQvTD69DWGId7KS8NShqmuZuEj/wGRXwWJZF7Jj54cTI3s3seLV9bAaySgp93KQ9e3JCv39szco3lGHFm49V6FdVMOpCl5hyi/ebtY2VmtbwogJlT9w3oTW+SZ+sFp9H0S9/hA==
From: Ido Schimmel <idosch@nvidia.com>
Date: Thu,  8 Dec 2022 17:28:32 +0200
Message-Id: <20221208152839.1016350-8-idosch@nvidia.com>
In-Reply-To: <20221208152839.1016350-1-idosch@nvidia.com>
References: <20221208152839.1016350-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 07/14] bridge: mcast: Add a flag for user
	installed source entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

There are a few places where the bridge driver differentiates between
(S, G) entries installed by the kernel (in response to Membership
Reports) and those installed by user space. One of them is when deleting
an (S, G) entry corresponding to a source entry that is being deleted.

While user space cannot currently add a source entry to a (*, G), it can
add an (S, G) entry that later corresponds to a source entry created by
the reception of a Membership Report. If this source entry is later
deleted because its source timer expired or because the (*, G) entry is
being deleted, the bridge driver will not delete the corresponding (S,
G) entry if it was added by user space as permanent.

This is going to be a problem when the ability to install a (*, G) with
a source list is exposed to user space. In this case, when user space
installs the (*, G) as permanent, then all the (S, G) entries
corresponding to its source list will also be installed as permanent.
When user space deletes the (*, G), all the source entries will be
deleted and the expectation is that the corresponding (S, G) entries
will be deleted as well.

Solve this by introducing a new source entry flag denoting that the
entry was installed by user space. When the entry is deleted, delete the
corresponding (S, G) entry even if it was installed by user space as
permanent, as the flag tells us that it was installed in response to the
source entry being created.

The flag will be set in a subsequent patch where source entries are
created in response to user requests.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_multicast.c | 3 ++-
 net/bridge/br_private.h   | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 8432b4ea7f28..48170bd3785e 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -552,7 +552,8 @@ static void br_multicast_fwd_src_remove(struct net_bridge_group_src *src,
 			continue;
 
 		if (p->rt_protocol != RTPROT_KERNEL &&
-		    (p->flags & MDB_PG_FLAGS_PERMANENT))
+		    (p->flags & MDB_PG_FLAGS_PERMANENT) &&
+		    !(src->flags & BR_SGRP_F_USER_ADDED))
 			break;
 
 		if (fastleave)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index a3db99d79a3d..74f17b56c9eb 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -300,6 +300,7 @@ struct net_bridge_fdb_flush_desc {
 #define BR_SGRP_F_DELETE	BIT(0)
 #define BR_SGRP_F_SEND		BIT(1)
 #define BR_SGRP_F_INSTALLED	BIT(2)
+#define BR_SGRP_F_USER_ADDED	BIT(3)
 
 struct net_bridge_mcast_gc {
 	struct hlist_node		gc_node;
-- 
2.37.3

