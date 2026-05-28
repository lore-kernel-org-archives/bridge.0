Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265F01A0B15;
	Thu, 28 May 2026 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928208; cv=none; b=auyNK6c6bzHqKWdve6fOzEKQqr7V/R4IZUErO6q7/Po0pskQGyNrfV8SLtbr0RX/aBaLn59YmNzRrpuNhBNtRVi0Kfe6z6TbgtgLD/EG2hTI8/YIriOl2mDpE+zY2R9dNFPRxF51bWq/Vd8cKZBcdxXNOoOwaA5D0FY/Oj/hMf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928208; c=relaxed/simple;
	bh=Cl+WCey3503Hpimo3w/zqfEW/ydEQJcAgtb2Ic4F8Yc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AW7OZd1uObruscyKnukKDzg8bzI4Xneyudf372izF4BNRPz2Wc0sdjjGfaVFO1gcf8sgyijshvim9WW47YiuuRqVTdvisDy0oxLtSuykTtZ0RO+q9jUCTrpuyMyIV1LE3CBGs0keLWm3sxZ9udPFMKlCFQaC/+5PQ0MHWper+mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKWZhy/i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKWZhy/i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC7D1F000E9;
	Thu, 28 May 2026 00:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779928205;
	bh=vCljM/Dh6ed/8Ny/oyfstf/pPL8U/xiMjs57EmJhId0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NKWZhy/iS7rjiAU3qap+iQx3N/D2Y9Y/kzZKtf+cIRBk+HiTQS/HYIUR8iDb+geaE
	 vbbJY9WL2a7a5sNo7hs7EDEHhhohNUKJpEMDxlzJGaDaf5l/1dZbp4z6YXksk/W28U
	 WawgxM6hrRuRfgQRWIVz7slAxlWSSv8AI3lu7qI2qx546pwjlLjENrf3bXN/+pIRS7
	 d7efw6os6Xb/JT+9fTKAYkV0ADy9VoXE8Iey/D1eQj0euNuSga6QjHdInxFOw/oC3O
	 K0oKDYaLbSa+hx/ADmsMs7M+VnQeTK7Jbeq0h3sKROoEEiXle22xoHEWKgdcBMzV+l
	 nvCYUsDGl3KAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0CE6380CFDE;
	Thu, 28 May 2026 00:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] bridge: Fix sleep in atomic context
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177992821039.694601.7451967203555108525.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 00:30:10 +0000
References: <20260526064818.272516-1-idosch@nvidia.com>
In-Reply-To: <20260526064818.272516-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, razor@blackwall.org,
 horms@kernel.org, sdf@fomichev.me

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 May 2026 09:48:15 +0300 you wrote:
> Under certain circumstances the bridge driver can call
> dev_set_promiscuity() while holding the bridge spin lock. This is a
> problem as dev_set_promiscuity() might sleep.
> 
> Patches #1-#2 fix the problem in the netlink and sysfs configuration
> paths by only taking the lock where it is actually needed, thereby
> avoiding calling dev_set_promiscuity() from an atomic context.
> 
> [...]

Here is the summary with links:
  - [net,1/3] bridge: Fix sleep in atomic context in netlink path
    https://git.kernel.org/netdev/net/c/5eec4427b89c
  - [net,2/3] bridge: Fix sleep in atomic context in sysfs path
    https://git.kernel.org/netdev/net/c/6d34594cc619
  - [net,3/3] selftests: rtnetlink: Add bridge promiscuity tests
    https://git.kernel.org/netdev/net/c/147f3b1f23cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


