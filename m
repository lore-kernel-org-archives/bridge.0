Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795375363;
	b=rDojIKuiOOA5t3RY6kN75ZldPExuHkFLusZRhPtCzGitwmbfN1JTBnNIWunJi/CyqxRH
	 qf2uJA4mWp2/yosWzRGdaqXJXJkFyY0Om2HkLlr79jo7XEHzf3eE3wQOo65GThjtadvLq
	 AIEbZYKLM99DQ4BrTg3chYigGt9RhBDPeL/ygDLlORl71D2NasfW3hSGCU4KS+VC8730G
	 KZELUilaxhF5esjuLXuCIHgulcTkox8ls5BwNdh3GtpcoiqufQht2sLsMXIyARtR8P2Gx
	 7tzxNdcmRpGbrWgj63PmMWcE4fZkLFr3A8PLA2QY3NZdRs5VS2LRSETcfYelK8c+GdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795375363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=S37Kq7lpvR2YyR5RAVtCqH5zGZdjSyX6X5jAfIRmo9g=;
	b=R/veOgSPSSlHwegQm64ABQVOCsWd93sgq3NpW6k8nDkkCNN4UOKQCb4nHWmBc6WPXdqv
	 GwjOWf5HaVU4ql55ENRRvUWzaWZeoxqWtp5paPLxBNOwAWx59OSNfExQe2l8iEQd11OlH
	 oM0bVwmkMjfIPZVfqzdKL+LMCqpHuRQw99S/u/uT3zCnk/knvEvGrvJwod5ZFgeMMtYGs
	 NAUuQeRjJmB3qA09fXxYbimuA3ibuxK9PaCyYry+NWjvisu7dz8kgopqTiXvOOIOljYcD
	 XF7fVybLWiTdPzGkqYzSeNKeVYKiHmbSMBz3ffB+O6t1hQAQkhG1H+1Y/D6YVgmzSNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=newoYX9K;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F5F606A31D
	for <bridge@lists.linux.dev>; Sun, 22 Nov 2026 19:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5F5F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=newoYX9K
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4cdc606b47so441334166b.0
        for <bridge@lists.linux.dev>; Sun, 22 Nov 2026 11:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1795375361; x=1795980161; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S37Kq7lpvR2YyR5RAVtCqH5zGZdjSyX6X5jAfIRmo9g=;
        b=newoYX9K2JIqrqFXBQl7kCxY8bk+HwiwxMTlduQ3uu9OrkeRhpVCmxsHPoxu4mRhHz
         3EZNEOWKeKZyXbcml+wxl7/09ZZD4xRFkWT4JbQg86qBI4I3PYvgAO5eW1NBcKn4t4wm
         toK8mX5lDXWshp8fCnxyEMhOoXYkfWYRN22x8MDIKWDxClq7RUZ3hJaQnYCveYV2gW8q
         7ixEeot7Zcfs24UxBeSBHtBVw84DhWrYpH5qvjbAmfpC/BbHmKLdzf4aUUFUldyiBruv
         e0lMnbkUMYhAjTPVFslTHIdzggFFds0NwxYPnwKltx92/Q7W8ZzvNn48diJQbKrSe0V5
         pQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795375361; x=1795980161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S37Kq7lpvR2YyR5RAVtCqH5zGZdjSyX6X5jAfIRmo9g=;
        b=vEvNUIXyyXyh4H6v6UengC4OUrpOzon01+RM7snkq+vDAxEbXwZwVYXxTOJ6sObIW4
         xtnP1UjUiVSyYBw8YhEyWNwxcab3drWJ7uGBEWwI9b0CXHoaIFYtQ9oA0oTwyMJ/pz2h
         Too9tw6zCjg6bxazB1mPbRuq3MQH4ek15n54lPwu2uspXk15DkNaJuu7ybXea5Fg1koZ
         LT1F8OmE/tKMW3XlmJMe8/QZJZ6vOPTkAU0y0LCAZsq9rFo0WsmfiISgUv7aPDlMDGb/
         toqBG7BEMgAZgzgfxdbGFx0Ktio+c2RWa7Lg4Dfh3Q5Lg6Dzq7MeUvOcX5rViY1ysPHn
         BhKQ==
X-Forwarded-Encrypted: i=1; AL+hErFg1tkyDHsDHNXEk0vPbIo3GFyYvJgUkJyYv4SCfZ3U29j/SVU4IGBX5ZySruAvddyZ9UL1+no=@lists.linux.dev
X-Gm-Message-State: APuU4Z9z6u88oV7m6EbGYmAOq8L3mYHAvnC4FQSHZ2NKQXycDcjFYgX7
	iStaaySGapzhHb+0MY6qW5AjkDIJQ8RhEzKpvPBucFxKBpbkpdrfKiqMc2eSZbTGTg==
X-Gm-Gg: AZFdTZe84ymeVdXKD77nRHHk6DIC/NthU93K6h+X7b74nB0mc+k8CZBT/9r+JeeAK9P
	B9JGxBbbt/CzB9tdxeyX+EQU8DImyvsjcDPEQd0XkTkyKVbGIDsdn46lKZf4zjjUzy8slZLATnR
	O+2kIyYEwdf2tRLTelOOg9U1JEnDzZu5EkgCTLecUKpaAXz2xn/4KP2sL5ZfxkQueCkhgUfxWD9
	awMLwVix9SHyQyLWBgQ++In/QXyLVD7fxqfw+EeZULALvrOdd7mrUT0UsTobVjTETH32RTsyw2o
	aWIHwUq99jEWwV3uPjqMdj6aJjbQYLlxqujTfYQTlsx64JcJXaAfQJYpfquMqGJhrg338vAEaeI
	uZY8kJlo/2CJd0PDO/YWYqVgGk89OYWnXjqSFbs6iBjq08MMBdaTR/IXGC+BqVhSjjV7x/PhSl5
	u4cgBR3ihwxxczhlZpk00d9nPPQeX5117km1BK9TriPFuB3vU67QbbOXek3AxUo7VTLbzLVEh83
	eGRSYQ2SUl4FeYumSfWLcdfgojGRbWdAZ6d5zFWdVgbbX1TsDMft68oLkIJwZ0DJH4Gv8jO8xZF
	bAO6SmO9Trat9qFyH2AESP60VYzPxVsL+H7u2UGDI183OeIS4PFJnjLBau9pZvXKETmV449zuc+
	Gy6MvDpMSYO2yilqrET2qwo2t0nNXIg05yOCg9Gen4G00TuGy9unq4DK6NIwVeuYsQ2vC7baHnf
	TmjvfJmwXzDmHKKck0jndwbSeFpxDo1n4e8tLojpahUlTbClGccSmFCabAID3BHPWpbtuwWFfOb
	1XYc97Og5f94Wb6iqDmOu3olwh7mSn0R6eH2/mNfBRv5gfCzlH0jeWZXUqJQoAaHaa+8wesBDo3
	BoO6/045bdtiWPf+YUf2n3Y70oMZPkIsr/xeXTWLvBWffOJ8Bp0+qa/FDwEl8xsCV/wAoDMNR2J
	QSw==
X-Received: by 2002:a17:907:3cb:b0:c51:40e:847c with SMTP id a640c23a62f3a-c513a84ab4emr462378966b.23.1795375361209;
        Sun, 22 Nov 2026 11:22:41 -0800 (PST)
Received: from Desktop.tail070c67.ts.net (p200300f24713a7000000000000000a27.dip0.t-ipconnect.de. [2003:f2:4713:a700::a27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc316bsm332597066b.56.2026.11.22.11.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:22:40 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: razor@blackwall.org,
	idosch@nvidia.com
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	horms@kernel.org,
	olteanv@gmail.com,
	vladimir.oltean@nxp.com,
	jbrandeb@kernel.org
Subject: Re: [PATCH net] net: bridge: withdraw the switchdev entry of an fdb entry made dynamic
Date: Sun, 22 Nov 2026 20:22:42 +0100
Message-ID: <20261122192242.1205890-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <4937f07a-6238-4136-94ca-a98b2f4b8db5@blackwall.org>
References: <20261121191638.1724620-1-julius@bairaktaris.de> <4937f07a-6238-4136-94ca-a98b2f4b8db5@blackwall.org>
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

On 22/11/2026 12:58, Nikolay Aleksandrov wrote:
> I think this has never worked, so this patch can go to net-next.

Agreed. v2 is for net-next:
https://lore.kernel.org/netdev/20261122192118.1204290-1-julius@bairaktaris.de/

> This helper isn't helpful. Just call br_switchdev_fdb_notify directly.

Agreed, v2 calls it directly.

> This comment is useless.

Agreed, v2 has no comments there.

> I played around with the possible bits that can result from this change and I think
> I got 1 bad case:
> What if a user adds a master static entry (created with BR_FDB_ADDED_BY_USER but without
> ext_learn) which is later programmed and gets BR_FDB_OFFLOADED set, then a replace with
> "master dynamic"?

Agreed. v2 clears BR_FDB_OFFLOADED together with the withdrawal in both
paths. Your sequence on a dsa_loop port leaves the entry without
"offload" in 3 of 3 boots; v1 kept it in 3 of 3.

pw-bot: cr

Julius
