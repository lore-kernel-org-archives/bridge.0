Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795403457;
	b=alHPwIHhAFaHDjGsXsLL5aP24IiC22bgAUs+QMtHAurawA66xhYAJ2sv2FBBx464E6dr
	 e18D/zSxveZ9fRz857bjqSMhRi/Qzi3nYBbsrVwm1SPaYt1KWbcrfoZ0kHecKYhT3DkcY
	 LwfUXJB8bLcTI/YgSGsidpCwJUslJRwV9mEs+Sv3heh2zXIVa3RU29sYZwyhzmefCjd/9
	 fiURyUj0KoB5KnPf8vvxvDt/YskQGuxkOr7kn9bguMcg+gPO/d74lfjCmlVBaYYjdP+N3
	 57L7QMqoL6CqEvm860FIZsjRB2m1G4BBrM1UWz3afQ6a53xAchJ8TOdulbjZ6J4KaYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795403457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xC8uNV0eir7OkjvnqZSoZuHi/kEMl+1aERjTTAXCD8w=;
	b=Dv9xn6fQzy9PzuenBtEPZTX3iUJ9rAPsrL3NsbrNKhVFLmxDvi9OPW8HPpnZcgysrfuN
	 LlJcMPGhkk5fw15dpKCkI4EzAO4zfxXQERzpfrCUy1cp0fLWsyK1KQESBdmHcpdWcqMhL
	 B+H85NjwSDQl7AlmuH/KFXYE49lQGhvUVPtnnQzsW7xWL6zD1DCxTqBbvFEuTGN5vxdQ6
	 ObrSGtSLEzOsCjNuDnVubx7H9qs7QcJtUCDHGcW76YP/Ac4D4lTlOGQzqGURhSysQKn2M
	 +SSoJNAixSJbqqFXF0MmvJjdLidqDvZbP5eUWZ6+Wa/NYAzOQ8NA70o4kLYXy32jTug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=Z58feEG7;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0A2606A31E
	for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 03:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D0A2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=Z58feEG7
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b5e5e64494so1471330b3a.1
        for <bridge@lists.linux.dev>; Sun, 22 Nov 2026 19:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1795403456; x=1796008256; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xC8uNV0eir7OkjvnqZSoZuHi/kEMl+1aERjTTAXCD8w=;
        b=Z58feEG7Bd3PfByOeLRu0UtPtHv38uCiiGvI7nC36w2rzSGRDTQHnyba0KUXmoYgde
         teoFemWQQ2ln19bdXJcDJbt6jU2lSSG7vq2ngAuXKEdNsbpa0FwIYAYhWsiI8BErVoRP
         iVogNKm+l2lT0yUiSlwoCgPeAfmUuvrUg9lUQ1iI0YdMWHc84xS1IbjOpBzVsBxAzmuA
         JTdIU29xcltOA2Usz6LllC6PKlFcaG54d5Wlk/cBBHpW45zPb5zQu3hRZ8no2e93qLk9
         yETobl6Nl9e4tqPvV0f15/GqVT3T8YxtNHVnT+7FmeilQ8KYT4GdvK7Nmh6zOQ/lGr++
         5AhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795403456; x=1796008256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xC8uNV0eir7OkjvnqZSoZuHi/kEMl+1aERjTTAXCD8w=;
        b=0XbM0ngRRR2TuM+0WPyPIptfldecXzyorQ5Q0wadbSpvdUX/ERklFp0t14ykhSUbIO
         HGm9stPxESyrjjBDhBM5SlxIsjD8jaNd1WRk5V0fPYCaIIUMFq2G5ytIjW3SJ3ff5ZhX
         OpgHj6uspzv/4sK864qI3em9d/zKTAnssI+5AmuFGbG8NgzwapIhAtb/tDgGFuwIcTF7
         iLNdbNINy/AcgxJSVzf+13Pmx7+/4X3OMa2EAFjTetqgj17sWHuxT5CEcrWmpfhwWu+t
         18rwyRnUPVmE2H6HkpeRSmkVXW9KO7fNR66CZt6gX4LO09xld1Adnr4BORIVSXP0fO8T
         6Dog==
X-Forwarded-Encrypted: i=1; AL+hErEwSxCQ8mX7SazdijOF7GjefOV78jASfK7FyyeCXTgjXKx02q5IFBotnMmbxM1pq0YuXXJbpic=@lists.linux.dev
X-Gm-Message-State: APuU4Z96UdejB2VOjut/rXK1vDGZ/EGy6J3MPSN8Y2E8fbUuOquzFkCM
	xYsARQdHSHPiHnBCkp6YSLVOKKNdvHA8dTLFh9sba4+8ovuHnKph4yExXNrtS8oWEPRk
X-Gm-Gg: AZFdTZccVX/S3htEE9WjFdajPNAF4/nZxfTiiBwVmSr2l9M/CLEjtsflNuSdgVHxJvn
	/RJVN6A3w9DAnTDWU9ON7GFRXqdIIfXFpTQzB8zYYkbUslE4WngkaU1XqIpISpEMSSrnfIvABZj
	kTZK7m1K8b2e7wCdk7vM9HUOQi56RUAShS9xRGoFjJRv5aN7oGxZ3as+8toc6nNhu4b8aBauwM+
	zR5wAPvaVgxinuRYkTqZhPQ+nUWMX8KH3jb6Qy3aZ3kpOi6h37IIP/9wFUvYZQ75iUrB5bXFAfV
	HUuin+WtKVEthBIsgYTpsOjAcm5+ygOCR23D68f9CKJdotlvsSm1ZhalmD30ucvrAi7ZQNt6kq/
	ONHrFmMedpJAoWTTWDSEvDZp34X3d+w+VQ14R/byMAAwlL8p0Dd7FtYpnZ2U6+ek/+I74qaqfL3
	/4FonBD8rteHb6FVSoV6/QdnJWQ4N3rio7zKnAl4tVGKDpxWNzKqbHw7mmjbv9tSIaSc/qzHVJF
	SOPo4BaH8kU7Y7ZKw5OKAvkKIIJqwLDirWwDGA0G6RPtOpLM3f3HP3gZSZYsZAZwtVHZGeippk6
	wDJnnQQkIcyoKM7xZf70js3W+uibXnyLLaTYzYP8
X-Received: by 2002:a05:6a00:4c19:b0:8b5:f313:9f54 with SMTP id d2e1a72fcca58-8c87d32b35cmr8423896b3a.56.1795403455931;
        Sun, 22 Nov 2026 19:10:55 -0800 (PST)
Received: from enjou-Legion-Y7000P-2019 ([191.223.218.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87343fe6csm4826392b3a.37.2026.11.22.19.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 19:10:55 -0800 (PST)
From: Ren Wei <weir@nebusec.ai>
To: netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	vega@nebusec.ai,
	sashiko-bot@kernel.org,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH nf 1/1] netfilter: bridge: detach conntrack template on invalid IP frames
Date: Mon, 23 Nov 2026 11:11:01 +0800
Message-ID: <b2d3ea42b2d8d4d9c97452a123dd5f6c3cded1c4.1795348417.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1795348417.git.rakukuip@gmail.com>
References: <cover.1795348417.git.rakukuip@gmail.com>
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

From: Luxiao Xu <rakukuip@gmail.com>

A bridge rule such as nftables `ct zone set` can attach a conntrack
template with IP_CT_NEW to an skb before nf_ct_bridge_pre() runs. When
a frame has an ETH_P_IP or ETH_P_IPV6 protocol, nf_ct_bridge_pre()
performs header pull, length trimming, and nf_ct_br_ip_check() /
nf_ct_br_ipv6_check() validation before invoking defragmentation and
nf_conntrack_in().

If any of those six checks fails, nf_ct_bridge_pre() returns NF_ACCEPT
immediately without passing the skb to nf_conntrack_in(), which would
normally clear skb->_nfct and drop the template reference on parse
failure. Because nft_ct_get_eval() evaluates NFT_CT_STATE from ct and
ctinfo before rejecting template objects, the retained template causes
malformed, truncated, or wrong-version IP frames to match `ct state new`
instead of `ct state invalid`.

Jump to a shared error path that calls nf_reset_ct(skb) before returning
NF_ACCEPT on all IPv4 and IPv6 header/length rejection paths so the
template reference is released and the frame is treated as invalid,
even on kernels without downstream template filtering in ct readers.

Fixes: 3c171f496ef5 ("netfilter: bridge: add connection tracking system")
Cc: stable@vger.kernel.org
Reported-by: VEGA <vega@nebusec.ai>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/3cf187b612fd78f8835fa9dad870326ce380f82f.1785479514.git.zhilinz@nebusec.ai
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
Note on related upstream work:
Florian Westphal's series "[v2,nf-next] netfilter: conntrack: add and
use nf_ct_get_real()" (linked below) mitigates the downstream symptom
by making ct state readers such as nft_ct_get_eval() treat retained
templates as NULL (INVALID rather than NEW). However, nf_ct_get_real()
targets nf-next and is not present in nf or -stable kernels, and
nf_ct_bridge_pre() still leaves an unconsumed template attached to
skb->_nfct on malformed IP frames until freed. Resetting ct state at
the rejection site in nf_ct_bridge_pre() aligns it with
nf_conntrack_in() and the existing non-IP default branch.
Link: https://lore.kernel.org/netfilter-devel/20260923122741.30468-1-fw@strlen.de/

 net/bridge/netfilter/nf_conntrack_bridge.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index b5444335b86f..0da0f899edb8 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -257,28 +257,28 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
 		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
-			return NF_ACCEPT;
+			goto invalid;
 
 		len = skb_ip_totlen(skb);
 		if (pskb_trim_rcsum(skb, len))
-			return NF_ACCEPT;
+			goto invalid;
 
 		if (nf_ct_br_ip_check(skb))
-			return NF_ACCEPT;
+			goto invalid;
 
 		bridge_state.pf = NFPROTO_IPV4;
 		ret = nf_ct_br_defrag4(skb, &bridge_state);
 		break;
 	case htons(ETH_P_IPV6):
 		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
-			return NF_ACCEPT;
+			goto invalid;
 
 		len = sizeof(struct ipv6hdr) + skb_ipv6_payload_len(skb);
 		if (pskb_trim_rcsum(skb, len))
-			return NF_ACCEPT;
+			goto invalid;
 
 		if (nf_ct_br_ipv6_check(skb))
-			return NF_ACCEPT;
+			goto invalid;
 
 		bridge_state.pf = NFPROTO_IPV6;
 		ret = nf_ct_br_defrag6(skb, &bridge_state);
@@ -293,6 +293,10 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 		return ret;
 
 	return nf_conntrack_in(skb, &bridge_state);
+
+invalid:
+	nf_reset_ct(skb);
+	return NF_ACCEPT;
 }
 
 static unsigned int nf_ct_bridge_in(void *priv, struct sk_buff *skb,
-- 
2.43.0

