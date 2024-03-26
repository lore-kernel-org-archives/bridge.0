Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D491D539
	for <bridge@lists.linux-foundation.org>; Tue, 26 Mar 2024 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473634; cv=none; b=nLGHYhGfqyNRq2KC87mhOv5mDTrP/eoXpIHi/JLOcW2K2YT2mxhit6YwlB91UqbPhXpDH/Rh8Hh8UgnjI6m5BUASYQwq3ozE4VylVMyZXs/thTFyy3isw+aWpsQmtfoxqBhJLx9VE5B6kQmiG0aT4mjj/E1ZjPhcI/yifwEDPjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473634; c=relaxed/simple;
	bh=/rHwIm1deK3wilJYf4JGMKVmiAfgUh423UZkZsb00/w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Me42VGFFOhz1hz9X//E7T15rn5hyAwKbkrBYokOghS68tO5m3xquAzCtgfoxpd2uRZA2Ia653stalVOgvpYQTRZYVhu4Bw2gcSWZWR57dHuunSpJcg0jOuiJ/7yDYrnxsJ+I9UT2oKycxpNUAB5TvPkfhno22zTXDnpRYtkIWfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSIGRrZY; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSIGRrZY"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E32F6069E
	for <bridge@lists.linux-foundation.org>; Tue, 26 Mar 2024 17:20:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.101
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TUvoPdLocw-Y for <bridge@lists.linux-foundation.org>;
 Tue, 26 Mar 2024 17:20:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 630456065C
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 630456065C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QSIGRrZY
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 630456065C
	for <bridge@lists.linux-foundation.org>; Tue, 26 Mar 2024 17:20:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9256961302;
	Tue, 26 Mar 2024 17:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40C80C43394;
	Tue, 26 Mar 2024 17:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711473631;
	bh=/rHwIm1deK3wilJYf4JGMKVmiAfgUh423UZkZsb00/w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QSIGRrZYgW/lo2/XAg9TCDhAIjvuf8Tkr0CqAuz2Xbvcy+FyxBZ7vap3Gi7OdPYvL
	 o/lrBlvJpRjgW942xeKsoa2TEe8lNZ/fWPHd4ekBTQemMJQklquSANvYs2N2RXWm6W
	 FggiNVqFf7WoUsERKxsuC/MVJeNLQ1E144EGJ/ZvGoOgaOfXKrVIG2A0sBMl22TyCy
	 I08B7Cyei/f13aHoo+rOJn8Y0C4eDAhY19UHkSn+4SKMNUMe3dDyYCa7eaOMbHB+xi
	 rNsS7Le0JBmgsABMroncbJ7WbjA6qRkM9l29ZscevQgIZUnFFeVzgKLt80FObmmv9K
	 LLTseblJawqdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 316ABD8BCE8;
	Tue, 26 Mar 2024 17:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v3 1/2] bridge: vlan: fix compressvlans usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171147363119.25319.2119573742630649233.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 17:20:31 +0000
References: <MAZP287MB05035FBFC9A954A55A67790BE4362@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
In-Reply-To: <MAZP287MB05035FBFC9A954A55A67790BE4362@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
To: Date Huang <tjjh89017@hotmail.com>
Cc: roopa@nvidia.com, razor@blackwall.org, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 25 Mar 2024 13:49:15 +0800 you wrote:
> Fix the incorrect short opt for compressvlans and color
> in usage
> 
> Signed-off-by: Date Huang <tjjh89017@hotmail.com>
> ---
>  bridge/bridge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [iproute2-next,v3,1/2] bridge: vlan: fix compressvlans usage
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=43b53968634e
  - [iproute2-next,v3,2/2] bridge: vlan: add compressvlans manpage
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


