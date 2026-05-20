Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C658A2DF137
	for <bridge@lists.linux-foundation.org>; Wed, 20 May 2026 01:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779240602; cv=none; b=AaeguiJPkaWBVaatySvEsVH0kERAKensFOe5iJGpl3lL4ac46hegq25PVBhlZy9Ibjmh7wUXhcDkYeo7XWfej8WQ+3LwF1amVFrqkgyrfnJdWtuc/R5mgptaP/MlBN4Jtlcx0ZaJy5BRh4W/uM9b+bxaEzMfaM2O1sJA/riI+5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779240602; c=relaxed/simple;
	bh=sM1L1zx+i2ahd/cTMDH9+znC4xMTO3u/lXS6BOMeSBU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kcpxPloCXeQa8JirvcCnOt18dWSLBxHQ6Q4aP1h+i9QIbLpTZE1eV2LDPlk5x4o3JNma5PdAJqFyRF28EhIIR9DHwI/0SrzBhYQVcy/8DTU2y/4yZy8PrGw6sAfW2tW4ASFCs0SuBTaHcvPuDiaBaLeCVz38u71nB4z2e/qIpV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5B8zQvz; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5B8zQvz"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E6D68231A
	for <bridge@lists.linux-foundation.org>; Wed, 20 May 2026 01:30:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wBiBz5rn8LaF for <bridge@lists.linux-foundation.org>;
 Wed, 20 May 2026 01:30:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A9E6B82319
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A9E6B82319
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l5B8zQvz
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A9E6B82319
	for <bridge@lists.linux-foundation.org>; Wed, 20 May 2026 01:30:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D35446022A;
	Wed, 20 May 2026 01:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846071F000E9;
	Wed, 20 May 2026 01:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779240598;
	bh=jszwEy24nLcTVgF3m5AFIH/l9o58q+amtk0RnAFl0DY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=l5B8zQvzlECZ2ERhen3wNV1X03DG0ukqKYw5UIO1KAiA37ppkfBphvmUUKeLXDGJq
	 GOYcvTHW66fbzXNZVaFJjKRWx76OpsVSrV4WLBU/Z/tOIAIdfJ1lNNnNZwLqlBRYdf
	 Si3cAsr3CbjYfwNmRG+HylhNDvsqqxt5BBcX+93RBJdJJe+noXCWsrceAVMOwEep1B
	 bzPx+gj5PbA7qM07TOMAXJ+07P3ujRJ8DfSQyaIkB7oO3n2T4VnBZviui2bPsLOeyh
	 j2jo0MB1EB8Waly9jiOKtuu5o144l/fy5zYOlWDrxDPh4j/TPrOhxBqF9rUvusVD2Q
	 lVchhj+4EojDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939B4383BF53;
	Wed, 20 May 2026 01:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] bridge: mcast: Fix a possible use-after-free when
 removing a bridge port
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177924060914.2943546.7719678973905052337.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 01:30:09 +0000
References: <20260517121122.188333-1-idosch@nvidia.com>
In-Reply-To: <20260517121122.188333-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 razor@blackwall.org, horms@kernel.org, dsahern@kernel.org,
 yongwang@nvidia.com, aroulin@nvidia.com, petrm@nvidia.com, tglx@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 17 May 2026 15:11:20 +0300 you wrote:
> Patch #1 fixes a possible use-after-free when removing a bridge port.
> 
> Patch #2 adds a test case that triggers the problem.
> 
> In net-next we can:
> 
> 1. Add DEBUG_NET_WARN_ON_ONCE() when a port multicast context is
> de-initialized while enabled.
> 
> [...]

Here is the summary with links:
  - [net,1/2] bridge: mcast: Fix a possible use-after-free when removing a bridge port
    https://git.kernel.org/netdev/net/c/4df78ff02629
  - [net,2/2] selftests: bridge_vlan_mcast: Test toggling of multicast snooping
    https://git.kernel.org/netdev/net/c/ae743a8ca8db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


