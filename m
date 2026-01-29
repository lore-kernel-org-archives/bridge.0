Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09BD238159;
	Thu, 29 Jan 2026 03:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769658013; cv=none; b=egekLZPGoCZt2t7J3+uTTg2nw+kSGRtz0O+Ad3lIHGFkGBNT4yaUlfytyy35SJQqUsuPTrbqXizTSoMuxHNHrEDYyXGLRmgICI9O6TM3pYSRp4+lGOnArOr+ogE0bNKzP4v9eXvXsjDqFS6t4P75Z3/OYLNKBnFDbKv5oUKdBwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769658013; c=relaxed/simple;
	bh=SAcfDDr39ZzbcKHfiR2Q7sWJKOvFRmGgM8KQHEsRjUg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EiaQEXuzayme4w4lrs/qK6lJeyN4oDJyg2GGigot/sEpQxHqWB4hLk2/A9VGBU8tnwUXBW8ejTHVZQkimDOGoP6Y3+1p36nJSzlmnxBuw/A7TcyqNKyTLtESiHfvJoiaB/Vu3wss7jgN0CCBEf2Rh5SomDsXzXOiBLtEfD8dvj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OS4gXBOM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OS4gXBOM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2141DC116D0;
	Thu, 29 Jan 2026 03:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769658013;
	bh=SAcfDDr39ZzbcKHfiR2Q7sWJKOvFRmGgM8KQHEsRjUg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OS4gXBOMD83xqG8C8i10PviyJvqUv9Merdd1uZOZ8RDUjMEjKFzUayCov9lYz9ex+
	 63PdseGceohRxa0sk1vSuMR9zC45u7ACrlEwCvGoYzpIyWEu5ZAia6t8os0U8WwdF0
	 Xbum766Z84r/SI85DmUYRwgn+YynLnlqbAUQAED1oYSwl3rEu6wDiz8kMv4HEk60QC
	 gqu1bzvV5MH9WOLjiVJCIlWxwHxzBdqvW88LdBjy/GP1vW0pEYxqVv4/a9OfM0nq/c
	 JucOm7CPp6W8J1ywVORmZJo2qKdd3B0zZg1Qg427+xS94XlRwCYuCy3252X6+hFsUf
	 wKXAQNXwNSFrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BBED380AA61;
	Thu, 29 Jan 2026 03:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: bridge: fix static key check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176965800635.2337808.7777015611484468506.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jan 2026 03:40:06 +0000
References: <20260127101925.1754425-1-martin@kaiser.cx>
In-Reply-To: <20260127101925.1754425-1-martin@kaiser.cx>
To: Martin Kaiser <martin@kaiser.cx>
Cc: razor@blackwall.org, idosch@nvidia.com, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jan 2026 11:19:23 +0100 you wrote:
> Fix the check if netfilter's static keys are available. netfilter defines
> and exports static keys if CONFIG_JUMP_LABEL is enabled. (HAVE_JUMP_LABEL
> is never defined.)
> 
> Fixes: 971502d77faa ("bridge: netfilter: unroll NF_HOOK helper in bridge input path")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> 
> [...]

Here is the summary with links:
  - net: bridge: fix static key check
    https://git.kernel.org/netdev/net/c/cc0cf10fdaea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


