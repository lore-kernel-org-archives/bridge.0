Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333381;
	b=al9ecym/XqRpdH38KjmDGrKISnBa86hItSd28KrYp6od+p5H9YgGkEQgU59YYQw7CHP4
	 3OYyflsiCcwLvlQrQq7HMLJShrEIEAk8TAMZVvj55x/8ue+NEqj4M1NgmjSKfH27GeXC1
	 +lKdUTzd8gKvlAcs6gRZkiUnScMl4JGN9M+KyygQe1j9cvanVqUyI4EhnetXv/Ir+qiRB
	 PHprNhFeCdmWvD03yXG4814yB5ZapytAU8wxGkmTcBPnuUmaIU08J153HMNPtXwLBoLoX
	 PkVIruZjPNi0D/h0pC89HfghBSpBXEVtP45SkuNpHqBllRGvfn+fVptCNeyn7QSDf/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333381;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=A/cdGv74aiAJeIyw8LXkjIfTsdqyySLgcmusJfQyN618sk/oDKwrFsi5qmeruDAkUZkA
	 76ZdyjB3NH7mkBzMnrjUeX/4fQSP5R4xlFFaQSFVEfbRn69LIKLQTowXv8j+JLygApO8m
	 iMsGcSibV1fw3AvTIBFDZCQzQAmWIPPTOU/xZJfY23OYiarV9epWe10rS8M2pqdAB4LuZ
	 Fnn9BKxPtRs5oN0eVUAqBrh+2rh5uH2p23ySMDkRhSOnIqrRYIacFN51XbS9Clnb2lZGU
	 2NYlOAt4AAsGjbGRhqBiIDeGkJqO374aoVVSZUys+hESuzdFPkaukiB5SvkW3e6gM1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c4axleEq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA33606A31A;
	Fri, 30 Oct 2026 04:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c4axleEq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A701F000C1;
	Fri, 30 Oct 2026 04:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793333381;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c4axleEqiXEoup7ZvFzm09nyH2eSCljYfdHVuXZuRIKEeVj9ry4XnhzkndNXazoEs
	 rnMOePMfTEo+wC/Mn6p0xEgTfQUOSidsYikkJ1zgEhIjYJqZh+kj6AdTVGUp2U+4HC
	 8qWwst4AaN1iS89CLVO/FGSeDVUtcNSn+5xb8QTEQHtPNfhEKIMkHpU3Md7JExEHHj
	 tuWDwEHS7vjkslBYEB2JWHwm0s0wZLmhBtORCK8m1hiyNUiU31qV2k/1skKjRq6V97
	 7vHaJV95oQLu0NsQHIKNUKwE7LW4hx05iG+5qHMJEX+gnWpr+em/kYMlqezb6SfhgR
	 O7aKXc4huxOhA==
From: netdev-bot+sinfo@kernel.org
To: Cheng Yongkang <teel4res@gmail.com>
Cc: Ido Schimmel <idosch@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: bridge: disable MRP ports before the FDB
 flush in del_nbp()
Date: Fri, 30 Oct 2026 04:09:40 +0000
Message-ID: <179333338010.3327.13357220384728515443@kernel.org>
In-Reply-To: <179333317814.2102764.8780283783548366593@gmail.com>
References: <179333317814.2102764.8780283783548366593@gmail.com>
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
