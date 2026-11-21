Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795288600;
	b=W9W3VmAe0sq2cRuknJjg6FWyfZp9eDQGkZPgWn6ZPekd7Vven0nwtypLGdKBO7woxDcl
	 0UsP+9f6E08w/UI5BGxDN72vZhuEjIdHpzfG6wu9B/YjUxy+BFhyWB8r/s2hXe/Ain1/G
	 QGGrPU1dnX2WCAtgKWWO1P0f7ZuOuHJFg1NTK7lnItvv26SXjKTZjRhh6uk0VTonzYnKK
	 x7AZrNFA5KZ0qw4HVqTxiznKCd43Al4IDUb/nbRQrcqfx+55Slog+3VVLv2DRN3fE9eYt
	 wxoDqm/va0AqlV3ZJ7NFAc8bHQ8OqKs32OrT9Ke/HyogqqFwnFMromPYU2MavBQT9iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TgHFnT0Aq23ijZjgXPqXmSzHBW3c5oZyz2iVakOwM3E=;
	b=MFTCJQwtHwGosibAlxDfQY8y8omDvI3zz/k1B0ShfhAV4xLQRpHbXtx5PESODjQjwl1z
	 9g98jD9VNr/tPinN/kLfTyL174y3reqKQqDkIRorJM63KdpouEE5oNluuVT4izFyROJSS
	 snl8hF3qlLkx7auYON5Grc34KR9SMoG288h87nBMXQM9x9iAjMDbRJrQtmlwEXGhZgMLC
	 vgmLjHuKYF5XoUr0dDEIbEvic+5+xGbfZR4A3XlFprXxHiQcko5MAS9X5k4+pQaqQX5p+
	 4phxKP8Bu+Ob3zLiy8SJ/SlqPURNOWACHwCr/JQ7Md3PR39o9GBrIO2sgX8xvypCK1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=GQeMcdoC;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C54A606A32C
	for <bridge@lists.linux.dev>; Sat, 21 Nov 2026 19:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C54A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=GQeMcdoC
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4322d310e7so359436866b.0
        for <bridge@lists.linux.dev>; Sat, 21 Nov 2026 11:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1795288598; x=1795893398; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TgHFnT0Aq23ijZjgXPqXmSzHBW3c5oZyz2iVakOwM3E=;
        b=GQeMcdoCVWQdIfKjRcMrHvUufZ6fvoxNh54L1Y+L2o/pvqjRstQCViQ6931QjeIHF2
         Fn7boCT3Kr2hzZEwJfKPmT9JPEvLA6B1f3Nl0dsdlOauTnsd83+JH5Xyl9HYjRMPJFJD
         hPv/PK4gb4qhIgnWZRJVQTrIr+VPAtLvo7WSkzoxpebMFW0CanHxW2rZM/HGUZ0Ym6F4
         ZjZyELumc+M7g6MgzhxQZdlON/ara5G1dIbMGHIkZNMHJUgs2MkAn3jOhFb7vzM0PFfe
         QIE6cSL2/JnNbMVTgFnHDLLDLCf+PX/3rru8TTGGxzL+UsbFTmYyqQ80FgHbnBRnRqQ1
         eyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795288598; x=1795893398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TgHFnT0Aq23ijZjgXPqXmSzHBW3c5oZyz2iVakOwM3E=;
        b=Zf/zBUxL1BqRefJlT/m9xEz4/5h3MjUnLUPCwLu4lHGeo0dYRGlc/z6kvLAIkPBt0/
         JKoFWnIUeEIfgotX9sYVp1/6FRcYD2G7BjC6a9emR348IPjMlH69TVEsTkSwfe09Y9P3
         HYVZEHfiGUaE1X9kSqYqBGffUdn29AyYdSXqecKbj//4xrnGscIYgc5+NYw29Hh86Uwu
         TTOSohMpy5Pj4o9Z6lTsbCzD4tAYcEGb33N76BOpw2IyAy5DrV7eH0eyVZn6vMsFEEPp
         VstgIC7InVjHFDZC/rZnaUTE2szYMiF/3ZiKfm5Iyz5+LAbYxfO1vlafF7ELPmI3nRMc
         7KiA==
X-Forwarded-Encrypted: i=1; AL+hErEaQzJb+BNtx919A1RMCHhloGold/rMg2P6XJvHnxJTk+fMb7hGygKZqrieBowW3x0JWevJL/Y=@lists.linux.dev
X-Gm-Message-State: APuU4Z/XzrKV+faHV127PQiGIsXA6sXioreAajJMoNAj7a7UJrpdaFfV
	Vm0XNSsK6sBda9Lm+CpLqrBxbD7X+jmlaQIjKR3Mp0GLa5SxqpOrdH3Dd0oMgH+z8Q==
X-Gm-Gg: AZFdTZdtGw9QATxL6b1sSpXqgiI7So3/XlQ26gSQ6zxoPTRpO+tbmPW0PfxUnjuGLVq
	eq7hOVW8P3mEjedEcRbEGr5/6esCpE26Cjh5qL9yNgbYI57qkiBpY+K0hwjByojHBI5VCmEybs4
	Pn39Qr2AvPkOISVOPA1yYw2wWVB/xJh760QR/7LV3Hn++72Wp7AJ6fN9RjHH5J9K0jvNKAW56QE
	jZES7xJXTsRs2bOCQI24lpYlD2jqSYVap1EYwr/wsFwaWurHWObUGv6TfSz/rKObKs1Ng+6a2mR
	2sc1hw0CaF7CBBqKYwV2AM/mJx+i+zToNwhhvCGjGZZggD3rEVdWyn3A3cEL2JawGaVSzo4WwHY
	AslAP6ET2OrMfBE1TJI0lRljFrO4GQhIA7ucwWGl2Mu3IsQleGTBiSCeyC1r5l5e32LuYKs9FpU
	E23xlA2P0f/3wtqWHWRsiAx0sp1QRRxtkoYw2QLTUSE+dyTeIs0P/wvkLS6bucRySniZF2EjpyA
	YizAnVHJDrhkchyn1Fy+PMlqOIxW56csQy9pOLr6PYaw7Cd5aFN7CdS5v/tRdaWYy8vt7CCT3tk
	n48/AC28VxMht0PdjuJyhlfXuMSORE1SECNyhaIcNlzRSb+10z2JtHqTAR0zU12Z6f2Xwie8GSY
	BmtiRG9aCJenF7FVPWf4wFuHtYLkjKEuhMw7fMRi69rJFdcWzUNivS0or/6sdG9nYwvdMx6Vzah
	KVcHDu6+KG08kOqxhPYKjvOpEyKvcj+BEqoXLFH2hBJWRFM0U6cO9Vr74S6LfthAeaRrZbeRjP/
	1RRteqc3Iytey6LdN6O0Q/eySxvR7fAp0MQGgcWXBV5XS/4aCAZ96t2L6b9b7gEYeENMgiP+19w
	yRJzckDBGYBedAScfizRds3ykGy3zWD1aIhnmSBTjcx4ujdU5xCFa4Ls3ibxL/VdisTmeiqRQOQ
	q
X-Received: by 2002:a17:906:3d21:b0:c51:24a4:1dfb with SMTP id a640c23a62f3a-c513ac7edecmr423647466b.40.1795288598612;
        Sat, 21 Nov 2026 11:16:38 -0800 (PST)
Received: from Desktop.tail070c67.ts.net (p200300f2470dfa000000000000000a27.dip0.t-ipconnect.de. [2003:f2:470d:fa00::a27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae66674sm226439266b.15.2026.11.21.11.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 11:16:38 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jesse Brandeburg <jbrandeb@kernel.org>
Subject: [PATCH net] net: bridge: withdraw the switchdev entry of an fdb entry made dynamic
Date: Sat, 21 Nov 2026 20:16:38 +0100
Message-ID: <20261121191638.1724620-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
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

Since commit 927cdea5d209 ("net: bridge: switchdev: don't notify FDB
entries with "master dynamic""), br_switchdev_fdb_notify() reports
neither the addition nor the deletion of an entry that the user added
without NUD_PERMANENT or NUD_NOARP. The user can turn an entry that
switchdev was told about, a learned one or a static one, into such an
entry: fdb_add_entry() does it for "bridge fdb replace ... master
dynamic", and __fdb_update() for "bridge fdb replace ... master use"
(NTF_USE), which marks a learned entry as added by the user. The
drivers then keep the entry they were given, and since its later
deletion is not reported either, they keep it after the bridge has
dropped it.

Report the deletion of the old entry to switchdev before either path
makes it one that is no longer reported, as br_fdb_update() does before
an entry moves to another port; br_switchdev_fdb_notify() tests the old
flags, so only an entry that was reported is withdrawn. Entries with
the extern_learn flag stay reported and are left alone. The NTF_USE
branch is only reached from netlink: the packet path passes no
BR_FDB_ADDED_BY_USER to br_fdb_update(). The offloaded flag of the
entry stays as the drivers report it.

Found while reviewing how DSA tracks host addresses for bridge FDB
entries. In QEMU with KASAN and dsa_loop given FDB operations and
assisted learning, an address learned on a veth port of the bridge is a
host address on the CPU port. After "bridge fdb replace <addr> dev vA
master dynamic", or "... master use", and the deletion of the entry,
net keeps the address on the CPU port in 3 of 3 boots for each command;
with this change it is deleted at the replace in 3 of 3 boots for each.

Fixes: 927cdea5d209 ("net: bridge: switchdev: don't notify FDB entries with "master dynamic"")
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
I used Claude (Anthropic) to help write these patches.

 net/bridge/br_fdb.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index b601245ad923..377ca8341029 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -996,6 +996,16 @@ static bool __fdb_mark_active(struct net_bridge_fdb_entry *fdb)
 		  test_and_clear_bit(BR_FDB_NOTIFY_INACTIVE, &fdb->flags));
 }
 
+/* Called before @fdb becomes an entry that the user added as dynamic, which
+ * br_switchdev_fdb_notify() does not report: report the deletion of the entry
+ * switchdev was told about, if it was
+ */
+static void fdb_switchdev_hide(struct net_bridge *br,
+			       const struct net_bridge_fdb_entry *fdb)
+{
+	br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
+}
+
 static void __fdb_update(struct net_bridge *br,
 			 struct net_bridge_fdb_entry *fdb,
 			 struct net_bridge_port *source,
@@ -1005,6 +1015,7 @@ static void __fdb_update(struct net_bridge *br,
 	struct net_bridge_port *old_port;
 	struct net_bridge_dst old_dst;
 	bool fdb_modified = false;
+	bool roamed = false;
 	unsigned long now;
 
 	/* attempt to update an entry for a local interface */
@@ -1032,6 +1043,7 @@ static void __fdb_update(struct net_bridge *br,
 			br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
 			br_fdb_dst_write(fdb, dst);
 			fdb_modified = true;
+			roamed = true;
 			/* take over HW learned entry */
 			if (unlikely(test_bit(BR_FDB_ADDED_BY_EXT_LEARN,
 					      &fdb->flags)))
@@ -1048,7 +1060,12 @@ static void __fdb_update(struct net_bridge *br,
 		}
 	}
 
+	/* Only from netlink (NTF_USE), with the user's flag in @flags */
 	if (unlikely(test_bit(BR_FDB_ADDED_BY_USER, &flags))) {
+		/* After a roam the deletion was reported above */
+		if (!roamed && !test_bit(BR_FDB_STATIC, &fdb->flags) &&
+		    !test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags))
+			fdb_switchdev_hide(br, fdb);
 		set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
 		if (test_and_clear_bit(BR_FDB_DYNAMIC_LEARNED, &fdb->flags))
 			atomic_dec(&br->fdb_n_learned);
@@ -1262,6 +1279,10 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_dst dst,
 		if (flags & NLM_F_EXCL)
 			return -EEXIST;
 
+		if (!(state & (NUD_PERMANENT | NUD_NOARP)) &&
+		    !test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags))
+			fdb_switchdev_hide(br, fdb);
+
 		old_dst = br_fdb_dst_read(fdb);
 		modified = fdb_update_dst(fdb, old_dst, dst);
 

base-commit: d5b89d55a322b632e2b465b392a4c1d9d338db9c
-- 
2.53.0

