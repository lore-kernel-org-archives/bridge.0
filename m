Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489A43CE481;
	Thu,  5 Mar 2026 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772727032; cv=none; b=UIMHvglgaQBE0290VWWqb32wFoIzgvxUtTn1Z/nGf6IHVgVtRf6VBkQCCfpQBnPWftWDuLP42uV0Osp9W/U4GbMGHSRsAskvnhM0lApVo0Bz5hOsuxvkbeVwZLssNMoCVUKOohgybbURTF81yoIZzRfKQYMjnomsH2bvy2XlWF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772727032; c=relaxed/simple;
	bh=JbkmzA5NT9w481WQQZ9L9xGW0U2u7zXu0ubWo2eH7ys=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NB+FUbJ53BvTTrbR0twjISstRscQLRrZ3zJQTZo8rfWwesKf3+WTZ2LnbOdGn4NpG3AuhSRpvcJSln0mjsYv3fqOtutKX8GgbXvMjRVJjN7BlauFGwNqBNrZMo/m0QsKsrwIU8XwA+6BaQIRIfAiDiDztvR/Y258xjBQ46SMSF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnzfeAhK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnzfeAhK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01279C2BC87;
	Thu,  5 Mar 2026 16:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772727032;
	bh=JbkmzA5NT9w481WQQZ9L9xGW0U2u7zXu0ubWo2eH7ys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YnzfeAhKgKqi4R76z34Xc8KyKzRfL2ehp7SFrgFlKZ6HAZR92RBPjFTgjhIhiysmC
	 +prNjc0KIu2yYV3+SWfIMfVzLtPk4+gWBNxHOHTqjNa8qehpAHuyjv8itwpM/FycmF
	 HokPk+m0kgVYvNFlGrTrgnsltiYiLyrToZQvwnX8Rl/zwLWSlpy/whvR1NdX/ppLv+
	 dC5PgSg6GR2Bdx/ZqRet1uPrmNfELT9fgvgB2QwM/STGZT1wH0AmsFOp3z1BkBauZn
	 Mg3GdDUufFsmyV+Z7Rb1V0VvDir8yYhrDfNR3OCRAv5WKG0KVPuy0k4QUH3Te5GNOH
	 ivfh9M1E906Mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE603808200;
	Thu,  5 Mar 2026 16:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2 net v3] net: bridge: fix nd_tbl NULL dereference when
 IPv6
 is disabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177272703204.3188128.4802292927759859112.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 16:10:32 +0000
References: <20260304120357.9778-1-fmancera@suse.de>
In-Reply-To: <20260304120357.9778-1-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, roopa@cumulusnetworks.com,
 sdf@fomichev.me, petrm@nvidia.com, horms@kernel.org, idosch@nvidia.com,
 razor@blackwall.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, gurucp2005@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Mar 2026 13:03:56 +0100 you wrote:
> When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
> initialized because inet6_init() exits before ndisc_init() is called
> which initializes it. Then, if neigh_suppress is enabled and an ICMPv6
> Neighbor Discovery packet reaches the bridge, br_do_suppress_nd() will
> dereference ipv6_stub->nd_tbl which is NULL, passing it to
> neigh_lookup(). This causes a kernel NULL pointer dereference.
> 
> [...]

Here is the summary with links:
  - [1/2,net,v3] net: bridge: fix nd_tbl NULL dereference when IPv6 is disabled
    https://git.kernel.org/netdev/net/c/e5e890630533
  - [2/2,net,v3] net: vxlan: fix nd_tbl NULL dereference when IPv6 is disabled
    https://git.kernel.org/netdev/net/c/168ff39e4758

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


