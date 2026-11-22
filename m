Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795369235;
	b=rhIilcSvx8OHRHlCYYIv5YvFBjBm9Pbow9W0G3yjxDLDPJFQYWIO77qqYpSG+EfY7oct
	 luwJuYg2WWd4Z8WxxAI9PAhWcm/8vMrsSCvDd6J4N8y6xw8PYbwpw8Syj/FZL2fFD2ybm
	 6SWZ8qe1VL9YwY2VmhVWUQEdkQ3WFPkjVPF91v1LY21oDmo/fhXK+PuDkiVMbePKuojNS
	 LQoTfQu3epKzHSLXW3KKJK6m5cbx0unbmBPxpuch0PNj1D8+nXhWTLxAr1v0DTp1TBWD6
	 oav0S5P+eIFLDlLSjsgsUGhyxaA6ZR7QfH/txarBYqU4kJAUYPdqglEnArFqlZuLDJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795369235;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yPdKG5WPu+3iWpOj22rT3wMvk9NwYQ6zarXMQgCV1vQ=;
	b=EkZr/OQ3Yxzr5xL+unpcsNdvUuomP6KWl+n+h9xaTUJAiS5jgx4e0QbQxFMle7dJ9BXD
	 BTWKA/1qwXmRGXdmRf011WIIBtq+8EZVnTO0R5wzMOvqKE+Gpgy/rSQYGr+kj9GEhQgbO
	 l5ryUzfaq5smUsLr9wRAcUYt0ZvIkwNQsdIaV0MgJGAxK1KsjqDOU7ouUanzOwjyjh+Y7
	 NTUJK+eWpJdZItc99FjIwA1MtlcMiey2a4BNqJWBu0MgVcOgyWS6Cz90ZCz57iXDlMucL
	 adLdyfSo+GDgvJflWgAWQkdr+MfrL8lHpyu7ElEypSfCMx/JJAk5hJJL40cGGL6ZG8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=mXJtKxVX;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D32A606A320
	for <bridge@lists.linux.dev>; Sun, 22 Nov 2026 17:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D32A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=mXJtKxVX
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b876afbb86so3118567a12.3
        for <bridge@lists.linux.dev>; Sun, 22 Nov 2026 09:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1795369234; x=1795974034; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yPdKG5WPu+3iWpOj22rT3wMvk9NwYQ6zarXMQgCV1vQ=;
        b=mXJtKxVX+0UHP0p+j+wNbLJxbMByKx2MBXAaWEuj7nBT4X7RJur/uK5iEsTvZk/kdB
         HKBQL4jBaptBSTQqLU9JgsNqGogaozX+mj4LGqMOrfEbseud/hr/3fsv5dK0J01U41jz
         TYg2skWbI5wF9XD7YDZsmeNiG6+123Dvo6hqDZ4hlLZ485yCMmdZqkJXDGGzcjGK64EO
         2uQYvQ0NqtEC1oj3UdqFgZI/GzkW5Zry+PjZ/TXpmRDakcChSnB/vE1LLGkJdp2S2PjS
         oHSJ5na8whdvSUzXbwCwb1anO6K6jgA64Yi2ByP1skbPjnd7MW/pHa2a6oqXu5+b7AEo
         fIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795369234; x=1795974034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yPdKG5WPu+3iWpOj22rT3wMvk9NwYQ6zarXMQgCV1vQ=;
        b=2TqKE4UbLQtcvVt5FgzEyfOZAt4TY47OWvXr4uFjAz7ZIVXTYMucucIAGH8ay98As0
         XlPbnSLMDAQqj0evk6/DLtWdUHVScU0+Uz5o/q76N906vDCdSb69bIfr8E/j2hLddVCP
         ddKqAM2fZb35Qw6RuU+6gtG5NiNEQySZow6VqZg0IYjT518qQybJpehzFiKxRK05/qQ+
         IKXvR/JmLKS4g6GGVO7Xf/ec2a7UsMmYJQlqUY78e6xaIjLU/jUqiuktTkZYa1Bhh3Dg
         f6ieyqAAprsG+QN2saRztxpcXBNbMwoQBfbLPftzhWkblQbmeKZ/Avl+N+sclZGBqLG0
         iAPA==
X-Forwarded-Encrypted: i=1; AL+hErEdrAviHy6aRYMGDjGzzodxbScz9K5csLKkZ9v0/ge7tbh/fB+PtKfXsIrbU4pNp28sh/gYSi4=@lists.linux.dev
X-Gm-Message-State: APuU4Z/VUmlWUJFa6zoP9iE7/r3XtBZVumBQq6EX+nXmRvoDxvgOR5RE
	Y9/mgZ4m4kvwdJTCvLYrQi0I3gzYpJ+FMZV/8kHvZaERRI6W9RBzn15Tkzei8Wk+Cg==
X-Gm-Gg: AZFdTZdGJkMUJiqhDQFM+03U2ODQDm/HZCo0b3e2SRX7GIAdCwWsoUs/hPw0SxX42SR
	G/BCJnDf9WSuptUEJG8Y5mRJsuAUl11TgbLka/VHq67w888rKAY7EZeWEH71bkFUUkg2Vm4Vtpt
	g73Zacww/bykBomPEyPrufs5tkwGjioGCAGtNgl3suI42F+F7skF8UFl/RyltUHCAhK6HyP/D4V
	8A4JiAZ8jRWkOacG39ZGFfwLR5SPp8xOaS9u5FYWDmEa2EtJKwWgxhQGXU/EPOQD2rsh2juYOCz
	Oe5QPdoTdCMAKpG90KIKrF9VkbdO5DRB77eld3fDmf9HVNvhrwDdtwpGLQfdnKv7gL4uhfP/ugr
	wiQSOaGsfg8xmfj6M8D5CdM6BT4JRZf2EVAcrHJyDrshfof/Q52dqWd+HTnVbMm5TqOALGX5sMZ
	ldOl+QAffAtd36vF5YL4VU7y3mLCRa8XhIBILjLoeE7Tu01GsmkaijGoSnU4CkeuJpaBdgG+dAu
	kGy1j04uED5t7q3ZcKCMZxJ04nK30P+zUXgFf62X7lDQ9OaWpgyMgTkhnGlJX15MpVbcAxPv3BU
	rpdhVPCeOSEeCNIZ61GHl2qe/FneTtQ1bYIc4dBmC67qe78WD+YOdpjbLCZpgQdagWhnNBR8E5S
	wir/WDTQcSzEzryaWE/epynx0lp1wVP9KUq3R4inUUEfbCUfDA322Lbs49/QcqucLjwE0cAjqtm
	esy9NRvzENHNcyffljdBRQSkq4rv/rJHmvIDvxUTBFj8wsl7ggO65Od5IBhfc5jLcRwcxw0Mq1f
	gjFQrmzRYK7pNWgpHutM3RJqF3iCfl1NRYe0SlTtgP30mKnGUcMyFk2cRCmoVVEaF/MtO+ExCGb
	ul/VCMQH7OWd0xbTrwe+urdA8/av+lOW/bYmwEMCTwgccTZyXirZLkSrivdQyGdE41OWV/Qky5A
	=
X-Received: by 2002:a17:906:1b45:b0:c4c:f85f:aa2b with SMTP id a640c23a62f3a-c513a817fc7mr555177466b.24.1795369233681;
        Sun, 22 Nov 2026 09:40:33 -0800 (PST)
Received: from Desktop.tail070c67.ts.net (p200300f247138c0090c03902c6657bcf.dip0.t-ipconnect.de. [2003:f2:4713:8c00:90c0:3902:c665:7bcf])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aeabdcbsm331656066b.46.2026.11.22.09.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 09:40:32 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev-bot+sinfo@kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	razor@blackwall.org,
	idosch@nvidia.com,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	horms@kernel.org,
	f.fainelli@gmail.com
Subject: Re: [PATCH net] net: dsa: hold the device a queued FDB event is reported to
Date: Sun, 22 Nov 2026 18:40:33 +0100
Message-ID: <20261122174033.968615-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179536905824.3294.1235394828103149751@kernel.org>
References: <20261122173347.791590-1-julius@bairaktaris.de> <179536905824.3294.1235394828103149751@kernel.org>
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

On Sun, 22 Nov 2026 17:37:38 +0000, netdev-bot wrote:
> - How the issue was discovered, e.g. hit in production, hit during
>   development, syzbot report, manual code inspection, LLM or static
>   analysis tool scan.

Found by an LLM review (Claude) of a follow-up DSA FDB patch, then
reproduced in QEMU with KASAN as the commit message describes.
Trigger: a non-DSA bridge port (veth, Wi-Fi, USB NIC) is unregistered
while an FDB event for an address learned on it is still queued, on a
switch with assisted_learning_on_cpu_port (mt7530, felix, sja1105,
rtl8365mb, mxl862xx, motorcomm). Impact: use-after-free read in
br_switchdev_event(); CVSS 3.1 4.1 (AV:L/AC:H/PR:H/UI:N/S:U/C:N/I:N/A:H).
Nothing short of the fix avoids it.

Julius
