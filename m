Return-Path: <vyasevich@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=wrhEt7dNESWyEX2ePDns29KMMwO9p+/mNQTURieik7Y=;
	b=bPnwiW7Rthowv7AGdhR3qTaEpyfX/olC5oFPY8eWp867jK6Akqbbxe5vTxKYiFhamv
	U74BcOQpLWU+nwGnDNqdSfYMJSp2rQEUaSn1S/UpFNesqzsNA1Dy8KoZrDuHs9mkUQ96
	4OujPcC/vSc+sjAqBfzDX8RT8DPR1s3qV9X9WHY1uf1RWiftRjEPfK4UZQFBl+QEFXnJ
	VO/z87h96KAcYorev6xnj99ZIy3MKVyXoFxDJoDwFR7jNTHwX+Cd3SKspbgKg8Eseegu
	/XkxREzB75f9q0uhDh61DcVSZ7wpH3i4OeQKdAy2CTGZ1VIaxbuPHzXGYP2nttzTwJK3
	rwIg==
From: Vladislav Yasevich <vyasevich@gmail.com>
Date: Tue, 30 Sep 2014 15:31:01 -0400
Message-Id: <1412105462-340-3-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1412105462-340-1-git-send-email-vyasevic@redhat.com>
References: <1412105462-340-1-git-send-email-vyasevic@redhat.com>
Subject: [Bridge] [PATCH v2 net 2/3] bridge: Simplify pvid checks.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org, bridge@lists.linux-foundation.org, Vladislav Yasevich <vyasevic@redhat.com>

Currently, if the pvid is not set, we return an illegal vlan value
even though the pvid value is set to 0.  Since pvid of 0 is currently
invalid, just return 0 instead.  This makes the current and future
checks simpler.

Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
---
 net/bridge/br_private.h | 2 +-
 net/bridge/br_vlan.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 6fe8680..873d9da 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -647,7 +647,7 @@ static inline u16 br_get_pvid(const struct net_port_vlans *v)
 	 * vid wasn't set
 	 */
 	smp_rmb();
-	return v->pvid ?: VLAN_N_VID;
+	return v->pvid;
 }
 
 static inline int br_vlan_enabled(struct net_bridge *br)
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 295ad0d..f5eee61 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -223,7 +223,7 @@ bool br_allowed_ingress(struct net_bridge *br, struct net_port_vlans *v,
 		 * See if pvid is set on this port.  That tells us which
 		 * vlan untagged or priority-tagged traffic belongs to.
 		 */
-		if (pvid == VLAN_N_VID)
+		if (!pvid)
 			goto drop;
 
 		/* PVID is set on this port.  Any untagged or priority-tagged
@@ -292,7 +292,7 @@ bool br_should_learn(struct net_bridge_port *p, struct sk_buff *skb, u16 *vid)
 
 	if (!*vid) {
 		*vid = br_get_pvid(v);
-		if (*vid == VLAN_N_VID)
+		if (!*vid)
 			return false;
 
 		return true;
-- 
1.9.3

