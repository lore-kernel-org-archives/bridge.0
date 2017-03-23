Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=/pfnyFq981cJHs2w1IRcro9BuTH6TUnE6/Sv9uY2aJE=;
	b=e3PZ96Dv/d+n/brTHORcITgtY3c4tqKXIP2hIiai2GFdDwTsaKa/ke9zzbyoVOE99E
	FThF9980Ttz5sj5rr5luayTQFveK/shzc2Oz56EjJZPvfFlE1VItFJEelS27thxpx9eK
	hlTT0jSyiyeYzqKu0DcfzbTjh3vw5ZRXdTrC0=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Thu, 23 Mar 2017 12:27:13 +0200
Message-Id: <1490264833-28867-3-git-send-email-nikolay@cumulusnetworks.com>
In-Reply-To: <1490264833-28867-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1490264833-28867-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 2/2] net: bridge: allow to add externally
	learned entries from user-space
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, idosch@mellanox.com, davem@davemloft.net

The NTF_EXT_LEARNED flag was added for switchdev and externally learned
entries, but it can also be used for entries learned via a software
in user-space which requires dynamic entries that do not expire.
One such case that we have is with quagga and evpn which need dynamic
entries but also require to age them themselves.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_fdb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index e4c8adf517ea..7e5902e69f85 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -857,6 +857,8 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
 		br_fdb_update(br, p, addr, vid, true);
 		rcu_read_unlock();
 		local_bh_enable();
+	} else if (ndm->ndm_flags & NTF_EXT_LEARNED) {
+		err = br_fdb_external_learn_add(br, p, addr, vid);
 	} else {
 		spin_lock_bh(&br->hash_lock);
 		err = fdb_add_entry(br, p, addr, ndm->ndm_state,
-- 
2.1.4

