Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0013D35BDCE
	for <bridge@lists.linux.dev>; Sun, 22 Feb 2026 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771790345; cv=none; b=LtQkgF0+7kD/nuQmlly3k4dvmTe/ErmVXcMbV2ycX4fPAB1z+OAZhcvlUFQtXsoqBfwYd/tlKOpEnpL8panq5a+ZEdkYWswKuHyVxTX5SpOs4YErO8mzXrbqFSxuBKX7+tOqWWZwpiPjlCvF02tQweKrTsuQCd8ZfHNyPv+MW2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771790345; c=relaxed/simple;
	bh=YUxeWiumDIevi3pfAqr7wG32llGuW6KcesoGqx9k/lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okUfaxF188HcUbIWrBLo6EE4SUEcxtMGMhWAyL7/iq+/r4nVBUZknterXoG9wckQjBhIv3J1EK9w46gknobuaJJQNWgu0h5TDtzb8/RlkSuo5McggqwWJsfnGRrklrFRJekL8AMVIuJN0MzLgAmUDMZrcfYbty70TqfM8H0+/mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EagIfpk9; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EagIfpk9"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8f8d80faebso664959566b.1
        for <bridge@lists.linux.dev>; Sun, 22 Feb 2026 11:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771790342; x=1772395142; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYuYJwbEOhynhWIFlwCSfc7cGmzyMZHQheg8tgUujHU=;
        b=EagIfpk9YHiTb2rMj1G2ulyBnAIg3V6+WK6hyOxUOaIowZ4VJJLKz5ZmdiIeyHeSCg
         K9ADTU2rTp9Ai8pGkxi6yaU4ePeVvRzgGDb8reAQrEHobgKoe1RgxWsnMKcTCM/bKaWD
         IevBMa01dajyM30U2r1ljCH7dI2tVzFL/SxtBJ6yL+eA+zT+K43/ijiGkiS7IEccI3Ow
         7fEz+10vLcaYh/NISxCSb8/K3D9Abst5fJwD5DCdF/ihEVB2cUQ8wgCW1j+3zkiy+xOA
         GtWIXlF9sUob59BXqcFu9iGK80Ej2vYrWjmiPm6D4/HVoKWnbDZGKoDK8Vtz5ZQgXQ0U
         4zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771790342; x=1772395142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gYuYJwbEOhynhWIFlwCSfc7cGmzyMZHQheg8tgUujHU=;
        b=Vptl5PymPu++g6nhW09drAennLBCezQ4NHhkRbHpqP66666SibW2k1ovUVYrWO2ntO
         WpAjI+p0n9azGUL86QHHdgzM5+hdAafn+MtzmafAPQGAl9XYBnF9ThkUDZ+jFzaFXvvX
         BlIisICFeRUfEpzemRA2mk3+R6R5LrNxa5heCc4OM4agboGg6xc2g76uPc87Ht+Fp/sQ
         RWAKbgasM1LX7sxKIMJx++poURgPq7Yu6gTLt6ebs2zuuO1L2oGRDkwQN7AX1iSL+kTj
         lU6fuVjIuwsHmD9Np2mKU1cmn8v+mXw7mGC099qtD4WNUmtCjGZo+ElTrEVvwIaI26YP
         onRg==
X-Forwarded-Encrypted: i=1; AJvYcCWkihz9lXusQSYSyh2E3dLJ+oyAfNJHf9N2fgK2Ry0nDg+e7AUt+XcziJMzScsjyO4cPrDePNE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzfqg24aupSq1RZx2ZacQBQZqmAfJplhYweYbIFjk29w13j1UxF
	tMt7jWEK0EfeyU+15gAoJgJMKt+drfSUMTh+nyRybBJwKD1yvXA050f8
X-Gm-Gg: AZuq6aJnfAtJFsrXEq9q3USJaDLLrTe/EMeg1mlbHgBA7KFkBth0LdEJwfK/FfLU2xA
	gzjb+bZORnf0rw1KbvUs3n8g80jeUxCh4I5jo+g96fvKl1U4SvHTRRtp2obS3j1kOxRbKuH86QB
	KBozd9fTxOI/lrTInb8NyVjnEk05EgZb9ArmboHHNkXaCLykhC7G59aU+IIraLLDn3PXvlmiSl9
	Uv7Dda0tA2W5FQI9VI2gCVQa0B5vk5HvAOJEqwJ9xhz1aHeiCE/wypFy3Bd64SphzYgtsmQ5SnM
	QU5E7f9z/9ZqBs+Yw49k6Z8dahV7wnCmKhHTXuc0Nbta/CuJldT/bD05uZjKWl780HjYU6Uatpc
	xVJjkaxS7CLutR7jnhl38QTbnadJStniIrXE7P0ncj/ONVnkgioYNjNqr47ZSiy5e+vHDveAakU
	OgRcjUT+7WguP7KuWu4yI++BQ1SLCW7j3bne1AjEFCowWHOXkmzuNnRyrqPjhG5meL/jJ6RUpD6
	DIxBiUqyc8/kMSsOZDvmTO1M8E0XPls3L0Mc78Idj9f4hCGVxmZolu6LXiWBW1+PQ==
X-Received: by 2002:a17:907:2d25:b0:b8f:c684:db3f with SMTP id a640c23a62f3a-b9054196076mr677551666b.12.1771790342007;
        Sun, 22 Feb 2026 11:59:02 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084c5c514sm246125466b.5.2026.02.22.11.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 11:59:01 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
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
Subject: [PATCH v18 nf-next 1/4] netfilter: utils: nf_checksum(_partial) correct data!=networkheader
Date: Sun, 22 Feb 2026 20:58:40 +0100
Message-ID: <20260222195845.77880-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222195845.77880-1-ericwouds@gmail.com>
References: <20260222195845.77880-1-ericwouds@gmail.com>
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
index 008419db815a..4f8b5442b650 100644
--- a/net/netfilter/utils.c
+++ b/net/netfilter/utils.c
@@ -124,16 +124,25 @@ __sum16 nf_checksum(struct sk_buff *skb, unsigned int hook,
 		    unsigned int dataoff, u8 protocol,
 		    unsigned short family)
 {
+	unsigned int nhpull = skb_network_offset(skb);
 	__sum16 csum = 0;
 
+	if (WARN_ON_ONCE(!skb_pointer_if_linear(skb, nhpull, 0)))
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
 
+	if (WARN_ON_ONCE(!skb_pointer_if_linear(skb, nhpull, 0)))
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
2.53.0

