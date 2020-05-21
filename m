Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1590096093; x=1621632093;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SkOPy4sOOrRfqtyXNELyPdU3uc8AlMHu0+NJ6A1acWA=;
 b=w0TxGZgUAer80vNU2WJ7wu/qGHAcQR1p4GQJPxTMlbc4f2VaE76DicuG
 4DhMb9drLFUZ7G4nwvaMhtF0FNyqVs01p0HHbZ1lufqd7/NfHkWcqwcBz
 mVeEieu6Eg8b3FZgEva0eyItsXFHOGkUq65LNDDnYhX60MUZ8DtTyjLiD
 s4egg7RAlYEs3yigyUDz1CS2dZIFI8mku6UuCnoAPdTm16lR0TUvzRoJo
 immluWFVLmQ0xCM85s4nFiwpemdrDODhiNAzOmRCdHsJcguG7e2gCqMSA
 8POjaeGL9ERpo07fL2x8CIYzc1lKRt0DubZACi6z6T5MHj+uCpqUnNwjC w==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Thu, 21 May 2020 23:19:05 +0000
Message-ID: <20200521231907.3564679-2-horatiu.vultur@microchip.com>
In-Reply-To: <20200521231907.3564679-1-horatiu.vultur@microchip.com>
References: <20200521231907.3564679-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH v2 1/3] bridge: mrp: Add br_mrp_unique_ifindex
	function
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net, kuba@kernel.org, roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

It is not allow to have the same net bridge port part of multiple MRP
rings. Therefore add a check if the port is used already in a different
MRP. In that case return failure.

Fixes: 9a9f26e8f7ea ("bridge: mrp: Connect MRP API with the switchdev API")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_mrp.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index d7bc09de4c139..854e31bf0151e 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -37,6 +37,26 @@ static struct br_mrp *br_mrp_find_id(struct net_bridge *br, u32 ring_id)
 	return res;
 }
 
+static bool br_mrp_unique_ifindex(struct net_bridge *br, u32 ifindex)
+{
+	struct br_mrp *mrp;
+
+	list_for_each_entry_rcu(mrp, &br->mrp_list, list,
+				lockdep_rtnl_is_held()) {
+		struct net_bridge_port *p;
+
+		p = rtnl_dereference(mrp->p_port);
+		if (p && p->dev->ifindex == ifindex)
+			return false;
+
+		p = rtnl_dereference(mrp->s_port);
+		if (p && p->dev->ifindex == ifindex)
+			return false;
+	}
+
+	return true;
+}
+
 static struct br_mrp *br_mrp_find_port(struct net_bridge *br,
 				       struct net_bridge_port *p)
 {
@@ -255,6 +275,11 @@ int br_mrp_add(struct net_bridge *br, struct br_mrp_instance *instance)
 	    !br_mrp_get_port(br, instance->s_ifindex))
 		return -EINVAL;
 
+	/* It is not possible to have the same port part of multiple rings */
+	if (!br_mrp_unique_ifindex(br, instance->p_ifindex) ||
+	    !br_mrp_unique_ifindex(br, instance->s_ifindex))
+		return -EINVAL;
+
 	mrp = kzalloc(sizeof(*mrp), GFP_KERNEL);
 	if (!mrp)
 		return -ENOMEM;
-- 
2.26.2

