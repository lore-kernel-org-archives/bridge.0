Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DB716DEB1;
	Sat,  7 Feb 2026 04:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770440167; cv=none; b=PrfCceqe7b48TWDcErM6J7YwNOYTMicVf7yRsbCnZhmCP2mNhddplsuXKLc53Qe9T/NjWZHN5QBDeBYGaASaTt3vQFrZ4GL4KGNOIvb+5j1mDs5mmr23QPuUbmYXJ9iFiG0OhonVdudEXyGKqr1NYG0Xtb0Ye8z6O/sKXpcvnlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770440167; c=relaxed/simple;
	bh=fw8tm7giaf+PqSVkT33wfK+ZLunkZypw1ssGwZMhero=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfrZpvyo8UWYXzLD1Jqg9i6dZ5QGCPv87ptW8zmlpNEsRGmqe7udmMcl477/A4Z+lz94OaMkK8GNgKvMZfRPEp53tOFGTf/eZB183JSPhdHlaArLtpSDh1Q5TLg0uglGJTbM/h3+FvnZ1zpDD3ZG7/do2ahX5edjNqXVEXTr4Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqwQs/LN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqwQs/LN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568E4C116D0;
	Sat,  7 Feb 2026 04:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770440167;
	bh=fw8tm7giaf+PqSVkT33wfK+ZLunkZypw1ssGwZMhero=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SqwQs/LNr9mYaAINxHryqWj9+Z08cb0nKya+n9zrpkv6Frx0P3b8fOsIEU63pLacN
	 o36U4XSG+VQ0GVUWt0FzyAqYALGd5SFks8k/vS6n7nzYNUvw9x7wiXMbLGJJcAQIOb
	 uM8VuoCCjGpXt956SRZ8zYVfhMKmZrSNtnR06wAWDW5sXlIm7nqEdwgB9kpcv+k3wV
	 pKd+cY3XFR8F0ORNyoYE9n1so2/LuiFPCpJh45qmAW26GGg8SY/2badkTzCDbL0lDb
	 0Eo0hqlIqZN9gr9OUPgI5o/1TuLDjZ7R9X5dsJvMnjP0bOq8U/5cJemi0VOeWhP/gN
	 VvdiSwP8Eyhkg==
From: Jakub Kicinski <kuba@kernel.org>
To: linus.luessing@c0d3.blue
Cc: Jakub Kicinski <kuba@kernel.org>,
	razor@blackwall.org,
	kuniyu@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	idosch@nvidia.com,
	sdf@fomichev.me,
	shaw.leon@gmail.com,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	horms@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,v2,05/14] net: bridge: mcast: track active state, foreign IGMP/MLD querier disappearance
Date: Fri,  6 Feb 2026 20:56:05 -0800
Message-ID: <20260207045605.4164706-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206030123.5430-6-linus.luessing@c0d3.blue>
References: <20260206030123.5430-6-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: bridge: mcast: track active state, foreign IGMP/MLD querier disappearance

This change ensures that the new multicast active state variable is unset
again after a foreign IGMP/MLD querier has disappeared (default: 255
seconds). If no new, other IGMP/MLD querier took over then we can't
reliably receive IGMP/MLD reports anymore and in turn can't ensure the
completeness of our MDB anymore either.

> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index d5c623dce7eb..0fc29875db9c 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1826,6 +1826,10 @@ static void br_multicast_querier_expired(struct net_bridge_mcast *brmctx,
>  	br_multicast_start_querier(brmctx, query);
>
>  out:
> +	/* another IGMP/MLD querier disappeared, set multicast state to inactive
> +	 * if our own querier is disabled, too
> +	 */
> +	br_multicast_update_active(brmctx);
>  	spin_unlock(&brmctx->br->multicast_lock);
>  }

This isn't a bug, but I noticed a couple of unaddressed review comments
from Ido Schimmel's feedback on v1 back in May 2025 that don't appear to
have been incorporated into this v2 series.

In __br_multicast_querier_exists() in net/bridge/br_private.h around line
1164, the 'is_ipv6' bool parameter is marked const. Since this is a
pass-by-value parameter, the const qualifier doesn't provide any benefit.
Should it be removed?

Reference: https://lore.kernel.org/all/aDNPxdmDPYwasUEM@shredder/

Also in br_multicast_querier_exists() in net/bridge/br_private.h around
line 1182, the function takes a struct ethhdr *eth parameter but only uses
eth->h_proto. Would it make more sense to either make the 'eth' parameter
const, or just pass the EtherType (__be16) directly instead of the entire
struct pointer?

Reference: https://lore.kernel.org/all/aDNPxdmDPYwasUEM@shredder/
