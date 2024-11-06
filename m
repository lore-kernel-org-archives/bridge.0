Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B519F205AB4
	for <bridge@lists.linux-foundation.org>; Wed,  6 Nov 2024 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730914230; cv=none; b=kKOAeWOdXDnAysGKBgak+IRKpCoy2tUGN/aEyfULlMzfEwIqKa6JIx3Rnq3kQh1GDGaUn+8IrNLmRtNOx3vjqADnnqQSNAqKDIWTj9OYFT8QzQi8oGHjlgR7DPUgEBToZRjXVte0Z0w/nUlB1sHrOM6qY7vEpLZ0v42aEhUjf6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730914230; c=relaxed/simple;
	bh=6PO2Ca1A/vzU4wQCwF7I2kgXYYW7dV0ReS9gXG9j7RE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s3yGNxAqXWi5Z/keAQinmfn0lxBgE4F7xBuBG+p0pNVpLM6t25qglJD+SCuSgVABCXL1dnkX7PDvDpBQ5z7zrrY0b7UFMI9D+NgupFk2acV4jBGc2bIFmFMxi5fvL1IubqaHVtw0/qqshjZlmAHik9xm6xNrbhXxRJXK+IcviMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlRbTOHW; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlRbTOHW"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30C6C406FD
	for <bridge@lists.linux-foundation.org>; Wed,  6 Nov 2024 17:30:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QoUSwuWlHTNY for <bridge@lists.linux-foundation.org>;
 Wed,  6 Nov 2024 17:30:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0DA9D40621
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0DA9D40621
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XlRbTOHW
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0DA9D40621
	for <bridge@lists.linux-foundation.org>; Wed,  6 Nov 2024 17:30:25 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 24C0F5C0767;
	Wed,  6 Nov 2024 17:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA84C4CEC6;
	Wed,  6 Nov 2024 17:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730914224;
	bh=6PO2Ca1A/vzU4wQCwF7I2kgXYYW7dV0ReS9gXG9j7RE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XlRbTOHWwehry9SszKOH1ux+2L19eCrYdLzSyXBVekRUHzjfIO5jkjGmcCaHfMcU5
	 ZoI9qhP+YvlBfbyN3BGFbphE6GkUkRqUksvtgIuraPYdewab8HcnQBqxvbIQPOw7sr
	 YqEtAhyVYea6FJH1RCRZCnCA6wEWjyeXqonk1Xi/3Uvxc7WTB5PlDb7ShtdxwDQp50
	 2BdYWaBb2gHKUTowdFZrVBhwQvTidj9a6SlUbr3y/FQFxJoMVufx/7RkKCudgLPYoa
	 g7igNv1pQGxk1e87mT1hW1zHkPnjFuLFjLCIt2GE+Kh8lF4MxyE9Uw3y3Pu3mFzURm
	 QHgs/9+mgjuaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF4DD3809A80;
	Wed,  6 Nov 2024 17:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] bridge: add ip/iplink_bridge files to
 MAINTAINERS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173091423354.1355897.85598411385203122.git-patchwork-notify@kernel.org>
Date: Wed, 06 Nov 2024 17:30:33 +0000
References: <20241031085143.878433-1-razor@blackwall.org>
In-Reply-To: <20241031085143.878433-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, roopa@nvidia.com,
 dsahern@gmail.com, bridge@lists.linux-foundation.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu, 31 Oct 2024 10:51:43 +0200 you wrote:
> Add F line for the ip/iplink_bridge* files to bridge's MAINTAINERS
> entry.
> 
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [iproute2-next] bridge: add ip/iplink_bridge files to MAINTAINERS
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=5da7e66992cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


