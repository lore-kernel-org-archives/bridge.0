Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E482391E45;
	Tue,  5 May 2026 02:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777947676; cv=none; b=O3H62BEH55h/kwSdymBlGR179afhF4oJA2ysp38PbR3YifyRYzs4S7/Du2l4Lpn1rzxbddv1ucJvw2su9+JBBs2JULqUzBz3a1ALuic3gxSJw1sb2APDf//5w4ZrJw2cU6xudAvWgtMWSqgEggcvtiXR6VoUKqtcdCYixVoqyM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777947676; c=relaxed/simple;
	bh=VcaP5c6tl95GFcm+fblQiriTHDyLGR00wfCO8eppSZA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QMrFM3V7jD9tbTkOJP7PCXpozTL4zCeP7ajMJiPekeZ9Qg4OunTtc9ZFrn8uZokqbI8+WwO21y6v6kFVafqUlkUvZ41DzWQ8oZmsPyQUARpwu6vuWg5dwuXfjImWHyenoSX5RzNOaF8RpQFIqQaqt/WWp3LPyuK1lFz4FlMARpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHNh3kOQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHNh3kOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBB9C2BCB8;
	Tue,  5 May 2026 02:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777947676;
	bh=VcaP5c6tl95GFcm+fblQiriTHDyLGR00wfCO8eppSZA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NHNh3kOQtdZzM4QekaEKOPOsgOyJjTj1Q/UlAOojbVZQeiZ7cOdOluQ0CEPgFxPqU
	 ttJYQn5wyOWc/APBux/OVY7EQJnaNR/VvDF6fJNcKD/0HdFaGSieM1tcfxnKeKaKKf
	 POTBo+1uwd65BXGfHEbm4dHvdjgsVkV0/c6HijRd8wYUKlAoCvzpjrCVrLWwcm1Hwn
	 I7rMqOLSwsW8cjBvfNbvbs+aXOlln04/wssI4P78RDph5pB+G29N01t+n84vDArpyW
	 paiy6DkIdY+gUE9whQI0hBVZHHzZm6XKaN8AHLxML80++/lzA39Y8RDj0JPfaE1k47
	 bUgVr87BwWaPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDBD39301A2;
	Tue,  5 May 2026 02:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/5] net: bridge: mcast: support exponential
 field
 encoding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177794762679.1391894.7351753363861517582.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 02:20:26 +0000
References: <20260502131907.987-1-royujjal@gmail.com>
In-Reply-To: <20260502131907.987-1-royujjal@gmail.com>
To: Ujjal Roy <royujjal@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, razor@blackwall.org, idosch@nvidia.com,
 dsahern@kernel.org, shuah@kernel.org, aroulin@nvidia.com,
 yongwang@nvidia.com, petrm@nvidia.com, ujjal@alumnux.com,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  2 May 2026 13:19:01 +0000 you wrote:
> Description:
> This series addresses a mismatch in how multicast query
> intervals and response codes are handled across IPv4 (IGMPv3)
> and IPv6 (MLDv2). While decoding logic currently exists,
> the corresponding encoding logic is missing during query
> packet generation. This leads to incorrect intervals being
> transmitted when values exceed their linear thresholds.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/5] ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation
    https://git.kernel.org/netdev/net-next/c/726fa7da2d8c
  - [net-next,v6,2/5] ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
    https://git.kernel.org/netdev/net-next/c/12cfb4ecc471
  - [net-next,v6,3/5] ipv4: igmp: encode multicast exponential fields
    https://git.kernel.org/netdev/net-next/c/95bfd196f0dc
  - [net-next,v6,4/5] ipv6: mld: encode multicast exponential fields
    https://git.kernel.org/netdev/net-next/c/e51560f4220a
  - [net-next,v6,5/5] selftests: net: bridge: add MRC and QQIC field encoding tests
    https://git.kernel.org/netdev/net-next/c/529dbe762de0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


