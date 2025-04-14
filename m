Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BB51F4604;
	Mon, 14 Apr 2025 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744672200; cv=none; b=WrHNwWF8wG3MPLgJ2kdJLiX+AXSijh6JoBdVrp2B0YBonC50AhDgVNyKzPbSzYg4rTwSmijmSvGQhMdoatVvz1NN4bzpN0S42SQyWfEXp3iZaT5syfVyUK/kY6ItIwAiqWgaHVOysue73J3SeULVCWkJVfBnlanBcINYz2dXtJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744672200; c=relaxed/simple;
	bh=9LfV/italWFNgIffCoa7HAgXNf1qvq53TgnzgS4bu4Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f6rxO31qJt2AcS4bM3QAt5GhlnrCIRmCSHdi2L/kDEO5wGelWmai8lVqIGNqlGJBbvr9d5VgF46+05gGJ/TQQTOhJGq6M/SzxYHUSPyfGOfWZE7qfLcXL4nMYtag/yJ5e5QX8ts54zGLvpxe43zBOK7OYdZK0Z4932FgeILAryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rond3j7k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rond3j7k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD555C4CEE2;
	Mon, 14 Apr 2025 23:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744672199;
	bh=9LfV/italWFNgIffCoa7HAgXNf1qvq53TgnzgS4bu4Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rond3j7kwGPoNsVe83XcdSLfP3KUJA7/vG0NVR3GpGVWXkR3fjQqNf2eguwi1Uvon
	 s7TmqQF54Bir/HL2NBg40ZtOweBafX2efPz0g3e2JO5cVoulIscteBtpJEMsWROTcA
	 5WPm9lGhgJ5lifoNGjG9xD1DZ3EDaEd8tGTSnP9TESXt9o7gD7uh9+tmqGsKaieIhP
	 Ts/QxrrOowuP/ZyBiL6gxPoHYOVIzFvTkEsM8I/mS/EhHksG+wawbtXoh7WL7WdzL9
	 TO5hp1T9wqPNacl2hE6AZZNgmkptTtGJgBD+ktY2PARe6tA65goeTRKapZ3SQB7GnR
	 gkodQM8IS47WA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBC253822D1A;
	Mon, 14 Apr 2025 23:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch v5 net-next 0/3] Add support for mdb offload failure
 notification
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174467223773.2068134.3853705562346849194.git-patchwork-notify@kernel.org>
Date: Mon, 14 Apr 2025 23:10:37 +0000
References: <20250411150323.1117797-1-Joseph.Huang@garmin.com>
In-Reply-To: <20250411150323.1117797-1-Joseph.Huang@garmin.com>
To: Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, joseph.huang.2024@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, roopa@nvidia.com, razor@blackwall.org,
 horms@kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Apr 2025 11:03:15 -0400 you wrote:
> Currently the bridge does not provide real-time feedback to user space
> on whether or not an attempt to offload an mdb entry was successful.
> 
> This patch set adds support to notify user space about failed offload
> attempts, and is controlled by a new knob mdb_offload_fail_notification.
> 
> A break-down of the patches in the series:
> 
> [...]

Here is the summary with links:
  - [v5,net-next,1/3] net: bridge: mcast: Add offload failed mdb flag
    https://git.kernel.org/netdev/net-next/c/e846fb5e7c52
  - [v5,net-next,2/3] net: bridge: Add offload_fail_notification bopt
    https://git.kernel.org/netdev/net-next/c/9fbe1e3e61c2
  - [v5,net-next,3/3] net: bridge: mcast: Notify on mdb offload failure
    https://git.kernel.org/netdev/net-next/c/c428d43d4f56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


