Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B872C22A4EE;
	Mon, 27 Jul 2026 23:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196241; cv=none; b=HN7i5+Fb6VG2y4Qv/51iavyLJthWSXnBtwskdiKMP1qT8skPjvp5g7nqkvvalezHwW4wabwh7CoyvTtMkC19SNtN8vqDa5PyRsjtyAA3rP2ZR/WN6DxhKBwWxXMIQMxzUqNoAQ/QiLL+gXBi2g4AUcfGVaF84ETVPMu37eacucA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196241; c=relaxed/simple;
	bh=/sBJ4yG6RA3KK2Zu0s1Plg1jSMbrwfuEWvGzN0+saUw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cWBihZQjTw7QhHZVWk8YLyV//qa9qL+K3+Ow5f/qdaVgtjUlwZW9mzalYrFEgXYhcMujgOUWXFzQVNZPFJWcLm29zZPP5rXAcUkWjcGCCsWXNbZbVR0KXJGw4W7nXj0kY4NCzG0U0eJ0YuoUd2bD8T+LBysbKYfdjniECesMG1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPbXRC01; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPbXRC01"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A571F000E9;
	Mon, 27 Jul 2026 23:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785196240;
	bh=pJlgTfAI2YJyHJfU+AfJCsMrXgYqX2SAdmsANoBhUQk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZPbXRC01ESqUjd3YL6d95qBYvFFn5H1+r074OEmP6LdbB2toPVFctNAF3JHmaaenl
	 iXfrl56DhhTM3GD+rrm/Lda4MoOv6qI3wW2pLgiHVkSvLqVdlHZ2QTVTX04VOhcUqp
	 Q1JB5+RppVF/QN9MBpYdsSpoH0Ign/3DCDj+0jmlUwYglEFMHDws5VPGqksNnQ0d+Z
	 87jVMP5vnMpMV5H2GVSJRRICc/n9CP+8t93tp2WGyoUQVmg5toePSQ4gPystcSph6o
	 TXqT4ZjyesKDwxk6AZvsJ1WT6ses6G8Oq6FclKcBwLtaO5mrww8yJ9Yt28bYxTkogK
	 CU26rcokCsmeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C3B380CED4;
	Mon, 27 Jul 2026 23:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: bridge: mrp: fix Option TLV length in
 MRP_Test
 frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178519620536.1464655.11874227970651465102.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jul 2026 23:50:05 +0000
References: <20260726062605.2746-1-david@corvaglia.dev>
In-Reply-To: <20260726062605.2746-1-david@corvaglia.dev>
To: David Corvaglia <david@corvaglia.dev>
Cc: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 26 Jul 2026 06:26:05 +0000 you wrote:
> oui is a pointer, so sizeof(oui) is the pointer size. The MRA
> Option TLV thus advertises a wrong length (15 vs 10 on x86_64),
> causing misparsing of the frame on peers. Fix is to replace
> with sizeof(*oui).
> 
> Fixes: f7458934b079 ("net: bridge: mrp: Update the Test frames for MRA")
> Signed-off-by: David Corvaglia <david@corvaglia.dev>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: bridge: mrp: fix Option TLV length in MRP_Test frames
    https://git.kernel.org/netdev/net/c/5546da86894d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


