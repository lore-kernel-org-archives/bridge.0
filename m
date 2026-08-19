Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CBB208D0;
	Wed, 19 Aug 2026 03:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787111455; cv=none; b=XIXqazw3ecaKWOYrS8e1s/DZy4/m3Ar8OVlGnPhqLoxYcAKi6DBCbfXdhtRuZfN6hhZZv25Q7p/UR7E0LErioz64fhQ3itNVwjS2Df7yIawjaEkManwOQ6fUQszCIKxiVC0unJqIrROBW+HECrSnVRCLagxevoW5qbTsU+OhNsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787111455; c=relaxed/simple;
	bh=Zqg2dHlJ6L7mU319ZdPlJwASeJDFJSQyMX8AQxKReHk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BhwjPaznhRt4Cm0w8j3UVteYWyGSM35ykB1INiI8OSreIdiwd/6laxmK3VlwAMIYdPLMl/sQh/7jHMkI6mmUQThxUvZNvOB+kxfPo18FCs4d2VadtA2efJ3SkntvyCNNVgZohhGwzRM8s1sInPeLmp8FntLswZOg4wnXNV6vLik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dW9vyOKq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dW9vyOKq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5497F1F000E9;
	Wed, 19 Aug 2026 03:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787111454;
	bh=z4ref/RM/CtI7W0sRmJvptQS3ZnMsvKyWYsixYtBFAQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dW9vyOKqio1HSE2hU9MKrOIsLqA7BQnfeszi8yv7ZMG2l+5zJFFT6NAZs31Bq31WH
	 11Fed3YZg3bIKBmZCSq9X+2gwZitJfyz+Zk66k6qn72dxadG0ljp0HD205xXJYUy1j
	 qr38BtrxFQ2RhEzTRuayTQrQQjEEQyugFs4ONI8n4UUe2KGijm4vYLYd0WCOjL7d/M
	 Qf8S0J+8jlgB+NvpwRJA1xVMLPuBmvcghZo1IMT+ezKc3DVVmuVWa5Zdtg6mqsk84l
	 D8t902dR5WI0k6lqTprOTtdQTBeYWnu2YgRsBDSj/2BYk0ASOOhWg1P39Po6CSZLda
	 hUNVqa2Ufzp9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09273927074;
	Wed, 19 Aug 2026 03:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bridge: Reject descending VLAN tunnel ranges
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178711140564.2835526.4256752863993963902.git-patchwork-notify@kernel.org>
Date: Wed, 19 Aug 2026 03:50:05 +0000
References: <20260814134053.1387275-1-ruoyuw560@gmail.com>
In-Reply-To: <20260814134053.1387275-1-ruoyuw560@gmail.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 14 Aug 2026 21:40:53 +0800 you wrote:
> A pair of descending VLAN and tunnel IDs can pass the tunnel range span
> check. The VLAN subtraction produces a negative int, which is converted
> to unsigned when compared with the u32 tunnel ID subtraction. It can
> therefore equal the wrapped tunnel ID delta.
> 
> The range loop then performs no iterations. Since the batched
> notification handling added a post-loop error check, this leaves err
> uninitialized and makes the request's return value unpredictable.
> 
> [...]

Here is the summary with links:
  - [net] net: bridge: Reject descending VLAN tunnel ranges
    https://git.kernel.org/netdev/net/c/40f04b51758e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


