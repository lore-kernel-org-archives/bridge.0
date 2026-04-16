Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA62B25A33F;
	Thu, 16 Apr 2026 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776337237; cv=none; b=dGImEMiFE6lME0pwnGrLv7n8l1/o73paKzjGIHse7D3CVepK3Pd5nzfL6886IJaPtSyohfOa954ha9xra5BaT1y1r5VYp85xJeeZtYx9ue2jcxgN1CgpkH6C30yx6teO/Cgfo3Fyb8If8MCFjb/RN01rU82nI1etP1GMIOlwX/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776337237; c=relaxed/simple;
	bh=O7DYIuvs06mainUmCRycXnWxme0hG6ESRlj4urnxje0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LTHG4oIlgsqEiTy57CC65D1ijAcvqFLvzvcCxNxKmWY0A0J9LhiYiaAtv//2fQdY0kDFZzU0YxbVjTtsDtu6kd+4VaL5sD9cbGwqrVteSbJoUPin1F0Zp1LBbtxlGrep0ISrgiQftaZHNIeOgue0PzC1QNxAS2ybDnbzx2uGnzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ue1GEphf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ue1GEphf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89263C2BCAF;
	Thu, 16 Apr 2026 11:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776337236;
	bh=O7DYIuvs06mainUmCRycXnWxme0hG6ESRlj4urnxje0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ue1GEphfu/HsskHAI1OitkGoTVi3gM6mV+JaSP24TTRv27wckwnxJ+h9LnuE+ZPGn
	 MD7n/Q8UCAUdLq7tm0xbuzXr/8FxeNG7XSqGdabvYnCdnpapKZx/7wvgYUoRgWA564
	 IoiCgMXDeTLmxEvoPpsleHhK86Z3yetkvfrErOQu6PVDoYKFfjfmJGc7l13BSpDiDS
	 2YGvtgOs95r9eVL/M1HJaCn7Tah7RjpG5/uSfDYYEeLuGl1isL21qNUx9LUT/QfcRd
	 QwkEP1tFzhL525uprxvtB939kgimQ/k6VeFSNOXMo7ZpCFy2JYPpZgzJQmwltvjJEr
	 BGWbN0W8ysiDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD55380A97F;
	Thu, 16 Apr 2026 11:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net: bridge: use a stable FDB dst snapshot in RCU
 readers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177633720529.2736516.16542585590441378455.git-patchwork-notify@kernel.org>
Date: Thu, 16 Apr 2026 11:00:05 +0000
References: 
 <6570fabb85ecadb8baaf019efe856f407711c7b9.1776043229.git.zcliangcn@gmail.com>
In-Reply-To: 
 <6570fabb85ecadb8baaf019efe856f407711c7b9.1776043229.git.zcliangcn@gmail.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org, razor@blackwall.org,
 idosch@nvidia.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, makita.toshiaki@lab.ntt.co.jp,
 vyasevic@redhat.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 yuantan098@gmail.com, bird@lzu.edu.cn, enjou1224z@gmail.com,
 zcliangcn@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 13 Apr 2026 17:08:46 +0800 you wrote:
> From: Zhengchuan Liang <zcliangcn@gmail.com>
> 
> Local FDB entries can be rewritten in place by `fdb_delete_local()`, which
> updates `f->dst` to another port or to `NULL` while keeping the entry
> alive. Several bridge RCU readers inspect `f->dst`, including
> `br_fdb_fillbuf()` through the `brforward_read()` sysfs path.
> 
> [...]

Here is the summary with links:
  - [net,1/1] net: bridge: use a stable FDB dst snapshot in RCU readers
    https://git.kernel.org/netdev/net/c/df4601653201

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


