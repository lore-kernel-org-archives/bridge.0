Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Nc81uF+mob/bBUle1
 3jkpOUiabXO09c1T6O3Yh/6G0g=; b=EyU54ZQcNEvV1Lrv3gj8oshfbjnlBWiXZ
 0Homm4Ak1wXjI9hgDHllXAOLqbQVKs9VXt3rTuP2Hl/7c91Fv2uskZAP17D4zrGe
 1hz1RgLuhbTutxo7f65sK3n//SKxSBRVn/z7+TRIsEdQlMmhAohz+dAQCpiTlfS+
 X1vsw794vWmcM3ip805bOkaVzoeLPW3jr6roHK+iUBTT00ROHuV2ugtrhgZpqQL1
 FF1E07qDea1hZhiKgkpeBz1Czw40sBszNgDJyBsCMWOOsk4wX+NDdQYZIZHHm2+r
 kBDKaBqL9rIdNxb0/5/QtrXymeCx9IpnAJCaFJ10TvhZRsc94lc8w==
From: Ido Schimmel <idosch@idosch.org>
Date: Fri, 11 Sep 2020 16:24:47 +0300
Message-Id: <20200911132447.3158141-1-idosch@idosch.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next] bridge: mcast: Fix incomplete MDB dump
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, Ido Schimmel <idosch@nvidia.com>, roopa@nvidia.com, nikolay@nvidia.com, jiri@nvidia.com, kuba@kernel.org, davem@davemloft.net

From: Ido Schimmel <idosch@nvidia.com>

Each MDB entry is encoded in a nested netlink attribute called
'MDBA_MDB_ENTRY'. In turn, this attribute contains another nested
attributed called 'MDBA_MDB_ENTRY_INFO', which encodes a single port
group entry within the MDB entry.

The cited commit added the ability to restart a dump from a specific
port group entry. However, on failure to add a port group entry to the
dump the entire MDB entry (stored in 'nest2') is removed, resulting in
missing port group entries.

Fix this by finalizing the MDB entry with the partial list of already
encoded port group entries.

Fixes: 5205e919c9f0 ("net: bridge: mcast: add support for src list and filter mode dumping")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 net/bridge/br_mdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 67e0976aeed2..00f1651a6aba 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -243,7 +243,7 @@ static int br_mdb_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
 
 			err = __mdb_fill_info(skb, mp, p);
 			if (err) {
-				nla_nest_cancel(skb, nest2);
+				nla_nest_end(skb, nest2);
 				goto out;
 			}
 skip_pg:
-- 
2.26.2

