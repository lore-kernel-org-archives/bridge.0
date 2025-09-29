Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648D430C60C
	for <bridge@lists.linux-foundation.org>; Mon, 29 Sep 2025 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161619; cv=none; b=Ub8Bn5mBfRoDYEo9MVqJyfXqXImbyc1tVx6dkggewOpJTij2ZXBSQUmG8KJdNg3+4L/kONY2WNCAkuI5oJM+c5KrOZBAaM8ej+KbzSBE+Tem6/5i2t1FFqhRxbJFwD98VRIc+U6qFC79/MRzgr9LFfLNG2qoDhR0E6H0zZRjPS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161619; c=relaxed/simple;
	bh=gxqbybMCG27rYjbGGovKV2EtyUzLzfX8r4kGBQG0VM8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qsJXAnDXJOYjqHRQhUTvGT5Ya2U35JyS2keKuFz+ZM5g2odybHNBV2G+IF+3OKe1AZMw3uCPnBQhf6u44o1Qs+n/vJR2PjB75tHhs3bmXDSGZg9hiNb6fp8MrSx+Jh6fxr+NL1wSDF/y85P2IZTP2RTgdvQmGFiDKg+ll51+vDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXIi7Xs6; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXIi7Xs6"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E20D680EA6
	for <bridge@lists.linux-foundation.org>; Mon, 29 Sep 2025 16:00:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oOAQDtYpyvXp for <bridge@lists.linux-foundation.org>;
 Mon, 29 Sep 2025 16:00:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3BCA281024
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3BCA281024
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CXIi7Xs6
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3BCA281024
	for <bridge@lists.linux-foundation.org>; Mon, 29 Sep 2025 16:00:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4BC8B455E2;
	Mon, 29 Sep 2025 16:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268AEC4CEF4;
	Mon, 29 Sep 2025 16:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759161615;
	bh=gxqbybMCG27rYjbGGovKV2EtyUzLzfX8r4kGBQG0VM8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CXIi7Xs6gHCmKmN6XF9eE3OFhH/eDWUE5bHi6BJ5dCUybDyWASGN0FD09oLscQUY3
	 9O3uS1ocCfBV3caLH1mmGkTgXcSyRDv6FYTQDXosAhIM/SWmL0HjmEkS0r1M4/990P
	 jmI3nDMVxVye0cwxW44Uqpzmi9iEueS9bnj4+nVYbjwJGxTFFQbHtipN+MqTrHSZ2u
	 qG/0N1npPk1Sef6mDoPXCncpN6GuGqvMWLC29gVz1WxRb03nfbj8XuNRunLnS8pvfe
	 nIbnaXV16qgxX5Nn2tN18XvcCZ/qsTVFIQP+vCaaPzlbJDNqC1YDWWnWF0SLa/yQQz
	 lyi39m4V0X5Rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBB8439D0C1A;
	Mon, 29 Sep 2025 16:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v3] ip: iplink_bridge: Support
 fdb_local_vlan_0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175916160876.1625635.16628239948699650647.git-patchwork-notify@kernel.org>
Date: Mon, 29 Sep 2025 16:00:08 +0000
References: 
 <d23fb4f116e5540afbd564e0e3a31d91eae42c60.1758209325.git.petrm@nvidia.com>
In-Reply-To: 
 <d23fb4f116e5540afbd564e0e3a31d91eae42c60.1758209325.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: idosch@nvidia.com, razor@blackwall.org, dsahern@kernel.org,
 netdev@vger.kernel.org, bridge@lists.linux-foundation.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Thu, 18 Sep 2025 17:39:26 +0200 you wrote:
> Add support for the new bridge option BR_BOOLOPT_FDB_LOCAL_VLAN_0.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
> 
> Notes:
>     v3:
>     - When printing the option, test optmask, not optval
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v3] ip: iplink_bridge: Support fdb_local_vlan_0
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=fc5f69b8f2c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


