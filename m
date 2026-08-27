Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8324F7978;
	Thu, 27 Aug 2026 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859682; cv=none; b=ZxpN0ZlQkIwHNW1aAcMWXE4BNzkS7oSSRhiJYIma7wtK3kbk1JluwLsrLRqfhxd9P4NJPcxMuMoi/qR3SXvsq+qVprG4MBlmJSSjw6kIRSHOJw5e2rx3O309vRcKP2bIqcugWeZ31TAp4guaUrhP34QvQ9v+ZMsbkb4+f+cBbjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859682; c=relaxed/simple;
	bh=DE0pY63zIxoiH7h+foin4Pdg6DaT8kpMyCqvV/G5xy0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IrYKUjZ3oQ8VIlWF59V1/heUSMpKitB2JzofIOAnY6DqPWey+5UdbeO1vspKuOn91/Gfxl1SApVIFv+UrQaZrUPTDrHM++xZDrpprg+6jmd9IrenMnQlOaYJqnbdGp895pVpO/dsmHq5Q4uvTCq8+v/TNvQagh8NTjRNnpUM98w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOt7dWhW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOt7dWhW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AFA1F00A3E;
	Thu, 27 Aug 2026 19:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787859681;
	bh=NkMaFslVp/1oCJXX37RUKuKe0pJNvW4UitRgYCrb6RI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VOt7dWhWxCCmA3vuK+ekrtlbcIdV99I3GWbX7zPoPphq75drm2ns30Zo0ekxNzBUH
	 2ouTub93zWAG6dlYieJ2sWHFo7tgYu7/HVchMbwZ1j/G8cC3whO66wPBZrekQyVpY9
	 wQhmburbaALgEWlzY0a+2s1Mkf6+waage44ociZNpWnBstVYXwt1laQAUmDbrnLvBa
	 Gz7XU06UVLUltdG+kaxeasZuKuFIWxbOu8BCLZapDVbpnejlJco6ZXP3u47RQdGoX1
	 hj25PlY5YPGf9Me2KnPG9uT+FzOESj/unNkSQb5QYZMA+KErIgEblvUUhAFniJZGT0
	 yFO4uIU9eb6Yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B8B3809A8D;
	Thu, 27 Aug 2026 19:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: bridge: mcast: fix use-after-free of a master
 VLAN's multicast context
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178785962639.1816627.6610160215197887882.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 19:40:26 +0000
References: <D400F6C7-543A-4B79-9E5B-D1D8974DE5C9@doyensec.com>
In-Reply-To: <D400F6C7-543A-4B79-9E5B-D1D8974DE5C9@doyensec.com>
To: Norbert Szetei <norbert@doyensec.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, bridge@lists.linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Aug 2026 11:12:27 +0200 you wrote:
> br_multicast_toggle_one_vlan() clears BR_VLFLAG_MCAST_ENABLED under
> br->multicast_lock before stopping a VLAN's multicast context.  That is
> the teardown handshake: lockless readers gate on the flag through
> br_multicast_ctx_should_use() -> br_multicast_ctx_vlan_disabled(), so
> once it is cleared under the lock no reader can arm the context again.
> 
> For a master VLAN the handshake never runs.  __vlan_del() clears
> BRIDGE_VLAN_INFO_BRENTRY before calling br_vlan_put_master(), so
> br_multicast_toggle_one_vlan(masterv, false) returns early on
> !br_vlan_is_brentry(vlan): the flag stays set and br->multicast_lock is
> never taken.  br_vlan_put_master() then drains the context in
> br_multicast_ctx_deinit() and frees the VLAN through call_rcu(), while a
> reader still inside rcu_read_lock() sees the context as enabled and
> re-arms it.  The port and port-VLAN branch of the function has no
> br_vlan_is_brentry() test and flips the flag under br->multicast_lock,
> so it is not affected.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: bridge: mcast: fix use-after-free of a master VLAN's multicast context
    https://git.kernel.org/netdev/net/c/50e5c6605cc9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


