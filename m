Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795865821;
	b=laABJ4fWYgUgr/slstY28k4I+uti1OwG9ZFTc9TOeGSa6YLOeWzX1Bvi/vTdmcUYjHK9
	 2/t+EhGehorAsl0mfkIGEebOhoDP0elTr70rsPEjZJEV96AN4fdGN6sDmfbUYP5nvjd1Q
	 EeTGnuRTLUG7dNVsqwWErl6W6JStiP1IpR5/CsIBo4ef+DHKXLiFiZFwhhm291Kw6GkIi
	 +udUpmID5RgHqBA3VoFE3YtVASCEJjb0p2BiDm4jk8xDdeZ4L6CXm1820u4l335Mx68cr
	 s91RPZnaP2EY4/G2IJ0sp4VtBFOIJ3midd7Eg07NHqtpIpTfXyoBv+HvHUOfg90qA6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795865821;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qXOfPubqSoWHD+2jyzNu4qv47adfo/O9zoKHSdZkEsA=;
	b=5A16cVZtNuiglghIPlT7oif2RU9STiFu6N2UPOjPi1wRAmpRVtuClJ+1WoflY8/QVZxz
	 jMAqJ4Tz3PUpPIUum6NRdKyGv7sxRenuQVlWLnjaYAge6H+cSLq7vsU8JxlQR3l7o/8G0
	 j0Q5WAf2RV/YwvmapL9ITJdF+w0YtDMuBZMrw3r+IVkFrXNK633s0HN9RPBdI3Y5JooMM
	 /M9RSifXCSZDnoxUNPhqup8QvX3c07exaf63GrI/5+ZenDEOLJAQd5MTUdM1BF24SZ4he
	 DItUR5o0gsOqGnlGuBmrrQ/JSHM2X7yIqCyNnhfHH/0QXi02vc2parmrjreYu/Wbmeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=yvgGbMTY;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD176606A31C
	for <bridge@lists.linux.dev>; Sat, 28 Nov 2026 11:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD176606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=yvgGbMTY
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c5126505cb3so1169279566b.0
        for <bridge@lists.linux.dev>; Sat, 28 Nov 2026 03:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1795865819; x=1796470619; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qXOfPubqSoWHD+2jyzNu4qv47adfo/O9zoKHSdZkEsA=;
        b=yvgGbMTYcoPomWk5odvkL895UIU6sWpITkrYf/gYSywl0JuygqjbVaSuv6hYTdLXXO
         /UAZnQUO+paY9A6SJ8FMqZopyGCaTn7oqcPndVmM+qYSQV/9x6ex+FtCZ3kbGwcfnKat
         Fe5xmSckao9R15V4g+szY3244T9CHUPOGhX1D994YequHSGuzVj/W2rYSDCKBvz9xhTu
         3fN9QKx8+OYVPIJcfbE7HK7K1Pwmu+1dXobsJk+9nM6fD0siOAwen2CsOr5IbHW20Ooj
         z7ShKqcg2dpGc3iZmkLuQeVEzL4H9qcfBhDvHTzgNlUwlhac2A4F7iNiTnUUeVbN9a8N
         memA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795865819; x=1796470619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qXOfPubqSoWHD+2jyzNu4qv47adfo/O9zoKHSdZkEsA=;
        b=d/aqRtqnKr6nJIQWsm+nRNuv5iT4xIpUblFe+JftbLPJclvgEv6vPlEpx7/zx+khV9
         DhJmmhWMdVUXf977whegKnd5yhQUbPOSq7+KW4wn/Cf7ZUFhB3l/lKWSdxbr9n1ApbnA
         pdcLOMqr+6ZR+y/ABQRyv6G6f6AjsASjXzKfH0nGW3vWYeAKTca71Xo8CPWIYys/Bdzr
         gJUiMDK7060cfkWZqSwHkQWADdDQItjL9O37rKgV2oGYdQZEuOnCvK84mtZ/LJSw0qID
         0g0NSfvqUKvqOT4dmtXbb6DPaRkmBnI7+IWijwQORTsh3QRgnqBWCvBZG1Hh1R3C5Cn7
         p/XQ==
X-Forwarded-Encrypted: i=1; AL+hErEYckfED3FBwBvM7MS5X6iEK0oz8mWwW3hTpuC88VU8OxNThwlixxgPjNorQNiXmFIGmVele+s=@lists.linux.dev
X-Gm-Message-State: APuU4Z8OyKFySIkhdSx7TYib9ENbiXMbhkSigLCE5qfqpcc1fT7itlKJ
	SF6b3dqiuD8uLi2yTxrEWQ93szRFKTRvRlidplSJeTdakCNHY5YGN7GPLTqpM8HCPA==
X-Gm-Gg: AZFdTZcm7RTwpR25IKHTXG1vL2Pv6TqgEfVu3kmhIDdTNOfvGjDHDZdflpBRFKDq6L3
	e6oLltJQRRwDSx0uaRheyrjca5iODcPWS6WIgLtWv8o/n3/ldv6LphwG0pBSbljqF/oW+uYT9iM
	H09jy4gXNRk42BeSFXSt8gTU8Ob8t0siapNdlo/4KajV8f2QmO4YUDGMajkiWYBwroJD9DtyMKE
	eAfjYSQ/HcjXq4/AKhWwR+9cIXPlLgc4mZxrwQPG9FkmbYatlDIFfdjivOMw4Nhmlf3M22gpXW3
	WuPuEjjcQ+kGZAOtx7Gji3icBGbYMvUBwYhKJx5B92NQzfMr4GVMfQrIcC049zk/kTff74tAOl0
	0GM9Vo63jbvx/adg08uMMUej58avwSL9Z3sN+FuMP4EPuX8k37sv17ELkElXNgvP4m4256iPLnY
	OMOmyUNiOoH0PVT9oC9Vh/zKd1HF7hgGc0jyh5uuPuAtk0e2cbljS1AKkj1CQhVKd1IfuhRURpa
	vOVwMFmKSrxSOV65fSOcyZ25BdLiF81WD31jlw+KrjqSMavyHwhL8vUNN8hBl9QdNdmdTyfDeSs
	UpLXIBpVBYSgOMu7HXzwRybAkcuemZ4WCspZf1EBvSJv5eH7rtRfcjHq95VMc09up+KKtpXg0o5
	7xJdur7ukfzphE7xpW80uajSi7iKwuaaSTlqdU95lIrPwTzOh7HhJ9J5xlwIz1dYU7XtQmHX3Vs
	NXk0uDbbWVeLjkORk6x7QejNHAKa79YtAQhJxPQ5n2Kgg4Gq5UvJaVnZy/+lK1BNuMxBRugtM6y
	3GVAwx0XH9GaWhgoDHA0XlPvWjfryoMO9LQhYh/tpciiaFp3jvTT1k/oJPziJCr0GQDgQ6ciFYK
	6Y5Eg2009faZ3ccw5jkjGqleWahR9/uD2Rr20REhB06jtzQlcJh+pX3uBDcP6FyyJnEV5F15BJ8
	z
X-Received: by 2002:a17:907:c612:20b0:c51:2583:78b9 with SMTP id a640c23a62f3a-c513ab477e2mr1631296366b.34.1795865818556;
        Sat, 28 Nov 2026 03:36:58 -0800 (PST)
Received: from Desktop.tail070c67.ts.net (p200300f2470120008502fb937d9e134d.dip0.t-ipconnect.de. [2003:f2:4701:2000:8502:fb93:7d9e:134d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aea31e4sm972211866b.39.2026.11.28.03.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 03:36:58 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: razor@blackwall.org
Cc: idosch@nvidia.com,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	olteanv@gmail.com,
	vladimir.oltean@nxp.com,
	jbrandeb@kernel.org
Subject: Re: [PATCH net-next v2 0/2] net: bridge: switchdev state of fdb entries made dynamic or roamed
Date: Sat, 28 Nov 2026 12:37:01 +0100
Message-ID: <20261128113701.20291-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9a0568ae-2f9d-4a25-9d34-65d1e74dc4fd@blackwall.org>
References: <20261122192118.1204290-1-julius@bairaktaris.de> <9a0568ae-2f9d-4a25-9d34-65d1e74dc4fd@blackwall.org>
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

On 24/11/2026 11:21, Nikolay Aleksandrov wrote:
> I've been thinking about this and I don't think it really improves the current
> situation. The problem is that it introduces new race conditions with the bits.
> It fixes one problem and introduces new ones that might be worse.

Agreed. A "replace ... master dynamic" while DSA's ADD work for the
entry is still queued clears the flag first, then dsa_fdb_offload_notify()
sets it again, and the entry is no longer reported, so nothing clears it.
Please drop the series.

Julius
