Return-Path: <weiyj.lk@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:x-received:date:message-id:subject:from:to:cc
	:content-type; bh=w4uYfDax76+MKAwaogtUyxC2dQYEKnw4eL5AF+t4NjQ=;
	b=R+uRCcT/xiHR9AGwGkUkdjZoBZiZej7p4XpG9aWxoohjWRiLv5WlVNlbljgLSpC/IA
	ZknsRs8R1jynD33cfZzPK55dnbUsjLnnTeyjYOBfOuPyzg8FsRkI46uKUVkDD6iKMl0q
	VN2gSCrzMDcaqEshJVME41X3n9wSRAPjMndzIT104UuC3hgf2QhqHFTUFx33Tdi1RPeb
	PcX3EvHN3ONJ33hAK7OVX1OzlaZjdqot3HyKFJsJuTLfttqlOJHv0VviLTf9/wsVc2m2
	VQfgAp5n/6YIGMwbCWXsPs+NZW4o393f+SaiqQUvrL0WHdOGWEWbaxPNvYn2jRj8SEHT
	/XKQ==
MIME-Version: 1.0
Date: Mon, 11 Mar 2013 23:45:23 +0800
Message-ID: <CAPgLHd_viA9nTBMRhhE-XJzYHu8a7f5Xjve9hYpU-RaY=uE9+g@mail.gmail.com>
From: Wei Yongjun <weiyj.lk@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bridge] [PATCH -next] bridge: using for_each_set_bit to simplify
	the code
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

Using for_each_set_bit() to simplify the code.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 net/bridge/br_netlink.c | 5 +----
 net/bridge/br_fdb.c     | 10 ++--------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 27aa3ee..2135afa 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -135,10 +135,7 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 			goto nla_put_failure;
 
 		pvid = br_get_pvid(pv);
-		for (vid = find_first_bit(pv->vlan_bitmap, BR_VLAN_BITMAP_LEN);
-		     vid < BR_VLAN_BITMAP_LEN;
-		     vid = find_next_bit(pv->vlan_bitmap,
-					 BR_VLAN_BITMAP_LEN, vid+1)) {
+		for_each_set_bit(vid, pv->vlan_bitmap, BR_VLAN_BITMAP_LEN) {
 			vinfo.vid = vid;
 			vinfo.flags = 0;
 			if (vid == pvid)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index b0812c9..4f68df1 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -724,13 +724,10 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 		 * specify a VLAN.  To be nice, add/update entry for every
 		 * vlan on this port.
 		 */
-		vid = find_first_bit(pv->vlan_bitmap, BR_VLAN_BITMAP_LEN);
-		while (vid < BR_VLAN_BITMAP_LEN) {
+		for_each_set_bit(vid, pv->vlan_bitmap, BR_VLAN_BITMAP_LEN) {
 			err = __br_fdb_add(ndm, p, addr, nlh_flags, vid);
 			if (err)
 				goto out;
-			vid = find_next_bit(pv->vlan_bitmap,
-					    BR_VLAN_BITMAP_LEN, vid+1);
 		}
 	}
 
@@ -815,11 +812,8 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 		 * vlan on this port.
 		 */
 		err = -ENOENT;
-		vid = find_first_bit(pv->vlan_bitmap, BR_VLAN_BITMAP_LEN);
-		while (vid < BR_VLAN_BITMAP_LEN) {
+		for_each_set_bit(vid, pv->vlan_bitmap, BR_VLAN_BITMAP_LEN) {
 			err &= __br_fdb_delete(p, addr, vid);
-			vid = find_next_bit(pv->vlan_bitmap,
-					    BR_VLAN_BITMAP_LEN, vid+1);
 		}
 	}
 out:

