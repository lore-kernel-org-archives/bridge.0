Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795680485;
	b=pt3xUjhTqzYpZLgovdVc7NQOFqM3a6WR3eVO5X9ru/1IGebR6bn5wDXtQYuQWhAiUVVA
	 jF8iMtX4sXdx9ivgEGnaLGngvHT6Iw5Yj/x5oXZK3Bs+mNQKKhMRaOMGK+hpGkhpk8Tav
	 hikwisn1p6Z9ildCmcI9f7G+tDIyRc97gSsqpi5x+DoIvr6/68YjvhgQ7SiuTQs/W/TY2
	 Pux2V6lVIl3cdaLTDWOyhO1kyqaOkZFS3gMwyB5iiB8v1vyiTnY9XjJlcsI0kuFsxzbB3
	 COXUUxPb9oceOI/u6ZXvpFB0uVxPMOFPyhVJG2jGXkJNvXBpKZbTvYSYoEZ+mLyvrQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680485;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=BVSxdfpeAJRFWrunpKDepXPbpqJmxv2tuIscSWFpfYc=;
	b=wNa0iR1zhmFbccl8GgWsFM/Zq+ZeAJTGkY96RCAlmzYLrOQXI4si9C7pREc8grp+W7jP
	 hw1DW2brjzyug5CVEEc1EBuZV6/VGLL4KuHLsP3mbgpAmguG8KLzqf+Src35BtTaI+PTM
	 6/cnJQN7lvlEi989oIUBXU/wvtzVc9ceKwrn7JjQivMLrNTdVkMuopPVoc9jgL5fiDc9S
	 ap42i2ys71MT37eg/IrJsJ/X5M20oFtZKqaeCtHh2SvtC18bBgZxprzEiSm0KDXQNVA4j
	 Qh3+LMtwi26qvQwaY3j17y7HGEfHWBUGQIjkAmMYJD6dQgsHdLph689o+OjFhomRV6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=OBV3OX7I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E3F606A323
	for <bridge@lists.linux.dev>; Thu, 26 Nov 2026 08:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82E3F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=OBV3OX7I
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D6223205A76;
	Thu, 26 Nov 2026 09:08:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795680480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVSxdfpeAJRFWrunpKDepXPbpqJmxv2tuIscSWFpfYc=;
	b=OBV3OX7I6ZPFCYFLwDptEIZq+FM9IjQEiox95RQLivNfpVmv41E4r78V/iTFCXaqxrisBP
	JzJKp+Jn0j2P/5avPq4cAh/DcFU3WBUNzZIBgZ/aFxpZYjbxDn34AxWSP3J9mzL9KQJjvA
	GL5G593OdKx0SScJvAMM1KcCWhGDVLMg+x43t1QBGMMwX9ThU506kVS8w3P1cz0Inqdl/s
	+FWcRJ4n28Sx6c5ZyoX+jUEsobLGtu8qAYcodZ8vpPvTYWDlsbI2AxJlOIR3LoZ+ggzzsy
	GOZjkw6GdY/HGFGAfL7RiBVX05PEHVHu8XG5HlyGLco2KWsOAm9/2WaSD3Xrhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795680480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVSxdfpeAJRFWrunpKDepXPbpqJmxv2tuIscSWFpfYc=;
	b=Pg00rAL+g4JaLPho3e1DWNGT/U1ZiGQazuqQLWRAAQczQoAg5D7Cd8A2P0hC+j53DwO4IL
	KcnKBuV+2gwIdeIMiFfIuQZF90w9tUmmJVuCFqQ3j+/wUwu61jFzNv/jPQKWkZ4gXdm221
	sKDewrUj7g3xKDm/0xEvt+6vowpu4BvjL20KfnINwiojn8gC3Jdd5WU7M7eY2YiCVTh0EL
	WMf1Jx2CsIlih/k1Mv7IGy3hYmbvJHRzLlMGRZHFYVmBB+wPTu+lGx+z0TZya1M/4uk+p6
	kSB95jpKVbp36wsjXwtM1z0CQt6OsKKaJHZdbalpKeAkO16bbD4qDtVGbszWew==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795680480; a=rsa-sha256;
	cv=none;
	b=fn5Ex74NDqnxXXMXVgEBdLuXdYeU9ERTK6tHxkvbaVSSvvQm7RoaWRvUAClaQVm5WhH0yT
	ElzVL6xzwIFGTCtpmxYxWrFQ7ODSWPvGCkMh145hyRHP/y2ykHvTBrSYRzE2nEUojreRGv
	JN8P2g/dd1kSt1URV5B7zwg5iYAep7nVy0Ng14AtR+mdX0bZgh/zPhTqsoUPntCoM5YRkk
	sR8VmnQvjgnwxYHjagXTAYnRMZNRwbRbWhJ1kc5tol9++hrQtRTj43e4YnnCtPinul6+up
	dqcsXNhuJbInSZgItsCpkMYZ6GVUp6rW/3OYtBIjBtq/HltSDCMGgwh2px8k/g==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id B7474380B75; Thu, 26 Nov 2026 09:08:00 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Thu, 26 Nov 2026 09:07:51 +0100
Subject: [PATCH net-next 4/5] net: dsa: microchip: ksz9477: refuse FDB/MDB
 entries for trapped groups
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-ksz-stp-link-local-v1-4-39aed15f6271@pengutronix.de>
References: <20261126-ksz-stp-link-local-v1-0-39aed15f6271@pengutronix.de>
In-Reply-To: <20261126-ksz-stp-link-local-v1-0-39aed15f6271@pengutronix.de>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
 netdev@vger.kernel.org, bridge@lists.linux.dev, kernel@pengutronix.de, 
 Oleksij Rempel <o.rempel@pengutronix.de>
X-Mailer: b4 0.14.2

Refuse FDB and MDB entries for trapped link-local groups on user ports,
so that they cannot bypass the trap.

The KSZ9477 family looks up a destination address in the address
lookup table (learned and static FDB entries), the static address table
(MDB entries) and the reserved multicast table. The driver traps the
link-local groups with the reserved multicast table: it sends
01:80:C2:00:00:00 to :0F to the CPU only, except :01 (PAUSE frames),
which it drops. On a KSZ9893, an FDB or MDB entry for a trapped group
overrides that rule. The switch then forwards such frames by its own
lookup, while the bridge decides in software whether to forward these
groups:
- with an MDB entry for 01:80:C2:00:00:0E on lan2, the switch forwarded
  these frames from lan1 to lan2, although group_fwd_mask did not allow
  it.
- with a host FDB entry for 01:80:C2:00:00:00, a Blocking port stopped
  passing BPDUs to the CPU, so the bridge moved the port to Listening.

Record the trapped groups when the driver sets up the reserved multicast
table, and refuse to offload such entries on user ports with
-EOPNOTSUPP. bridge fdb add and bridge mdb add still succeed, and the
bridge keeps the entries without the offload flag. In software the
bridge uses only the MDB entries for these groups, so an FDB entry for
such a group has no effect. DSA logs an error for a refused FDB entry,
not for an MDB entry. Accept the entries on the CPU and DSA ports
without a write. Entries for :01 are accepted as before.

A later patch makes the tagger stop marking these frames as already
forwarded by the switch. This patch comes first, so that the switch and
the bridge never both forward such a frame. Until then, frames to a
group with a refused MDB entry are not forwarded between switch ports
at all.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz9477.c    | 58 ++++++++++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz_common.h |  2 ++
 2 files changed, 60 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 8271bc742ddc5c92b925b01bedfcf876cfa14078..b972c9fab55c170758dac97bda026e1f29e487f2 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -768,6 +768,27 @@ int ksz9477_port_vlan_del(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+/* True if @addr is a link-local group that the switch sends to the CPU only.
+ * An FDB or MDB entry for such a group would override the trap.
+ */
+static bool ksz9477_link_local_is_trapped(struct ksz_device *dev,
+					  const unsigned char *addr)
+{
+	/* is_link_local_ether_addr() limits addr[5] to 0x00..0x0f */
+	return is_link_local_ether_addr(addr) &&
+	       dev->link_local_to_cpu & BIT(addr[5]);
+}
+
+/* Return -EOPNOTSUPP on a user port, so that the bridge keeps the entry in
+ * software and does not mark it offloaded. Return 0 on the CPU and DSA ports
+ * and write nothing: the bridge adds its host entries there, and they must
+ * not fail.
+ */
+static int ksz9477_link_local_entry_err(struct dsa_switch *ds, int port)
+{
+	return dsa_is_user_port(ds, port) ? -EOPNOTSUPP : 0;
+}
+
 int ksz9477_fdb_add(struct dsa_switch *ds, int port,
 		    const unsigned char *addr, u16 vid, struct dsa_db db)
 {
@@ -776,6 +797,9 @@ int ksz9477_fdb_add(struct dsa_switch *ds, int port,
 	u32 data;
 	int ret = 0;
 
+	if (ksz9477_link_local_is_trapped(dev, addr))
+		return ksz9477_link_local_entry_err(ds, port);
+
 	mutex_lock(&dev->alu_mutex);
 
 	/* find any entry with mac & vid */
@@ -840,6 +864,10 @@ int ksz9477_fdb_del(struct dsa_switch *ds, int port,
 	u32 data;
 	int ret = 0;
 
+	/* never written, see ksz9477_link_local_entry_err() */
+	if (ksz9477_link_local_is_trapped(dev, addr))
+		return 0;
+
 	mutex_lock(&dev->alu_mutex);
 
 	/* read any entry with mac & vid */
@@ -989,6 +1017,9 @@ int ksz9477_mdb_add(struct dsa_switch *ds, int port,
 	u32 mac_hi, mac_lo;
 	int err = 0;
 
+	if (ksz9477_link_local_is_trapped(dev, mdb->addr))
+		return ksz9477_link_local_entry_err(ds, port);
+
 	shifts = dev->info->shifts;
 	masks = dev->info->masks;
 
@@ -1069,6 +1100,10 @@ int ksz9477_mdb_del(struct dsa_switch *ds, int port,
 	int index;
 	u32 data;
 
+	/* never written, see ksz9477_link_local_entry_err() */
+	if (ksz9477_link_local_is_trapped(dev, mdb->addr))
+		return 0;
+
 	shifts = dev->info->shifts;
 	masks = dev->info->masks;
 
@@ -1554,8 +1589,21 @@ static void ksz9477_config_cpu_port(struct dsa_switch *ds)
 
 static u8 reserved_mcast_map[RESV_MCAST_CNT] = { 0, 1, 3, 16, 32, 33, 2, 17 };
 
+/* Index: group number in the datasheet's Reserved Multicast Address Table,
+ * the same index as reserved_mcast_map. Value: the link-local addresses the
+ * group covers, bit X for 01:80:C2:00:00:0X. The other groups cover
+ * addresses above :0F.
+ */
+static const u16 ksz9477_resv_mcast_link_local[RESV_MCAST_CNT] = {
+	[0] = BIT(0),			/* STP BPDUs */
+	[1] = BIT(1),			/* MAC control (e.g. PAUSE), dropped */
+	[2] = BIT(3),			/* 802.1X (EAPOL) */
+	[6] = BIT(2) | GENMASK(15, 4),	/* LACP, LLDP and others */
+};
+
 int ksz9477_enable_stp_addr(struct ksz_device *dev)
 {
+	u16 link_local_to_cpu = 0;
 	u8 i, ports, update;
 	const u32 *masks;
 	bool override;
@@ -1621,6 +1669,14 @@ int ksz9477_enable_stp_addr(struct ksz_device *dev)
 			update = ports;
 			break;
 		}
+
+		/* Record the link-local addresses of group i if the switch
+		 * sends it to the CPU only. Group 1 keeps its drop default and
+		 * does not match.
+		 */
+		if (update == BIT(dev->cpu_port))
+			link_local_to_cpu |= ksz9477_resv_mcast_link_local[i];
+
 		if (update != ports || override) {
 			data &= ~dev->port_mask;
 			data |= update;
@@ -1650,6 +1706,8 @@ int ksz9477_enable_stp_addr(struct ksz_device *dev)
 		}
 	}
 
+	dev->link_local_to_cpu = link_local_to_cpu;
+
 	return 0;
 }
 
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 8819670cbb053eeb73ea4a7685303d9849bd6efb..7b96d110b1f64f4226ee7a371da38cd7e5b3767a 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -243,6 +243,8 @@ struct ksz_device {
 	u16 mirror_rx;
 	u16 mirror_tx;
 	u16 port_mask;
+	/* link-local groups sent to the CPU only, bit X: 01:80:C2:00:00:0X */
+	u16 link_local_to_cpu;
 	struct mutex lock_irq;		/* IRQ Access */
 	struct ksz_irq girq;
 	struct ksz_ptp_data ptp_data;

-- 
2.47.3

