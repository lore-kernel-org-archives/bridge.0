Return-Path: <clement.leger@bootlin.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1650536055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=an69hgvRkZo4fDphZoWRjZyAXfGzKRGmPZzwE3TFtww=;
 b=UVU1MzSboPYmjJnNfcM3Qk71BBGbWaDl9mydrmQzASqiNP//6Bi6Fu7YwJTbLVt6SLIql3
 2hUt6A5FNi+3wHF/DKZC3lnjDm378xiXMZKwensfWYZ7kwrQY1tBsq5+o1M0bNXD+WOp0l
 0NKFeqwrqVqtEbBAcMb+LrMHJ7mb2mjJqnKBFspRVFslA63voqp+i1j0sS5AxTeGQWVolD
 S3OMLJ5aW690aZdHUX2lgVPqt20ErhXno7ixftgee6PvkgoWMEAj+rz6NbczFSA+n5f7/A
 3gD59XFMH3ld/VwWT4vyP8YjlG3rdn4sdY2RvHOcQC88fE90XMBL+LBbzWNMGQ==
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Date: Thu, 21 Apr 2022 12:12:47 +0200
Message-Id: <20220421101247.121896-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next] net: bridge: switchdev: check
	br_vlan_group() return value
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Tobias Waldekranz <tobias@waldekranz.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>, linux-kernel@vger.kernel.org

br_vlan_group() can return NULL and thus return value must be checked
to avoid dereferencing a NULL pointer.

Fixes: 6284c723d9b9 ("net: bridge: mst: Notify switchdev drivers of VLAN MSTI migrations")
Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 net/bridge/br_switchdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 81400e0b26ac..8f3d76c751dd 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -354,6 +354,8 @@ static int br_switchdev_vlan_attr_replay(struct net_device *br_dev,
 	attr.orig_dev = br_dev;
 
 	vg = br_vlan_group(br);
+	if (!vg)
+		return 0;
 
 	list_for_each_entry(v, &vg->vlan_list, vlist) {
 		if (v->msti) {
-- 
2.34.1

