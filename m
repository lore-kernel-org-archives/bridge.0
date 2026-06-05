Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135F0324B31
	for <bridge@lists.linux-foundation.org>; Fri,  5 Jun 2026 01:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622424; cv=none; b=RkqLOKpc/PrJFInIbvpCIcp6SawR1tK7F74ulzHiF7nhFG35CLcUvPAYD30qGdaINMmRbpUwMgiP10aNhMAS3dKIMCb/Dd7sedeHHW4PQO3MTy5IudG8achNmrgmaTIaJPdqXPRkcLLYCIK91DzGt4qt/5S4xVg+kDTF0MlBpnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622424; c=relaxed/simple;
	bh=l/r40VBOQDnOqZgdgyKpgvvV2c7x5HBfWSjTDu+dX3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CZqApGOKAezzKcYX9JoH4c1FpEYSwL0kCPCPvBE198CdMJ/zl4IFwwTu4nmKKDYK51ZTVgb8mjFAB7FiM33RQDA3tZ53rbJVlPjgY9+Zr9cChC6W7kiYiK4IAb40el3gg4vPe3ccoOAD+Z02LBw7mEKbmMnQPNV39/eX9EfR05w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHVJ9wgo; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHVJ9wgo"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B8BE6074C
	for <bridge@lists.linux-foundation.org>; Fri,  5 Jun 2026 01:20:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9_jZLvwn4Gpg for <bridge@lists.linux-foundation.org>;
 Fri,  5 Jun 2026 01:20:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C1F826074A
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C1F826074A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GHVJ9wgo
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C1F826074A
	for <bridge@lists.linux-foundation.org>; Fri,  5 Jun 2026 01:20:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1755540C46;
	Fri,  5 Jun 2026 01:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6041F0089A;
	Fri,  5 Jun 2026 01:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622417;
	bh=ekDCFzXsFkRGi0GgX/tAP2jZ+LijT86BaWK9QE9YGXs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GHVJ9wgoY6Mi0gIj8tnQZ1Hl2FLY8x8UFf0KRYeR6Cek/heXF4+S5jDfWe6wHUBe+
	 POYMu8zKLrm2/R3CNYgoJjfEu3IJxry59PGdoTkVx9DwlN+6bLJ9x/Wa2LUOkug+me
	 rGsHDJd1jQ63RiJeWHhwKvCVvYQz/Z60iqZQoQ0IhjKJBT21evMw6SSVtj5dQ4C3ku
	 iVDQ8ZG1xkUZbqLlFUF2ZmCux6MxxVC0gKbIE3HOQsSCxj77LCmhXC8Vt2gxyrhIFU
	 mXydskyFMLjt2SDhnocevq3FcDQiv35aFVpSwbMF3kA37eDd0RQMDuOmiYgOR8y5L8
	 6nyAOaLH0TCLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B1B3930A8A;
	Fri,  5 Jun 2026 01:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bridge: mcast: Synchronously shutdown port
 multicast
 timers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178062241739.3090676.1203878185997865685.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 01:20:17 +0000
References: <20260603103522.622411-1-idosch@nvidia.com>
In-Reply-To: <20260603103522.622411-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 razor@blackwall.org, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 13:35:22 +0300 you wrote:
> Currently, while four timers are set up during port multicast context
> initialization, only two are synchronously deleted when the context is
> de-initialized, just before being deleted.
> 
> This is fine because the structure containing the multicast context
> (either a bridge port or a VLAN) is only deleted after an RCU grace
> period and it will not pass as long as the timers are executing. These
> timers are also not supposed to do any work at this stage. They acquire
> the bridge multicast lock, see that the multicast context was disabled
> and exit.
> 
> [...]

Here is the summary with links:
  - [net-next] bridge: mcast: Synchronously shutdown port multicast timers
    https://git.kernel.org/netdev/net-next/c/7a188fcc18d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


