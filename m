Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FJyorqRdVcMr4H3CHmU331uPAEpW16yWV7e4SmBCjxw=;
 b=FEeWeXk+x+8IjDWcPJr1Q5JuO4PaLPPmgsa3YH/b3YPsEVHUpVbQRIiUlcdnCn98Cd
 1dMWXg8aE9ISYRMUzLfSh/a4/AQj3mAVwsSI2lED+yhujAQYei5N9eGu9J/jzBEwFMKc
 mYHg98230wURiRZojHyAaq4d6kNDpNbLRHyJmA+wSIzdORsIdcFSTwzo3eygZxs9bh7c
 Y0S9jucq/4jSnzl8LHznW+KWYZ6jnRCJ90gkdl9eDNSpFQMoPhyZ6ztuSmpBHHaR35wd
 tDPMsE3kqdmM25AP9m7gMn+7zqDGso8K19c6gbgxfQggvbd2VpGr6eHMAVq6GmQwoLXF
 Vl7w==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 25 Jan 2021 10:20:40 +0200
Message-Id: <20210125082040.13022-1-razor@blackwall.org>
In-Reply-To: <202101250327.48TBMqng-lkp@intel.com>
References: <202101250327.48TBMqng-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next] net: bridge: multicast: fix
	br_multicast_eht_set_entry_lookup indentation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>, bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Fix the messed up indentation in br_multicast_eht_set_entry_lookup().

Fixes: baa74d39ca39 ("net: bridge: multicast: add EHT source set handling functions")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast_eht.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/bridge/br_multicast_eht.c b/net/bridge/br_multicast_eht.c
index a4fa1760bc8a..ff9b3ba37cab 100644
--- a/net/bridge/br_multicast_eht.c
+++ b/net/bridge/br_multicast_eht.c
@@ -85,15 +85,15 @@ br_multicast_eht_set_entry_lookup(struct net_bridge_group_eht_set *eht_set,
 		struct net_bridge_group_eht_set_entry *this;
 		int result;
 
-	this = rb_entry(node, struct net_bridge_group_eht_set_entry,
-			rb_node);
-	result = memcmp(h_addr, &this->h_addr, sizeof(*h_addr));
-	if (result < 0)
-		node = node->rb_left;
-	else if (result > 0)
-		node = node->rb_right;
-	else
-		return this;
+		this = rb_entry(node, struct net_bridge_group_eht_set_entry,
+				rb_node);
+		result = memcmp(h_addr, &this->h_addr, sizeof(*h_addr));
+		if (result < 0)
+			node = node->rb_left;
+		else if (result > 0)
+			node = node->rb_right;
+		else
+			return this;
 	}
 
 	return NULL;
-- 
2.29.2

