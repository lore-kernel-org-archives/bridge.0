Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E194477F1
	for <bridge@lists.linux.dev>; Thu, 27 Aug 2026 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787840987; cv=none; b=HaLGRk7FIgYOKppIQKDwnYkyq8/oPBQ9yN+mENZhJUUpZXnV+C0vM7NEpgx3gUuHd4tx61f9TFpBfHF8+ZW48pbhYsPqGDC27llXDT40BP7rJ5l3pPgXcUAKILKkYhzAfdLSO081FpccTYIwukryH6CfdRXg/tTSnoLRkFaD5zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787840987; c=relaxed/simple;
	bh=nVlbatA/iH85BPi6NincgPUw3sFNqvX+MmZ1HYgQNmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phUm+CflMx63XsYBWNGCdTLSUBCMZq/XA3ahFpaxLkZcmJPz+wpWNH6VZAgIHu47PX6S01KXhE4R7livJJ/dcCbjSLgus+v91ecPk+TDzAjV95aCOXO8gMJ3KLsizdHZLrSUQX18TVkYNJOJPt3w4bwA7fX4PuK0ddRda8hkxzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id A57F560260; Thu, 27 Aug 2026 16:29:36 +0200 (CEST)
Date: Thu, 27 Aug 2026 16:29:28 +0200
From: Florian Westphal <fw@strlen.de>
To: netfilter-devel@vger.kernel.org
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>, Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] net/bridge: out-of-bounds in br_forward()
Message-ID: <apBJyKJ7zs4kUmpd@strlen.de>
References: <fai12uKS5302YnCQV4E3zlDqcsAS5aGcMutS@bugs.sh>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fai12uKS5302YnCQV4E3zlDqcsAS5aGcMutS@bugs.sh>

co <co+63bad23bb3b4cd85@bugs.sh> wrote:
> We found a bug reachable in:
> 
>     path    net/bridge/netfilter
>     crash   out-of-bounds in br_forward()
>     commit  7b5344954050 ("Merge tag 'nf-26-08-10' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf")

I'm looking into these reports, I think this is the same
underlying bug as the other report; a variant of

ccb9fd4b8753 ("netfilter: revalidate bridge ports")

That bug uses nfnetlink_queue for RCU escape, the other two reports
use defrag engine.

And sure, its br_netfilter again -- I think we will have to consider
removing it even though it will break existing setups.

As a compromise, I suggest to reject br_netfilter in user namespaces,
i.e. call_iptables cannot be enabled anymore unless you have
CAP_NET_ADMIN in init net.
