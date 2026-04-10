Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3686343D7F;
	Fri, 10 Apr 2026 23:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775862646; cv=none; b=KoXny8MeP00xO8CevmjmB0cxug8pdccowH70X2VCMofGENwos/Z2WtRb8e7ofVsvtoi32HNTALqN7jLCzUFOf6+vPOiHAy0CriYYVL4xlQIinmZKP7A6PmJ43UgAUJwOm8M+s8g9jKfM4jq+0spJm9Ov+RmbYoIHwCJJsfPHg8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775862646; c=relaxed/simple;
	bh=VLWH1xSQJbFjKnanR6LtfMMRcIn2EuvK7B8BqizJ75U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QUxKqBIcyMqB0BMpMh5NN80JnjApTto54XuNc261lFQhRe4Jt6/YQcvRi0RXhn7FRBAOn8/6J0Gs1DbhF6zaBhzsCZ9/QwrACbYLk04yS83mvBYJraM0g2VAHsknJJWrD1aC4HeX/Q6HUZNaiBxeagS0azP7HAL8m9/vHx1hIY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eK3GPbIu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eK3GPbIu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF951C19421;
	Fri, 10 Apr 2026 23:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775862646;
	bh=VLWH1xSQJbFjKnanR6LtfMMRcIn2EuvK7B8BqizJ75U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eK3GPbIuShJ2N0W/epLZDSYNJkdgwumRYc2q8O10NMGX6xkPgaJDVJgPE2gOiLI+p
	 vRA5DdSIQ2E/0U5MssqxqREjlxL+L3k/1MYwznVPpe5i+1pUPT1PSJxZYxRZ8RBoyD
	 zfAYL2xmZwsZa+BMvmMg2+vaqkgn8GhtzYclYs36/yRBlwFw437W2+cJy58m5MnHQC
	 RGUHsSrcJFBBw+dT4d4u+jYtlzBfY8SYoHniUXrf879mJaUqBo2E4FTrkBp+GkeZ1o
	 /7F+bPjQ/UNUiKSQFh2cSOCLzJXR6BhC4BB4rLdzuxUyL7tWEe4HfrdeqsOmtYEmtu
	 502YmrbZgWVqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD633809A88;
	Fri, 10 Apr 2026 23:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/3] net: bridge: add stp_mode attribute for
 STP
 mode selection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177586262079.2678602.7436891627860485314.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 23:10:20 +0000
References: <20260405205224.3163000-1-aroulin@nvidia.com>
In-Reply-To: <20260405205224.3163000-1-aroulin@nvidia.com>
To: Andy Roulin <aroulin@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, razor@blackwall.org,
 idosch@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, shuah@kernel.org, petrm@nvidia.com, donald.hunter@gmail.com,
 jonas.gorski@gmail.com, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  5 Apr 2026 13:52:21 -0700 you wrote:
> The bridge-stp usermode helper is currently restricted to the initial
> network namespace, preventing userspace STP daemons like mstpd from
> operating on bridges in other namespaces. Since commit ff62198553e4
> ("bridge: Only call /sbin/bridge-stp for the initial network
> namespace"), bridges in non-init namespaces silently fall back to
> kernel STP with no way to request userspace STP.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/3] net: bridge: add stp_mode attribute for STP mode selection
    https://git.kernel.org/netdev/net-next/c/54fc83a17285
  - [net-next,v4,2/3] docs: net: bridge: document stp_mode attribute
    https://git.kernel.org/netdev/net-next/c/c4f2aab121cd
  - [net-next,v4,3/3] selftests: net: add bridge STP mode selection test
    https://git.kernel.org/netdev/net-next/c/20ae6d76e381

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


