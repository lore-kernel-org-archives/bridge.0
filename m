Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283528;
	b=d7FwNcT3BEornSASeuawoTxpRRmxiNwLYUCDrsWUyW1L4NOX5n67rKAF+2k9PO9FV9ok
	 fU1VfCbsTwVfnCdI+UcL5P9dEXPknutZBf5IObCnnfBGCzAHJ5J8YxHy9N/mHsZqsASZF
	 xjdBteX+6vc+2qfmAy9YuKD3BTQ1TCtEitxbZE6nNVWvT5rVkRPbuyfvMUlIeLEx9uZZK
	 tapZ6FyOBYRMqN6FRWnni+XrztlhnBC6vcBKhhB6Sdj2RrxCqoDlk1BitqggHk9LrIcyP
	 k0Rp2hpD04fa0qguN8/GE40MwJpu+awP6yFbCvu/2zC7/31hcBtUQUCFSFtVQ9DCxyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283528;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=bi3XCRBGvmSDE1K5OHmyVRwmgMxDG33ALAmA+5YU2uM9Bla2XicQl3o1AOu+ioHZ9cu6
	 H+JqFOBp9lwVOlP3HEsnga8d7KLswjttYUmEcqtadjzOrjKixkN5MOt3IJodRalleu/OS
	 diIGyC1GrrEyaGnmabG3/XIQeMvsyeQjWg4oCMejz7WtendyY+iPhb1f2d2Dqni0XNyyp
	 1Kh9freGDogsdrZTSNVFXTDlgiyv9OUx+s82FhPC2T4DkoSdxtBHDmxMSKWffuYq52Wyn
	 D6T+bEJ483MdrbyD3KmPJaGbEIKY/fcCtVvjxArvRq6fpa/1CVbI5ybpcrO8YzfPo1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cfn3C+x8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB8860A382C;
	Thu, 29 Oct 2026 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cfn3C+x8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9D51F012F7;
	Thu, 29 Oct 2026 14:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793283527;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cfn3C+x8PWgqZ6uc0GI1t9iDicUCtNUmrMQuLjb/ZvGRonVQp9Nh4jYtoQ1DZPD4J
	 bGGSiaCOjnJ++iujcT2PdJ/QJ72Ftk7Usw1d1s3wBFdG1EAz5TtrkcEirJQcsKc96X
	 vAGrX6EbTjtUtz5IxxXyLPlFQQTL84F7/0V+OpkXOqCB8+KoBnTzC5qze9XcBjWUOK
	 QZa93OFk719/XRn0CGp6kH33X/05mWX0JbO9+2e/w79VJw2jMv+Gtk6bWkaDCCyNHn
	 ABpFrbd9Z7UCkl40ia78/1EANT3lNpbflZqvwbpk4Jc8SeN/0gj5lfi46lIc0TFqZ1
	 jgkIMzFWWjPYA==
From: netdev-bot+sinfo@kernel.org
To: Cheng Yongkang <teel4res@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: mcast: release the EHT host budget for
 zero-address hosts
Date: Thu, 29 Oct 2026 14:18:46 +0000
Message-ID: <179328352676.3327.7322681510650096532@kernel.org>
In-Reply-To: <179328314076.648427.17991367257682028617@gmail.com>
References: <179328314076.648427.17991367257682028617@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
