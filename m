Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD4F2E738B;
	Fri,  7 Aug 2026 23:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786146065; cv=none; b=PmAsH+Pl76i/nlBl6RPN2YCpNa7uMntv8IIcSQ7jKl5flnyf3bLV3vGBI/aZVF8k6u5M+eBlJQ8BLD5TlXQDE+iLwP6qtPGqWkWkq7ivPJcb2Cg5reBOp90RdEPf+rZOMeViMwNLz1w0vXO2n0Vww5HGktkkiXhGQ55VwNYKEaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786146065; c=relaxed/simple;
	bh=jVEOoZr574AUQLwTn558cGWbjz0MKUAsl7zINVwziiU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sniFh9xusWEc4BsXT4Uo2HqTAuMGs8EYl4IGGS3G4c/cwCP6kUIuk87mIHxmWfuXHrDWhcd5ZXDiVv+bVOQZMxk3CUQ1+MOK6FhqOm1oqRKli1K3PKPxq8oTboXobZ5+xXK4L8cdbqRafjqw8UkZb3JkcC3B0JbSYsGIbt9Aspk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCDFDsSG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCDFDsSG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34861F000E9;
	Fri,  7 Aug 2026 23:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786146063;
	bh=5sKIwkA3YiSD9rYIJIWzyi7doLr4k4YEOfI3zsuywnY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cCDFDsSGs+gS7QvthR3d6anV6UG+4XZpM+a1S3XqKhZIEhklxLZUXskveZNv/2VY3
	 UnyAGwSBjF9bMt9LnJ9OC09aUs0fMxSVg3eS3FRN8+CW6rNyeyT9lg9TFK57UWD8j6
	 ESGDxELv2KwZCULf8tSMCuXxLiIURBs9muTg0Hqtmb6FLNoyzjNIkeU8Kef86F9Rmd
	 EkZb8/LM7EVkCkIgItRAsneu3GxsXEQvh8Hz9ir0HKY0BFK4aIfTHVqNd7gGgISvmS
	 nzElZeFdDktTXSdSHDOdMA8cIoWf7deG5i85obeU1OkKKbd57jXDV5gj7qLsCAQCXW
	 ndgq2OKrceM0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56956380CEF9;
	Fri,  7 Aug 2026 23:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] bridge: Validate and clean up IPv6
 neighbour
 suppression
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178614602190.2465504.10010813956529839994.git-patchwork-notify@kernel.org>
Date: Fri, 07 Aug 2026 23:40:21 +0000
References: <20260803112505.613873-1-danieller@nvidia.com>
In-Reply-To: <20260803112505.613873-1-danieller@nvidia.com>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, razor@blackwall.org, ja@ssi.bg, petrm@nvidia.com,
 fw@strlen.de, kuniyu@google.com, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 3 Aug 2026 14:25:00 +0300 you wrote:
> The bridge implements IPv6 neighbour suppression by snooping Neighbour
> Solicitation and Neighbour Advertisement messages, but it previously only
> checked the ICMPv6 type and code before acting on them. This leaves it
> open to acting on malformed or spoofed packets that any RFC 4861 compliant
> node should reject, and the option parsing in br_nd_send() open-codes a
> loop that has historically been a source of bugs.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] bridge: Use direct pointer in br_is_nd_neigh_msg()
    https://git.kernel.org/netdev/net-next/c/2cad8e3d9d94
  - [net-next,v2,2/5] ipv6: ndisc: Add ndisc_check_ns_na() validation helper
    https://git.kernel.org/netdev/net-next/c/9dfa6cca8959
  - [net-next,v2,3/5] bridge: Validate NS/NA messages using ndisc_check_ns_na()
    https://git.kernel.org/netdev/net-next/c/18668f4747c9
  - [net-next,v2,4/5] bridge: Linearize skb once the ND message type is validated
    https://git.kernel.org/netdev/net-next/c/67b14d6e36cf
  - [net-next,v2,5/5] bridge: Use ndisc_parse_options() to parse ND options in br_nd_send()
    https://git.kernel.org/netdev/net-next/c/7445aaa9fe6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


