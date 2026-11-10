Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279294;
	b=BTmq0z8r6i3MLzdaAi6iXVCll5JxtfIEwnN7DjEDE7+5ahdugrKRhrVqMni4JgOzaBfc
	 JWRg1+ZLac+kDkxULoW43ToQPcuuqCLr1C4R+c30M59Jd4dpKGu5D5aVA/m7ryxGc7ocN
	 VbgggBDGU15lo0n/ljhNNfjwavZ/Szi7AveOGR2DyGwX4sbO+K36iNMwk3hEJhyWcwOYG
	 zrZY4D9cCUBx3E/0aU16Y8N4GyOGkHlzj1PPKzXSnogotqLZnrPdostEue/K0B638QzJh
	 PmVOE5a62YYDa5t6OmfknJbZaDaplOe/XIPNP9H8/jSvE8L8MVNnVNsI/z/dcLJ5yTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279294;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=jv+vF3++GwgqpQ1PH4C9bCjUHyBWz4gvH4XJmA0knyY=;
	b=jtik7AnCp0XIM334RuBUKQaFsv6ufRxWZdtCGhQvy4MH8dSTAIkrdqRstOnuDxmeeXpE
	 E7rXrQMrW1a1SjszzsqT2hnol/cEf+oRupQcQBAH9vYvb6Yz/hkIUCbl8Moe/zuV0hVoi
	 CUqBDBh6YT3BcYztZz1zLKOH7/TJIk63GnllOAPP6ySKHd7mCA5PrsBcj7oJ09kJdk4Dp
	 WT9v2wESmIMmHpIG/9P1bJEVRbp8iPM3sAYBQiVRvNHAdN6rUfXMusPXgNzcU0e29NsCF
	 Q+dcK4B8HSz/0avQRdM8GMNUrgENR4xLruR5qNMPYqBCrzi3ClXtBQw7lIQoVZreBkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gbKJ2Csy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545DD606A337;
	Tue, 10 Nov 2026 02:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gbKJ2Csy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C51D1F008A2;
	Tue, 10 Nov 2026 02:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279294;
	bh=jv+vF3++GwgqpQ1PH4C9bCjUHyBWz4gvH4XJmA0knyY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gbKJ2Csy1FIT4dmShDTHmvbS1oaTqSWKenfibZkUYiNnzKxe/NCQagYP9mOWv5s6V
	 1DapM4PRl2C6QLbdqKa959wVFIaBJUmaS0gn+ucag68AiAkzhS3ISSk6HgroS5UC6W
	 ND6aM3rjLSPlitySwOq0q7M+vVlwrSCPVPqKzb5SWwTTyQ4zb+GiiI1Nwx8enXlYOr
	 SIpnPznbP/7ios88peVrsf5AbgFpu/WMQZLg8D5N8kOV262ZqWIayxcrem+7GB/rO0
	 gbt1959LzVM66lXb+Q3cS9BaP7y+WTpB9BtYCvHirDnm2xpKgu8ZURpqggF6mQKp8b
	 UQ8a6LBrirM2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 20FCA391AFCB;
	Tue, 10 Nov 2026 02:54:54 +0000 (UTC)
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
Subject: Re: [PATCH net] net: bridge: use one headroom snapshot for ND replies
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427929267.3612825.9041747036599625059.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:54:52 +0000
References: <20261103075439.43644-1-juny24602@gmail.com>
In-Reply-To: <20261103075439.43644-1-juny24602@gmail.com>
To: Jun Yang <juny24602@gmail.com>
Cc: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 roopa@cumulusnetworks.com, bridge@lists.linux.dev, netdev@vger.kernel.org,
 junvyyang@tencent.com, stable@kernel.org, corvus@tencent.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Nov 2026 15:54:37 +0800 you wrote:
> From: Jun Yang <junvyyang@tencent.com>
> 
> br_nd_send() calls LL_RESERVED_SPACE(dev) once to size the reply skb and
> again to reserve its headroom. When a port requiring more headroom is
> added to the bridge, br_add_if() can increase dev->needed_headroom
> between the two calls. The reserved headroom can then exceed the space
> accounted for by alloc_skb().
> 
> [...]

Here is the summary with links:
  - [net] net: bridge: use one headroom snapshot for ND replies
    https://git.kernel.org/netdev/net/c/e573df093ef8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


