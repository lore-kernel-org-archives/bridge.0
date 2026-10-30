Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333202;
	b=lY0itLmC49YjbT0KUhqp35Hci9kGxf1CeiyCs28xxKvP/v3Klpn5dk+IvpfDWK5WyWcu
	 qtpEOOigZ3+MnYbVEunhHkm4tJ4xioOw7G1nwLpM04JttDNwjF2RI3ul0JH2J4kZL1Ohw
	 SFY3LJmysqIVSk2w+f1s89wGTz3K4LZU2v8Ekvx6YP4sGrmx3yiFIPNADRijGxpT6pF1H
	 Uypdpy/KkV1ouxj2sI07Xy95rQzH8LEK09coFv1SjbO1gm5opkInZ2Nhr6mEG+1Y+5naB
	 ZPbo1Ww/gBtxpaTc8Y6KpylspqDdljA5cabSS1GxgJVte1febmBqWEdqorHwkX7KWOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=idK/OHsk8PCTskL28fTb65exOFJHBkY2hYQtf1j8B4w=;
	b=DG4aw2uYYZjvfDTxQrjQZmtQGNbS009YBYF3w2blKFlAKE/HMRzLOntt5RJ8Q/FA73l+
	 0CHd25r06KN4G8mRr7O7n9W4jCslsAwDyT2JtJfekRg3GeF+3lq0VekP7aDVxsVOUJfom
	 jv3ztKXuKXpoC0VmsSfKKZcvZXjlW2tsR4hqytL7btgH/jG5G8rgXqRHWogwneHM3s4xv
	 CYJrSYdWdvbCvxSp0g1RYQS5tmiCOsp7sdnlR/dkPHmbJA8JKYK5o6aQeAIsimLRp1U8+
	 WEgXLFn5E1io/QI9FMvbwiDPD/jx+Tsqr0EfrCFu1mqAcgycyy5GIfp9kECnebtyOyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xDXNUpFl;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCCD606A31E
	for <bridge@lists.linux.dev>; Fri, 30 Oct 2026 04:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BCCD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xDXNUpFl
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36a17a332ecso590220eec.1
        for <bridge@lists.linux.dev>; Thu, 29 Oct 2026 21:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793333201; x=1793938001; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=idK/OHsk8PCTskL28fTb65exOFJHBkY2hYQtf1j8B4w=;
        b=xDXNUpFlXEOJoE4X81LIFH9mdXDgLv/gH5/v00KAcgvH4l+vUTyKv5ePBUrhlQ3nQc
         b8YBcedfip/vc4wMabpK1yFztdbpFu28Fj/DkelGMGyt2xdjo2EEs3doqJQhgkc4mEye
         vxNL8m+WKtcqffM5wd9SnNf5+zK2Qt+1ZkJNLrem8ajSTJw2NrhkOVLVCA2xOgnXBv58
         E0udpGKIqfZuCDZvrf4wxwYTrGAySJc8BQA0S5AuacEC4azPedDowGdXOvZNLj2CONod
         iMQ/7LQQJuxyB9gYaefuigMsNXpsfuHcyDe653r9AGsyhjcPYTYr+b+Qiz+tC5Ol9568
         hciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793333201; x=1793938001;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=idK/OHsk8PCTskL28fTb65exOFJHBkY2hYQtf1j8B4w=;
        b=vOBmD0yEXAAjQHaG/7y7r+pK7znUn/wbfGpkD5niwVttVdQmAkMjsLmOKty7Q/D+Fv
         upjJqTUjCSgYn6AljCe6XZhZmD4TJY8hJHnR19npXyymsjlMuWNvAoak/70gQMNSB2Bp
         qwOT91RLPrcSAD1iYkH7Ej6KZIT+7AYu1bz57mEA6CUcpNGuu5H8ecjPi3pC62do0eED
         FEuqdux2pFwpS3mD3CfDkGWsxK7SmpmCBctJfjbf0/q85eGoUJig0O4eC0Kk9Hr0yhku
         Pi1D2b1Cnc7NPA7TCIDyqfomugyqXPUHHmo6DNhsURWLMOMEVLoeqAX9T/6GjmsQqriv
         YedQ==
X-Forwarded-Encrypted: i=1; AKwUvByqwJldFpcjgo3NwpAOHpWRdx4+joyZ/rsNAtGuYNSIqJxEwQJiQ6G9bmXf2nEhc5yGFYD5CkQ=@lists.linux.dev
X-Gm-Message-State: AFq9FYL2fvBkfmzRR7jEpuZN9P3sXKyqCB235TZlO2aZsESXmRLCywRM
	uX8/M7bNcTe18FV6OAmimUcRKD+9h6GM6/mx+pOvguEdjDCBItl2XDXt
X-Gm-Gg: AYBFou2Sjb03GXS4yXxRkcw9QUOSA8VKiZSj7thQFQZWtc7KN7wQEEKP3v1pXfWUkYS
	4hErD0CslNFv6Ps4Dttl5iXmG0HaSwNXgk34V8s4q/e3bw0coLWlIqBygWpwHC7qS5UZOKvrEUV
	3vVy4gZrSe4ajT14x19NsdJVdMIrcjcWOnzDh997XvbWEPDiMi1/+caRG2OZKA59AZhRUormOV6
	NaptuP+FZbOfidYLIQfayfuR4xddFq9rM/9Hl6YNRHXdMk7t5XGUNF4wuiTj2SQVig5VaReFrSD
	+SRld9J8X/vq17KrWFUn8AVc0gU0OBkBDSLNhK7wUVXX/HpYg86hzGapXAwdOsG4ICBIXu1wi1K
	qb4BBhhPkMfBS9VbHwqPSdPV0NoqJKMzFastux+RkXy7jTShHtbx5m8gJDj4evuWPyM4eTSCLFX
	PPH2vvrOU1SF8ZGqWM7eCB73VjSP6cXIx01VMVCFZU4VDmCnMD7BrDLNSojS6egJyCPj7d0V9mS
	OY9cLiuGUleL+ZfojjBI5qQ8NtKrIXxrr3kGIK9qe/4mgEUB2VYlBIIjZzlsXa3ITVQPt61h9Uj
	ybpkGkdQv7lcbCt8Olf0VT6oD3rdRf4vW22VxcEASMc+uCQudYY/qg==
X-Received: by 2002:a05:7301:db8b:b0:35e:ebb1:8e5a with SMTP id 5a478bee46e88-36a424261e9mr1794192eec.26.1793333200901;
        Thu, 29 Oct 2026 21:06:40 -0700 (PDT)
Received: from [127.0.1.1] (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42902649sm3412216eec.11.2026.10.29.21.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:06:40 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: bridge: disable MRP ports before the FDB flush in
 del_nbp()
Date: Thu, 29 Oct 2026 21:06:18 -0700
Message-ID: <179333317814.2102764.8780283783548366593@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

net: bridge: disable MRP ports before the FDB flush in del_nbp()

del_nbp() flushes the port's FDB entries before it unregisters the RX
handler.  For a normal port, br_stp_disable_port() has already moved the
port to BR_STATE_DISABLED, so no frame is learned in between.

That does not hold for an MRP ring port.  br_set_state() ignores state
changes while BR_MRP_AWARE_BIT is set, so br_stp_disable_port() leaves
the port state alone, and br_mrp_port_del() then sets the port to
BR_STATE_FORWARDING (when the bridge is up) before clearing the bit.  A
frame received between br_fdb_delete_by_port() and
netdev_rx_handler_unregister() is learned with dst == p.  Nothing
removes that entry before destroy_nbp_rcu() frees the port, and a later
frame to the learned MAC is forwarded to the freed port:

  BUG: KASAN: slab-use-after-free in br_forward+0x55/0x3c0
  Read of size 8 at addr ffff8880200bf038 by task mrp-poc/9420
  Call Trace:
   <IRQ>
   br_forward+0x55/0x3c0
   br_handle_frame_finish+0x1300/0x1d40
   br_handle_frame+0x90a/0x15c0

Remove the MRP and CFM instances before disabling the port, so that
br_stp_disable_port() actually transitions the port to BR_STATE_DISABLED.
The synchronize_net() in nbp_vlan_flush() then drains the receive paths
that could still learn with the old state, and the FDB flush that
follows removes their entries.  No frame can be learned after that
flush and before netdev_rx_handler_unregister().

Tested on v7.3 with KASAN and a reproducer that holds del_nbp() in the
post-FDB-flush/pre-unregister window for 1.5 s while a flood keeps
sending frames.  The unpatched kernel reports the KASAN use-after-free
above.  With this change the same window is exercised in six cycles and
no KASAN report is produced; normal bridge forwarding, FDB learning and
port detach also pass.

Fixes: 6536993371fa ("bridge: mrp: Integrate MRP into the bridge")
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/netdev/20261012123051.GA714215@shredder/
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
 net/bridge/br_if.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

v2:
- Implement the reorder suggested by Ido instead of adding a second FDB
  flush after netdev_rx_handler_unregister().
- The reproducer still exercises the post-flush window; the unpatched
  kernel reports the KASAN use-after-free and the patched kernel does
  not.
- Regression-tested normal bridge forwarding, FDB learning and port
  detach.

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index c52613431f88..45642b6a5866 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -340,13 +340,13 @@ static void del_nbp(struct net_bridge_port *p)
 
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
