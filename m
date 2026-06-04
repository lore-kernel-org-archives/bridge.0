Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224F23491E1;
	Thu,  4 Jun 2026 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587006; cv=none; b=ew6tGR2tTAxylLr6Q+GGVL0R8piV/zznHdXi4xcHgYrW6FInqlikkY67nwOQQl6w92L01Pkh2lCWi1AyGn/xwS/QwOsDeg8W0Zp2AlE9K9bQnUh5hR/+QJWKuaggb/mmCHXgnUz78+NaF8TdGL8PE817ggWPpNpa9/lHJH2K1ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587006; c=relaxed/simple;
	bh=OjCG4ii5Ej6R94diVRA+YbwYd+iKVD71/fZ3p8MxjQQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s7w2FgfmTiBEpCGlq3OIqQ+c4W/brmEniUuraliJvaM5JtDq1AnjHItL+U8mK9BGTNoOi+FBT8Nf43TcJxNNNgRehZVdkiX8PHuqQ9mtJ4H2svuEYFIjEQeG8Ikj0KXzlbfTFdqS66iv1Qhw2Ue0BArkL9MB4ncUh2Ng3cUvNgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDtvt/Eu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDtvt/Eu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD09D1F00893;
	Thu,  4 Jun 2026 15:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780587004;
	bh=ut9b2yqF9HIKGzxpdHB3sG6CeRnS9xitgBfqtupw1ww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WDtvt/EuhfvS6fRNY9QO2Tfd5aTBgW0mgER4cWqfxn7iaZ1Sp8lYTybOUrWZ6v/d/
	 LmBOJzWvUoVGPlGHnlBTZgGhpQxfgUIed2WudXMTCQRVmHXfILEsk3b/u2PGJA9zo/
	 Cq9pb4vv9z6d00G6NDRwTXtXdi4fLshJjBBe+yXlcRMuPwLjVPYmRTeD4rbPni/fYj
	 UM5IzUi1KwBjy8PaB+bWQmWlq7TUSFLRp6qSUxfcskV0fTJ6+prF7c73JWQ6uvZ6V1
	 5w4YIG6eJcQiCX9TrBH6CMXcmCmxvetPMBMHNLTW+jQpOsphhVeckK+N79V1OpO+la
	 v1Q8GbN1taj8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CAB0739309B7;
	Thu,  4 Jun 2026 15:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2] iplink: bridge: add stp_mode support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178058700565.2481052.14698719924041642531.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 15:30:05 +0000
References: <20260603173304.564055-1-aroulin@nvidia.com>
In-Reply-To: <20260603173304.564055-1-aroulin@nvidia.com>
To: Andy Roulin <aroulin@nvidia.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org,
 bridge@lists.linux.dev, razor@blackwall.org, nikolay@nvidia.com,
 idosch@nvidia.com, petrm@nvidia.com, danieller@nvidia.com, dsahern@kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed,  3 Jun 2026 10:33:04 -0700 you wrote:
> Add support for the IFLA_BR_STP_MODE bridge attribute that allows
> userspace to explicitly select the STP mode:
> 
>   - auto (0): default, try /sbin/bridge-stp helper in init_net
>   - user (1): directly enable userspace STP without the helper,
>     works in any network namespace
>   - kernel (2): directly enable kernel STP without the helper
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2] iplink: bridge: add stp_mode support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=2d84aef19e96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


