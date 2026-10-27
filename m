Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793091349;
	b=cK/eVNXJuKeC33CosNh6kD52foeawHIw0TSus6rSuz6idM/w5v0vo09Cn/ZAwd9U8PJH
	 uqoj6I2NXSUV9f5A/ALHNnP//eescRdBQ/HinJmV1CPvtrJCYwqZK/i5p5DS0CpxFKtez
	 pwSkZZ4OU61b4c9+R26YKZWEpZy2VUDWnqvYgklvayfG84Fj8mn/WFwuv/SjYb0tUscVg
	 6spxCutx8WApgCIQzBijKKCymOnw89YkxzWL07Vm8ZPKzR+day0h7a+Rp2YVHpQDAnLHo
	 YmsMddt0TEZ6Rx06EoimARFz4fwIxvnWiG5NvNGF0Fi4JOuYCVb2sjzZj+HWQG6IxQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091349;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=nVH2k9Nlyv0p/HGc+M55DlFCW2VHePnoM6h0gU++FrosnZSGahaHWClMK3W+hscuWxAo
	 FEBp7V2r1nuFSVZjbGYRm5HrGyFu9WfYM1pFvpgp49HtjLp6UYqHUUb+emnhEJ77aZD7Y
	 kV25RF+80iAVa+fCxcRDPb7EH6PsQdp4CbJ8rAz77muSKrsK/Lt49cBGZ0w8soodWbP5X
	 IxsrwFfI3MHMFsBSq3OkqEO6/1UGQj2uCIeuKNfIDSWqTjBqTOpo1s1XnEsdNVV5WNIlG
	 k2SPXVACyA9zMjamG6OWMAMd1crgjiGwI6gr/DDrXbJAsHRJd8bAkBwp8XHDjCBDrKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hko64qbw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA91606A31A;
	Tue, 27 Oct 2026 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hko64qbw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F481F01825;
	Tue, 27 Oct 2026 08:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793091348;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hko64qbwtH5qsRhgg4jeDB0UcxJbt6xPkGq4J02axbIszRdyClF+vvD69JXhTsGi0
	 OY575qoXr2HxYBJnvLhq/je88BxqDEWI5YKUCshUGRz2RCeXMC6tYqzWizlQYtx/kw
	 KWR1QuyfaE7DuJao2mwh45Pf3rBGzUZtw6UjW4hjlm4x7iIDsKAvSmtMIVgNkaphnJ
	 rHGjXnLk1KCNIgMPO3WgeIj1bzxesG64/0lofgz6VpP0CL9SX8nawOiQVdNI96JvDj
	 Hz1djaXr1eVswsPB5gns/G26EcoVWLo+VA0IPGqLxlQKYiRU3Zh18rlqfhvZqZhfeD
	 kOH4627g21p/g==
From: netdev-bot+sinfo@kernel.org
To: Linkui Xiao <xiaolinkui@126.com>
Cc: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: 
 Re: [PATCH net] net: bridge: netlink: do not clear the vlan info dump error
Date: Tue, 27 Oct 2026 08:55:47 +0000
Message-ID: <179309134717.3327.17438354236814047357@kernel.org>
In-Reply-To: <20261027085200.1501599-1-xiaolinkui@126.com>
References: <20261027085200.1501599-1-xiaolinkui@126.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
