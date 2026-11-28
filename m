Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795872909;
	b=ZBH8JGiqwLVen8J7+m1a1zUzAzkOI4uNz/kvnXNnNj1Pd/Ip/rd5cXoIp+qQq5lfS+6I
	 hWD5o+mrvnQbINGpFO6cHqQolVC0GLo/TUuv233d+frNHkWK8WiM+0sLeha+1F49E6tC0
	 JisoEtjk2E5bQEOylBYS4q1EqM5jX1tHR2KxqpAksN7P8IgQIzfZD4JUl7Pb14NloT00s
	 9soBBo5rsrX/3bg0oiZQtguz26+kltvRylZoOhKI5FtbQ/cZs7/QyfNesIg3QNo5Wddr5
	 4zW1X6uUpCs8WXV/2cp4sQ9OQiKTDXj28bI+4zpKDX0X99SWEUUNyCLmrz5/NyWX5sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795872909;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4FtfN8L9+6gP5bWFBYQKEK99xwzUrxvf5q+hYLwXrRc=;
	b=r2RzniS4hEziPeBwRGHxsKTJcoBrK5HgBIRbTkUDA4Ww9mc/ccjqY48FeG6FJOLRaxKe
	 FIUxRVb6yok7fVccdl7r6D6Hg2tZYUmGvSqbmDJcDa7I6SMn1o/ttRDe2m3ZXlIkt3RcL
	 IQGHVcdSfkUda1m4iLLpamKXk3x6kWP3bdQOHoeweHZRS5esbhouAJq+5atSKaaTHKsjK
	 7Zgu/ZnHX/KcfH/YRi1lHDPjRG2/qH/BNQ/dMgapP0aiA4DEdEdKFs2yf94o3T9yjt49/
	 MAIY30P22LDHM458G97uQHU0qYYHHEF8gOz2gbKr54I7J0+Nv8inq/Q6ybrkYs3wWXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=F7+Ul0Zd;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1A4606A32C
	for <bridge@lists.linux.dev>; Sat, 28 Nov 2026 13:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E1A4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=F7+Ul0Zd
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b894d9a075so9912290a12.2
        for <bridge@lists.linux.dev>; Sat, 28 Nov 2026 05:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1795872907; x=1796477707; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4FtfN8L9+6gP5bWFBYQKEK99xwzUrxvf5q+hYLwXrRc=;
        b=F7+Ul0Zdge0f4sHqy5yNcSIWkWlwZGZ9cuutprhLSkeGXH6dMsVAPL5La+TkX0sv46
         PNFWN0ckRoAHHC2V+AMZdV1h23+Vg6iq4gjohIvGIMp0cxEFH5E00YxRhQCm4HhlrFab
         diA3VlO9SVSAxDJI0hACY/Y+K2y/Tqg/6S786mWpNhtMxDKbF2GeSkS4up/y0uQjLZq6
         mUFK81zeULcb21Rn5u+mVJ75RU1Z8CjpQXtKNhrG0lu9aU2wYalyPRPW/RqmGyXcNIfk
         59Ql1Mx6YNZVhXHO+75D7qdPrTfKt46h94iLeSc+RDoOr7eM7CyP99gjr5in2H4nJrWn
         Bsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795872907; x=1796477707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4FtfN8L9+6gP5bWFBYQKEK99xwzUrxvf5q+hYLwXrRc=;
        b=CWwCpVSlFKzq8+Z2wWgjfRjBqQSrWfTdY2NYdRRmpdmH2ENXqw8KvnP6mq5hBOfgCG
         I5SeN5T0w9Em1kp+KoLQE1mD3dGfkmHRingyi4nB6I2pBPtXImeOAo08G9HCaBkzi4yL
         9W6/luPOFM7PRbRQ/eU+P5Dc1GPMLmf4GFqq42ZgqE25xobDYenyTJ1uwBfONYf9RjlX
         cYs/v6Xyh3hgwNl2Ie1iSF7Imw4ZxIrsVhiPasD6eeIQw67mU4JQVETIERFZVp+8xnDC
         LWVVmb+ESbuTgZ6pgFNs9hjzjqXNI2go6eMYdhJDkNF+7Uzo/pqdF4AWIjuS8vH0AXTt
         7fDg==
X-Forwarded-Encrypted: i=1; AL+hErHBMdFVsZEOSGmcrQS+gegOn2SPpa13MbAgNA+9VtY3PjLqKVthvo8OhdGOmCOK5Vxw67577XM=@lists.linux.dev
X-Gm-Message-State: APuU4Z++hhCo7N6hA4aZo4S8wiDudk2iUVejEdyo6BkOarExwqSJ0tl6
	/bmnDUdsQ7/5ee6X5zDKTufopNX2D25XabA/2EN+uVM01IYkLTxe3vntU73/hAZEOA==
X-Gm-Gg: AZFdTZcMRqSfKLLg94NJFtLdXf2p+7/K4tCE3vbXA9klSyBblSF34sdJnwaL4elQKTp
	IuIq/P22JBdexwJi6OYOG92IjplvFWGa/zEpo1lfmwh1sG1hdOD3yyBDzOAPbnJfwp8ytvbxnt1
	KVJwcgoS8WsWiNnoIZZ877BJgklWx46jjBg3UgBvsOX/hjgvFSZwujbNzD/kvbDRvvHND/Ls0Qm
	Fabj8p2J2IE9lNkHOyiKwKUJ2TVB8B9pgnxEY9XnwFyR/W1dIqc64y8Inrv1QG/sUIdYore5Kuy
	ZIa842AwkuNR69nTN8A0UshQjdi7WUsCrlqibUwOykTHvhp6XWBOknzJJmhDgjxrd5x6Oh81Gbd
	wtaxJPLYJPnFOfZgikEQxXIcQwfGrcR2aDMlg/5xScWsz9HTr1/XrP09V1j+Btn4Jfjkzisjj9x
	2hXqUTWCN8dds1uYiMMyPODDZ3lTb8pHqd6M9Xq1PgyHi+2oIu18hX/5LrKEJfQeqb4h5GeecU6
	uGIx3HqfpiipuQKfJsjYkxaBODj7MO7eViBvHEsJu7uA6jxaqEZnBEPAm3VPnnbwLaLlZuXxzjO
	7FZB4UG2D/ssKsVxKufWj0EK8Di3bPs9dyIIQpfhqQOk+Hs6Iv2LnZn867QjlPMK5EQgbz2TBGt
	i8Vf6weOjoOxP920d5/a8aWBCsXm+hnn/ZthPiI6kEsOGvsRAOHwqF51LyNkgvLkH6FvySdGlFM
	VjuhK0ZRgbCAFAyr5lOJeEORu98A2G5uktdsy9M60qIUx/JAOYAJ48dNf6QYfsQGC4+jEDTEiAl
	NMnoEKLxvFVHnz9iErdusLILJI9o1Bd+SAJ7qctxwzHk/Y265y2iud0Imlqb7JeKUh2VJtESS/d
	hQgHnrD9qUzOicZkDJ+26tott/wTuwq5ajgwpNGCy0YJ0uTcl/Ri3QpJsMBM/ZWodVFNx2g6Fdc
	=
X-Received: by 2002:a05:6402:2422:b0:6bb:579a:c53f with SMTP id 4fb4d7f45d1cf-6bb579ac84emr5194763a12.18.1795872906656;
        Sat, 28 Nov 2026 05:35:06 -0800 (PST)
Received: from Desktop.tail070c67.ts.net (p200300f247080f000000000000000a27.dip0.t-ipconnect.de. [2003:f2:4708:f00::a27])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6bb1d49d992sm5282111a12.26.2026.11.28.05.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 05:35:06 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Linus Walleij <linusw@kernel.org>,
	Pawel Dembicki <paweldembicki@gmail.com>
Subject: [PATCH net v2 3/3] net: dsa: forward a marked frame only while its port is in a bridge
Date: Sat, 28 Nov 2026 14:35:03 +0100
Message-ID: <20261128133503.3887987-4-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261128133503.3887987-1-julius@bairaktaris.de>
References: <20261128133503.3887987-1-julius@bairaktaris.de>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tag_dsa, tag_sja1105 and tag_vsc73xx_8021q taggers build a tag that
has the switch forward a frame in the domain of the port's bridge when
skb->offload_fwd_mark is set, which the bridge does for a port with TX
forwarding offload. They read the bridge number and device with
dsa_port_bridge_num_get() and dsa_port_bridge_dev_get() and assume that
the port is in a bridge.

It need not be. A frame the bridge marked can still be in a qdisc of the
port when the port leaves the bridge, and a frame received on a bridged
port still carries the mark its tagger set on reception when tc
redirects it to another port. With no bridge, sja1105_imprecise_xmit()
and vsc73xx_xmit() pass NULL to br_vlan_enabled(), which with
CONFIG_BRIDGE_VLAN_FILTERING reads the bridge's private area:

  BUG: KASAN: null-ptr-deref in br_vlan_enabled+0x21/0x60
  Read of size 8 at addr 0000000000000e48 by task vinject/142
  Call Trace:
   br_vlan_enabled+0x21/0x60
   vsc73xx_xmit+0x130/0x1c0
   dsa_user_xmit+0x265/0x4c0
   dev_hard_start_xmit+0xde/0x5b0
   __dev_queue_xmit+0x15f3/0x34f0
   tcf_mirred_to_dev+0x9cc/0x15a0

and dsa_xmit_ll() sends a FORWARD tag for bridge number 0, which names
the last physical switch instead of a virtual bridge device. Each
helper also reads dp->bridge on its own, so a port that leaves between
the two reads gives a bridge number without a bridge device.

Read dp->bridge once in each of the three taggers, and forward on
behalf of the bridge only when the frame is marked and the port is in a
bridge. Otherwise the frame takes the tagger's path for a port in no
bridge, which sends it to the port the stack chose. The bridge stays
valid while the tagger uses it: dsa_port_bridge_destroy() waits with
synchronize_net() before it frees it.

A marked frame that is still queued when its port joins another bridge
is forwarded in the domain of that bridge. That needs the queued frames
dropped when the port's TX forwarding offload ends, which this change
does not do.

Found by the hosted Sashiko review of v1 of "net: dsa: do not run
queued FDB events after the port left the bridge" [1], and the tc
redirect by an LLM review (Claude) of this change.

In QEMU with KASAN, with dsa_loop given the vsc73xx-8021q or the dsa
tagger and TX forwarding offload (test-only changes): 40 broadcasts from
the bridge held in a tbf qdisc on two user ports that then leave the
bridge oops as above with vsc73xx-8021q in 3 of 3 boots, and with dsa
go out as FORWARD tags for bridge 0 (28, 26 and 28 frames) in 3 of 3
boots; frames received on a bridged port and redirected by tc to a port
in no bridge oops as above in 3 of 3 boots. With this change, neither
oopses in 5 of 5 boots each, the frames go out with the VLAN of their
port in no bridge (vsc73xx-8021q, counted in one boot of each), and
with dsa the frames sent after the leave carry FROM_CPU tags (29, 28
and 29 frames) in 3 of 3 boots.

Fixes: d82f8ab0d874 ("net: dsa: tag_dsa: offload the bridge forwarding process")
Fixes: b6ad86e6ad6c ("net: dsa: sja1105: add bridge TX data plane offload based on tag_8021q")
Fixes: 6c87e1a47928 ("net: dsa: vsc73xx: introduce tag 8021q for vsc73xx")
Link: https://lore.kernel.org/all/20261121185821.1471559-1-julius@bairaktaris.de/ [1]
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
v2: new.

 net/dsa/tag_dsa.c           | 15 ++++++++++-----
 net/dsa/tag_sja1105.c       | 23 ++++++++++++++---------
 net/dsa/tag_vsc73xx_8021q.c | 14 ++++++++------
 3 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/net/dsa/tag_dsa.c b/net/dsa/tag_dsa.c
index d5ffee35fbb5..ee3d94a6b608 100644
--- a/net/dsa/tag_dsa.c
+++ b/net/dsa/tag_dsa.c
@@ -130,13 +130,20 @@ static struct sk_buff *dsa_xmit_ll(struct sk_buff *skb, struct net_device *dev,
 				   u8 extra)
 {
 	struct dsa_port *dp = dsa_user_to_port(dev);
+	const struct dsa_bridge *bridge;
 	struct net_device *br_dev;
 	u8 tag_dev, tag_port;
 	enum dsa_cmd cmd;
 	u8 *dsa_header;
 
-	if (skb->offload_fwd_mark) {
-		unsigned int bridge_num = dsa_port_bridge_num_get(dp);
+	/* Forward on behalf of the bridge only while the port is in one: the
+	 * frame can have been marked before the port left it, or on reception
+	 * and kept by a redirect that bypassed the bridge
+	 */
+	bridge = READ_ONCE(dp->bridge);
+	br_dev = bridge ? bridge->dev : NULL;
+
+	if (skb->offload_fwd_mark && bridge) {
 		struct dsa_switch_tree *dst = dp->ds->dst;
 
 		cmd = DSA_CMD_FORWARD;
@@ -145,7 +152,7 @@ static struct sk_buff *dsa_xmit_ll(struct sk_buff *skb, struct net_device *dev,
 		 * packets on behalf of a virtual switch device with an index
 		 * past the physical switches.
 		 */
-		tag_dev = dst->last_switch + bridge_num;
+		tag_dev = dst->last_switch + bridge->num;
 		tag_port = 0;
 	} else {
 		cmd = DSA_CMD_FROM_CPU;
@@ -153,8 +160,6 @@ static struct sk_buff *dsa_xmit_ll(struct sk_buff *skb, struct net_device *dev,
 		tag_port = dp->index;
 	}
 
-	br_dev = dsa_port_bridge_dev_get(dp);
-
 	/* If frame is already 802.1Q tagged, we can convert it to a DSA
 	 * tag (avoiding a memmove), but only if the port is standalone
 	 * (in which case we always send FROM_CPU) or if the port's
diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index bfe1f746f55b..f149852c5d83 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -209,11 +209,10 @@ static u16 sja1105_xmit_tpid(struct dsa_port *dp)
 }
 
 static struct sk_buff *sja1105_imprecise_xmit(struct sk_buff *skb,
-					      struct net_device *netdev)
+					      struct net_device *netdev,
+					      const struct dsa_bridge *bridge)
 {
 	struct dsa_port *dp = dsa_user_to_port(netdev);
-	unsigned int bridge_num = dsa_port_bridge_num_get(dp);
-	struct net_device *br = dsa_port_bridge_dev_get(dp);
 	u16 tx_vid;
 
 	/* If the port is under a VLAN-aware bridge, just slide the
@@ -222,14 +221,14 @@ static struct sk_buff *sja1105_imprecise_xmit(struct sk_buff *skb,
 	 * across the entire dst, and its VLANs cannot be shared with
 	 * any standalone port.
 	 */
-	if (br_vlan_enabled(br))
+	if (br_vlan_enabled(bridge->dev))
 		return skb;
 
 	/* If the port is under a VLAN-unaware bridge, use an imprecise
 	 * TX VLAN that targets the bridge's entire broadcast domain,
 	 * instead of just the specific port.
 	 */
-	tx_vid = dsa_tag_8021q_bridge_vid(bridge_num);
+	tx_vid = dsa_tag_8021q_bridge_vid(bridge->num);
 
 	return dsa_8021q_xmit(skb, netdev, sja1105_xmit_tpid(dp), tx_vid);
 }
@@ -268,12 +267,17 @@ static struct sk_buff *sja1105_xmit(struct sk_buff *skb,
 				    struct net_device *netdev)
 {
 	struct dsa_port *dp = dsa_user_to_port(netdev);
+	const struct dsa_bridge *bridge = READ_ONCE(dp->bridge);
 	u16 queue_mapping = skb_get_queue_mapping(skb);
 	u8 pcp = netdev_txq_to_tc(netdev, queue_mapping);
 	u16 tx_vid = dsa_tag_8021q_standalone_vid(dp);
 
-	if (skb->offload_fwd_mark)
-		return sja1105_imprecise_xmit(skb, netdev);
+	/* Forward on behalf of the bridge only while the port is in one: the
+	 * frame can have been marked before the port left it, or on reception
+	 * and kept by a redirect that bypassed the bridge
+	 */
+	if (skb->offload_fwd_mark && bridge)
+		return sja1105_imprecise_xmit(skb, netdev, bridge);
 
 	/* Transmitting management traffic does not rely upon switch tagging,
 	 * but instead SPI-installed management routes. Part 2 of this
@@ -296,6 +300,7 @@ static struct sk_buff *sja1110_xmit(struct sk_buff *skb,
 {
 	struct sk_buff *clone = SJA1105_SKB_CB(skb)->clone;
 	struct dsa_port *dp = dsa_user_to_port(netdev);
+	const struct dsa_bridge *bridge = READ_ONCE(dp->bridge);
 	u16 queue_mapping = skb_get_queue_mapping(skb);
 	u8 pcp = netdev_txq_to_tc(netdev, queue_mapping);
 	u16 tx_vid = dsa_tag_8021q_standalone_vid(dp);
@@ -303,8 +308,8 @@ static struct sk_buff *sja1110_xmit(struct sk_buff *skb,
 	__be16 *tx_header;
 	int trailer_pos;
 
-	if (skb->offload_fwd_mark)
-		return sja1105_imprecise_xmit(skb, netdev);
+	if (skb->offload_fwd_mark && bridge)
+		return sja1105_imprecise_xmit(skb, netdev, bridge);
 
 	/* Transmitting control packets is done using in-band control
 	 * extensions, while data packets are transmitted using
diff --git a/net/dsa/tag_vsc73xx_8021q.c b/net/dsa/tag_vsc73xx_8021q.c
index f4736a1a7a0f..575dd2f99aeb 100644
--- a/net/dsa/tag_vsc73xx_8021q.c
+++ b/net/dsa/tag_vsc73xx_8021q.c
@@ -12,18 +12,20 @@ static struct sk_buff *
 vsc73xx_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct dsa_port *dp = dsa_user_to_port(netdev);
+	const struct dsa_bridge *bridge = READ_ONCE(dp->bridge);
 	u16 queue_mapping = skb_get_queue_mapping(skb);
 	u16 tx_vid = dsa_tag_8021q_standalone_vid(dp);
 	u8 pcp;
 
-	if (skb->offload_fwd_mark) {
-		unsigned int bridge_num = dsa_port_bridge_num_get(dp);
-		struct net_device *br = dsa_port_bridge_dev_get(dp);
-
-		if (br_vlan_enabled(br))
+	/* Forward on behalf of the bridge only while the port is in one: the
+	 * frame can have been marked before the port left it, or on reception
+	 * and kept by a redirect that bypassed the bridge
+	 */
+	if (skb->offload_fwd_mark && bridge) {
+		if (br_vlan_enabled(bridge->dev))
 			return skb;
 
-		tx_vid = dsa_tag_8021q_bridge_vid(bridge_num);
+		tx_vid = dsa_tag_8021q_bridge_vid(bridge->num);
 	}
 
 	pcp = netdev_txq_to_tc(netdev, queue_mapping);
-- 
2.53.0

