Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB9514ABE;
	Tue, 18 Aug 2026 01:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787016658; cv=none; b=JPX6jVzFIbM+ibfl4XHlKv3Z+SYkseElnPvUAjybyQrTllsPqn7ZYAdPYmmTFVubzzN8Ea5n5+FAKDC59GuLXS25N3ecYTcqSDchW+0k2mUolYzKXzGSRcdAuFcyVU/M3Y23kKtMJc1fpNeFi32XN8Pd5DDvSd/1AD9/MZK2WVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787016658; c=relaxed/simple;
	bh=TEN99SWgsOjo5IfOv/+0W1HUpZIc2hsYpOWIxckGtTA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k73oZdpZ+dQAMUvGn3ppaquzIr/Hw09m2Wc+l+L9xpKWPhNd2A3fOxhqdigJgaVWZhTs5e4Z2EG0k9tUkl5J3vnfVLkKkV5isHhfJ9DrXxOixiIiXPIrBMbI8wLhM55S0v0nREQO8+mpcdSs5zM0rKQyhbOQ/EqUP+B6ztFc7g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROcZRASm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROcZRASm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609581F000E9;
	Tue, 18 Aug 2026 01:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787016656;
	bh=I6IqvXq7RZBGPavZ35rIRRSCaDJ0uJ0fo4qWL4/somU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ROcZRASmPv3hS6VzFiwUdEQ72NkQobXFZqTXbe/WfPd8wxahmKcRwvTkrJOB7TrOg
	 no4aWRERCXSCMPNFAoN6GwkIPl5FEkRauhDIj56erz40HwHpoT2aP/YKECWRzE3jyn
	 qccvfLMNWJcuHgea2DP3tKwhJG8ppAPsv3KP65ad8Za9+9h8wPdLd1acnx1H0NG7FJ
	 wAlFwDhp/g5oRWNFSGYyscQBkriAmElzf+m7SE7ILKVDBQ8SRay9gVU+omwNFuWnwg
	 XL8iJTnhc34DXdk5KEgSQnMXnn0eHLyaIzxDtngS7prXzz7oDJP/9tAxz80BHB74Sm
	 Iw9Fs+Gq7nd7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939413926279;
	Tue, 18 Aug 2026 01:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bridge: vlan: fix inverted default vlan
 notification
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178701660839.1820167.12374828576561003816.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 01:30:08 +0000
References: <20260814141640.64958-1-razor@blackwall.org>
In-Reply-To: <20260814141640.64958-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Aug 2026 17:16:40 +0300 you wrote:
> A notification should be emitted only when the vlan delete was successful
> and not otherwise. The proper check is if br/nbp_vlan_delete returned 0.
> 
> Fixes: f545923b4a6b ("net: bridge: vlan: notify on vlan add/delete/change flags")
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
> Found this issue while preparing some vlan code cleanups.
> 
> [...]

Here is the summary with links:
  - [net] net: bridge: vlan: fix inverted default vlan notification
    https://git.kernel.org/netdev/net/c/21040c7f9315

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


