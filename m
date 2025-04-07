Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335DC258CCF
	for <bridge@lists.linux-foundation.org>; Mon,  7 Apr 2025 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049999; cv=none; b=NEK2cWvrshmaI+5hmvJVKFCDlpmojYtOB4KnnwxN0KqbAvQi2qSBeNvzLRvj2rPF6xErLMUaTiY3wEQu2PFffkSZehRnzRkVT1JeaWNCdByT2Icsw4nkSedNwzJPnMijN4e9u+glgsOkO1ADLb8qKB0tLXHgZ2H+m5IJF1L0fv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049999; c=relaxed/simple;
	bh=nOtUH7kovfwgg06yUNsNxTZGWgaoyv1F+qWWuCFGn7I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ujsLVtRigE/LL5tKJf3sYVEtNYkJBk6luhg/lqXMqMCo54l3ZYdsWf7VDXXgo9JpE0Nl44Akhn2Oe7AlScFY1YUWk63DJ04Wblpqmy6gVVcyjr7Q8mOZkvbiiwkFFjuHIptMevMNshniB0yYAo7WHKBrqAu7xjY2p+MkkVFUQZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Is4OfOcI; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Is4OfOcI"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF59F805AA
	for <bridge@lists.linux-foundation.org>; Mon,  7 Apr 2025 18:19:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -8.092
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6FwMIpuRYdf8 for <bridge@lists.linux-foundation.org>;
 Mon,  7 Apr 2025 18:19:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D0D0D81E89
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D0D0D81E89
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Is4OfOcI
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D0D0D81E89
	for <bridge@lists.linux-foundation.org>; Mon,  7 Apr 2025 18:19:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C5E1EA484BF;
	Mon,  7 Apr 2025 18:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FF5C4CEE7;
	Mon,  7 Apr 2025 18:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049995;
	bh=nOtUH7kovfwgg06yUNsNxTZGWgaoyv1F+qWWuCFGn7I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Is4OfOcIGMN14wQAx05bbgxRJP3KLRYsY+eO5NPhZNfFT68/M4D9UG1ZKClg4dHxG
	 eZlusOSp9LhQGIY7qFK2Qz3/7Wknh7Y4ZQAhtIDWExoZkIbt435bDO06+bexFlpvy1
	 n0f5/5cwKfCrJduky/oDafoRj8aeGvQLdxzbX8Nih+M4zEux8g0u2KG4lN1DvRQ+Op
	 C7XPdaK6smloAap9RxJZonr5FIcSyu9e0YfaxPvA1mzxIPHVDgrGLFcsBDjJD1Klx/
	 k2XiskZODsEtxTqBALoqRBvC0H6o5Ni3R4WrvHm5brXbfjwo7KWbPS+yrPKm2PJ87V
	 UD/+AmxdBHLYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE073380CEEF;
	Mon,  7 Apr 2025 18:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] MAINTAINERS: update bridge entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174405003250.1220282.3145051055620556802.git-patchwork-notify@kernel.org>
Date: Mon, 07 Apr 2025 18:20:32 +0000
References: <20250405102504.219970-1-razor@blackwall.org>
In-Reply-To: <20250405102504.219970-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
 roopa@nvidia.com, idosch@nvidia.com, stephen@networkplumber.org,
 dsahern@kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sat,  5 Apr 2025 13:25:04 +0300 you wrote:
> Sync with the kernel and update the bridge entry with the current bridge
> maintainers. Roopa decided to withdraw and Ido has agreed to step in.
> 
> Link: https://lore.kernel.org/netdev/20250314100631.40999-1-razor@blackwall.org/
> CC: Roopa Prabhu <roopa@nvidia.com>
> CC: Ido Schimmel <idosch@nvidia.com>
> CC: Stephen Hemminger <stephen@networkplumber.org>
> CC: David Ahern <dsahern@kernel.org>
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> 
> [...]

Here is the summary with links:
  - [iproute2] MAINTAINERS: update bridge entry
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=c498efe79ba9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


