Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F843EBF2C;
	Wed,  4 Feb 2026 03:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770175819; cv=none; b=i7Bo45UFSniFGV2jwNF0FMXrBvUG4eOx6A63Faiiz32+xX+0EE29qtyqYzl439fBfOY8pbg9oWDYZjSJdG3rB1PEBjVZHFXYyZ+K3EOhjcHhYaMWwg5jW9ZIgUsmaZ2gFp+mmc0NjMs4i9mX6DtML5TxluGKTR6FTn5JiwsEiv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770175819; c=relaxed/simple;
	bh=N0gPfx+mrjsGjtAOixXxt/e/mIoWqnLIPtX3G+OWHhc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mpGoccxQBxv5w41DF449h0ZtCPicVwLJGaOZ6F5e8m2B0MM+Fs7QU+2QNubMGa+67QwYwBwbG8W//4WWn8Ht4xDIQG8R387zq/nRVR+TLJ57xyCdt7n+8ojX+7qCqrZ/rop/N4cEAwhP9ZtiSUqTUVaQBh4WTsDp+/D2Zqo7EpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKJ+e0i0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKJ+e0i0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C9EC4CEF7;
	Wed,  4 Feb 2026 03:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770175818;
	bh=N0gPfx+mrjsGjtAOixXxt/e/mIoWqnLIPtX3G+OWHhc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UKJ+e0i0lzVLgQ4qJjIKv82Kh4dlfoz6UilwQhiUnb5WiJjlEe8oP6HkD+ynucgOT
	 T+vFH1bjHdkXvglg8vtb5ARQzNLwKoWXbWzWpGg1GwIsclzSQ0GrE86H2agSPSrPfZ
	 /sh7mu4vDQhj15Hb/7G/mBg6zK66GYW4HBOQscJKoOHWd0vldz5ZFNz4hqYArsE+93
	 L2HdwSCp44J0a0LkTH5J5OCoDNgB4PpMsCF9kd1xtmG/0vt6ux0OUnVgLk4K9qm+66
	 o0scc/iI+8pn03UCmI/9Y7hYJB7QgIiljCHacJZh4+k9oezFsZywE2/2IBg7/OL3RA
	 vPo4/Gjxl9/pA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 53E143808200;
	Wed,  4 Feb 2026 03:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: bridge: use sysfs_emit instead of
 sprintf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177017581512.2166000.312361835089736155.git-patchwork-notify@kernel.org>
Date: Wed, 04 Feb 2026 03:30:15 +0000
References: 
 <0100019c1fc2bcc3-bc9ca2f1-22d7-4250-8441-91e4af57117b-000000@email.amazonses.com>
In-Reply-To: 
 <0100019c1fc2bcc3-bc9ca2f1-22d7-4250-8441-91e4af57117b-000000@email.amazonses.com>
To: David Corvaglia <david@corvaglia.dev>
Cc: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 2 Feb 2026 19:09:41 +0000 you wrote:
> Replace sprintf with sysfs_emit in sysfs show() methods as outlined in
> Documentation/filesystems/sysfs.rst.
> 
> sysfs_emit is preferred to sprintf in sysfs show() methods as it is safer
> with buffer handling.
> 
> Signed-off-by: David Corvaglia <david@corvaglia.dev>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: bridge: use sysfs_emit instead of sprintf
    https://git.kernel.org/netdev/net-next/c/6dfa3df797bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


