Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792945940;
	b=KlnpSoyqew2hZggusFdlshkpnRT4vsYliwXonGw6RqsdIIe0CTR1rnNmYLxRTcs7Qbtc
	 NpUnX7C5f2LgvGRWlbkJlqOSqY2RVEQzpZ7OslSMDvgwQpxOrNrMld9t/oXAQAZzI+nLe
	 JM+q5K07P98RWIX5xU5FJC8bBrRLmdLbQ2SSH/Gjq8jtpqH6t6SSDPSnGPWhTpckLQqRF
	 KS24xHJv3jLIv1DZG8UlRPE1GnVDt7M7JSGCFdbNovauAi4n9xrOd0HDFoeVFO0rtiSbF
	 V3u7P69fBklKLOhVu+kIrFmYaNUPTBVOuWLKUcv9MXpKtNL7+/mArzjkiTIVUnsmZqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792945940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8okjaHqjL4OJDz9RgzhtvzITY5sy3ytCZSHI9pXfkb8=;
	b=SQZ+4weazLgn2dLjh9cMySS825yiCpPIWHPUl71eddwj37oSmzLofPpdoKFck3MPz6WX
	 xVzsGHW1fGRZB3P1FFK054iHI4CusmXPHTTVUUdkMRzIwFDbYEfI6E1ebfqSIcvC0RRjH
	 W8b1frg3FIGkOvYRVqb2/MRUMvWzhcVP8iYRcM8HizJd4Mbxw8HWEc1AXE8e3GzX+AIzr
	 3Jq++imGPilzmabpBgzAHBHCMVw9+oMVv2ic0qzRwgfdPyHpxP3cgQlloM/aSFtQRtgXm
	 eisXbAradA0M9khdVM6mEWcZQyqkxDRB4TqhucMHpuVlm7zRmaCCyiVup6/r8aWNa/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ovt0ZCJQ;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C01606A31A
	for <bridge@lists.linux.dev>; Sun, 25 Oct 2026 16:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15C01606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ovt0ZCJQ
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-16079d54c17so1681206c88.0
        for <bridge@lists.linux.dev>; Sun, 25 Oct 2026 09:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792945939; x=1793550739; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8okjaHqjL4OJDz9RgzhtvzITY5sy3ytCZSHI9pXfkb8=;
        b=Ovt0ZCJQK+dN2wPFVkD3/DKAMAQUVxEqb1hmdLSDgC4FTk/JH2OjDgGyUlPyMBtevT
         qcklQQnWqGaGpGS44OmpkkUF/50emjtaOqVcaa59RQBgzdibYAZUdACa/lh/ZOXdIc/Q
         HHTnVoBQ8c2BnvXD+hUDCYVQ468aoVbOZVVvZ6uB2TmWNwX9D6n00ZIr1kJp2tHbPYik
         J5t3mq5wCSX8t0+FvB9fY5VJGV7PoEnPOZzopopegN1dv9JXMTdyaZ3W0jN1H2/Zj4Pl
         pTu3sI1slQJYnuXyzeuWR4EN0sIjS8hiE4NJo8yhvYrTQIpO7EKFkEHnXEcrXJkccnwj
         iidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792945939; x=1793550739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8okjaHqjL4OJDz9RgzhtvzITY5sy3ytCZSHI9pXfkb8=;
        b=k3V4RD6W/6a9sQ6GICn8NBVKI+z8lNRxFcGz/Fm5njfU/8G13rn7L7G6eKV+rpQGsU
         Z6MV6PlN3MnfbQApJkMY2mh7w+0cWzcOStr/hfTeoa768Pbr74+TbPmIZJyGC1QXHxXM
         sjwZasvUUt3VVB5qVEbTNk4M9P0p/YLxbEfDg397SrjZ9/nDJs51FKjVcBIuObsC3++m
         5GSBTxAhs2cs7YqH0PTRzukhDbMOPbThrUXxBrPnGRlyfRzT5KpyQI3V/Wzs5hkfUhCM
         ECz8cmHrfN5FFeCPum6nmvYrCdSWVASUDqww1gAl2GHQkik6bREeZ/2GC42Fb74kaquu
         W/Lg==
X-Forwarded-Encrypted: i=1; AKwUvByDfcYMmwNHpNE+Ti4hB5xL//6PvPwq2EGJRKbWhyqwIwhpYBmjM9qtPeRdBKbSOejTn/p4USw=@lists.linux.dev
X-Gm-Message-State: AFq9FYLZ5z/UdlJsoymJPgXyaghjXsQg1hxOMSnXhMHKkzIhxAOE4GA+
	DlFmppTU/OKaO6gdIHZn1BaZLHMMdsq3cwUxFXOsEu3rIRYikvkd9Vz8
X-Gm-Gg: AYBFou2kvvqqhyaiyYyMtnkxa3Bn4ctWFPURqAKOoFGxcSeQAM33+hFlJkeeWz3FAU0
	9u7ozaJISuS9WM9bjogWo1w4862GFnTEbgoWi3f26O+lWwVH4E0qayahcGKXZviDysDL7UJgtb3
	Tjhsl+FaxsnpeKlZ//4ni2g9dtX7RMrMR78H1QB+a7mJRG/87yipbc4O/8lmU7OQQaWN+3+ekfh
	zHCoCWpQ4tvnImKL/D38g830RPcpiCQa6G5+sfQCFvpdpYXgR/ldMYWhji2xcF3dEt8VP4vX9cG
	Bggr7Hv8VCDFUA8BDkJe64R2GEO3pf3Fq+GEL+6M1iHiZ5Mh4FnrVZHW+27m/wyrIDVfqIHwOOG
	uYzsne1zi7w1xRzZKrQ00HA3eVDJavMCsXILMmKW+o2AcqHBO4qLronhBYOqeO1hkFw5i9uFRue
	uYVpDg+WtUiXS4qKE4XJRc43zBr2H/Fv9otXiV/GgA6eehJ8kj1Bk38uvkdar+skEAVsTPDD3I7
	aassNNRaLho7QMmCk/s/dvgzvzWIGrUpoPVH7wmpgV+LlgpbqCFYib83rJkG3Y/fzGF/fAZ
X-Received: by 2002:a05:7022:b051:10b0:151:d6e5:596b with SMTP id a92af1059eb24-1993571a0abmr7277044c88.9.1792945939038;
        Sun, 25 Oct 2026 09:32:19 -0700 (PDT)
Received: from asahi.tail4da9e3.ts.net ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0f83cedsm22025164c88.13.2026.10.25.09.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 09:32:18 -0700 (PDT)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@nvidia.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Baek Kyu, Kim" <pocj8ur4in@gmail.com>
Subject: [PATCH net] bridge: cfm: keep RX work disabled while CC is disabled
Date: Mon, 26 Oct 2026 01:32:15 +0900
Message-ID: <20261025163215.62509-1-pocj8ur4in@gmail.com>
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

Found by reviewing the peer deletion workqueue fix. After CC is
turned off, a valid CCM can still reach br_cfm_frame_rx(), clear the
peer defect and restart its RX timer. cancel_delayed_work_sync()
only cancels existing work, so a later receive can queue it again.
The peer may then report a new loss defect with CC still disabled.

With a bridge/veth setup under ARM64 QEMU/KVM, disabling CC after a
loss defect and injecting a valid CCM reproduced the restart. The
original kernel reported another loss defect; the fixed kernel did
not. A test-only gate paused an in-flight receive until after the
disable ACK and reproduced the same difference. The gate is absent
from this patch. The reproducer passed with the fix; bridge selftests
were not run.

Initialize each peer's RX work disabled, enable it only when CC is
explicitly enabled, and disable it synchronously when CC is turned
off. This also prevents an in-flight receive from queuing work after
the disable completes.

Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM frame RX added.")
Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>
---
Tested under ARM64 QEMU/KVM using bridge/veth, netlink CC settings,
and valid CCM frames received through AF_PACKET. After a disable ACK,
the baseline queued RX work and reported another loss defect; the
patched kernel rejected the queue attempt and reported no new defect.
The same difference was observed when an in-flight receive resumed
after the ACK. Explicit re-enable and peer deletion were also checked.
No physical NIC was tested.

 net/bridge/br_cfm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
index 9dcc97d63a6f..8576f387d037 100644
--- a/net/bridge/br_cfm.c
+++ b/net/bridge/br_cfm.c
@@ -150,12 +150,13 @@ static void cc_peer_enable(struct br_cfm_peer_mep *peer_mep)
 	memset(&peer_mep->cc_status, 0, sizeof(peer_mep->cc_status));
 	peer_mep->ccm_rx_count_miss = 0;
 
+	enable_delayed_work(&peer_mep->ccm_rx_dwork);
 	ccm_rx_timer_start(peer_mep);
 }
 
 static void cc_peer_disable(struct br_cfm_peer_mep *peer_mep)
 {
-	cancel_delayed_work_sync(&peer_mep->ccm_rx_dwork);
+	disable_delayed_work_sync(&peer_mep->ccm_rx_dwork);
 }
 
 static struct sk_buff *ccm_frame_build(struct br_cfm_mep *mep,
@@ -695,6 +696,8 @@ int br_cfm_cc_peer_mep_add(struct net_bridge *br, const u32 instance,
 	peer_mep->mepid = mepid;
 	peer_mep->mep = mep;
 	INIT_DELAYED_WORK(&peer_mep->ccm_rx_dwork, ccm_rx_work_expired);
+	/* Keep RX work disabled until CC is enabled. */
+	disable_delayed_work(&peer_mep->ccm_rx_dwork);
 
 	if (mep->cc_config.enable)
 		cc_peer_enable(peer_mep);
