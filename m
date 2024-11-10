Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923321798F
	for <bridge@lists.linux-foundation.org>; Sun, 10 Nov 2024 00:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731198622; cv=none; b=JMKwCyk2hcmnqRiOqDE0jLJTetjS6kWaCSdVWY3bhs45J/0gU8Y3Nh/CFk3Q8IR/VUENy2UeAyYpmEw6MRKUTV/6t8cWAB8b176+C1A8FCN+YyTBrF9/HWi2imyR3UG35ozzSYrulQEfYx15tbnX5xP4pP6Sd86yaM9jn5DcdC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731198622; c=relaxed/simple;
	bh=7JmhH6UIYC4+6p24kmOSJZy8bj0axf8IzILEdgQF7lU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NuCmligVc5tVgxsfemjrylf+0P9aly+1qGuLG0s/lOy+kzuuWg3TuWzinsiTBtcIJwuFk282xkhkTwAZQyg4kiDKcl3LMTXvyRH1vOzLobZto1F7H1UQWRHTzEFoLVOb6RSi7mci6w6ze60XANX26hItbET/FRwKLNtVUnqX+O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kataOhwD; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kataOhwD"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25BA1810C5
	for <bridge@lists.linux-foundation.org>; Sun, 10 Nov 2024 00:30:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r4MUEjAkdvy2 for <bridge@lists.linux-foundation.org>;
 Sun, 10 Nov 2024 00:30:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 434FE80FFD
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 434FE80FFD
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kataOhwD
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 434FE80FFD
	for <bridge@lists.linux-foundation.org>; Sun, 10 Nov 2024 00:30:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id F40DFA40A95;
	Sun, 10 Nov 2024 00:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C8DC4CECE;
	Sun, 10 Nov 2024 00:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731198618;
	bh=7JmhH6UIYC4+6p24kmOSJZy8bj0axf8IzILEdgQF7lU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kataOhwDzdDChtbcFe0ctcYIhT1fFGntq/UgBZFbOkGlPiY27nXZeBnVvTTnMXL+K
	 +ZkMu4PD5uLH9BtJaLFbg7yZHm70QWHJ8W0ernRxI+GiOhZI03xzp6nKBIbrtb+Q7b
	 DdbnEwHXS4+rNWZQyAYkWPU4AlQhvhaiHRv8yLzOzHFcnPgMft4D+52jeJGnDyumRf
	 hK/mmC+eP6ZCD6OLAr3WaOfQ30sNZXY1qOznTbkAG7Xtw8/Oy6T+2R+Nm/5T6m1NU5
	 CI3OWOc+Rshjxwv+WFEPmY2A7Ph2A/mRNspcEak4IJ7GXNea1RWTU+FRdNA+5m6N4i
	 WiOrC8ScOazRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF953809A80;
	Sun, 10 Nov 2024 00:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bridge: Allow deleting FDB entries with non-existent
 VLAN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173119862775.3043730.8123158047350078052.git-patchwork-notify@kernel.org>
Date: Sun, 10 Nov 2024 00:30:27 +0000
References: <20241105133954.350479-1-idosch@nvidia.com>
In-Reply-To: <20241105133954.350479-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 razor@blackwall.org, roopa@nvidia.com, horms@kernel.org, petrm@nvidia.com,
 aroulin@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 5 Nov 2024 15:39:54 +0200 you wrote:
> It is currently impossible to delete individual FDB entries (as opposed
> to flushing) that were added with a VLAN that no longer exists:
> 
>  # ip link add name dummy1 up type dummy
>  # ip link add name br1 up type bridge vlan_filtering 1
>  # ip link set dev dummy1 master br1
>  # bridge fdb add 00:11:22:33:44:55 dev dummy1 master static vlan 1
>  # bridge vlan del vid 1 dev dummy1
>  # bridge fdb get 00:11:22:33:44:55 br br1 vlan 1
>  00:11:22:33:44:55 dev dummy1 vlan 1 master br1 static
>  # bridge fdb del 00:11:22:33:44:55 dev dummy1 master vlan 1
>  RTNETLINK answers: Invalid argument
>  # bridge fdb get 00:11:22:33:44:55 br br1 vlan 1
>  00:11:22:33:44:55 dev dummy1 vlan 1 master br1 static
> 
> [...]

Here is the summary with links:
  - [net-next] bridge: Allow deleting FDB entries with non-existent VLAN
    https://git.kernel.org/netdev/net-next/c/774ca6d3bf24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


