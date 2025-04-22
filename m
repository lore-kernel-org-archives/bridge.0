Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17DC1F09B1
	for <bridge@lists.linux-foundation.org>; Tue, 22 Apr 2025 22:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745362199; cv=none; b=oVQY4jLbtpiLGCC35lLX585DIymurfSeG0CEAjZyYcMunEZiabMioHT18sQTvT0NzxKvh2Y+goOmWidetTb8ueX9UzIgDERYPZ8ofajE3QYZQ4WZv44ot9CiezSfAUwj49ZlntkW+8ED6fw5nkz1KNq4VNjMBhB7n8YpLbZy9Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745362199; c=relaxed/simple;
	bh=gK02uRtbIPfT0wi8eklMvtcyFjPFLGNwxr2+qteMrnE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bRImYdHWFmPxuVksueZEp0Mu/m0pb/vqf8URHtBDPnN8BwyMZay9kGiVUqm6AaGb51rx1qU9MU1AZnaXZWCMIvs1UbngKkHLy6bfKpxPEBy7OTATs6p5WSRsasFLC9CI0OTP9zV06luumK0dfTjICN2pHqtNoz48jyeL4aow7Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFn5y/l8; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFn5y/l8"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4381340CC5
	for <bridge@lists.linux-foundation.org>; Tue, 22 Apr 2025 22:49:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -10.792
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HlgXTLSXTntU for <bridge@lists.linux-foundation.org>;
 Tue, 22 Apr 2025 22:49:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7DF5740CB6
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7DF5740CB6
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BFn5y/l8
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7DF5740CB6
	for <bridge@lists.linux-foundation.org>; Tue, 22 Apr 2025 22:49:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 11F6F5C3B5C;
	Tue, 22 Apr 2025 22:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71A2C4CEEC;
	Tue, 22 Apr 2025 22:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745362195;
	bh=gK02uRtbIPfT0wi8eklMvtcyFjPFLGNwxr2+qteMrnE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BFn5y/l8E2U2vjMF4Ao0SOlj0cvksEMNuehxjcTYbeqNyrTcsRK72/jyCzQZJhkKB
	 uWiFcyaRlQfGC2HiAmsz5yIzo4uw7/11RTH2HkGsrWMIk+SHj3MI3At28k+PU4jZOp
	 Hwn7Ig1KZLcsHc3VaPvqrKGu2U9eJlpAUDdAVIPyvWtkdqda8klhgKBx/pgnIzxLRg
	 I7L2tcSRhNd6m7EDCNCfvpNw3Ps0M8nujulMay541+00y45B1Rs71GEeZ4XAZ/W3Zu
	 r2oLOWKTuxTgWUzRMsVpqufT1Cd3IO/2I2kXXkWyhwovqj1UXaxSudDTxRncbcs5aQ
	 MiLLXVutc9XKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7146E380CEF4;
	Tue, 22 Apr 2025 22:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch v4 iproute2-next 0/2] Add mdb offload failure notification
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174536223428.2078978.18421801962462859445.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 22:50:34 +0000
References: <20250415144306.908154-1-Joseph.Huang@garmin.com>
In-Reply-To: <20250415144306.908154-1-Joseph.Huang@garmin.com>
To: Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, idosch@nvidia.com,
 bridge@lists.linux-foundation.org, joseph.huang.2024@gmail.com

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue, 15 Apr 2025 10:43:04 -0400 you wrote:
> Add support to handle mdb offload failure notifications.
> 
> Kernel commits:
> e846fb5e7c52 ("net: bridge: mcast: Add offload failed mdb flag")
> 9fbe1e3e61c2 ("net: bridge: Add offload_fail_notification bopt")
> 
> The link to kernel changes:
> https://lore.kernel.org/netdev/20250411150323.1117797-1-Joseph.Huang@garmin.com/
> 
> [...]

Here is the summary with links:
  - [v4,iproute2-next,1/2] bridge: mdb: Support offload failed flag
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=7e24631ccf31
  - [v4,iproute2-next,2/2] iplink_bridge: Add mdb_offload_fail_notification
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=4f4e3bb5c3d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


