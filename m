Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062904CDDCA;
	Fri,  2 Oct 2026 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971216; cv=none; b=Z8+GtdLGRMd/C/1xmfszrXpFbdXurcvpoMA+d1pOgi6z5cZXtrxXdtNd7p5CE/d0KkokJK2dMY3V307juC67uYCI7JkTUGklbQIDnb64qCO+bmhsgAe9mCx/pfVGteRg5jHAnIJExJflcXSNDiU4VUDApNrvxYsB1dd2XUsMFk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971216; c=relaxed/simple;
	bh=4puJqDhMH/yMl5WE7XAM1y41DhQ2DVsN1Wxf9Rf5Fqk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PUm4QkQzI+nPDYhsPtFZTmdYs0lH3FNBx80YbAxHDZBbPxn94ajmUCJpe12n1HdAPIkmt1tz6jje2UaLrk4KUle2AvDdbKvIfyQSx46imSxF9AxAnOvWxtdd3AZw4+/uLab5pKtDuWYHC7lXZmVSKMUNDyUvsoho//GOnZTNbaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJ7/z70d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJ7/z70d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE531F000FF;
	Fri,  2 Oct 2026 20:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790971214;
	bh=cKRmuOxnOhh6/MOH4zYO1BD8bfYFPQM55SyJF1XMWqE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HJ7/z70d0SpSTwR6yFd8xeOx0wjjz1FTaFGAPJVgzyphM2XUV9ZaDVbz3vcV2xfVt
	 8FlUK3+SyZP4w0E2Ikzm5NAvq4z2Pb0PUP57oV2Jq9dSb8qTPRCj1aMKOab5oyLE3R
	 vqmS1NvMlOBjdsxps2pqyWFbbGKkKPi/FTwdig1V8Qt0EfpyG7TRRzd/vFRulzKchK
	 cWiC4fg7FAHQO/KPUgql5sfhobm2J0WkFVcvI36DChar9XxQ9FHaCU0I39g6H9DmKD
	 lJFRBW4xFRTakf/LJqbiYi9AU+FIqepYD7iJZH1J7k12HXezAsZZbCvOHnT1a/Midk
	 zMdfWWBQW+3Xg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7737A3811A72;
	Fri,  2 Oct 2026 20:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/12] net: bridge: vlan: optimize standard fdb
 fwding path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179097121302.3565478.15729563050864292363.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 20:00:13 +0000
References: <20260930071411.2786201-1-razor@blackwall.org>
In-Reply-To: <20260930071411.2786201-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Sep 2026 10:13:59 +0300 you wrote:
> Hi,
> This patch-set is a follow-up after the bridge flood fwding path
> optimizations and applies the same idea to the standard fdb fwding path.
> We are able to remove 2 vlan hash lookups in the standard fdb fwding
> path by caching the port-VLAN pointer in the fdb, to do that we switch the
> fdb dst to an opaque type that can be either a port pointer or vlan pointer
> differentiated by a bit. The field is a struct and also has a __private tag
> so we can catch direct users, it should be used only via the helpers.
> Sharing a field makes it easier to pass it around and also allows us to
> save struct space for the fast-path. Interesting case is when an fdb is
> promoted from a raw port to port-VLAN on the same port, it needs to be
> handled carefully so we use cmpxchg to make sure we don't generate
> deletion/replace notifications because it doesn't change the port.
> I tested VLAN deletion after these changes (we now wait a grace period for
> every delete) and the hit was ~20% reduction in deleted VLANs / sec
> deleting 4k VLANs took 14ms more and on my VM the VLANs deleted / sec went
> from 63k to 52k / sec. The complexity to batch them is not worth it.
> 
> [...]

Here is the summary with links:
  - [net-next,01/12] net: bridge: introduce a bridge destination type
    https://git.kernel.org/netdev/net-next/c/13bb47965e02
  - [net-next,02/12] net: bridge: use net_bridge_dst for fdb destinations
    https://git.kernel.org/netdev/net-next/c/fd7a8eb03c32
  - [net-next,03/12] net: bridge: add VLAN support to bridge destinations
    https://git.kernel.org/netdev/net-next/c/a39c339fd6c5
  - [net-next,04/12] net: bridge: vlan: return VLAN entries from ingress helpers
    https://git.kernel.org/netdev/net-next/c/cebd6130e6c2
  - [net-next,05/12] net: bridge: fdb: pass VLAN entries to learning updates
    https://git.kernel.org/netdev/net-next/c/8247ef76032b
  - [net-next,06/12] net: bridge: fdb: consolidate port-VLAN cleanup
    https://git.kernel.org/netdev/net-next/c/f0a349b92120
  - [net-next,07/12] net: bridge: vlan: split unpublishing from deletion
    https://git.kernel.org/netdev/net-next/c/e5c71bf91447
  - [net-next,08/12] net: bridge: vlan: quiesce readers before freeing port VLANs
    https://git.kernel.org/netdev/net-next/c/83edc87a9172
  - [net-next,09/12] net: bridge: fdb: factor out existing entry updates
    https://git.kernel.org/netdev/net-next/c/941056f91907
  - [net-next,10/12] net: bridge: fdb: cache port VLANs in learned entries
    https://git.kernel.org/netdev/net-next/c/8009eb405fc6
  - [net-next,11/12] net: bridge: fdb: cache VLAN destinations in configured entries
    https://git.kernel.org/netdev/net-next/c/8533e9b85bd2
  - [net-next,12/12] net: bridge: fdb: avoid VLAN lookups in unicast forwarding
    https://git.kernel.org/netdev/net-next/c/f1829618e0ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


