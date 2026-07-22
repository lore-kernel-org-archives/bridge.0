Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2994399FE;
	Wed, 22 Jul 2026 18:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784743851; cv=none; b=EgecEIMalep8ikg6OJRydWGGEMPP4QEdCK09h4Kqk1PEo7r8R15jflksyb7NqsvquYV7tflx1opNg5ojVxrWpyrSttE+GSqi/lujJURrp9ePSzy8pt7xfXwZjWMUHEwpKUWILPvS2zy9u5jLtIjcXtpLRmBa5M4If9bvLthTwhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784743851; c=relaxed/simple;
	bh=T7jpaxdaXft/l/GEEgAyQ/HgTv4ytAHEZ6kNb6mC76s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rYeayXVgFr7CiRPMOBYNA7J5WXzfeGY49IXkLHLy0O75c9yZXMIm2n/u0zxFAkpy41GwxEY/hwFCsUQHn/H4neQ9VEwFhPzB6ypZ3+113DiAoHpIxl8deHcfdjG73WuDMnOJ4hTatUK4NHa8vJa3gTY0UmpL5Ei6sdL5f9ok07o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfXfJucj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfXfJucj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B881F000E9;
	Wed, 22 Jul 2026 18:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784743850;
	bh=AUJm0nyFPLHXAKLdamD46tE620hs68Hsh0E9wkian00=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bfXfJucjmwpS079WadrAxFRWILWP6D6P/5jHjNJ7cNA23cTXbWFh66vXE8lUNCV2Q
	 lksHvTYXAW83AmJL7roXcxcPpUbfKe46TKb70M9DoToJKEAJ6PbZltPm8LdJqVpU1S
	 cnBEDPkoiBgrBsumZnnMxr9fF/PRZyadHrssdtG25akrDn59X1e33yIvZO5OheGKK+
	 jGuVanTSjoeQTBUe4ZBHs1IdsUAm5pr9gP18UKaGcyHOHBU/FqusIzDbeLwwY+a3S/
	 3fTAwQytJs3iftLZG87h9latY+Eer+e1W8oXX0lP8npSePUM00ji7v22livO3mQ+6u
	 pc/CNW1/UDFRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198E1380CECD;
	Wed, 22 Jul 2026 18:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net: bridge: fix vlan range dumps starting with a
 PVID
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178474381863.1967992.14565089382183026274.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 18:10:18 +0000
References: <20260721140922.682265-1-razor@blackwall.org>
In-Reply-To: <20260721140922.682265-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Jul 2026 17:09:20 +0300 you wrote:
> Hi,
> Patch 01 fixes a bug that can skip dumping VLANs which a part of a range
> starting with a PVID VLAN and share the same flags. PVID VLAN should be
> always on its own. Patch 02 adds a selftest for this case. More information
> can be found in the respective patches.
> 
> Thanks,
>  Nik
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: bridge: vlan: fix vlan range dumps starting with pvid
    https://git.kernel.org/netdev/net/c/43171c97e471
  - [net,2/2] selftests: net: bridge: test ranges with PVID VLAN
    https://git.kernel.org/netdev/net/c/679eb1e32d2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


