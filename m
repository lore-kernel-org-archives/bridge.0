Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE115013D1
	for <bridge@lists.linux.dev>; Fri, 18 Sep 2026 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745405; cv=none; b=UK61SjgyRER1SDV5qWND4jrcqaQMYwc2nJ6BiaSpyx+bfb439aAJryL8qx0X8F37vIox3JZD8gKh2UvbD0tfwBAZ68A8bfStnQdL5S3DcRkNR0izROiP0c7+2E4BG8cWAm3SCCBtnCriPF2iWMPrfqN5HqVx5kbzUbDiv4/R+9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745405; c=relaxed/simple;
	bh=vPdVL81FDVg0TO4uofdiBt+hhnNdQuJHDjmcN1sb5bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6uKMhqy4efvXCo33zni3EBcZA31Qi8eh1XvMY3wazwOBMuvVkG6yIvb7OMQkkQxgBhc8JK1AojBE2Ot1IRS56xn2MAQgrmdvdNH5ojirj+WRi8qJiqAv51w1r63Tp1KEX00r2y6U5TB5W5CiLpxxpM/b8w4x6HodjXr/N8idWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=RveNDkt4; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="RveNDkt4"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so5288225e9.3
        for <bridge@lists.linux.dev>; Fri, 18 Sep 2026 08:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789745402; x=1790350202; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=amEgsq9/x54qq2eWnuO6h/vQWTMXR2GmqJyXo88O4/k=;
        b=RveNDkt4MoAKNXaLXPpUne1/zxEURwXWrH3G0SFdm1PHF7wcAvL6NuDmWqpssEZeNh
         jKS3Q9dSaBaWI4zZmQVl8VV11ZCHuovEL7h40d7rEE+cyVhSi8ccBi8mPxYJdL/2VBbd
         lHR+uu2jqi2fWmTX8J1Fqoj1seM2BRqEI61wD7+Jvu/1PDWZnVHbX4qLG6UC3LqTNjVP
         BeLYkT6gKzssEuPrEg+j2wwUjoBQCr64ZwysSgiF5V7H//OJbZcbRLZ7J4VldmHZipEx
         qeiTdkAbFW8V+6+s1HSYyJL3G9is7FLa8tfUHfO5PyDIftLp0S9UQF+8+7HP+YqYpo2/
         3y+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745402; x=1790350202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=amEgsq9/x54qq2eWnuO6h/vQWTMXR2GmqJyXo88O4/k=;
        b=oKZpTGPrJURM7rv3HLJA8y4GsD49e4kPTa4HQOuH8ReRdbvCCNMrUdYemLM8kUg5da
         5X+hNWN3tB2LIB6Xes6VaudajW+BB+UAgUrT0QHKmSZI216ZLau/C0hQqsvv4qlvwP9h
         k+p5OqjWzhipxi3eJaOo48vqScLYLawu4859J3KgHXXnoZWIr5SzqJe1MT6xOs1UFGIj
         vRUAt+oGm2nDR1bEh8Y4du4Q/SsyGxGkhvXewfC1tB9QVZEP2kKtYojBcHixtfCvFfW5
         w/j3Nb6iGtvmg2AxLPC8JGRpok2clN58Tr0cUeai2ZTfMswCXrvUkWQIPYvTPVKcgyCs
         dqYw==
X-Forwarded-Encrypted: i=1; AKwUvByCZUpkPOOvYcabrnG/90skP6hV0p6JRNCLM3wir06ATvzodKme+8Xe6ErNsOcdWlKNu9+InRs=@lists.linux.dev
X-Gm-Message-State: AFuF++mpU/XB4scYQKGOsjx070jIdzm+bgeu48Hj5r5pIst7WF1QBJx/
	XV1C7upbS+k8KtcwtPWlIqPs7I4WgcfLi9Pj0VVfDyYs4CVCfcjBg9YXWrinczNe2M4=
X-Gm-Gg: AYBFou1GZFlJGoLsiJ89zSyPppLFZ0ux24WieJX30PG58tye0HixjFSKtjRidT6BsUu
	O+0vXE/MQssyGNz2kn2/Q/mdKWDgjxIjIWfqfwSngyLWFjinfwmQXCa1OarvO/sOJF7aHVHnGsS
	mavbbnZaESumJ1D14MSh6TP7UTiHfRhNlkvoTvd65GqCx1reECAn5spR+AiYrxb8sRQ6/6QzgHu
	Xp9CtPRJO2ZrcviOHAF2Wf8zjScK5yVvKPgRPBPEo7ktxmG1cVQ2iYwAltEbgrCDX/EVZgJX4j/
	666dK1cnBxh7xFZT44BhS+QXGdsTPFIYjl94xHlqO+CSPzK20hDJUqQ82+xja5XYEego9bZt56Q
	u3LpktnVh3JcFM2AIkd0p4JzOwHVAgdldjz/ROpZCwVA/WKF7a4FiyHXErvhHcx4LFnrlRyhBDF
	vMR5+iSfqB2qrGTOWhW/s74OoT3zDMA20fvCniZwV+oHcpuGQo4aKyWHLoanrX9aLf9pNtxFi7X
	jV5dpamCgVXrM8g06p8dg==
X-Received: by 2002:a05:600c:6217:b0:49e:8418:389d with SMTP id 5b1f17b1804b1-49fc571423dmr37735005e9.9.1789745401448;
        Fri, 18 Sep 2026 08:30:01 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49fc6ca43edsm63465895e9.0.2026.09.18.08.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:30:00 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 6/9] net: bridge: vlan: use an RCU array for large flood sets
Date: Fri, 18 Sep 2026 18:29:47 +0300
Message-ID: <20260918152950.1938259-7-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918152950.1938259-1-razor@blackwall.org>
References: <20260918152950.1938259-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Walking the master VLAN's port-VLAN list avoids considering ports outside
the VLAN but its pointer chasing becomes more expensive than array when
many ports participate. Add an rcu array of port-VLAN pointers for larger
flood sets. Rebuild and publish the array under RTNL when VLAN membership
changes. Continue using the list for small flood sets and as a fallback
if the array allocation fails.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 From local sashiko run:
 [Severity: Medium]
 Could these rebuilds be amortized or batched for large VLAN memberships?

 In net/bridge/br_vlan.c, br_vlan_rebuild_port_array() allocates and copies the
 complete masterv->port_vlist whenever count exceeds
 BR_VLAN_PORT_ARRAY_THRESHOLD. It then defers freeing the previous complete
 array through kvfree_rcu(), so sustained updates can retain several full-array
 generations until their RCU grace periods finish.

 Every successful individual port-VLAN addition calls this helper from
 __vlan_add(), while every individual deletion calls it from __vlan_del().
 Growing a flood set from nine entries to N therefore copies
 9 + 10 + ... + N pointers, and shrinking it performs the same quadratic work
 while RTNL is held.

 Can this cause a control-plane CPU and transient-memory regression during
 large incremental bridge VLAN updates? The later patches in the series retain
 this rebuild-on-add/delete path in the final series state.

 Nik: Yes, that is well understood but it is control path and I have tested
      sustained 2k / sec VLAN add/delete with 64 VLAN ports in each VLAN.
      If it ever becomes a problem we can optimize it, I think for the
      initial implementation would be best to keep it simple.

 net/bridge/br_forward.c | 39 ++++++++++++++++++++++++++++++---------
 net/bridge/br_private.h | 13 +++++++++++++
 net/bridge/br_vlan.c    | 37 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 79 insertions(+), 10 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 251d61e7c312..e8f30f2df1ed 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -261,6 +261,35 @@ static void br_flood_port(struct net_bridge_port **prev,
 	*prev = maybe_deliver(*prev, p, skb, local_orig);
 }
 
+static void br_flood_vlan(struct net_bridge_port **prev,
+			  struct net_bridge_vlan *v, struct sk_buff *skb,
+			  enum br_pkt_type pkt_type, bool local_orig)
+{
+	struct net_bridge_vlan_port_array *array;
+	struct net_bridge_vlan *masterv, *pv;
+
+	masterv = br_vlan_is_master(v) ? v : v->brvlan;
+	array = rcu_dereference(masterv->port_array);
+	if (array) {
+		unsigned int i;
+
+		for (i = 0; i < array->count; i++) {
+			pv = array->vlans[i];
+			br_flood_port(prev, pv->port, skb, pkt_type,
+				      local_orig, v->vid);
+			if (IS_ERR(*prev))
+				break;
+		}
+	} else {
+		list_for_each_entry_rcu(pv, &masterv->port_vlist, port_vlist) {
+			br_flood_port(prev, pv->port, skb, pkt_type,
+				      local_orig, v->vid);
+			if (IS_ERR(*prev))
+				break;
+		}
+	}
+}
+
 /* called under rcu_read_lock */
 void br_flood(struct net_bridge *br, struct net_bridge_vlan *v,
 	      struct sk_buff *skb, enum br_pkt_type pkt_type,
@@ -271,15 +300,7 @@ void br_flood(struct net_bridge *br, struct net_bridge_vlan *v,
 	br_tc_skb_miss_set(skb, pkt_type != BR_PKT_BROADCAST);
 
 	if (v) {
-		struct net_bridge_vlan *masterv, *pv;
-
-		masterv = br_vlan_is_master(v) ? v : v->brvlan;
-		list_for_each_entry_rcu(pv, &masterv->port_vlist, port_vlist) {
-			br_flood_port(&prev, pv->port, skb, pkt_type,
-				      local_orig, v->vid);
-			if (IS_ERR(prev))
-				break;
-		}
+		br_flood_vlan(&prev, v, skb, pkt_type, local_orig);
 	} else {
 		struct net_bridge_port *p;
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 239cf58d2268..a33da6e9765f 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -190,6 +190,17 @@ enum {
 	BR_VLFLAG_NEIGH_FORWARD_GRAT_ENABLED = BIT(6),
 };
 
+/* start publishing arrays when there're > BR_VLAN_PORT_ARRAY_THRESHOLD
+ * port-VLANs
+ */
+#define BR_VLAN_PORT_ARRAY_THRESHOLD 8
+
+struct net_bridge_vlan_port_array {
+	struct rcu_head		rcu;
+	unsigned int		count;
+	struct net_bridge_vlan	*vlans[];
+};
+
 /**
  * struct net_bridge_vlan - per-vlan entry
  *
@@ -210,6 +221,7 @@ enum {
  * @port_mcast_ctx: if MASTER flag unset, this is the per-port/vlan multicast
  *                  context
  * @msti: if MASTER flag set, this holds the VLANs MST instance
+ * @port_array: if MASTER flag set, this is the port-VLAN array
  * @port_vlist: if MASTER flag set, this is the port-VLAN list
  * @vlist: sorted list of VLAN entries
  * @rcu: used for entry destruction
@@ -245,6 +257,7 @@ struct net_bridge_vlan {
 
 	u16				msti;
 
+	struct net_bridge_vlan_port_array __rcu *port_array;
 	struct list_head		port_vlist;
 	struct list_head		vlist;
 
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 34d1df59d190..d750581df64d 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -258,6 +258,36 @@ static void br_vlan_init_state(struct net_bridge_vlan *v)
 	v->msti = 0;
 }
 
+static unsigned int br_vlan_num_ports(const struct net_bridge_vlan *masterv)
+{
+	return refcount_read(&masterv->refcnt) - br_vlan_is_brentry(masterv);
+}
+
+static void br_vlan_rebuild_port_array(struct net_bridge_vlan *masterv,
+				       unsigned int count)
+{
+	struct net_bridge_vlan_port_array *array = NULL, *old;
+	unsigned int i = 0;
+
+	WARN_ON(!br_vlan_is_master(masterv));
+
+	if (count > BR_VLAN_PORT_ARRAY_THRESHOLD)
+		array = kvmalloc(struct_size(array, vlans, count), GFP_KERNEL);
+
+	if (array) {
+		struct net_bridge_vlan *pv;
+
+		array->count = count;
+		list_for_each_entry(pv, &masterv->port_vlist, port_vlist)
+			array->vlans[i++] = pv;
+	}
+
+	old = rtnl_dereference(masterv->port_array);
+	rcu_assign_pointer(masterv->port_array, array);
+	if (old)
+		kvfree_rcu(old, rcu);
+}
+
 /* This is the shared VLAN add function which works for both ports and bridge
  * devices. There are four possible calls to this function in terms of the
  * vlan entry type:
@@ -368,8 +398,10 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags,
 	__vlan_flags_commit(v, flags);
 	br_multicast_toggle_one_vlan(v, true);
 
-	if (p)
+	if (p) {
+		br_vlan_rebuild_port_array(masterv, br_vlan_num_ports(masterv));
 		nbp_vlan_set_vlan_dev_state(p, v->vid);
+	}
 out:
 	return err;
 
@@ -438,6 +470,9 @@ static void __vlan_del(struct net_bridge_vlan *v)
 		rhashtable_remove_fast(&vg->vlan_hash, &v->vnode,
 				       br_vlan_rht_params);
 		__vlan_del_list(v);
+		/* -1 because br_vlan_put_master() is called later */
+		br_vlan_rebuild_port_array(masterv,
+					   br_vlan_num_ports(masterv) - 1);
 		nbp_vlan_set_vlan_dev_state(p, v->vid);
 		br_multicast_toggle_one_vlan(v, false);
 		br_multicast_port_ctx_deinit(&v->port_mcast_ctx);
-- 
2.47.3

