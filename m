Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD4915D1
	for <bridge@lists.linux-foundation.org>; Wed, 24 Sep 2025 00:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758673227; cv=none; b=mMOID/0abLEFZpo6bGxVMVzIH87cJpXcZ9Fa0d9TzBkqEwubz8skUP1AKs8KJsCDIbkxNFRmEFd2oYNJX9+Msx+SAimA4TpsPPj2uK00jullgC1di96lrXrf6OWpa+B0dGvce4zgwGXscaMi/rAEzCGm0O9Pwue0azJADm2OvoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758673227; c=relaxed/simple;
	bh=AsLKiOnYrDDrClhwRLf39bXJPVdgZThDfAY5suNGOwI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bgaiyNi2vv3mPW6vAEPDCnwuC7oFK0EC3t69obtketMo13Vtb20zjDC9aAADDl+IVse9fYOp9fRsgZVNN8SDsprjN/LfM/Ab2hRgG83ldjIezh/UN/hAbl9G84409vVT/lTwLMgIV0y74ZwPP6PxHo6AM4ONlRthpyKVRnmBKj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWaJJHJM; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWaJJHJM"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3CBA60E0A
	for <bridge@lists.linux-foundation.org>; Wed, 24 Sep 2025 00:20:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4qUMnNmpL-ss for <bridge@lists.linux-foundation.org>;
 Wed, 24 Sep 2025 00:20:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 185CC6125F
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 185CC6125F
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nWaJJHJM
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 185CC6125F
	for <bridge@lists.linux-foundation.org>; Wed, 24 Sep 2025 00:20:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 60E3660202;
	Wed, 24 Sep 2025 00:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1212DC4CEF5;
	Wed, 24 Sep 2025 00:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758673223;
	bh=AsLKiOnYrDDrClhwRLf39bXJPVdgZThDfAY5suNGOwI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nWaJJHJMUCIWhwL8RV1GpbKmyL+MIbboAKqP144zgExqikew5HlVDS++FBvxfVccL
	 NNPYWbRd9SrdgbAysuQKK2nRHdrJsk88iBCt/gdxL/jtaFgneQP95egwbTBJqf9stw
	 LCX2xhfUcKzu5AmFDxk7steqlOEfatmBzlBqoJk8+9GYz3x8SenAefwWCfk1VcfrhE
	 rUXi+lle0Aja59Z9Z3A63NmjQIjJdQbqBeVuZdxObi6jzyLDgxJnFDHy7mG79iS0Ua
	 snYe5wOK5s/Dhl27soP9kSHtdO1kyasMLwrPghbSezx6Qjg5cXQOqntfjr7TZZVpi5
	 6x7UMImRC/uyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B6839D0C20;
	Wed, 24 Sep 2025 00:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net: bridge: Install FDB for bridge MAC on
 VLAN
 0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175867321999.1971872.15659581370165041096.git-patchwork-notify@kernel.org>
Date: Wed, 24 Sep 2025 00:20:19 +0000
References: 
 <415202b2d1b9b0899479a502bbe2ba188678f192.1758550408.git.petrm@nvidia.com>
In-Reply-To: 
 <415202b2d1b9b0899479a502bbe2ba188678f192.1758550408.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, idosch@nvidia.com, razor@blackwall.org,
 netdev@vger.kernel.org, horms@kernel.org, bridge@lists.linux-foundation.org,
 mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Sep 2025 16:14:48 +0200 you wrote:
> Currently, after the bridge is created, the FDB does not hold an FDB entry
> for the bridge MAC on VLAN 0:
> 
>  # ip link add name br up type bridge
>  # ip -br link show dev br
>  br               UNKNOWN        92:19:8c:4e:01:ed <BROADCAST,MULTICAST,UP,LOWER_UP>
>  # bridge fdb show | grep 92:19:8c:4e:01:ed
>  92:19:8c:4e:01:ed dev br vlan 1 master br permanent
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: bridge: Install FDB for bridge MAC on VLAN 0
    https://git.kernel.org/netdev/net-next/c/cd9a9562b255
  - [net-next,2/2] selftests: bridge_fdb_local_vlan_0: Test FDB vs. NET_ADDR_SET behavior
    https://git.kernel.org/netdev/net-next/c/f67e9ae72dd7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


