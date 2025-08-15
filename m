Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44B81419A9
	for <bridge@lists.linux-foundation.org>; Fri, 15 Aug 2025 00:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755219515; cv=none; b=ic0GR5kxh+tGZ9yJSAT7uUC7JtUOmBz1EPJjrGMW+1iTkj/L1LK02KzUrD6yQrVQOlIviMgcGkx2F8Hh64Y+BsQJMLfCvPHzqQoKtayj5FV1u0PuWY/Qv0DpEYDoYsqvp7pE0IpsH9yQA7qjsI1Qt+UcJjtfCtzzt4lfERGJ/B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755219515; c=relaxed/simple;
	bh=g5sfBB+8wm+QzrL4fd0Fu1o9NJK9Iqu6DIyVGvdZLZQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZWlxF0tFybirCq9rOTHJbEPvqYg4Y0bodDQaCbXZuM+VUnyRcRJ9C16BwmvZ5Hbfohm82s/Qw3Sib/kg/YglC9xja8VlZbjnmbOPMLlAr/yYe758Aux/E/iS/zBrMPbI3UJZcz2Q30XoWxbTjaYN+Ovi5nw2HvhhGWuSfFB8sIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kilzjN4z; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kilzjN4z"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4E08340720
	for <bridge@lists.linux-foundation.org>; Fri, 15 Aug 2025 00:58:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -10.792
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oc5WvXGAoDI1 for <bridge@lists.linux-foundation.org>;
 Fri, 15 Aug 2025 00:58:33 +0000 (UTC)
X-Greylist: delayed 499 seconds by postgrey-1.37 at util1.osuosl.org; Fri, 15 Aug 2025 00:58:33 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9672C40075
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9672C40075
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kilzjN4z
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9672C40075
	for <bridge@lists.linux-foundation.org>; Fri, 15 Aug 2025 00:58:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1375C5C67F2;
	Fri, 15 Aug 2025 00:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20AAC4CEED;
	Fri, 15 Aug 2025 00:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755219012;
	bh=g5sfBB+8wm+QzrL4fd0Fu1o9NJK9Iqu6DIyVGvdZLZQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kilzjN4zEVqTe9tQjptp/LHY7GB0SKVZCzYbYC29Xxpxj/BlPQbA+OBUuER4MFf7H
	 XUjFZIt/Qw24yMaDPYfpKkVD1FgPFZe4MfxrgJZM2WK9Qi3m/vW/+H7i4YeekYsDQw
	 8c9szoyiKLQb01XAl0EhGqF/0RGxN2ryMF9CHHk+A2h4viaxaMEwe584WBpDd03cOa
	 RpF9q0/qg9KMllnuedPOpZQNp1VnvIzsklyntiiCRkQ8jFG+qLg0nujW3tcTALdDNP
	 y/n91dXnTT8XQpwn8lafyqBJwIPpmnt7UBQ9VD3tCJgaJXbNoVHsVLuo7ChGwWV8np
	 lTpw74damNlvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B4B39D0C3E;
	Fri, 15 Aug 2025 00:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] bridge: Redirect to backup port when port is
 administratively down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175521902398.500228.4413563447477304609.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 00:50:23 +0000
References: <20250812080213.325298-1-idosch@nvidia.com>
In-Reply-To: <20250812080213.325298-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 razor@blackwall.org, petrm@nvidia.com, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Aug 2025 11:02:11 +0300 you wrote:
> Patch #1 amends the bridge to redirect to the backup port when the
> primary port is administratively down and not only when it does not have
> a carrier. See the commit message for more details.
> 
> Patch #2 extends the bridge backup port selftest to cover this case.
> 
> Ido Schimmel (2):
>   bridge: Redirect to backup port when port is administratively down
>   selftests: net: Test bridge backup port when port is administratively
>     down
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] bridge: Redirect to backup port when port is administratively down
    https://git.kernel.org/netdev/net-next/c/3d05b24429e1
  - [net-next,2/2] selftests: net: Test bridge backup port when port is administratively down
    https://git.kernel.org/netdev/net-next/c/51ca1e67f416

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


