Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527011;
	b=4sZ2GAOrDwTD1FXla+Drc1db756/euRKhMWGK1WMvwS6/gcUG5COG8LjEpDq/4k9v6y5
	 /5jyeGFMZjFm8uF2aeXey2x6ypeD+3zZzvmTQF4cT+Q54iU2e7/M1hwtFLA6Mr9HpQ76K
	 ckRGSItOe5lc3TMLpu/uTPNzaVD/ScnLBemrUcrimle0jbinqvvQ2r7BCXk6QcYb6vAqJ
	 rGsjJBM1l5h4UaY5MrBV4/ko08ev+XMDEVygHriyj58f0IuWc/4NdytOLc/M2y6gfZLUi
	 cBrVOuDE3P3RL+ZS2wYmxMLEv+0UsLxSATsa242dUXwjS8EyP/m8A7pxTCmn7/OdWNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527011;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=8JAOc6z8twyN3FHwD/8u6EnZf/YO8277tQVvG5yXToA=;
	b=Ta7kWtZH+wKsOLBdgTGiBnKCzOw1lHhjocusMoG/X576zbn1vX+901Lf/vm/ZDyNo5KL
	 /V5dcBSV8m9nViQku/DgvIBYNSSB/ZBBaOAJg9ry8aEU2a0zs6lIlrbKhcp6/hol5PCXZ
	 BkTV4KxuWmB+YmI55wbtosFdzyAztiVXJ7cLwvpT2d+xR+bAYTMdzNEMQaJwJARa2NYAe
	 NQ5Z3h+sG84ho4WO8wvO3bcHNzKWASojrfKe9nIDdnvrbMLwQZ+ggtmGVRekNTZbAcHHc
	 wruLd+hzXLiQcNisp77YXXGV8wicDDKIKM92Sn+Ialfb53PdSUEc6gexhRtRWnr0K9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eWht8o19;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE39D606A31E;
	Tue, 20 Oct 2026 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eWht8o19
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820CF1F000CA;
	Tue, 20 Oct 2026 20:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792527010;
	bh=8JAOc6z8twyN3FHwD/8u6EnZf/YO8277tQVvG5yXToA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eWht8o1922tbzy/UrreYJtY9nhtsExSdFwNai5pBhjChedBseGQCYCa0Fij60xvAh
	 wpCcaibXyrY1//8DKOgQ6QmYv8JeLCIz8iz9Cbx/P98FNlkcSM9eTxwJyQmtMLyZli
	 EBen95845Xzf+6upy3anK6YNfstOw7Dt/5mSfrEBMYESR9i0bvdRk66tApyvLfFJu/
	 dw2U+J4e9ovJDw6/+eReYIYLinZmNxRG0LNYNUYOe6I7LAUSy5sR8TZYiboBQE0g1d
	 qD1LRfAyVlQcIxge2OSES8hrtj6nvA0hh29wglnoW3YWTfNMsB2BkZElk6u7IvxpVA
	 n7+d6/NsdF9fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7738B3809A09;
	Tue, 20 Oct 2026 20:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] bridge: mcast: Fix MDB exhaustion by rejected
 entries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252700905.186787.5147911317441263308.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 20:10:09 +0000
References: <20261016101407.2030133-1-idosch@nvidia.com>
In-Reply-To: <20261016101407.2030133-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@kernel.org, razor@blackwall.org,
 horms@kernel.org, petrm@nvidia.com, yunlong_ma@buaa.edu.cn

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Oct 2026 13:14:05 +0300 you wrote:
> When the bridge fails to create a port group for a new MDB entry, the
> entry is left behind with no ports and is never deleted, but it is still
> counted towards mcast_hash_max. Since the introduction of
> mcast_max_groups, a host behind a port that reached its maximum can use
> this to exhaust the MDB and disable multicast snooping.
> 
> Patch #1 fixes the problem by deleting the entry upon failure.
> 
> [...]

Here is the summary with links:
  - [net,1/2] bridge: mcast: Delete empty MDB entry when port group creation fails
    https://git.kernel.org/netdev/net/c/1d0590f96fa4
  - [net,2/2] selftests: forwarding: bridge_mdb_max: Add a test for rejected MDB entries
    https://git.kernel.org/netdev/net/c/335ae22c2e9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


