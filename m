Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CC73093A6
	for <bridge@lists.linux-foundation.org>; Wed,  2 Jul 2025 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467189; cv=none; b=FyEcT1YRmMXch/nL2g/qsWI03gv2UmA6s83vD7Q3vuwzIWdE+faOUgyTWzZum3gIILDEqKvh0zyfskcikVM4Ky91zpTZAayOu2Y5c47D8or7nRqvHRGibUitZEfltO0CVUgzKqWcYfrPbYORYEAaoveJ7OLO+FWD+ToCi7eejcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467189; c=relaxed/simple;
	bh=R19ihR/OzC6bqGGAFeNWZKeZX9q7baXzFvYHJPRF9Po=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H7t917hp7iHEs4e+Qje8xWJmLq3vuJb4aTl/ZjpWPkOMk/Jvieah1lp6YbpL9D6woJsEr97pfJpgVWl3GCbyhy/fjXC4nGcwhJDF2Dvqoz2ZJ5w9xGj2vfsX1M6PAeNA7W8VzBaYaAtdPmqJ5Qkep79HXm8muQfjTpbjm1lNh3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0l+QKx4; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0l+QKx4"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2E019414B4
	for <bridge@lists.linux-foundation.org>; Wed,  2 Jul 2025 14:39:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -8.092
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0vL4RAdOUD31 for <bridge@lists.linux-foundation.org>;
 Wed,  2 Jul 2025 14:39:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4C09D40FB2
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4C09D40FB2
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=n0l+QKx4
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4C09D40FB2
	for <bridge@lists.linux-foundation.org>; Wed,  2 Jul 2025 14:39:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id EE9E5A5363E;
	Wed,  2 Jul 2025 14:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD1CC4CEE7;
	Wed,  2 Jul 2025 14:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751467185;
	bh=R19ihR/OzC6bqGGAFeNWZKeZX9q7baXzFvYHJPRF9Po=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n0l+QKx4kkKS37EgfPZ2gZQy8Qe/TRE0QBf9SRUvqIMsTbK8s/rXQdvi+uMsLgHcf
	 wfC9OaE11W2N80JPNTB51ZpD9dmabCme0o6OgwKdcRk/tE06gHDKeyNJkX8RNOMN2s
	 zQoJdNgZdANzJYtqG7ZxnDHU1Ujma2ACeHERa2uZZuM8pTtblxRhV2l5d+9Nvo033v
	 pE1J5kQQWCdsNhoGWRTU/YlGZ+L58IgAqTfpuTjSa5FDW9LlH1aH6tkU4BTJlgc6L5
	 Aiwxx11abTwbw58Ld24D4DkRPw4UT9Hw9zkCVg3dTCiZT7woMpJ9jnUaM1JFNR/zyW
	 g8EEhO+JCmaDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C4C383B273;
	Wed,  2 Jul 2025 14:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v6 0/3] bridge: dump mcast querier state per
 vlan
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175146721025.744720.14595669667124615372.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 14:40:10 +0000
References: <20250625-mcast-querier-vlan-lib-v6-0-03659be44d48@pengutronix.de>
In-Reply-To: 
 <20250625-mcast-querier-vlan-lib-v6-0-03659be44d48@pengutronix.de>
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Cc: netdev@vger.kernel.org, entwicklung@pengutronix.de, razor@blackwall.org,
 bridge@lists.linux-foundation.org, dsahern@gmail.com, idosch@nvidia.com

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 25 Jun 2025 10:39:12 +0200 you wrote:
> Dump the multicast querier state per vlan.
> This commit is almost identical to [1].
> 
> The querier state can be seen with:
> 
> bridge -d vlan global
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v6,1/3] bridge: move mcast querier dumping code into a shared function
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=da6fbcf63c13
  - [iproute2-next,v6,2/3] bridge: dump mcast querier per vlan
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=baeeb9a8e184
  - [iproute2-next,v6,3/3] bridge: refactor bridge mcast querier function
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=cdc027cb7f47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


