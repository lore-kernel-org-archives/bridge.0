Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4424406289;
	Thu, 11 Jun 2026 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217022; cv=none; b=fi0Q4tQJeIwNy/Qqbc9tRfdR0Z7QjGOUWBk1/Uc52fAZh9A7eFE+k5MqBZtsVrivWVgxhC+YMgWtnRuxkVD5tBnyYeTFfuaY9N6t/zAbH9iBkNP0Yw+8ZJqPGC3zc2MhuMcVjnGvCx2G+igA10r3XeiF0jZucGa1RQQK2a6jop4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217022; c=relaxed/simple;
	bh=uOzmNu9MuAcNLjMFdpNLBO6zZuRHSuusIWaynmRj7RA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=da4r6i8vxBPIvgaTX0H1Q6k4TTKEkFl8xd7XJ1CnXHVf1s7TX1EEcLxrwRNUEQ39b93CH930JXqDdT3Ubh3gBYZo9ctwhKQwJ8PNQSMjGe/9+Whgj2HCjCuU16oz+/pX9ZmPZ8OtHZMkIWcuvohbxYtRkaWnJ3bL2MLqXhTEHwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYwQsuKo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYwQsuKo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8ABF1F000E9;
	Thu, 11 Jun 2026 22:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781217021;
	bh=00EzGCJvY7drxKmHEpF5ggxVpCANugiteR/v3bR67uU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cYwQsuKoAZMQGkAlnhQ2WLkk9iGWDlwY+a8a7OR5rwlACfOtjbB17uTCDQHvjFMDo
	 n0EagOAh6cbC7r0e2EoIB0W8Y9TJFgR0LmXcPQDEQJzY/oYDtnFlSiWk8QjUFz+z/K
	 QoE3Kx9Vfi9rDEi0MHnrdUTUCExCtoW5n8uro6gp02+s/9nW7Rl8KDh9RxImXc50zp
	 wp8Xid9E5SDTsXuxvARJStu4902xfYo44Dtpd0BEsh8YttE4ePwwprJCfvHwvgAA4z
	 CwlEsUQc9z34nULU0PkcP3AqFqO0sZVajSQthlgnJINQp5/YYneTGkVsju1G0XVM3m
	 jsPv51NBCer6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1982A3930FAD;
	Thu, 11 Jun 2026 22:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] bridge: cfm: reject invalid CCM interval at
 configuration time
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121701863.389578.697997429159988292.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 22:30:18 +0000
References: <20260609065116.2818837-1-xmei5@asu.edu>
In-Reply-To: <20260609065116.2818837-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, horms@kernel.org,
 bridge@lists.linux.dev, razor@blackwall.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, bestswngs@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jun 2026 23:51:16 -0700 you wrote:
> ccm_tx_work_expired() re-arms itself via queue_delayed_work() using
> the configured exp_interval converted by interval_to_us(). When
> exp_interval is BR_CFM_CCM_INTERVAL_NONE or out of range,
> interval_to_us() returns 0, causing the worker to fire immediately in
> a tight loop that allocates skbs until OOM.
> 
> Fix this by validating exp_interval at configuration time:
> 
> [...]

Here is the summary with links:
  - [net,v4] bridge: cfm: reject invalid CCM interval at configuration time
    https://git.kernel.org/netdev/net/c/f3e02edd8322

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


