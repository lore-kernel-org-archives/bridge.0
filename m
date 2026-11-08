Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794138454;
	b=zO8FkWVc3yDiSUER256KVOPbI1UqJJFpu4FbNfnQP3tMFvLw8OS1UvJhTuRUrD0QTO0T
	 e9QNh9ja9jn3tIyFYJGfGnKfAibYEwOxIPGFVqpXbNy8HCsCUAGPXHQAmhT1NeJ0GTreZ
	 jEEK05b1cMCCnvO44SPOqMkpsiAfQfYDqGSzqHWqShf2EAgF9rBcVReQ/ToVMcIgvEDcl
	 cdYR+C1HKibZXg9Pxfv0jRGjuH1BChV2CDP4Dw6btKKdes0Cfj8pa5CQctiSMLwVJ6TDh
	 hCn5Jzzz327Me/wSUF3Ti365ilWjn1ghJyqfNXyH/zqEOFgK1pu0VYcyDNeBvrxQ7Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794138454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1Y8EnhS7o4bUUaMd+9kBk4x0A+szwvlZw6MXN768V/Y=;
	b=2WxD5GPZrPMh1XzLKBZYJb2l3f5xwBQ4AfGSjGOAScmDXLPPVWKim5zY7nj6nGhYgLeb
	 NFkKL97EakCcD+ghLXBNb7+oBrOqQDFh1UVdblvRyxMBuuxM313vTXYa67AlFYOEazaCs
	 9CwX6O2Esd2WHwRA+b6Bj7JmVKYPrYhbpHCeyz7XcsEr3S0HYIUYJl45kr9nBKf3mVrmW
	 Ii6t+io3alKV3B8dcEdFxCwD6paXLDGV6pAXF/7TlbroCsncdT//BHQDog9pD1qvQyc5w
	 NZXaTcOE0NUHwgSrzarAyTBQhQlRAUQ/erRSzPkx7dQ8vUEAqIVM6nDx1Hc9c3ia6gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=fdmMnvSJ;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDD3606A323
	for <bridge@lists.linux.dev>; Sun,  8 Nov 2026 11:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEDD3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=fdmMnvSJ
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso7896266b.2
        for <bridge@lists.linux.dev>; Sun, 08 Nov 2026 03:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1794138452; x=1794743252; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Y8EnhS7o4bUUaMd+9kBk4x0A+szwvlZw6MXN768V/Y=;
        b=fdmMnvSJHu0bfGT3U+rof51h1Zr6LSqlVPMuxyCcBiRpbwnab2JsWYSrNTu9xW3YnO
         COAD9tIdNlXc04Yt4PiNllP4GwPD6eYL65aB9oH0weC8p5KpNqKdFvDXxhu0nlEhtzD/
         SQUSXv1DaLr5QFVCT/a9eVPm4rizE7wyxA7mU9+KjEmiT8Zr/Zy52IozTy1UPq1LoKD0
         jkHQyDNPqXn7R7beoMNaJE6OvGjpLlmM6W1suVGCe0Ty5mkJemJqLeaIzS7/3Tuv9QQe
         T7RAcUS7BSeY16uCbcFjPxLGr5jC84yLj7ateRX08aCTCg9tQFjeoLceVhn6DX6sgIKE
         xbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794138452; x=1794743252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Y8EnhS7o4bUUaMd+9kBk4x0A+szwvlZw6MXN768V/Y=;
        b=uRxM9Sab+25Aj2j5Tm7NqawFHOQjDhMJjQGR8CM4EVdTJuuh2hel8ZiAMu52agYw4k
         Lk2sCqAaIecCC3FWLpQvTbiNUAa6djuo+6YZoPXWAAawLQ7aKWhkE2TBhV8m/qkh71NW
         iXbcLYsdn70sOBOopm31AzDXfnekJMMCggVgcdBuqsIfQI9yhCiAk5M1ZrdFcZIawgKa
         Yh+dkwjkotfsMAn2xNIrQchAydZdewxuUtDm+JBXZckl9U6xqB4iGtm/a9FqCVMCCgUw
         j3FvcbSdlN+VFjFT1RX3CT6gue7ufuh803MJ6kz6PNOcukiUmpo/9dmnu13a6QeVKaQY
         bvMg==
X-Forwarded-Encrypted: i=1; AKwUvByAhvJkIa3GkW+f15bmJisgHPUX44mnhIAC4IefNn1gBj+eQgdoqXp9xZSrbYCMe8kbsnybwM4=@lists.linux.dev
X-Gm-Message-State: APuU4Z9WMHnFScCfQpCcizqR7V3RMQFDZjKPd+NYZkhYTp5BY14FNilN
	EkPkaiPdRie3QXozVV4CjMNBYZax6rQDibAaejpfwSkc7NPjA/sQ+WpfI7os++ihoIpKPYWjBo6
	As2QCffs/
X-Gm-Gg: AYBFou2E97UyXhwlMPSyJmLIXnmx2WR6yRORmGLeMh6Omrl9YOoe0kREI0ck3WinwlB
	05QNEJIiOQiaLkccmj0S9b7U3T6db+15JmO/YGxZcdKVAOlBrAxnN/Of0yJCnxDqnbZDcaZUbth
	CdZG2JhbM27/Oc6/s4oOHar7c2IRpFmkkwc0f2dyTD/3jKmB9+LeGb6QrvwB0CHORjvIRqWEfcg
	EbOuy+NC4Bo1HNYe9NPr/jbx7UDtGuVfMhGVG+wMQuRvxyADLQuUkwQWpxIwCpcLABo9B1WFFkZ
	QSBPQzz852faNwQhr1JneG+6H96wi+F0Eylne+vxYKpA406yvyObRqhC1ZI854TpdkMz2mstyBk
	KG+/FKzarL5fEGZzJ0kM142WJkUMFPG6etvJvJtY3jc4mXiALJmFfoudKqhTTwZbLY22/mVFkF4
	i8myylSkP736bYTbBKlpUBYs0SNzUr77ruka3JtgLFyH50XhRLvfEMo+bsWsAtb3aUacFPGiZrv
	stNQuOqvj7UlQ1+hADKePHfsfZolVQr8MIRVjNZ78V7snwS6nQbeM2vTLddELxabDif/Z4o9Av+
	2+zdWUjBhlaSzPMApSiYof8UVkD8Mu7KIVf8pI/x4KEZE3lFBnDfbDQ1TgITOQVx4qQ1nlzreDj
	Nx8QZuesWccRN2k7ajOz4tSEclab+FHRVWq8RSELxsCxs4Nw9RpUr5nf7I8czkrxp7rsznXNXUM
	UCLm7GecX03NWk7RTr3KrejXefh64OuBXG1Ci8FWzOwwxNhhymkRpcITuAOiw7omlEidsLihUzL
	JqxhRDLWBljtlDZ993+wNg8uUlNgUWF9VJmP81EZjOMpQQdj5c+r2phdD/E8u8q2QP8E3POdPLA
	bySOLsvZ5znSm/C0vA==
X-Received: by 2002:a17:907:80b:b0:c4d:2cb4:7bbd with SMTP id a640c23a62f3a-c4d6d7c1ac0mr93601366b.47.1794138452222;
        Sun, 08 Nov 2026 03:47:32 -0800 (PST)
Received: from Desktop (p54afff19.dip0.t-ipconnect.de. [84.175.255.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d6a99320bsm56079066b.67.2026.11.08.03.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 03:47:31 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: razor@blackwall.org
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	vladimir.oltean@nxp.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: fdb: hold hash_lock when an entry roams
Date: Sun,  8 Nov 2026 12:47:31 +0100
Message-ID: <20261108114731.123174-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <01600be7-3d8b-48b2-a59a-1125eb452714@blackwall.org>
References: <20261004124254.3525496-1-julius@bairaktaris.de> <01600be7-3d8b-48b2-a59a-1125eb452714@blackwall.org>
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

(Resent with the lists on Cc; the first copy went to the To:
address only.)

On 04/10/2026 15:44, Nikolay Aleksandrov wrote:
> Absolutely not, this was made intentionally. Taking the hash_lock would further kill learning
> and roaming scaling. Surely switchdev drivers must have dealt with this for some time
> now, if you'd like to fix it do it so the software path isn't affected.

The fix moved to DSA, with br_fdb_update() unchanged: "[PATCH net-next
0/2] net: dsa: fix host fdb refcount when an entry roams". DSA no longer
counts the roam events; when it handles each event from its workqueue,
it looks up where the bridge has the entry. The only bridge change is
that RCU lookup and the filter it shares with br_switchdev_fdb_notify().

https://lore.kernel.org/netdev/cover.1794134495.git.julius@bairaktaris.de/

Julius
