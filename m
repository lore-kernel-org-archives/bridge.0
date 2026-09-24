Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBA043CEC8
	for <bridge@lists.linux.dev>; Thu, 24 Sep 2026 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238604; cv=none; b=W9mu1jxQhQaJsKDjOKJThARXzORMa5jlLrd9oLcQqdTOcRNIH458/Eq7TehLmThnCsN1KNlpMn2enTlf6FiT55XRBXBxsWMInlVV73x6C1sReSx/vPTE5KMrGFkPdCeuiyO9o17qaKEGVo4kPswxBJI352hStc54XKkH+Ab2cfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238604; c=relaxed/simple;
	bh=xRa9+XhnH139UlMz9q8QC4ImWbH0adT67Z5A84Y4dfA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QJxUZ/EOD9RF5OT13QGNz5wvAuFlpmnBkyKEXepP8PJO0KjvC5TFK5wGHi81amxV5/13jsDUgBLv3+ZXSTLIK7AW8d/AyCL3Qwkowm01Ta2xmF0jk0t9oD0ulEZRbj+aM9FgXGixOaCcHE9uvkJHZSNU9vjyoPWET/DWz2Jfx9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qv4ajWjk; arc=none smtp.client-ip=209.85.160.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qv4ajWjk"
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-532dc3793easo11692981cf.0
        for <bridge@lists.linux.dev>; Thu, 24 Sep 2026 01:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790238596; x=1790843396; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VHG5LsKzXWnAQza+czJEgZBibMlnELCbqoybOyO8YD4=;
        b=Qv4ajWjkRczocbDKEgXiMXAnxdiiWXxI1HjipDF925peAb47icVDOJlWzooYKUSTpd
         HYZO9/N/xYId0jgcP+HTpwwGVV6HrPQ6ook0xxwwCTz1YcaUmF0HwXR4px64E59gEbIJ
         V6m71MbqXixfQzTjOI6SKE2uKE/9hbyLCwA+GsaT2Qhz9ZuBXGKJvv7IX5O1KMccAgzd
         a+jVSNu3oxyEgqeBGKmhWPQMdwh3qSub8QdXqW40d7hlzCU0aPAiiorbJ7JNQ+0wYN7U
         x0tzyX5+vAZ7KK3HDM4tTih7g8ellEolTnSqLiD8hphXq3boDBY20Obq+52RTFVWg+SD
         dKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238596; x=1790843396;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VHG5LsKzXWnAQza+czJEgZBibMlnELCbqoybOyO8YD4=;
        b=on6ANo8FYhPOhVSMYfRYC9kXTG8lD5x/E/YKqJfD3FJmzBzFXCaE6n6ivu52+KCKRe
         Lllmm8bfSzQHjQIU1L7L9WbQ04VC9+xY8+PD4A6sujfh67fVq4ApbBt23RfHsdlstG2R
         DnYfeSPj7KSM+Pe1/KEc18k4Wq74WaqHYczVRtecnN67kA224F6tnH2vC+um/uLKcoUI
         hmxX47RpWYsOvHalETJ2Xj232fOPNCBPwIsSp9SGql9tAOrci8i8I6yRZoDrtL6POSjd
         DTzZvfSRDDxY/EbTNC7tyHLWpyqDkEfXIm8K+/pzn60gfIrf69sw6xFUZohW7o/TSSFW
         1n7Q==
X-Forwarded-Encrypted: i=1; AKwUvBxnhprHta/liZtBAjEmIe/NfTKi0eVICH/jxYwtqhYP0D5tOmgvM28R7QslhuWtJv2gGMTDhGk=@lists.linux.dev
X-Gm-Message-State: AFuF++k2RZBZof97ZsBC9NRYGk0bMWlNkLvyCM6isbvD2cK1HUKAt3Jz
	LsSpnv2nrQUzAxlABuF5ngnEuo5e4GxKcSZ2l6nZChx4pfEv9LPF0QH24aLHLe0CYiRun8KVVab
	RHP4eW0DBwpQ1eg==
X-Received: from qvae6.prod.google.com ([2002:a05:6214:6206:b0:914:1dc3:df5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5513:b0:52d:6f91:86e with SMTP id d75a77b69052e-532fea5306emr11751091cf.15.1790238596027;
 Thu, 24 Sep 2026 01:29:56 -0700 (PDT)
Date: Thu, 24 Sep 2026 08:29:49 +0000
In-Reply-To: <20260924082951.1599377-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260924082951.1599377-1-edumazet@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924082951.1599377-3-edumazet@google.com>
Subject: [PATCH v2 net 2/4] bridge: check llc_mac_hdr_init() return value in br_send_bpdu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, edumazet@kernel.org, 
	Eric Dumazet <edumazet@google.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

If llc_mac_hdr_init() fails (for instance if the port device type does
not support LLC or dev_hard_header() fails), br_send_bpdu() should drop
the skb instead of resetting the mac header to the LLC payload and
transmitting a malformed frame.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Closes: https://lore.kernel.org/netdev/179022851638.2160803.1808206741379444999@kernel.org/
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: bridge@lists.linux.dev
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/bridge/br_stp_bpdu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_stp_bpdu.c b/net/bridge/br_stp_bpdu.c
index 74ec42ba1e7d086cbfde608c93f5fa24d6b4ed7b..21d092f5acbb81f1d0ccd80200cebdbda722f4bf 100644
--- a/net/bridge/br_stp_bpdu.c
+++ b/net/bridge/br_stp_bpdu.c
@@ -52,7 +52,10 @@ static void br_send_bpdu(struct net_bridge_port *p,
 			    LLC_SAP_BSPAN, LLC_PDU_CMD);
 	llc_pdu_init_as_ui_cmd(skb);
 
-	llc_mac_hdr_init(skb, p->dev->dev_addr, p->br->group_addr);
+	if (llc_mac_hdr_init(skb, p->dev->dev_addr, p->br->group_addr)) {
+		kfree_skb(skb);
+		return;
+	}
 
 	skb_reset_mac_header(skb);
 
-- 
2.56.0.rc1.310.g51773c2048-goog

