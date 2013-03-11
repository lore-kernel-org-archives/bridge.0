Return-Path: <weiyj.lk@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:x-received:date:message-id:subject:from:to:cc
	:content-type; bh=qMBbHKMbZkvtHGBthqtOveTHcNRhYehhcq7J6eGITOM=;
	b=nhx4JPFddbdrqfISQHWRwvnrLkhdOwHupRu8IH76q9HVhkvsaRZhFI/yw5MulhaBLe
	CAULElbgkww3ZRD51Ypzy2iWuofLdnS2DedRLu26DxsAQNsh0nCiABATJAFRCzW0hjwW
	k/u2Y8QATWiKFnSdxRO3w3VeqyDWvmNEapKvh0GAcGVne+id1fOi14VF3Pr2CVn2ksR2
	+dpDFzvEoGdUI3qtcXUOnuWyqqvO1K93deqZJ0pVbe9O4GuyrXPNKy8E3NCUiTDg9Jbo
	hDHXmlfh/SLWrbN9sABESehLsFVTwu98dtWk5e4XEMWm3M+hyA+KCUsqwHhrZPqjwzAn
	vHDQ==
MIME-Version: 1.0
Date: Mon, 11 Mar 2013 23:43:48 +0800
Message-ID: <CAPgLHd_EW_y3VjSc9F4+fgmHpPVLZsysBo+sdDambZN96WBBcw@mail.gmail.com>
From: Wei Yongjun <weiyj.lk@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bridge] [PATCH -next] bridge: using for_each_set_bit_from to
	simplify the code
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stephen@networkplumber.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, yongjun_wei@trendmicro.com.cn, bridge@lists.linux-foundation.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Using for_each_set_bit_from() to simplify the code.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 net/bridge/br_fdb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index b0812c9..48fe761 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -161,9 +161,7 @@ void br_fdb_change_mac_address(struct net_bridge *br, const u8 *newaddr)
 	if (!pv)
 		return;
 
-	for (vid = find_next_bit(pv->vlan_bitmap, BR_VLAN_BITMAP_LEN, vid);
-	     vid < BR_VLAN_BITMAP_LEN;
-	     vid = find_next_bit(pv->vlan_bitmap, BR_VLAN_BITMAP_LEN, vid+1)) {
+	for_each_set_bit_from(vid, pv->vlan_bitmap, BR_VLAN_BITMAP_LEN) {
 		f = __br_fdb_get(br, br->dev->dev_addr, vid);
 		if (f && f->is_local && !f->dst)
 			fdb_delete(br, f);

