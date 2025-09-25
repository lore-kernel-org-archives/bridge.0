Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610D9313E3E
	for <bridge@lists.linux.dev>; Thu, 25 Sep 2025 18:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825063; cv=none; b=gH/MBwpm9ZF16uRKiuVYiMilAsBGHfs1CRuYp39DRi17HPaAGtUxSxAJFFFxJFkbleXOgv+0nUHqD+4hTlZ/IpV2hmVxCBfg56TT6UFSSIg1dZQp8PUlJ6p3n3VstPoyN83V5TnYbchWxuZ1V015nW/81s9It30i7iCjRjP51Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825063; c=relaxed/simple;
	bh=fdY4s91tI+lPau1JubbQ0x8fEYiPT2Mrr0LtPH6xCk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6+QxA/P8bvplXrfPTdj6QXajNiMR6Qx9nAMXdCUxOWnvjgbeChAlve9RyIwRd9frvb8RWsY54kn/eoNftOImL7fQI47tYnf3U4ugscz5Njvt41lPMFl0UzLy1XOOVMAvW1kTLQiqcenc1PSlOkFhTCyDrbV69yZekUA63WFfD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQk/BTrh; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQk/BTrh"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so2552318a12.3
        for <bridge@lists.linux.dev>; Thu, 25 Sep 2025 11:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758825060; x=1759429860; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+3n/wt4G7GIqXmLm7jMx2L0Drt9lvIRoMC4cC/d+Ac=;
        b=mQk/BTrhSU/ac6t896ThzzULRc2HVj4fSwcA7o0ftWHisQ+q7iqFfMwCWy0HinXYGA
         QKmNzBjqtNVf1yErFsGW+lAaXRIEI2d3L/e5VIZWuKZD0eYleZds3mNydmeHi7i5XPTt
         BJ6SiWYsSATxqSOqunxmVx/lhZthJ0/I7N7X2bWPTYTNh6WI0S/lSavRp5ANs4zpmXS5
         iLQz+Z74rVURYVtj0vCo2qoMJB0GrrPgiRZlV4alGku4cNgzlayMpQSruITwbMTN0vVP
         9ukMI9Q3RTbQHFzvZnL50xDz/ACVdgtCsG19w7l3lHs5t+TtyX/ZaQi6CjwHOi25eAc9
         U3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758825060; x=1759429860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+3n/wt4G7GIqXmLm7jMx2L0Drt9lvIRoMC4cC/d+Ac=;
        b=IAVobYHFWtxIxKWKb+M3mMmJkRMeZWhTo9BriYCJEW+AkKETOoeEG6TXSS69PHfyBy
         LDjUzW+uWPdR7mZoq7E2e1Iiw3IEfdT66MNM7gaIzoLfD+vx6O/xnp9mD3fX52bd4E5l
         iDOPZr01BKZKoi1doCDx3pbCq7wRLo5DCjUVH70EWnbpoGEA7q6erkZyiQiq7OCo6IhK
         sSbUixvR0cbNS8YrFL5QrHDCYMyEIk29+vo3SFviRWk/f8CwzFBKjjeCsIYp+8H7J1n3
         8UL6wOi7QMRgEMarHJRfTljfL/JctFgryxEbLFymJV4EgGzMGEYzyFqoTEBk4R9DnIem
         UvvA==
X-Forwarded-Encrypted: i=1; AJvYcCWdKyogfGdz/wJAEFiPclI+mK+EHxTPJe552mgywNGPSql5/8Ih3lri/rvQWZtxowr6Je4j7Qk=@lists.linux.dev
X-Gm-Message-State: AOJu0YyeGTKY1GdET95UB/P3MgZ+YiDWE0Kr1jvdUnUHUrgewWU7KAtp
	o5iB0LF8jqvxBtjvvjo/xS1ho0Sg3zrfffuaj4XqrPJqGiWdTEhqP/kb
X-Gm-Gg: ASbGncssg6HwS6oVXMsog5buz1dTmgV/B9UZomHEBlmh8Z0e7HiYGiUYslJ8iliY7Uh
	5EYpb0LArQN8KjNP+W8C/ax2Qk8H8NMX4F4yFqAm+l5YSB4UX34VN1nvnmn7W0lSE5w2NuzhMhg
	rKLrKg8eaLILOTHwFhV0TZxnUzvehbbbcBtJxF14qQYnNIFfpiD/CSeTmwc1O/rQ3HFyhIkZWz9
	kEB8RbL07ZkQs6ucqBQW7njtpCDWhwz2IPjT/2ix5H70Hy2dKXi+5K6UoYHTP2Berm+BUCyisK6
	3AFiU/tKseys0lHwPnTaXzb2WwpVZlJWrWj7rk98CE+LiBaQB3xT5TMtsu9y6EGrbB93qbSE/9D
	fuhr8fSMuqqkPARDAILM1pKBfmm3KJ3LGLrjyx5M4rdW74MvWx03zvIX+4knkycNrNtqFjfV6MX
	JvNeze4C8XYABWv19HPw==
X-Google-Smtp-Source: AGHT+IGAa02mHOQA+yISRuVyAiyglwnY2AxzVt78/ebOCI2IUEbTqhhH5+ovN3xQr0fSLhe5oRXbZA==
X-Received: by 2002:a17:906:f597:b0:b21:6dce:785 with SMTP id a640c23a62f3a-b34b7209d39mr472920266b.1.1758825059575;
        Thu, 25 Sep 2025 11:30:59 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3545a9c560sm211198666b.107.2025.09.25.11.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 11:30:59 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v15 nf-next 1/3] netfilter: utils: nf_checksum(_partial) correct data!=networkheader
Date: Thu, 25 Sep 2025 20:30:41 +0200
Message-ID: <20250925183043.114660-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250925183043.114660-1-ericwouds@gmail.com>
References: <20250925183043.114660-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the conntrack hook it may not always be the case that:
skb_network_header(skb) == skb->data, i.e. skb_network_offset(skb)
is zero.

This is problematic when L4 function nf_conntrack_handle_packet()
is accessing L3 data. This function uses thoff and ip_hdr()
to finds it's data. But it also calculates the checksum.
nf_checksum() and nf_checksum_partial() both use lower skb-checksum
functions that are based on using skb->data.

Adjust for skb_network_offset(skb), so that the checksum is calculated
correctly.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/utils.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/utils.c b/net/netfilter/utils.c
index 008419db815a..7b33fe63c5fa 100644
--- a/net/netfilter/utils.c
+++ b/net/netfilter/utils.c
@@ -124,16 +124,25 @@ __sum16 nf_checksum(struct sk_buff *skb, unsigned int hook,
 		    unsigned int dataoff, u8 protocol,
 		    unsigned short family)
 {
+	unsigned int nhpull = skb_network_offset(skb);
 	__sum16 csum = 0;
 
+	if (WARN_ON(!skb_pointer_if_linear(skb, nhpull, 0)))
+		return 0;
+
+	/* pull/push because the lower csum functions assume that
+	 * skb_network_offset(skb) is zero.
+	 */
+	__skb_pull(skb, nhpull);
 	switch (family) {
 	case AF_INET:
-		csum = nf_ip_checksum(skb, hook, dataoff, protocol);
+		csum = nf_ip_checksum(skb, hook, dataoff - nhpull, protocol);
 		break;
 	case AF_INET6:
-		csum = nf_ip6_checksum(skb, hook, dataoff, protocol);
+		csum = nf_ip6_checksum(skb, hook, dataoff - nhpull, protocol);
 		break;
 	}
+	__skb_push(skb, nhpull);
 
 	return csum;
 }
@@ -143,18 +152,25 @@ __sum16 nf_checksum_partial(struct sk_buff *skb, unsigned int hook,
 			    unsigned int dataoff, unsigned int len,
 			    u8 protocol, unsigned short family)
 {
+	unsigned int nhpull = skb_network_offset(skb);
 	__sum16 csum = 0;
 
+	if (WARN_ON(!skb_pointer_if_linear(skb, nhpull, 0)))
+		return 0;
+
+	/* See nf_checksum() */
+	__skb_pull(skb, nhpull);
 	switch (family) {
 	case AF_INET:
-		csum = nf_ip_checksum_partial(skb, hook, dataoff, len,
-					      protocol);
+		csum = nf_ip_checksum_partial(skb, hook, dataoff - nhpull,
+					      len, protocol);
 		break;
 	case AF_INET6:
-		csum = nf_ip6_checksum_partial(skb, hook, dataoff, len,
-					       protocol);
+		csum = nf_ip6_checksum_partial(skb, hook, dataoff - nhpull,
+					       len, protocol);
 		break;
 	}
+	__skb_push(skb, nhpull);
 
 	return csum;
 }
-- 
2.50.0

