Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794138459;
	b=yfQub6ZSbcNIub9JTiXWF+drf6ypI6e29PwDszNCJO3R1P2njKoh0jRukppRc3ViKIV0
	 JIxmDxMzA4xsm6AVQqgHiGWSDZpAXx2jJQ4f+WzlxTAlkG3L2vBiq7d2jAWTJU4kgwRcx
	 1Igqjr/mBC92u7qUHN3mJ2qxakVeKuUCADLuTP6G9wrADawNkUciBS2omdE9ZAb1vgfcu
	 jwbLeJ/j58ibsRLk0+jxArtqcwNP58DTlVmb4C7DA8zU9QRAYqoMXk1MZV1oav7QSsgyo
	 ILFfVf/kyDF4/euTxfCqPzFIHYQ8jn03GsrShJp9igPuonX0qr3lVadZsVC4mA3jt2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794138459;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=H6Hvjmx3E6u8slnggZfsBaEM6lqcy8rkOeo4cE7U+mg=;
	b=1BJqiqeirLIS04131UNkcRKOtJaLfB+ee3kQyOWRvJIk2xsN8JRI3K6dOR4i1agE43Qq
	 hELQa7HnCHnlM+gfqGJrW2zo6aYdQmyVqa+tMMpp1H4ZlMSLr3YoR+C/YIFxoiIwZ6hTm
	 K72/jIeMg1xsbAnral+MRUIn/+XFv6H0kTUp0MVCtdzb8Q/vQtCl6PJXLZHhKAyKl4s1f
	 ZuwVQDx1Lm7jYV4krE5FBSWzPGKi06NjNJ6HN4O5g/lZcfwVIC7FEtn512DzwgYiqtC8N
	 OiQ0uUbGfIgcZA62kE48QWcH4o96uBiaT8BpWqMzhiDOTBPR41qzSBjR/u91TjrtSWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=sfdffKTU;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C396606A322
	for <bridge@lists.linux.dev>; Sun,  8 Nov 2026 11:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C396606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=sfdffKTU
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c3f8d72d7ceso7026366b.3
        for <bridge@lists.linux.dev>; Sun, 08 Nov 2026 03:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1794138457; x=1794743257; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H6Hvjmx3E6u8slnggZfsBaEM6lqcy8rkOeo4cE7U+mg=;
        b=sfdffKTUN+GDG+lrIy2iHZE/GR97nMj5o7tD+mgi+ZlYxz8uVrLX9b11EEPtStk9a2
         7PO9sbowooWhxG1pUInxSDWrXEvNR1TYx41+75u1dsAPUiSOg0ddIGpd+5rCdJeOisRX
         uZgWYE4V91REe7YylSlLic59GYPZ+rzMLu9j31MExjG3dkUuatKdXAWsaAittwH8foYm
         zB+F0ypUuQ2sF89v0xNj5J5hoHhnub+dUdNbb5Str0Xn7Sha6a31cfT/9HozaaSJ5Yvo
         DzMXKiZrBdSkLYogl7CDLFeYQKaopvOz5kMx7s6grOej+4UqMdECKRlL0sSC/qW09Oqt
         az5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794138457; x=1794743257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H6Hvjmx3E6u8slnggZfsBaEM6lqcy8rkOeo4cE7U+mg=;
        b=wsTOdPKQIR3aubWW4JcJj0uaiHmmo8O+hquWt/Vg1Q/T64Xrm4zhb7CzCZappGGi7J
         HOVWxfmCjY/aMDZHJ/mSL/zM3qjSUWV5oGUWLGoY6SNNMVKN8IDJJghJypjxjsmO/yHe
         1S71i3f39OeCeaX1KStMcOoB0ZJFNp5MrE2ZVGQW1gWxb+fcloaGIEqeXMpICfsxO5bR
         U6Ua8mT/osu5ji7sXWI883QRt60p92RcpwVM52Ll5DkX3qNXQBhH+Awl8IU6OK86lZWS
         yihwabjsYdK9SqIvmcZEYMxNXQAXYmSo5klweL5DIJ66BzCHZ6BdK2mxW6QWDhCe4OqQ
         vh3A==
X-Forwarded-Encrypted: i=1; AL+hErEeYdHC5ZKT6rqu9tTz5jociL/dXg1/1IZDR/brHRPVyhjivsFFvUyXGsChEqbEYbY+tIm2lbM=@lists.linux.dev
X-Gm-Message-State: APuU4Z89mn9t8Kgrxc4p9/T/m6Ehw0ck+s0HF9icb1dJucUhn8vJdYGh
	3yLuAouJGZ2PMa/VRbkAqLmQp4hDcsREqno1APc4XXIx3u0ZQ/e5HVNuNKmaJecizg==
X-Gm-Gg: AYBFou2Cgk4Hbz9asZa/UQunU1NmXceL1qbwRwGrLrJGXOi8Q0WXuCzQ4WhYP+wX07l
	x8cPonMVy+kSKkpRZben96YcKO75YUiDph98PNJphsbpd+C/vfjO9p+peg/wDrFpgXYqfBtY87M
	ryshAZwNlA68u90O0FUDD+oJSml+QSM+7K7DcVphvExRplsr3cEC/8cd/YmA7XLF3TI69GWbNCv
	O/I1GqUad7YL+raT7XWWiBFBOU25jOh+yrtCQVqTFoJ88c6LwgIdeJJTvsjc7pGZHb2WkZUz4Im
	pBQ6TjC05ZI+mvR2+/BJDNdlS9G52iQLYLysd0Mnd3yPe2sZxze3seT8zEn2+ff+E8f0MlfsDjx
	/wrKyGtpM+BdOSuDXqe/n7KCXFrnRsKdMnpBtGVALY7xz7liIkqb/NermKrZTg2S0KC+dro6Lcm
	e0c3Gtp9Q9n9ZSR5P6xZjmpxGhgnw36Id3vKaV/OAeHMYN5x3MhwtikJSdOeRuN+vVd5CF1eP3b
	bU887foWD3rgimxJ2vVzRssGjmtN7h41PHG6HpMokwDGeQe4V3bXXtfrl5yk+qe7ixLUd3jToQ+
	VPxLOIR7alZuMFK3EjDMmlHxsDqDpQGNJudaD91yigCbn1OJUQEOLzeyzcbSxa0neD/qUXHgs/K
	4KtWrlRE7p7HXIPuAv0joReIK1l4oQV/3hbpZ/zRC/kLeeGdL3RYlxf/DdYOabxl5HozyFdwYQm
	0dpA0AxbJ/iAWWQOoZK4+LzuT6FbiNT3DZH7BUVwT/HTn2u11xpr2YlzNjJywyllayAabaDUUhl
	kab0onx9NhoAAhf7VH+MjGCZ0lDVQizgvNo8H59rTcOZjsUDF98uIEcSxzbNZmBqIsIGS9MCycS
	YXUKhMoIt/vLk7v3RQ==
X-Received: by 2002:a17:906:4792:b0:c4d:31c5:e30 with SMTP id a640c23a62f3a-c4d6d7ced04mr87104766b.49.1794138457495;
        Sun, 08 Nov 2026 03:47:37 -0800 (PST)
Received: from Desktop (p54afff19.dip0.t-ipconnect.de. [84.175.255.25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ed3b32sm490083a12.23.2026.11.08.03.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 03:47:36 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev-bot+sinfo@kernel.org
Cc: razor@blackwall.org,
	idosch@nvidia.com,
	andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: dsa: fix host fdb refcount when an entry roams
Date: Sun,  8 Nov 2026 12:47:37 +0100
Message-ID: <20261108114737.124573-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794134495.git.julius@bairaktaris.de>
References: <cover.1794134495.git.julius@bairaktaris.de>
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

> - How the issue was discovered, e.g. hit in production, hit during
>   development, syzbot report, manual code inspection, LLM or static
>   analysis tool scan.

Hit during development on a Xiaomi AX3600 (IPQ8074) running OpenWrt's
qca-ppe DSA switch driver. A station roaming between a DSA user port
and a Wi-Fi AP port of the same bridge logged

  qca-ppe 3a000000.ppe: port 5 failed to delete 02:5a:0b:a2:1a:46 vid 0 from fdb: -2

3-6 times per address when the two ports received on different CPUs,
and not at all when they shared one CPU (4 runs each). The dsa_loop
harness described in the cover letter reproduces it on net-next.

Julius
