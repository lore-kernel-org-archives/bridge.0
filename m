Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4FA3803F0
	for <bridge@lists.linux.dev>; Tue, 12 May 2026 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579136; cv=none; b=m/7Qo5M6h2BBTQJCrC6OjcFL+P+7r6T6Ob1fIKtWY8aE0HFcvCGAE76CUu5G8tktemedQ/eZuvGhOTMoR+MbOSsNJYdKxXkHkZBqGaboUsS/LIOq5TwKwI2DtppegBUjzn1xL94KkpFiTX/D3lRUN2yrigwBp77Dy9x+IXUehCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579136; c=relaxed/simple;
	bh=kB3FgQ1v4x2nNTOvP/co8m4IKeLd7kxFg6GkVhqpuFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyOYC6q++iEa5OTlEZJFdfzgBTtUInznrs3eVR/VW5DdfHx0YZmghCVSDbqkEMCJt6WyFWSuMnOukdPYUOfUF2gClmemulfKwEB1SFpsLVSJrjgcMw52y9WHTtX5dAGkVuBnb7Gz5xWsgopefD4QseXEHXB6xZdPs+mGuGaozd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 3E3B66092A; Tue, 12 May 2026 11:45:33 +0200 (CEST)
Date: Tue, 12 May 2026 11:45:30 +0200
From: Florian Westphal <fw@strlen.de>
To: Yuan Tan <yuantan098@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Ren Wei <n05ec@lzu.edu.cn>,
	bridge@lists.linux.dev, netdev@vger.kernel.org, idosch@nvidia.com,
	davem@davemloft.net, yifanwucs@gmail.com, tomapufckgml@gmail.com,
	bird@lzu.edu.cn, tonanli66@gmail.com
Subject: Re: [PATCH net 1/1] net: bridge: guard local finish against missing
 port
Message-ID: <agL2up-rblE9Y6yP@strlen.de>
References: <cover.1778504155.git.tonanli66@gmail.com>
 <ad183a40c4d906f39e03590b371fdcfdffb863c6.1778504155.git.tonanli66@gmail.com>
 <1bfd86a2-e7f8-42ef-8486-4d7fa91b2199@blackwall.org>
 <CAPuPA7JzZC1veoLtdmsGdqZ4xuy7Znu=z=+7FsyX0_iUQxcZAQ@mail.gmail.com>
 <c2bbd2ab-e4f9-4142-a3d4-531f3d5ce6d7@blackwall.org>
 <CAPuPA7+jMHLjpY-RWK6-EQqs-NjrGUmanuPVVTDZJv1yeRk1oA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPuPA7+jMHLjpY-RWK6-EQqs-NjrGUmanuPVVTDZJv1yeRk1oA@mail.gmail.com>

Yuan Tan <yuantan098@gmail.com> wrote:
> > >>> The bridge local receive path may be deferred by netfilter and resumed
> > >>> later. By the time br_handle_local_finish() runs, skb->dev may still be
> > >>> valid while its bridge port association has already been removed.
> > >>>
> > >>> br_handle_local_finish() unconditionally looks up the bridge port from
> > >>> skb->dev and dereferences it for source learning. If the port is no
> > >>> longer attached to the bridge, the lookup returns NULL and the deferred
> > >>> local receive path can no longer rely on the port state being present.
> > You should update the Fixes: tag but also wait 24h before re-posting another
> > patch version.
> 
> Ok we will send the v2 with fix tag f350a0a87374 after 24h

Would you mind exploring an alternative fix for this?

As nfnetlink_queue'd skbs leave rcu read locked section, great
care has to be taken on reinject.

Either bridge could call nf_queue_nf_hook_drop() on bridge
port removal, or nfqnl_reinject() could revalidate that skb->dev
is part of a bridge and munge verdict to NF_DROP in case
the assocication was removed while packet was out.

static bool nfqnl_bridge_port_removed(const struct nf_queue_entry *e)
{
	return e->state.pf == NFPROTO_BRIDGE &&
		!br_port_get_rcu(e->skb->dev) == NULL;
}

static void nfqnl_reinject(struct nf_queue_entry *entry, unsigned int verdict)
{
        const struct nf_ct_hook *ct_hook;

        if (verdict == NF_ACCEPT ||
            verdict == NF_REPEAT ||
            verdict == NF_STOP) {
                unsigned int ct_verdict = verdict;

		....

		if (nfqnl_bridge_port_removed(entry))
			verdict = NF_DROP;

Its more work, but it places the extra checks to where
they are really needed.

Also see related bug fix:  At this time, entire bridge device can go
away while packet is out.

https://patchwork.ozlabs.org/project/netfilter-devel/patch/ca7ee343bbcb44905e1f5b853df2f3a5b7d40548.1778493188.git.royenheart@gmail.com/
