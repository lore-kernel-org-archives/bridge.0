Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0362F532F;
	Fri, 13 Mar 2026 01:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773366010; cv=none; b=uLo9xQV7NFk82ylsavpUY494L6u8qeiEHeFfQ1Tb81lLgahow0zQmJhE3SerXGxQFWE+zwwlmDiOyOolbb25As3qFPfQELydG/fbvKUDSlWbqqZ+6nYTmo0kDTJ0j2Z3/wa2U9occjCDd3xdfwsOFFVGR61Q9Tm0TKKcMLLLaWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773366010; c=relaxed/simple;
	bh=9julhPHix0+n/imzVgiojmJlJVQn8OgQW7B4wlRNCxM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U0TrwyGJI7ckEez53HEQUFgsMfe0r+GnJZvMTV0r5jza1meLI6xHRK1EgC1Jrg8Cejgkrh7d1ayn8WndhOHMs74ix4coL6RHlO5gwvqHILhuwk5eKwbuhK89jnnGZx41L+LrTXvVkmO3S+4Rlpa0mJqc+Psa0bFEE8B4gcK7w0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoQsDSeW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoQsDSeW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1461AC4CEF7;
	Fri, 13 Mar 2026 01:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773366010;
	bh=9julhPHix0+n/imzVgiojmJlJVQn8OgQW7B4wlRNCxM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QoQsDSeW9b5iSvak8E9HDpJCuBmmK+tGe/dfQ6Jkn5S67eC5AnhN88f9MV8MpGPW9
	 kKut4lFNP7UhcrkC/eyHcmiK0MO5NihXJTJ9ZAU688c4v+nuCksoO7/7u4lX14Rud5
	 h4nrbGK7IWMSfRMl0stPB1NPyWvvSqCqgFBX0TckSzXGwgd0pLmihhvE3wlSqNmd77
	 2/ix87JTA1uVCOqeKD4KEVaNlODQOuocjiPf9q9ByJwaOD/5CMWOMwE71WY9HEzBCD
	 ZGT+/nq6VTqJLV/NRdNPk8gtSswwoMXFdKZhcdwNwofwdmA7GAOG51K+WBy4f93701
	 baZIHKGojT6cQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF4E3808200;
	Fri, 13 Mar 2026 01:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bridge: cfm: Fix race condition in peer_mep deletion
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177336600530.628795.16179964876225068685.git-patchwork-notify@kernel.org>
Date: Fri, 13 Mar 2026 01:40:05 +0000
References: <abBgYT5K_FI9rD1a@v4bel>
In-Reply-To: <abBgYT5K_FI9rD1a@v4bel>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Mar 2026 03:18:09 +0900 you wrote:
> When a peer MEP is being deleted, cancel_delayed_work_sync() is called
> on ccm_rx_dwork before freeing. However, br_cfm_frame_rx() runs in
> softirq context under rcu_read_lock (without RTNL) and can re-schedule
> ccm_rx_dwork via ccm_rx_timer_start() between cancel_delayed_work_sync()
> returning and kfree_rcu() being called.
> 
> The following is a simple race scenario:
> 
> [...]

Here is the summary with links:
  - [net] bridge: cfm: Fix race condition in peer_mep deletion
    https://git.kernel.org/netdev/net/c/3715a0085531

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


