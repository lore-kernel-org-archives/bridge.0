Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB95416853
	for <bridge@lists.linux.dev>; Fri, 16 Oct 2026 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165910; cv=none; b=ABNSzqRA/bZMGZgPEGzg3FuCaGshxwznaZ/W8eLqNhp65YQSgn3G+YeIXeoxnoZzuueu0mb600n9rgYT4LonvqHUgYvHC58K64jheL+cBx/gOzUS4UbiRmLurzswux1U+6BUlBhWLrx6NqD876z332Q8qYqLC5yXRAA4UflHsPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165910; c=relaxed/simple;
	bh=dEV7hzEa6Vta9NCBnSztXL8acglcKteH4D2HOXHWrro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1YK0OiVKPwju9SU+Y2hrvrd+bCc0Qf7Fe55fMAypisZidktRFWq/Vet5+6sHpkqKCfz6mYdzao5RqyZi3fY0ErdyhEDGYv8pDTCVti9uM1Z7GnGMpQUCy6rNzJktCe7f/tuLaiYiVGguym3iKBhmbDY1rzxy34rLk730lpyti0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B02DE489FA;
	Fri, 16 Oct 2026 17:51:39 +0200 (CEST)
Date: Fri, 16 Oct 2026 17:51:38 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, edumazet@kernel.org, razor@blackwall.org, 
	horms@kernel.org, petrm@nvidia.com, yunlong_ma@buaa.edu.cn
Subject: Re: [PATCH net 0/2] bridge: mcast: Fix MDB exhaustion by rejected
 entries
Message-ID: <atJH5h69c6jAuXg5@luna.proxmox.com>
References: <20261016101407.2030133-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261016101407.2030133-1-idosch@nvidia.com>
User-Agent: NeoMutt/20260504
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1792165899147

On 16.10.2026 13:14, Ido Schimmel wrote:
> When the bridge fails to create a port group for a new MDB entry, the
> entry is left behind with no ports and is never deleted, but it is still
> counted towards mcast_hash_max. Since the introduction of
> mcast_max_groups, a host behind a port that reached its maximum can use
> this to exhaust the MDB and disable multicast snooping.
> 
> Patch #1 fixes the problem by deleting the entry upon failure.
> 
> Patch #2 adds a selftest.
> 
> Ido Schimmel (2):
>   bridge: mcast: Delete empty MDB entry when port group creation fails
>   selftests: forwarding: bridge_mdb_max: Add a test for rejected MDB
>     entries
> 
>  net/bridge/br_mdb.c                           |  16 +-
>  net/bridge/br_multicast.c                     |   9 ++
>  net/bridge/br_private.h                       |   1 +
>  .../net/forwarding/bridge_mdb_max.sh          | 138 ++++++++++++++++++
>  4 files changed, 161 insertions(+), 3 deletions(-)
> 
> -- 
> 2.56.0

Thanks,
Consider:

Tested-by: Gabriel Goller <g.goller@proxmox.com>
Reviewed-by: Gabriel Goller <g.goller@proxmox.com>

