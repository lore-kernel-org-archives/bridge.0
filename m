Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=UlKckfrIHU65HVSmDyzxdhwKEKQ84tnWNrbUl9eAUEk=;
	b=SmkzYfvj3DKoLNk83RhochXuATZwMueovrOREQhT3GUNDfpsaDGA7ly152+7v/tKtR
	GFuUimOr+UPz82kL/H60+YfJ8W0yr056PzfglIT9j9eSjdsARkfzWZCbd98AXO0Kjmaq
	RZgAGI/RH1Gm9CRS+oCPEZXBDyMN5+19vzSq0=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue,  6 Jun 2017 01:26:24 +0300
Message-Id: <1496701584-26855-1-git-send-email-nikolay@cumulusnetworks.com>
In-Reply-To: <840022de-3d31-4f62-aaaf-ba83d5c78ad7@cumulusnetworks.com>
References: <840022de-3d31-4f62-aaaf-ba83d5c78ad7@cumulusnetworks.com>
Subject: [Bridge] [PATCH net] net: bridge: fix a null pointer dereference in
	br_afspec
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, garsilva@embeddedor.com, davem@davemloft.net

We might call br_afspec() with p == NULL which is a valid use case if
the action is on the bridge device itself, but the bridge tunnel code
dereferences the p pointer without checking, so check if p is null
first.

Reported-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Fixes: efa5356b0d97 ("bridge: per vlan dst_metadata netlink support")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 1e63ec466d7c..3bcda556971e 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -595,7 +595,7 @@ static int br_afspec(struct net_bridge *br,
 		err = 0;
 		switch (nla_type(attr)) {
 		case IFLA_BRIDGE_VLAN_TUNNEL_INFO:
-			if (!(p->flags & BR_VLAN_TUNNEL))
+			if (!p || !(p->flags & BR_VLAN_TUNNEL))
 				return -EINVAL;
 			err = br_parse_vlan_tunnel_info(attr, &tinfo_curr);
 			if (err)
-- 
2.1.4

