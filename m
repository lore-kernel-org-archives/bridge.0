Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3CA3FB066
	for <bridge@lists.linux.dev>; Mon,  2 Mar 2026 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460543; cv=none; b=UVoPCIlO6krJyGluUZCVJew02herXFYy0MCPh+/0PoJ1vunYoT3U4p+2oi1gVzDGd1lT9emNY9OoB0ZVlWb/+oK3PnYxCWbfrWaKvaOq+v6mNsthhUL7oPYTI7Qh9UejNwkYcChDzhRF8CJoRwzohZFUohkYoRsa2rYOJQgjNk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460543; c=relaxed/simple;
	bh=dkR69i4zpv7lKN51CSLZknyMgwYpFg2euTFIuXcTNPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gAhA9MqmzmrAsfpr1QQhuzSCOeW54KQNYZqtoDSJUALRBLPe3LVjGn2RMNttNTrY3UMCYy40ed+M5rtLmzFwOnvAYu3n8Gt2+4LkP+n0yxupmjr4DI6Z9Gzdr5vEpfmVfE/cWplAUHibM1JdtVykd2nj4+Mo9wCd8N2+IMnK/eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W8+1CBpf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nJyErpgP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BBMikLke; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7UQNaGI8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W8+1CBpf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nJyErpgP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BBMikLke";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7UQNaGI8"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EEDB13F7D8;
	Mon,  2 Mar 2026 14:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772460541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ru6QvWRuWn9dvd2aEznuE2WFc9BiKyRlLWDwuxExu3k=;
	b=W8+1CBpfE2RAf10fuZ3Dvvd5uQfDBsJyJ6XkSoIFozgWrLdFv1f0EvDp/No0YznWedexPU
	BSAMYrzBsHh341qMuusenvwvRBK8jn8NqbgJlzWfF1G1pZ3yrBR5wYIc/W0xIWMFpEOcV5
	MZfGXTiJekwTh1bJfrQUVku8R03N9iA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772460541;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ru6QvWRuWn9dvd2aEznuE2WFc9BiKyRlLWDwuxExu3k=;
	b=nJyErpgPVGKXYMpIKm845VN7uasSSKcoYygltgji80VnrwDDHpgmnPqPXlj+xjN/YX0F3g
	Mk5TXHDy4MG8TdDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772460540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ru6QvWRuWn9dvd2aEznuE2WFc9BiKyRlLWDwuxExu3k=;
	b=BBMikLkeZb/i8iTzbK+lo/zxiCpyrHSaVeJj7s+lYy0rOMKOad55UbtgtMDyFwgC0fKjbL
	dmN+TVgNRRj208NK1gNJnJgd7VbHGwwfplQPFkkPfXwLLqqQ4ktIQE0lSkyNDDxdYlnG7Y
	LI/Sl9f+huNy2EMGsirKkBtg1SVpfQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772460540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ru6QvWRuWn9dvd2aEznuE2WFc9BiKyRlLWDwuxExu3k=;
	b=7UQNaGI8wTagOLZvUYT2AciAm8/wkW5I432eJ9ajFSRUNpahFTChOP11s4bR+3L+PmgZW2
	tFxwNKYjlDr7nUAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28F063EA69;
	Mon,  2 Mar 2026 14:09:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EGUfB/yZpWnCJAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 02 Mar 2026 14:09:00 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	roopa@cumulusnetworks.com,
	sdf@fomichev.me,
	petrm@nvidia.com,
	horms@kernel.org,
	idosch@nvidia.com,
	razor@blackwall.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 2/2 net v2] net: vxlan: fix nd_tbl NULL dereference when IPv6 is disabled
Date: Mon,  2 Mar 2026 15:08:47 +0100
Message-ID: <20260302140847.5941-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302140847.5941-1-fmancera@suse.de>
References: <20260302140847.5941-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spam-Level: 

When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
initialized because inet6_init() exits before ndisc_init() is called
which initializes it. If an IPv6 packet is injected into the interface,
route_shortcircuit() is called and a NULL pointer dereference happens on
neigh_lookup().

 BUG: kernel NULL pointer dereference, address: 0000000000000380
 Oops: Oops: 0000 [#1] SMP NOPTI
 [...]
 RIP: 0010:neigh_lookup+0x20/0x270
 [...]
 Call Trace:
  <TASK>
  vxlan_xmit+0x638/0x1ef0 [vxlan]
  dev_hard_start_xmit+0x9e/0x2e0
  __dev_queue_xmit+0xbee/0x14e0
  packet_sendmsg+0x116f/0x1930
  __sys_sendto+0x1f5/0x200
  __x64_sys_sendto+0x24/0x30
  do_syscall_64+0x12f/0x1590
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fix this by adding an early check on route_shortcircuit() when protocol
is ETH_P_IPV6.

Fixes: e15a00aafa4b ("vxlan: add ipv6 route short circuit support")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: use ipv6_mod_enabled() instead of a NULL check
---
 drivers/net/vxlan/vxlan_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 05558b6afecd..5fee680e4a8b 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2130,6 +2130,8 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
 	{
 		struct ipv6hdr *pip6;
 
+		if (!ipv6_mod_enabled())
+			return false;
 		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
 			return false;
 		pip6 = ipv6_hdr(skb);
-- 
2.53.0

