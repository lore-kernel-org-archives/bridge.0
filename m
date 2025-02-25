Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FBF3209
	for <bridge@lists.linux.dev>; Tue, 25 Feb 2025 20:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514594; cv=none; b=o868RxvzhoZHvk3HAekcF1cifwGZXKn6vWjd1po5OGeiABHgfUF5A3eEvQRjl7+JKR7be+E+9NezbBSzhrxLvFVPF5glTZxgWKLyqNj5zDDAYonc5fapEjoIaJYu1WXoJgpdgWP/0NN23sU0I5tV+mv7j+likT98NDW4u2dtpjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514594; c=relaxed/simple;
	bh=WOvVk2IW6QUSaxpGvpwW6W6ywpdv9Y60/i896yobQ+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqYAuQLUiJhvsSedNmQDS4i/ksRNFbIq7wlUjXmsNwm6z9psqEqW7mGQIODYmxfdZb9/TemEs5AtTqCoOHdKu+9a7ENPLZVyxQZmgNmvqfci9dLgMyIoSymD2jruNKJ6LmTy5M4oOAGpmfvwQFWKVE4ADoddxK7nMtR33zANXEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aj1zKW+L; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aj1zKW+L"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abb892fe379so911893466b.0
        for <bridge@lists.linux.dev>; Tue, 25 Feb 2025 12:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740514591; x=1741119391; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukwtTV0ExXBJKM7v4LhbJXSMG6hQJqW8GgzzDxNF23M=;
        b=Aj1zKW+LehKO3s8O4fnw1nqeFsjPKcIksaCI2LsPQw1CSv7HTDYulYzTYCZ8Uqo8iH
         d1RLd8HOF+5iz3ZPeTMu4xRNTqwJAvL8+kT3MHUObgvCxVJ4cH5cI8ZiI9VAM8QVSQAh
         1gzePGzQCjvuxjJf9wKGoKYb1HHJK9qcc0x+ajHoYZPTseDo0205I3j/Twlcb3nOvUZp
         P9pvOJhe469C43Mg/KUqAKWQN6ZhyHI2xClmtBsWM+kRm9toE2w+1DXUd3IVNIRAPN8w
         pSieuEhJA8AiTmkiWfgxNsDv/oStfJVXzE3GPWQ8xcEhjKslMeQHaNF79D/XMcdOHsjr
         6cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740514591; x=1741119391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukwtTV0ExXBJKM7v4LhbJXSMG6hQJqW8GgzzDxNF23M=;
        b=k67kgcwURMim3kBXDADj00Pl3VoEnLVDU+9OgFwlluJ33Xff620iNvI5SaQUlwjc/I
         uGI1EVkXzkjJvZ5mBLZa7FPkV7GLWBCzmiwTKPVPjjJk86hNf+PXlW9byI5KDqwLLwhM
         wDaiFYyy5xx3OblyFOh3AkgxU3Imjk3PJ4ec5NlzwRFhkOAAgzFDwxoZg+IG272nKkwr
         WqYiX0t18SwPvw1kbGuQjchuxjqnBFXwNAPfHy+OQAK0jW03titI9QGQzPwYnK78KXuj
         9kNUVIfbaeQkOwLfwKVWZ83DA6JHQAsVIXbqvwK1nOeXbCXUo65Yb70++jFAYEN2Coc1
         PG1g==
X-Forwarded-Encrypted: i=1; AJvYcCUysp7Iu41ZfTyr3niEccogmpuj3hJf7RSptaMtfuZP52lveAq9jBI9A+jgb9gTzuKQow9blc0=@lists.linux.dev
X-Gm-Message-State: AOJu0YxN58zP6wQg8B6EMMCkHNbPg71RvdO361fYnIkMOj8tlFZrgCsS
	ciSmaMICnP38qYLw8tKvNf2Pj6LNiemHN70bqudRv0RZ9xCZfUBZ
X-Gm-Gg: ASbGncvxGuufZ3xR0XcJbNylM66/IIhBfwlh1XY9dyHDlxHW7BKDG0iP6AAZ6EYF9kt
	OQ/JknV0BblLaNrMf6su9JRrHRB0969JFeSqNNLvWszK3mYUAdFfvGo1A3T8deyc6Pvh3tEPJdV
	iSxRPFvBh5K4qEQrkwz6qJzN614VT+QMLnFJ34s1pWs8IHGrL2NvGStu+w8h1gnjt+TF2tyrL6O
	PIS1pv3jHKM+3xCEsA6V+t8RbQZFBcGizQ0HM2mcM0qRcjRK5awZiUbDyqtt1943gqDMs/fepUv
	zHTDYcbAPq/Sv5LTZ7axDjIbBxhRg7XOoM8Hveg8ig5KokmwnVWOtJ3J4YmRA3ft3pAtJz5oyR2
	MOfKi/zWQ76zF0zxv3Yce0BvSAt1XX7EJjD1e1/xQypA=
X-Google-Smtp-Source: AGHT+IFELKJeBL47E24AYBhFNQB8kxvH4OvNCfLa7OLiE5g3zAvMls9N3TtS1GIRuC8kJEKI8Wmk4Q==
X-Received: by 2002:a05:6402:210d:b0:5df:6a:54ea with SMTP id 4fb4d7f45d1cf-5e4457abbc9mr11921566a12.11.1740514590457;
        Tue, 25 Feb 2025 12:16:30 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed201218fsm194319666b.104.2025.02.25.12.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:16:30 -0800 (PST)
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
	Joe Damato <jdamato@fastly.com>,
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
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v7 net-next 04/14] netfilter: nft_chain_filter: Add bridge double vlan and pppoe
Date: Tue, 25 Feb 2025 21:16:06 +0100
Message-ID: <20250225201616.21114-5-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250225201616.21114-1-ericwouds@gmail.com>
References: <20250225201616.21114-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the capability to evaluate 802.1ad, QinQ, PPPoE and PPPoE-in-Q
packets in the bridge filter chain.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_chain_filter.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index 19a553550c76..7c7080c1a67d 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -232,11 +232,27 @@ nft_do_chain_bridge(void *priv,
 		    struct sk_buff *skb,
 		    const struct nf_hook_state *state)
 {
+	struct ethhdr *ethh = eth_hdr(skb);
 	struct nft_pktinfo pkt;
+	int thoff;
 
 	nft_set_pktinfo(&pkt, skb, state);
 
-	switch (eth_hdr(skb)->h_proto) {
+	switch (ethh->h_proto) {
+	case htons(ETH_P_PPP_SES):
+		thoff = PPPOE_SES_HLEN;
+		ethh += thoff;
+		break;
+	case htons(ETH_P_8021Q):
+		thoff = VLAN_HLEN;
+		ethh += thoff;
+		break;
+	default:
+		thoff = 0;
+		break;
+	}
+
+	switch (ethh->h_proto) {
 	case htons(ETH_P_IP):
 		nft_set_pktinfo_ipv4_validate(&pkt);
 		break;
@@ -248,6 +264,8 @@ nft_do_chain_bridge(void *priv,
 		break;
 	}
 
+	pkt.thoff += thoff;
+
 	return nft_do_chain(&pkt, priv);
 }
 
-- 
2.47.1

