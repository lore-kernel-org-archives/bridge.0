Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794970207;
	b=VlL6X/pwtUrkdtUdflObelLFQ0Qiw+1lbgn4WCe6ahNKuH7G25biaQsN3+/T+Eg8En/x
	 s5+5K2ZhK20wt1Qms66T2BIxBwZS9PM2M5fGu+Ua10giuRMjuxAMA0T98AELPg6qtTHKS
	 RBZDj3cWRPzZsyyyEDT4qc5204PBugNPMJwV6Qp4jf7dqWM4oQccxpZWDOZgolr576xyP
	 A2V8f0qQHOm0l/oO4sUkPvnWbNbk0M6Zc++4ye8ILhJtQp9ZB04wTpbSXTaJnC8p0MV6v
	 SCv4jUfxgVYqvVcO+suwibl8wn7gwBrWC+RdMaU+j2b1guTr6NmWWvvXSxIgnKR5RFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794970207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=dzhVr7ooy4NmV1PPNADeNTmJcEBZPbMvTHOVGSY5ZGk=;
	b=1YW5EoCn9+PWoJWKEdi37+RWSrGU+QH8jJ7O4MRqPPfXraF4PxvI/oIv2fWBXUvFOPdD
	 V0u36h0EWB5DWUe66fdb38da4d9dhXYd50N2uLHwenKCAlN1zOgGGLuzm572R3AdKL/9W
	 5q0t33zKaqB9B84iKGk1+EJe+CuVjdABo8kFFsDu1pw/yrnJYupr7LDcNY2lHou6UtaHv
	 NqHeEQtn6BHGFPemjqwVa6HzRq/20k2iBI6B8TJW5RoVdwcrXgn3XYpoO4pr5qbJ2y8IK
	 Ngg1wyWxF7CqwQ93EfdMaIb+5or0C0F659MVhzUxMuEUqw2syPoIKsUFhAODu4IR9IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iw1vZ4S3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4538606A31C;
	Wed, 18 Nov 2026 02:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iw1vZ4S3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097501F000C4;
	Wed, 18 Nov 2026 02:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794970207;
	bh=dzhVr7ooy4NmV1PPNADeNTmJcEBZPbMvTHOVGSY5ZGk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Iw1vZ4S3/CRkf1mYAuT9nXZY6/P8NAT+0CoIOge0mliGxX860kOhqYgFQpFP+rE+l
	 cDamF2B7g4qdqt/WTVIrd4PV5KiYMzLI/ZdiaN7kAP9bUkleOAowqEvm1MQJBmjLY7
	 dWxMHBDCrwhZcPlvyzX7dD6qRr/vA5/gNl5cJG/UCWbAEOdc04nM3HpIB0z/5UFK5J
	 zClTwZy7pRxNwNClDuYpumdqTFUR7pBq213b7op1VguEQEVUjAL/VQfYOal/CtbPgK
	 pFvYlfdY4PCYUULkpMROp1Jx5jzb+aNPal9XAwjTSpFhtLCjzBw6f77kLUwJ3OJSlI
	 j6gINp+57VB1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1556392B1FF;
	Wed, 18 Nov 2026 02:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
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
Subject: Re: [PATCH net] net: bridge: fix skb leak of reinjected link-local
 frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179497020578.1430642.1274657276624361229.git-patchwork-notify@kernel.org>
Date: Wed, 18 Nov 2026 02:50:05 +0000
References: <20261115130211.7724-1-danjwade95@gmail.com>
In-Reply-To: <20261115130211.7724-1-danjwade95@gmail.com>
To: Daniel Wade <danjwade95@gmail.com>
Cc: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 15 Nov 2026 23:32:11 +1030 you wrote:
> br_handle_frame() passes the link-local frames it neither forwards nor
> delivers (01:80:c2:00:00:02 to 0d and 0f, unless set in the group
> forward mask) through NF_HOOK() at NF_BR_LOCAL_IN. Since commit
> 3b2e2904deb3 ("net: bridge: fix per-port af_packet sockets") the okfn
> only learns the source and returns 1, which becomes RX_HANDLER_PASS.
> 
> That commit sent the nf_queue case to RX_HANDLER_CONSUMED, which is
> right for the synchronous return, but the frame comes back: on
> reinjection nf_reinject() calls the okfn and ignores its return value,
> because every other okfn consumes the skb. This one no longer does, so
> nothing frees the frame. NFQA_CFG_F_FAIL_OPEN leaks it the same way
> with no verdict at all, when the queue or the listener's socket is full.
> 
> [...]

Here is the summary with links:
  - [net] net: bridge: fix skb leak of reinjected link-local frames
    https://git.kernel.org/netdev/net/c/98382d41f92f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


