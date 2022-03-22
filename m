Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version:organization
 :content-transfer-encoding;
 bh=9HKooFSzF8EEsT2BEZgeunYRwvAjSyxG2IXK+iRrPEs=;
 b=29htvhMmpTh4PKGEPvfVlPAUZrleKez8uBO1KBF0exKnC1WyZp6jRTQwDHy/q9a/if
 R4OwsReo7NGIThGIV7Cil5RrsIpD6Gq6vC1sQxSVfEfj+mIzlK0nKfNpZ9QbNiwlgS8C
 IAU6K1e3RWdb5GSt7vgRoCkvtWl8/5rV2tcGNYmKwgvSq1+bnrrTogQhTcAQrJIYuQV4
 c2i+5SZEbLgLKdrjjNhmiO9KDuvbzRn9mfT3oshKO442uXOdu1FxRcxyAka7Iz174Xak
 A40spqBYtTqd5MC1/e/YiixXhFlC5r4oiPSg7YS+KHOQSiu7YXIEt7T90404opxzbomi
 bUvw==
From: Tobias Waldekranz <tobias@waldekranz.com>
Date: Tue, 22 Mar 2022 14:30:01 +0100
Message-Id: <20220322133001.16181-1-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next] net: bridge: mst: Restrict info size
	queries to bridge ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>

Ensure that no bridge masters are ever considered for MST info
dumping. MST states are only supported on bridge ports, not bridge
masters - which br_mst_info_size relies on.

Fixes: 122c29486e1f ("net: bridge: mst: Support setting and reporting MST port states")
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---

It turns out that even with Eric's fix, the guard was not restrictive
enough. Sorry about all the noise around this.

 net/bridge/br_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 204472449ec9..200ad05b296f 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -119,7 +119,7 @@ static size_t br_get_link_af_size_filtered(const struct net_device *dev,
 	/* Each VLAN is returned in bridge_vlan_info along with flags */
 	vinfo_sz += num_vlan_infos * nla_total_size(sizeof(struct bridge_vlan_info));
 
-	if (vg && (filter_mask & RTEXT_FILTER_MST))
+	if (p && vg && (filter_mask & RTEXT_FILTER_MST))
 		vinfo_sz += br_mst_info_size(vg);
 
 	if (!(filter_mask & RTEXT_FILTER_CFM_STATUS))
-- 
2.25.1

