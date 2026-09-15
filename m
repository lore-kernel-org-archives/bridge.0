Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DE541E6A3;
	Tue, 15 Sep 2026 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789468271; cv=none; b=gjgc4B3KyJk8DGq8IJzVQf0yofLcdmiBC78amWehQ4eAkXrJfRjvJMMfSonqoYx71xQB3dxmfqCikX27emcV+hciKU9nE52VujyDGeGUADurISnI8qLQWtn/G/lHSCkdozB+o8Ptp5KPJdfqanAeE4pzZN+81w4KwL22GkJKRq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789468271; c=relaxed/simple;
	bh=UV8zIL0jIGWxIDxyW9zzPpN7KJxmnLtDGqX6LEpo1Jg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LTowrvyhnyZsd/3R8NAyeOl2zXGGEOACfHOXn47hD4PAAtg9pUK9G+SOKLtbOiDcbAD8ki49LKTKr5xt8Km24aZEuC6M5XBidm22Fklxgps313ES9qASpulvWCz8gP7nO/BGsjm6/VhlxqMJ9BJwJEvXwGOblCu/x/c3KEosZyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYs2ogqT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYs2ogqT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EF61F00893;
	Tue, 15 Sep 2026 10:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789468269;
	bh=tyIhaFqbO5Rrgoqc8j2a2TZiij+LXpf2mkoczxbWT2E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lYs2ogqTC5rqkbvkFkhDR5sLB26sFm4+9U+TgqARKwaVogSmaR++UkWQkFTbacfCZ
	 aVotGn+I0NYrAoKgK6yVm854z6s5fGEoPmpUztoLxgmert5YLW2rxreiht1kNObOwk
	 Ae8itbpQm8lvnbvtUUc3NPK3NXfRaQbbffjm3OV5KKT3uBgQoVrB1CyKppAB2EnSz0
	 6a628zr4hSZD1PHny5pAR1R/A4L59N4wIBD3khnfH7UOPlrmaA7HCOCxrUtTMQm71R
	 31xrND5iOu6tcc+W7MbAAtYwIDZ8W2y+ojpkWNjRmj7JPCDp8rTVj+uG2/4+EAgkxC
	 5hMr8+7zxsZ8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939633926265;
	Tue, 15 Sep 2026 10:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bridge: mst: move switchdev call outside rcu
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178946820438.1502971.5687704154883281434.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 10:30:04 +0000
References: <20260911105021.1385934-1-razor@blackwall.org>
In-Reply-To: <20260911105021.1385934-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 tobias@waldekranz.com, bridge@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 11 Sep 2026 13:50:21 +0300 you wrote:
> This is a follow-up of one of sashiko's pre-existing bug reports.
> br_mst_set_state() calls switchdev_port_attr_set() for nonzero MSTIs
> while holding rcu_read_lock() which invokes the blocking switchdev
> notifier chain and may sleep. Nonzero MSTI changes come from netlink
> with rtnl held. Move the switchdev call before entering the rcu section and
> assert that rtnl is held.
> 
> [...]

Here is the summary with links:
  - [net] net: bridge: mst: move switchdev call outside rcu
    https://git.kernel.org/netdev/net/c/18a6fe05fb6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


