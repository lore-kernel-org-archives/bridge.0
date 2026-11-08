Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794136944;
	b=xGqFj+D0e7k78JRebaue7rm7bNVk9nbBUJGzUgQ+gpwQhYG32zqztEo/cJWei0m0E9/S
	 jrrFE49NWdsl4laFyyMSB+MEZf+QB5OFKeQVGYXGy5Q8T8R04WvaiokkjaMqjfd1662/O
	 YvJwspNugVUOnRE0oeh4KPOlP7FKRmEufmo1Cr32tQU8r1GrezorOtwmE6dgyd0kJwd3E
	 MBRZOU3kqGdz82b0QrkAUmwyfS0p5G7/LF74yx5w4k9J7cU4RLODGI8WLTGufSvTBnTA/
	 tTTbeRpYQ+Hlgg2EQNdZRB026WU7lyaPr2KtkF6t+Y7UNpXFESLuDsaymBB9pZ2Iz8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794136944;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=g10D/bTzFs/e9X+cpkcbTaKRNVxweDFcaU4JuFcPHM+ip4kIyM2LM1SGlr258TXLvYF2
	 /DgSO3odIxi5iUBeCNf7kXFforESzjzh0B3h8Lz4vXEOUaOva0yXaIziKxXbn4AfVvyv2
	 jw51z2j2ixW1d8tx3rc7cZIjDqy4SyRNT9SuT+IMxB46YpiMJ1ynpZZSc1GRn5GKVSDSK
	 sBcztLMWFEghKqfZmu7tZogvgDnbJ/9tuZ3CVpG5SBLLqoWDEkn5HffteLkGefanFlK9S
	 b+mquB1JfV42oPgq3wgMCP4DKND8NfW+G2HnE6gNc8YBKO//xacBjJdAJL7GSbShC6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyzsRi4D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8D4606A31C;
	Sun,  8 Nov 2026 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyzsRi4D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724BD1F0089F;
	Sun,  8 Nov 2026 11:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794136943;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hyzsRi4DsM7nNwp5QM/4HFQRr1AY2DxYMZDLzNIiz3oGiwb+geR7hFCaCjc29X91b
	 3Mn5bMiR45NBlFk4ZNeiV/V7JAhfYhXcrI45xnqVvPZOSWdjPKIQxlR8HwCHzzWgKx
	 FyhnN9Kbl+ZM6wx2kuONok7nxoGhJKxnGrIGyJjv4c5S3bvsl+VW7sSlBCKIWMdZjY
	 QGSWJfgfn8KGfMwdle0AG2Ckg/NIzX4PYMoVkVkEnWAdZBgK+w01Y+P22Q2nva08hR
	 gLoT3MPkOzM2w0neEdf8gL+xqjajVaVlqoIJB5qGo8lKDc5ru5x5b7kR8D7QxhjDcN
	 A//+mfT42hnUg==
From: netdev-bot+sinfo@kernel.org
To: Julius Bairaktaris <julius@bairaktaris.de>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
 bridge@lists.linux.dev, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net-next 0/2] net: dsa: fix host fdb refcount when an entry roams
Date: Sun, 08 Nov 2026 11:22:21 +0000
Message-ID: <179413694195.488859.17529427355608385770@kernel.org>
In-Reply-To: <cover.1794134495.git.julius@bairaktaris.de>
References: <cover.1794134495.git.julius@bairaktaris.de>
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
