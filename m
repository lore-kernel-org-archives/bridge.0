Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B163ED109;
	Mon, 27 Jul 2026 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192056; cv=none; b=LsF6POXfEz3AAhapzCRasI/ChDub/dLHelgsXeKJ5/Q4X59c0IzJP0ErdbVZdg21Tnujq0bEakYZ5xqjL32IeFgKYcq4m3cWIHtmltAHxdfNJ2UPdLNfBmT3nC01xLG+N5RjMAqkrx/ws7rzgjFMQ2ClaeK4vc84Q3/6dx44poY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192056; c=relaxed/simple;
	bh=rf2bfZuVGszM70Samwl9CQmJhwVeNMnFbzxPN52Ll7g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fyq1zbcFkL5zHve71OfEgKqu9+Jyd8tPU5pJY6mURTIh3OyPVYB5qRaOJ3Z00b0WqpccJNhn55JvX/EVXhDFQmfsoeOGfS8WNWCgnsEAAbtnu8opeSyuvRbLZpN3V3j3/MkB5l4HEmk9pVUAxAs6FUVUEFVzjVgtuA7M6M3m+CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5Bb+z61; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5Bb+z61"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5411F00A3A;
	Mon, 27 Jul 2026 22:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785192055;
	bh=XRwfXWQ34ILdWnNLRPG2d7pC4hEEoox7ulKOeiP0BA4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=R5Bb+z61fLsaze9AkWtBp9AOxgaXwByp8yP9BW3J1zW9mzzBn/PRSRpSJDBoUS4VJ
	 reiaIwZEzDyLOJZJ3OS8DHzSppb/sNB9qwhD5snfufQI4NKEpyxShVkaNoWQaWqvIO
	 RqeWv/qt9XE5HhIQbDJf9Jv+d/qVNPBLLYZSD8CpLvUAbJ0XS/FqVgLqRuvkxUUjfz
	 NTtBZfj1KKPv06CzQZQ0nVkbiBFiOnnfcZJVw9o87nijTdMyJrjF8zPhpGIw8qGn7O
	 1j8Tu4a9qZc+52luyYl9rO9nHvkzZEgupnUza61xo5mWOeF5+3swTt7K/UJbayCgLC
	 h1VeQtVjs3i/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93CF1380CECF;
	Mon, 27 Jul 2026 22:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/1] net: bridge: fix fast-leave use-after-free
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178519202013.1443317.3670329492058915531.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jul 2026 22:40:20 +0000
References: <cover.1784707712.git.zhilinz@nebusec.ai>
In-Reply-To: <cover.1784707712.git.zhilinz@nebusec.ai>
To: Ren Wei <enjou1224z@gmail.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org, razor@blackwall.org,
 idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, nbd@nbd.name, linus.luessing@c0d3.blue,
 vega@nebusec.ai, zhilinz@nebusec.ai

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Jul 2026 00:52:47 +0800 you wrote:
> From: Zhiling Zou <zhilinz@nebusec.ai>
> 
> Hi Linux kernel maintainers,
> 
> We found and validated a issue in net/bridge/br_multicast.c. The bug
> is reachable by a non-root user via user and net namespace.
> We've tested it, and it should not affect any other functionality.
> 
> [...]

Here is the summary with links:
  - [net,1/1] net: bridge: stop fast-leave after deleting a port group
    https://git.kernel.org/netdev/net/c/a39789f211b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


