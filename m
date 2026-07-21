Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA423FC5C3;
	Tue, 21 Jul 2026 01:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784597448; cv=none; b=Mzc0YXbjLYSk9mzMyLpXA2Dt/n+M7hqUVJ303bkTgvWdvHd2xg0KrR4zJGnitJP/ybpwctt2inFbSAfFaQOE1akJit3Gj20DiwLNmboHO7/rTIphD5h5IVJBTO/afnr3GJ3Q5WCN0lUA3eFpmU2K0loLQO6eJByVeRgZRZ26uHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784597448; c=relaxed/simple;
	bh=fn6+6suD87yMq8/W3e1u/tDlHVj69DGcjtvu9j/NTSo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LMBW2/LBXwd2/pR1QuqitC+lbCg15OA1VDljIMPPnJpeSROnZblXKQxYZtrw2UoLKL5xoj6UF2klya/o5SzI+B0zoZ1RMnP4HH0mNfey+XMJgaun/eWhP8320MFVuk43PSdrCB9S/BB2XDK8kxcSEGhGeYHYdOZhJlM1YR1OAUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrcOO+SD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrcOO+SD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40241F000E9;
	Tue, 21 Jul 2026 01:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784597446;
	bh=sYTQRgUCQyxP4PZjDEdW2ctEL81B2vC5Ga9Vl7nsuoE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UrcOO+SD5xnf2muj2zH4Pr5697Lu3evGisJ9x1iVAF5qhbFH1ddzwnG+BLbSz5dHe
	 sdchCjpBARTemjRWu3T54gUUbWJ8Qu6cv9XSaIuItJZzEqqwBRty61Znu2hVP/DQ4k
	 oGbTYwdxxK+qOG7xULYT3k24lLHCP2VaHNJ2J6MPRuV6iOwNZzwT6BAP1LUeCHz3fs
	 ELC+vBUG4lMk81co2UsJYvQ10KeEpSGiIsmuz2JZlA1anCaZaT2r7F6liwzsDK+Vu1
	 B884R1hsjWwI4JKBXtz7SnYPppIRWsK3C6G2GMhp35i07nlIjr2ZARH5adIc+Oa2Fe
	 aIbYhWlor9ETw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1991139244E7;
	Tue, 21 Jul 2026 01:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netlink: specs: rt-link: convert bridge port flag
 attributes to u8
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178459741664.39048.17414512935698336198.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 01:30:16 +0000
References: 
 <a57cdfcfc4a6dcb92106c25b4dde5059fde2bd44.1783236731.git.danieller@nvidia.com>
In-Reply-To: 
 <a57cdfcfc4a6dcb92106c25b4dde5059fde2bd44.1783236731.git.danieller@nvidia.com>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, razor@blackwall.org, petrm@nvidia.com, nikolay@nvidia.com,
 idosch@nvidia.com, bridge@lists.linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 7 Jul 2026 11:03:04 +0300 you wrote:
> A number of IFLA_BRPORT_* attributes are documented in the rt-link spec
> as having the "flag" type, i.e. a payload-less NLA_FLAG attribute whose
> meaning is presence-only. This does not match the kernel, which emits
> these attributes with nla_put_u8() and validates them as NLA_U8 in
> br_port_policy[]. The values are not mere presence flags but carry a u8
> payload (0/1).
> 
> [...]

Here is the summary with links:
  - [net] netlink: specs: rt-link: convert bridge port flag attributes to u8
    https://git.kernel.org/netdev/net/c/f6e3b21608e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


