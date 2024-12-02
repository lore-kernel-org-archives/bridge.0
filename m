Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB2B1DED6B
	for <bridge@lists.linux-foundation.org>; Mon,  2 Dec 2024 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168422; cv=none; b=OiRnb9D0KR7IWKTX6co5WHCVjLrWRFXEP9FY1mXUGGcDLdHLjcvrrkvppkGRbF9gu1TU6/7sdu7GdWr90hFbhCN6TAtvreTbJvqC1vFH8R9zpPndk+rfeJJPpCv3VjPpIzq56sNs+aSakas3gjqJaBo/tBgrmsjUi9cKZiboKFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168422; c=relaxed/simple;
	bh=UlEOERXcozjwdrvIIh6LO4viPEq6OisSFY32daHo7As=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OE8cflYMHfeHEWBahme78cB2tQy8iJCT/q/AF0ej8nZ/ChhqQ9Yb6JKd+0sEdqfIdRagh3dKo1HtyEP7dCtoLPUL3RKLTcF/lR0UicodwFrWWc3K1VzmLaJ4P70SB131+ZxTfHufZl7WF+Sk8VP7CCcncnDdjO+kh8NzRSW8EDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVRUtgm8; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVRUtgm8"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FB824087D
	for <bridge@lists.linux-foundation.org>; Mon,  2 Dec 2024 19:40:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HzIBb338jzek for <bridge@lists.linux-foundation.org>;
 Mon,  2 Dec 2024 19:40:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9A07940882
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A07940882
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CVRUtgm8
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9A07940882
	for <bridge@lists.linux-foundation.org>; Mon,  2 Dec 2024 19:40:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 216A45C67F4;
	Mon,  2 Dec 2024 19:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D259BC4CED1;
	Mon,  2 Dec 2024 19:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733168416;
	bh=UlEOERXcozjwdrvIIh6LO4viPEq6OisSFY32daHo7As=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CVRUtgm8d99XQEa4oOHoxwq6eQ7vRRcjakWnHaufRKK+DSfrHQ9XRvbnY3EwJvL+g
	 x/fWrAo0xJmqLRbV1R5vsG8UxTjBYPL/OFn4EBojOUWsHupeV+iq3BJE/tKIcOAJnY
	 9DkkwtNUuIlFI+mQ/d33NQ32Wk7qldviLxSlUUj/aJd33cuQqrnNZjh2j7P2sXGmPZ
	 cFavJf4/6j8wxfHFGwktQq8m5Np4KQPHbYgX7vSwQwGdyHBzS032l5k4iHRADkXXOK
	 ApxI38rkJb40oiQO6jMwpJAU9fkQ9UO1pmQHa20u9/qHxR0tEMJDPAXrnhVPiptYjb
	 WCCOadc39IOaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34E2B3806656;
	Mon,  2 Dec 2024 19:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 v2] bridge: fix memory leak in error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173316843074.3871672.16208625269238916831.git-patchwork-notify@kernel.org>
Date: Mon, 02 Dec 2024 19:40:30 +0000
References: <20241126021819.18663-1-heminhong@kylinos.cn>
In-Reply-To: <20241126021819.18663-1-heminhong@kylinos.cn>
To: Minhong He <heminhong@kylinos.cn>
Cc: razor@blackwall.org, netdev@vger.kernel.org, stephen@networkplumber.org,
 roopa@nvidia.com, bridge@lists.linux-foundation.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue, 26 Nov 2024 10:18:19 +0800 you wrote:
> The 'json' object doesn't free when 'rtnl_dump_filter()' fails to process,
> fix it.
> 
> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> ---
>  bridge/mst.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [iproute2,v2] bridge: fix memory leak in error path
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=5682cf3ac6f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


