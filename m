Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793508531;
	b=iOkCCERMZMm2qSVyQS1taTEcbf1gBxXDWm9UO87EIx9NAgu5XV1eIu2y3kf06/ns60F1
	 hTTUkvfGeKnf0DSGn9nY16pKtuCq5KVuKBrLFG9g9UFl5fGYKHp3Z1hQrYjNqVEeFAZFN
	 uhKQGUPNsLvx6rObNG9rN9Kl7u2wo5YezZu73DqoxZAtq2EameUrhelu4yZeyCXSL2ljh
	 OaWnqFfN2T01EzBCc8BKh1Wa0djS8+g2zLCHI7OqnaFAUlfCTyIDf6PdtWnZdmq/wbCxG
	 7XkTVk/Gu8xTqOx5r0/II/lKQ0neDN6YG1EkwwAMC5vwjvsYDTR9VKXs0WW6Q6fnPTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793508531;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QNvU5RCwGD7yT7rtU7WNdTuMkbHAjYhh78R8TjXDdfE=;
	b=gzd64FXuU8yBc8SxZ+hfeDykp7bfbd4QtfXXymTiRInx+PQvf3wr9NLJmHY65OwPXhD4
	 TAwHLE0ebKzohdiws5p0hnT77mTSkpbmOfOzjVRjOi7hA5WfQ5vyaN7/RUSmj2ruLNcTx
	 0qy3v0UzLiyE4rq5mWsRTxyc/QVIDeJpcso2FdZCgqSmtoYxzO59FUmX/iBXkhm5aui5J
	 WNh3p66DCRp494M2e79PqlcnVD8Rw0ESGk5I3Ve0oR0vfh9njJUB06ZwLrk6yHm+CyD+V
	 R7ZL6W8ZoVEQJg03q4jTmeGUs/R3TZLldLj2QvQ5eL9iAjrm7FsxRcwPJiWerZkPT6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sa09qu5N;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBF3606A325
	for <bridge@lists.linux.dev>; Sun,  1 Nov 2026 04:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEBF3606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sa09qu5N
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1931ff67a29so2785584c88.1
        for <bridge@lists.linux.dev>; Sat, 31 Oct 2026 21:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793508530; x=1794113330; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QNvU5RCwGD7yT7rtU7WNdTuMkbHAjYhh78R8TjXDdfE=;
        b=Sa09qu5NApV7fDa9EM6F5+PSlEINV2sjYioWnzUsL4qycbuwn9JGG+tIVCIxdv1tij
         JFhaa0ds9JCGdu4Axsl783PlLkrDFjv31UekiSRAjhCbA1doWOygm6rhzi+0XqYYPmN/
         5Nwr75zAWw+mvwtjZgCO6JX9JxtsllUbecvQ/tSut4goZG5Ni2RU3kHvVzAFfMJYjq+Y
         oH7RRcWApcx6vOBBJyVvxABd/vGGmGtfrO+1xz1UGIXjh2glu7pzfpCZIkzzkfGgvpOo
         9oFJAueSz2QAguzCTfU+6H+Wr9DazPchhDUk4a547a3X2stD8Y2mu9Ki6SerutFyGqkK
         +i/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793508530; x=1794113330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QNvU5RCwGD7yT7rtU7WNdTuMkbHAjYhh78R8TjXDdfE=;
        b=nL7YI01+aBtfdB9aYBlUoTT03ggR6NhrkmiYff+IzxKodgyL6yuIGlmr67StwNYoKJ
         X8iqk1yIl7ZXll6baTeKtc5OeFxJuF+LRiRCWVTv7xoT7FCjw32PAy6uQVSsPbjo516b
         p+ezDeB3rAE6xyzlB1DbEX/lpvayDYT9XeLUx6RPcQwa+wl7L9ADGtURQEVqGkYw+AEq
         3ff/jYLXJMp6xCTs7Bhmgdao8RZ9lk769hrqxMY7zGSij/SsHZW2XEdvNHTye2PTJKn7
         z2t5ZBKmuVybtfzqE7b+JIoA1tXGteFuKFQPbEOTPjvKr+hGZxH7G3gQuqPaYgYr2zPI
         aL5A==
X-Forwarded-Encrypted: i=1; AKwUvByU2Xy2+g0RPhKnJcgaGXqvBsm1RjaOiNtbPsnWrL2M29R8rGmpima2eOgGGfrKM4+XZzGREqo=@lists.linux.dev
X-Gm-Message-State: AFq9FYKknwGND73bLuLeNKpWKRidZSbZuI2tCBOT/vkEPuqWu5RI68py
	fBKUNf9IA/C0OrJESqKPUW/mLdmy0+Tyxax6wJoR1ZDHUkWmaGWzo2es
X-Gm-Gg: AYBFou3WvTY+B4cAFICEGeyq3I+xvCsRKHBrwmZxw8AAXtE67kRUEgJHVLjjB+dT5zx
	pVZgprxNuMp57DBdWI93hpSyWYxnDTqLja657oxleajD3SYjoTIbmQ6yip9sU1rnAu7kdcGS9bY
	1kvdNLjuRiRJ1IX7x+S+mCEFMRMWa2V68PxdUEJdr2Tfoep5yD8J5M3QyU3mlnnrZklCEOGlMYZ
	Zy8OHTHAL/0ka0Em/YWG40PyAiNvYOMcxN1lGYb3fC55GB5eQfSFE4u6x/Nvm5jgApYzco1t6C/
	bCHwu4wlmGfzGcyqxe1YwEwAtrVtmD1BkJW5/X2/epdB8/dHxT84Cm6N88oBl6FeWFES9k3hgL5
	J0tEzQyX3uz79e1CjsSKRwFi2gNn/orfh7vVJpKrRf0D8s5tDQkelx9b1Hnsroy+vj+XGgZ/HN6
	EucDpLoDvLscfeyuHE19IvfEmBT+oHtEgVAwAUJ5Ge2bqlet9pbWq1xe/wHZMBn8+ye9hPXn+UV
	suY3mAhvG05YZgqx5Vp/yek5S8PcXPUIXQTUpVYDu40otUjiy3cXq3t7KJIRYdup0MDYqRnalKP
	hzA9AluKOLiz230cgxHqCBu3mlbvRM/Kvhm+mKskcoN7CsWsaa3jdGNUCaLbX0xiO9rI/TJrZwS
	v8AMpG2vUF0PY
X-Received: by 2002:a05:7022:eb50:10b0:14d:baf5:c415 with SMTP id a92af1059eb24-1ac5a0b4324mr10594227c88.7.1793508528871;
        Sat, 31 Oct 2026 21:48:48 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19c6b969sm20843929c88.14.2026.10.31.21.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 21:48:48 -0700 (PDT)
From: xiaoblac <teel4res@gmail.com>
X-Google-Original-From: xiaoblac <1020691186@qq.com>
To: Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cheng Yongkang <teel4res@gmail.com>
Subject: [PATCH net v3] net: bridge: disable MRP ports before the FDB flush in del_nbp()
Date: Sat, 31 Oct 2026 21:48:40 -0700
Message-Id: <20261101044840.1595584-1-1020691186@qq.com>
X-Mailer: git-send-email 2.34.1
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

From: Cheng Yongkang <teel4res@gmail.com>

del_nbp() flushes the port's FDB entries before it unregisters the RX
handler. For a normal port, br_stp_disable_port() moves the port to
BR_STATE_DISABLED before this cleanup.

That does not hold for an MRP ring port. br_set_state() ignores state
changes while BR_MRP_AWARE_BIT is set, so br_stp_disable_port() leaves
the port state alone. br_mrp_port_del() then restores forwarding when
the bridge is up before clearing the bit. A frame received between
br_fdb_cleanup_by_dst() and netdev_rx_handler_unregister() can therefore
create a new FDB entry referencing the dying port. Nothing removes that
entry before destroy_nbp_rcu() frees the port, so a later frame to the
learned MAC can be forwarded through the freed port.

Remove the MRP and CFM instances before disabling the port, so that
br_stp_disable_port() actually transitions it to BR_STATE_DISABLED.
With CONFIG_BRIDGE_VLAN_FILTERING=y, synchronize_net() in
nbp_vlan_group_unpublish() also drains receive paths that could still
learn with the old state before the final FDB cleanup.

Found through an LLM-assisted source code analysis workflow and
reproduced on net with KASAN and CONFIG_BRIDGE_VLAN_FILTERING=y in QEMU.
A diagnostic switchdev module accepts MRP objects and delays the
NETDEV_CHANGEUPPER callback for 1.5 s, holding del_nbp() after the FDB
cleanup and before RX handler removal. The reproducer floods the MRP
port with rotating source MACs, waits for the port's RCU callback
through the module's rcu_barrier(), then sends frames to those MACs
from another port. The unpatched kernel reports:

  BUG: KASAN: slab-use-after-free in br_forward+0xb1/0x820
  Call Trace:
   <IRQ>
   br_forward+0xb1/0x820
   br_handle_frame_finish+0x148b/0x1e50
   br_handle_frame+0x90a/0x15c0

With this patch, three runs of six cycles each reach the delay without
a KASAN report.

Fixes: 6536993371fa ("bridge: mrp: Integrate MRP into the bridge")
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/netdev/20261012123051.GA714215@shredder/
Closes: https://lore.kernel.org/netdev/20261022090431.3641707-1-teel4res@gmail.com/
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
Tested on net cb284914e749 (clang 20, KASAN), with and without this
patch:
- the reproducer above: the unpatched kernel hits the UAF on the first
  cycle; the patched kernel completes all cycles without KASAN, WARN
  or BUG, and a ping / FDB learning / port detach / bridge delete check
  passes
- selftests/net: vlan_bridge_binding.sh, bridge_vlan_dump.sh,
  test_bridge_backup_port.sh and forwarding/bridge_vlan_unaware.sh,
  bridge_vlan_aware.sh, bridge_fdb_learning_limit.sh,
  bridge_sticky_fdb.sh, bridge_port_isolation.sh, bridge_locked_port.sh
  pass on both kernels; bridge_stp_mode.sh skips on both (iproute2
  without stp_mode support)
- W=1 build of net/bridge/ with allmodconfig: no warnings

v3:
- Re-test on current net (Ido).
- Update the FDB cleanup and VLAN group unpublish names for current net.
- Describe the FDB's reference to the port without the old dst == p
  expression.
- Remove the deprecated Assisted-by trailer and describe discovery and
  diagnostic instrumentation in plain text.
- Add the original report/reproducer link and links to v1 and v2.
- State the VLAN support prerequisite for the receive-path drain.

v2: https://lore.kernel.org/netdev/179333317814.2102764.8780283783548366593@gmail.com/
- Use Ido's MRP/CFM reorder instead of adding a second FDB flush.
- Validate the reorder with the v7.3 reproducer and custom regressions.

v1: https://lore.kernel.org/netdev/179268538303.70821.8213834342995341232@gmail.com/

 net/bridge/br_if.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 2c05ebc1299d..fb25ce3e5e64 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -341,13 +341,13 @@ static void del_nbp(struct net_bridge_port *p)
 
 	nbp_delete_promisc(p);
 
+	br_mrp_port_del(br, p);
+	br_cfm_port_del(br, p);
+
 	spin_lock_bh(&br->lock);
 	br_stp_disable_port(p);
 	spin_unlock_bh(&br->lock);
 
-	br_mrp_port_del(br, p);
-	br_cfm_port_del(br, p);
-
 	br_ifinfo_notify(RTM_DELLINK, NULL, p);
 
 	list_del_rcu(&p->list);

base-commit: cb284914e749388eef402938bdb3115fe1f6d337
