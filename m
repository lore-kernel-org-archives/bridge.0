Return-Path: <lucien.xin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B3QGPgxprh2tb4Gl3h4Uv0GQ0Zm/aQZNDdCKiWQFxV4=;
 b=Vs6GqXTRoEgfIrL4ioHj2vTbxNFzHHhRKV/cH+MwljLJjuMYhd4Xg6apa5T1kLs1KR
 G74Y7f3UgHj+a0ZYPksnCWcMIP4vCu6IE7HjdLPJ0WSvXSxNDp3I3+kq3pql1I3a7zKv
 0AP8yCngVgBc3ZR/JOMgLRSmnD250nsTeYmVn6gqVoKRX+wXHOFWmLXMKYZSdHvcoEOX
 rdt+Ouw76gm2cz/AWYpPiQ+dhBgAK1kCpQjm3Pn9JaNPf6iLlgw+bS+TymajlQNdPhmt
 /aOuZabhtvYAHgU5X6nQdM4/IeSSFNCb3+UYS0WGh+tVLP4Q+I9NreR/Wj3RrY7pD6xD
 vS9g==
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 24 Nov 2021 14:39:33 -0500
Message-Id: <4e35f415226765e79c2a11d2c96fbf3061c486e2.1637782773.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next] bridge: use __set_bit in
	__br_vlan_set_default_pvid
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: network dev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org
Cc: kuba@kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, christophe.jaillet@wanadoo.fr, davem@davemloft.net, Roopa Prabhu <roopa@nvidia.com>

The same optimization as the one in commit cc0be1ad686f ("net:
bridge: Slightly optimize 'find_portno()'") is needed for the
'changed' bitmap in __br_vlan_set_default_pvid().

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/bridge/br_vlan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 49e105e0a447..84ba456a78cc 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1063,7 +1063,7 @@ int __br_vlan_set_default_pvid(struct net_bridge *br, u16 pvid,
 		if (br_vlan_delete(br, old_pvid))
 			br_vlan_notify(br, NULL, old_pvid, 0, RTM_DELVLAN);
 		br_vlan_notify(br, NULL, pvid, 0, RTM_NEWVLAN);
-		set_bit(0, changed);
+		__set_bit(0, changed);
 	}
 
 	list_for_each_entry(p, &br->port_list, list) {
@@ -1085,7 +1085,7 @@ int __br_vlan_set_default_pvid(struct net_bridge *br, u16 pvid,
 		if (nbp_vlan_delete(p, old_pvid))
 			br_vlan_notify(br, p, old_pvid, 0, RTM_DELVLAN);
 		br_vlan_notify(p->br, p, pvid, 0, RTM_NEWVLAN);
-		set_bit(p->port_no, changed);
+		__set_bit(p->port_no, changed);
 	}
 
 	br->default_pvid = pvid;
-- 
2.27.0

