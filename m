Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795369060;
	b=KMC1oQWjMo8zKETbC6UKbAXUgVmtcKB1VmcNes3v9qybPgkAb9uc8XbGxEAeLGfc+RD8
	 Swx4OzoCiClLq253winb/kUVGv9g8k87M7goAYvQXdSYQKwBvNSED9VEAT5TfEzeMzVzw
	 Flfr8L5MGa/iZoy1RyehTCcBBsbs4/FBj3TbcaEdRs64i0B6DcIUAYxFWyq1zfkZvhAkJ
	 FHCYrkabxm6FKabgvIENt+1sXxyc08iyFqKi23QJ5bwGOZVsaZySSzzhYLmk2sTLoFqAA
	 Ed4rgoqSVj2UF62BWOYmksCRWvAS22HUs3yPgQ+o7xE6zAOLCYSQszcSolq2RQLyjqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795369060;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	b=rFYZfPKL9AleW4G0dokU48+vu3ee3d19rHA9YMDBmyZ0I9L+xDCyhwwBpWxkyXIQBsUr
	 jKdPIsLmlUO4gV0BzfRZbvKodIxE2rrbSf3joPMBnq7byXBLXS6FUxI/biD9yE64FwfFH
	 1XF9RHjtzfpMMAUMMUfTlN7VOE2Murs+TX1MOu+lclq0zf4iBsVSSBOKDv19nSCXE27y1
	 ukS9wZWLaT3Z0qNBdpg3XP9agnIbFiagp6hThtZaRfkep8cxDO3AIJd9TPlExu/Bvdfta
	 aebS75Dy3ZqiHGpq1p5E4WseLEzN4Orm6a1UDeOtGBMNyVj6gDLPn6fSZQnsXDH9qXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtPRtLFV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DED9606A320;
	Sun, 22 Nov 2026 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtPRtLFV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C061F000CF;
	Sun, 22 Nov 2026 17:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795369059;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HtPRtLFVbEXseV21dzEa5hXG0VDXvWJ0oEx6H3qKw8l65WvcwIcC92Cb0O6okOXJB
	 RAnMYbNFE04zs3X3JQNP+nPkEGxk2cofNjgULHRyCSK+MIaAi9rCpFma7PjS7WDW0J
	 psvAYpN/+NLhcDnU9lFbZQuNFkkGXLrunUAT6U1t8tc3YbiAYVjYpIHtMlJvBS+FID
	 2ueUv4ipXsqZz48Jv94ZVOOEJ2vT8HbBqbXonKkroJ1vWGs8AlaxsNp8BC+0wu5SK8
	 /CwyG76lnrSxPvPtKqnZv88iqPJJqjIHROrdbwrjuvRFuyrUuzYTV6wxe/2eo4IoUe
	 pwts4WY+g+Z2g==
From: netdev-bot+sinfo@kernel.org
To: Julius Bairaktaris <julius@bairaktaris.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, bridge@lists.linux.dev,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>
Subject: 
 Re: [PATCH net] net: dsa: hold the device a queued FDB event is reported to
Date: Sun, 22 Nov 2026 17:37:38 +0000
Message-ID: <179536905824.3294.1235394828103149751@kernel.org>
In-Reply-To: <20261122173347.791590-1-julius@bairaktaris.de>
References: <20261122173347.791590-1-julius@bairaktaris.de>
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
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
