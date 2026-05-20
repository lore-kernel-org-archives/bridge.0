Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D981D7995;
	Wed, 20 May 2026 01:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779240611; cv=none; b=SdEEACLEVFUuGEWICBrid2x0hulAtAO0UOdJ51LiCkA8ih/R4i9le/7AZ+SPmu9Ko53Ukza4QJYfiAqbdXzHWQVVem7Ehks74ER87u80l7iwnRzeRnzoCavLCaGcIx0CwK6mMRlI5Gac39Y2ZE8nycfHwnUmrXY8KILXu4Z1XqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779240611; c=relaxed/simple;
	bh=jTRlPnSOWZHJosogVXrzfWKO+kWGZCUV97dNt8sgUlA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bA2+cvOtggNY2LC/30djJXZxYQl2r0l31aWw/304b2IiWm3o/APOinXyQD0G8zxeMDBrhXqXEMis6fHg5GyFKRrVK707K/uCMX8RjWEaWadLRebriGR+RE3Js0Jw28nei4aIu0NujXh8bZg+Drj4tZ2OlLgNKa4Ytn/ErKCgiaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9ArQaeU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9ArQaeU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BCF1F000E9;
	Wed, 20 May 2026 01:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779240609;
	bh=wIvZ6PgdFGga6gl6kL0+8wTOSm2S6UKARMpBdCAh8Mg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=K9ArQaeUXS+YX9AvP6Pl2x9eBe+esfzJuLHMtYHXpgVpQwHtxG8tDB63SqzArkIrC
	 QpV3jENhqld1eTALEYyqrv9sAZZMIwTf2SglKhGuQvJXlineg1ualKdhUuth9Xm/Lp
	 8TyTKe43Ts+eGz5NUyolqkv/V7TzuJ3TM06pLRdr3tg0wOFgJOZDx+vDdLYQpQlP8t
	 zYjeMYHueqElZEnmZbBbB64iUZZayfuKXkuJ2Xka06e9ChM6mURZyXBQHZgCIk/xXE
	 vSpS20L45IA4H8wOph8unD2OtxQcVXwmba728FU44oWOyqg76QLroG9i681JnLcCrZ
	 28IRQU28osS1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D08B5383BF53;
	Wed, 20 May 2026 01:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bridge: Add missing READ_ONCE() annotations
 around
 FDB destination port
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177924062039.2943546.12387380140236795047.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 01:30:20 +0000
References: <20260517115009.175163-1-idosch@nvidia.com>
In-Reply-To: <20260517115009.175163-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, razor@blackwall.org,
 horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 17 May 2026 14:50:09 +0300 you wrote:
> When roaming, the FDB destination port can change without holding the
> bridge's hash lock. Therefore, add missing READ_ONCE() annotations in
> both RCU readers and readers that hold the lock. In the latter case, the
> annotation is not needed in places where the FDB entry was already
> validated to be a local entry since such entries cannot roam.
> 
> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next] bridge: Add missing READ_ONCE() annotations around FDB destination port
    https://git.kernel.org/netdev/net-next/c/bcdfd9fb109e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


