Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B47207DF8
	for <bridge@lists.linux.dev>; Wed,  5 Mar 2025 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170607; cv=none; b=L7oV1w+xOE3Joh8c0LY9MpAG81ymRx21Ahj3uA1tYcIVwfnKhoxBz4ZgVEz7LgJdF+FFW1znO+SgVXquFuntLxDzKHj4oTF2cwMZkrAHdgFek+xv99SielEeVp7/YzR97219Ry7TZMnjiGKanFZ+CXQ+qeIiWcvTdy5ttAUeN9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170607; c=relaxed/simple;
	bh=4chn1/0IJNSwJ1oT95Yplw/ROsSLsSsjiBPzOuAxsgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLuf036whkFwBSP0IDKx3sKFmlcUIAzONFQhVMPEqR3H5ucJWzRLSLDTMSYpIdOvMF0K83mUeWwyLzbTTJrOrv+07vSP56Y2a+f4ywxEEJOl/dANO5NxCWQeHhqoFYmFI+vjtUTJlKVUik+JW1XfwjX0n4n5Tex/x+lg70pBg5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXS6/KnV; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXS6/KnV"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abf5358984bso664591066b.3
        for <bridge@lists.linux.dev>; Wed, 05 Mar 2025 02:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741170604; x=1741775404; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWSHNbB5JKEbeWuUj8vjDFfUx12Bd6PhpeoYLsDsQTU=;
        b=VXS6/KnViCdi4V7/lQjFa5HNJhNjrpvEoawCV9n8WPFSRfe1iBvqbgAw82n71SCj8F
         NALsaTEJHvDrwZ7qjpgNhBnqodvKjTHkefGXBMSH2pz9x7L8gTV9/rdb6KYBXVLJ69lD
         0BGany77I5OB/liq5XLguh5Q0bEqyj/BZMDMwyFfDHm62e6OoTwviadni4ioiqG5gCIJ
         An/DFWdDxL0bxfrUWEYUnNAdhHSLzx/l1kxsJpDDQOt7h++uHOSvkQg4MfoH84U7NmWP
         ZlQliGhFwxHh74Iy7eFZ7IpFQ8WSjPlhoyXCmuN3UzfUE8ffEPP/LRuc61k47Yir+yOi
         PZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170604; x=1741775404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWSHNbB5JKEbeWuUj8vjDFfUx12Bd6PhpeoYLsDsQTU=;
        b=fHBiIsjduUA+mzu1ecwSk8xdWVcq2+1bbUKjxEYJTD9ur3Z3kIGJvf0JA06OI9tNtf
         aD4pF2gJ+JxJzRwnrfD1hBQDxY8VI/SfXyXEewA+gsi4onnXwdjwpxQD2RB+bZFDZbX4
         9Q1+FNU3Ivr4PjiDHyfAbsH5kyv2UN4djBql5Ocke+Zs4EOPYAMUrK9nTApys+HgoE2E
         zotYTQ+sVSIAYSfsY40SR6XK+lj6rafzknh8KQ7pMAFg7P2xLR8X6SVtgCBi7oIDShVy
         7rwKqq4jxwj4EaXrqm1iMrA3TK3/ZG219Ir/gcWqlIjQMmw5OsF5sEqOSnaMcFQ5WKai
         k9uQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4IZVACtxiOiiYhJbL0Inarbmappe50EBXdQ05lIp2v8zGeTuAnbE4UAoUZDJ18g/JSInO0Yw=@lists.linux.dev
X-Gm-Message-State: AOJu0YzZKaRXncLlIjBJUAX1X4D9gmKxey/43Qu6qWCG9DDkC4YaQ7UB
	Olqr/FyOk2Y4b3CBLBlObnwDZqQ/CzXjB9ZEHjOg2Dmy00LS+hnA
X-Gm-Gg: ASbGncv3fTXTI96Tr7ZcnqfkI8YzPXzk5nt5ttuEDirSjFWiD3gbUb1toCDkKEpHdCV
	LBjWtH40izqJxMhBPW7Y6Pph+I+mrJB2kkxYTdBbZ80Q2KfoOL+IkD0Ru+qYLGpZgMhk6mfbT5c
	QqlS5wEQsLe1UrYgrGGlrk1dfT5d+5JaB4pDGAfR/3JN0anh+lJLh5p1MylSa1ooqbjkFOrMwPw
	0chbPV4sOqFXBj8ebtaZ1PKb58MniGxjPAgmYImrfIBozGUphK5EJKwIBFvrbfvNjIxpEo5m5Qf
	PwFnI3Ev5zyYRel40pR8BFbzl7wEQQESNcJlQo0ZVXVyPCpGAngTGmsuBw3VgJUutkDbgAiMvtE
	ev4NwqVR36zn9D/UDxz4MvOKvKc9lPUzkiSwww9o0IPea4dxpmFRLBU7UbneuDw==
X-Google-Smtp-Source: AGHT+IFmOl+znPOCyIBVoWXbUGUsHEWWessyONqSdjDiGli0zSAoB+kKDiPnSaw44bEm0nFmaT3VhQ==
X-Received: by 2002:a17:907:3f0a:b0:ac1:ddaa:2c03 with SMTP id a640c23a62f3a-ac20d036458mr300465466b.0.1741170603887;
        Wed, 05 Mar 2025 02:30:03 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1f7161a4esm247154266b.161.2025.03.05.02.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:30:03 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v9 nf 01/15] net: pppoe: avoid zero-length arrays in struct pppoe_hdr
Date: Wed,  5 Mar 2025 11:29:35 +0100
Message-ID: <20250305102949.16370-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305102949.16370-1-ericwouds@gmail.com>
References: <20250305102949.16370-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jakub Kicinski suggested following patch:

W=1 C=1 GCC build gives us:

net/bridge/netfilter/nf_conntrack_bridge.c: note: in included file (through
../include/linux/if_pppox.h, ../include/uapi/linux/netfilter_bridge.h,
../include/linux/netfilter_bridge.h): include/uapi/linux/if_pppox.h:
153:29: warning: array of flexible structures

It doesn't like that hdr has a zero-length array which overlaps proto.
The kernel code doesn't currently need those arrays.

PPPoE connection is functional after applying this patch.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 drivers/net/ppp/pppoe.c       | 2 +-
 include/uapi/linux/if_pppox.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 68e631718ab0..17946af6a8cf 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -882,7 +882,7 @@ static int pppoe_sendmsg(struct socket *sock, struct msghdr *m,
 	skb->protocol = cpu_to_be16(ETH_P_PPP_SES);
 
 	ph = skb_put(skb, total_len + sizeof(struct pppoe_hdr));
-	start = (char *)&ph->tag[0];
+	start = (char *)ph + sizeof(*ph);
 
 	error = memcpy_from_msg(start, m, total_len);
 	if (error < 0) {
diff --git a/include/uapi/linux/if_pppox.h b/include/uapi/linux/if_pppox.h
index 9abd80dcc46f..29b804aa7474 100644
--- a/include/uapi/linux/if_pppox.h
+++ b/include/uapi/linux/if_pppox.h
@@ -122,7 +122,9 @@ struct sockaddr_pppol2tpv3in6 {
 struct pppoe_tag {
 	__be16 tag_type;
 	__be16 tag_len;
+#ifndef __KERNEL__
 	char tag_data[];
+#endif
 } __attribute__ ((packed));
 
 /* Tag identifiers */
@@ -150,7 +152,9 @@ struct pppoe_hdr {
 	__u8 code;
 	__be16 sid;
 	__be16 length;
+#ifndef __KERNEL__
 	struct pppoe_tag tag[];
+#endif
 } __packed;
 
 /* Length of entire PPPoE + PPP header */
-- 
2.47.1

