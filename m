Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E251D551
	for <bridge@lists.linux-foundation.org>; Tue, 26 Mar 2024 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473635; cv=none; b=fO7dFQB54GRySi9ZtxPiIuRCWTjPo9e/r5di4Ta6l1PvDU5vQOhzS/w5jR92XDl8qprKSEv+OA/SuF/rTjbBeAqOPND+S/75ulGodKvB8Fh+ZEcw/Irc9zjpcxjQy+YcBTEOm4h/3lCnzVkG1UabMPc0XkRxKLcjZsd/ah4igCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473635; c=relaxed/simple;
	bh=Y1zyvG4k5gdIwGVGPtgZesUY+MghHSuoXSfeukvLL7U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IhPsF6str3nafFg1h1PmcHpjzUujqT19azY3tLQd5u6klvc0c/X2i8ilDaSSIqbUbor+Fl9rEYznXfMCBab9RdxWZr33B8lBmPxmscDwt3kxWxmfhuxRGi0mY06j1ma6F4qwyEzznbQodLkVfatC5hdF6hwx/IN63g3TftpOWBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5vcnlwH; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5vcnlwH"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9354440196
	for <bridge@lists.linux-foundation.org>; Tue, 26 Mar 2024 17:20:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wA8eh4-Inxj4 for <bridge@lists.linux-foundation.org>;
 Tue, 26 Mar 2024 17:20:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AD1F840108
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AD1F840108
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=l5vcnlwH
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AD1F840108
	for <bridge@lists.linux-foundation.org>; Tue, 26 Mar 2024 17:20:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8B2CE6129B;
	Tue, 26 Mar 2024 17:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AF01C433C7;
	Tue, 26 Mar 2024 17:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711473631;
	bh=Y1zyvG4k5gdIwGVGPtgZesUY+MghHSuoXSfeukvLL7U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l5vcnlwHjhUMluWCQtqv2MBFU4CLdW8n9z8Zm489RiouzpGcueOI/VIWdAYmqkMcf
	 j0CHflVbNedXJHzZh36ADynBgJhq9QRRrS3uwo7OrgI4UyCYOsHLhvj2MqCXHNt367
	 RseF6jLrosQwBGM9dqMDy5jcrWK29331ZdnzAxnf4+fdKd5v1rDo5W54ZSTKO5yMwk
	 acnCCounCtUsrUFUQt+yMjKOelK4MaJKUla1AKqIhOfALTmrjoK7g+n+7MlD/7kren
	 FOAGMEzEhx1Qkew/Gf+tutDX+vrI9mzF+rKZfX6Y45UOJgThWEhNq3wtXIifDZJUiM
	 jGUGf1H5a74Mg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28AEFD2D0EC;
	Tue, 26 Mar 2024 17:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2 0/2] bridge: vlan: add compressvlans manpage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171147363116.25319.1656578476839776586.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 17:20:31 +0000
References: <MAZP287MB05039AA2ECF8022DD501D4BCE4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
In-Reply-To: <MAZP287MB05039AA2ECF8022DD501D4BCE4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
To: Date Huang <tjjh89017@hotmail.com>
Cc: roopa@nvidia.com, razor@blackwall.org, jiri@resnulli.us,
 netdev@vger.kernel.org, bridge@lists.linux-foundation.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Fri, 22 Mar 2024 20:39:21 +0800 you wrote:
> Hi maintainers
> 
> I followed Nikolay and Jiri's comment and updated the patch to v2.
> Please check it.
> 
> Date Huang (2):
>   bridge: vlan: fix compressvlans usage
>   bridge: vlan: add compressvlans manpage
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2,1/2] bridge: vlan: fix compressvlans usage
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=43b53968634e
  - [iproute2-next,v2,2/2] bridge: vlan: fix compressvlans usage
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=9ccf8fa8d4d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


