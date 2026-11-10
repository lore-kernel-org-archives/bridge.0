Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.190.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271456;
	b=zjYp57xwEaLY5bUQ/dIvgaciJdN6yCczYyl/GG86vj8Txhn15uVtMnIx8DhAy1ViN+fu
	 heOr99N5Sag1FiKepz3oV17W30ictLCIn2UmkhV+rL1JHNgOByvQzwM7BHEq48AaJJ2gq
	 gvROeWLCtHFMzViEvHzdVRLjU0nKLH668I09CBHAYPt4ixIF+6JPM80of1oXRWbgSkBV7
	 AwHzZrZS3/4AUlpPMZNLCSD39nGgmbQa/65BkgD++DKJ4Jt8SnLuVL4QhOFZyv+5DvaKA
	 zHmRdF9QoGKiJH1UxCkERyNAzEqaea7264+vIDgmCe2q++9OnBq13LB2vgKGx6AcKiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271456;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=X7vRBwY1YVP+YsmylbzJovNrvWSg1Yr0Awx7ynFxjKQ=;
	b=zJAekXdTMDnCNaSqMHQxewR0Epj+ZTLBLNkOgH2oXruoNfOD8VDxd5w/DGfik8SopueJ
	 2L4fWJShC1eo3LKISc7cQhf9y1sdtep912p4ttL64VdYuC+baakBYwEGIlBI3Rbu6Uwsp
	 /uhkDNdj9NwDaBJwauo+m5VylYTuiIfjvhlIFu6lRvS3OA4PNZudTn3lZr3W5lqppGDNG
	 HfwC2AWX+sCg9LPbviT7lAvAkNfcG41jVW7eTepJBhWP1pPq+oMLhNRqI7HtLTkHIVbUL
	 r1qpnzvEOWxtf2YCXqZJcvb/uFXdEucH5bT3Jurvsbw5rywqTIY2yQsf4YOaHtpEr8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=netfilter.org;
	spf=pass smtp.mailfrom=netfilter.org;
	dkim=pass header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b=fYwpeXq7;
	arc=none smtp.remote-ip=217.70.190.124
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 61DFE606A326
	for <bridge@lists.linux.dev>; Tue, 10 Nov 2026 00:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61DFE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b=fYwpeXq7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1794271452;
	bh=X7vRBwY1YVP+YsmylbzJovNrvWSg1Yr0Awx7ynFxjKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fYwpeXq7MHbhkmAE9/6mASGiHNWLPD/BBzKdUdgs9L3DoLl0WjwoHaZbj8eAEaHLm
	 XsnyBydw8vrqKuBZhsw1PDe/bHSEx3TBEMpsTidQNOhVokFfsaXflQLcadPGkLPN8y
	 PtJIw9HfU9XFf+T6dUYT+Q/zBTB0nhXPoUVOOBcx63KN7qn2w2gVr34KYdFgiyP0b6
	 gYaTDBwjSVSQqUFRFyQk7yIiLfo9yQu+K5v8jK5luV+UWOn3uu6vnXkswbTy3mmmX2
	 wW39nDuHHBrmFT/rpD6yI6gcAwrqbH1mP3Pg3K7nk+EX2DL6HoiDg+eqmZRpQCzlEd
	 VVqcpw5wSQ5gw==
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id A9F3A60058;
	Tue, 10 Nov 2026 01:44:12 +0100 (CET)
Date: Tue, 10 Nov 2026 01:44:10 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Laveesh Bansal <laveeshb@laveeshbansal.com>
Cc: Florian Westphal <fw@strlen.de>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	syzbot+a8ba738fe2db6b4bb27f@syzkaller.appspotmail.com,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH nf-next 0/2] netfilter: bridge: refragment packets with a
 vlan tag moved by the bridge
Message-ID: <avJo2nhgnulY776l@chamomile>
References: <20261109191842.57359-1-laveeshb@laveeshbansal.com>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261109191842.57359-1-laveeshb@laveeshbansal.com>

Hi,

On Mon, Nov 09, 2026 at 11:18:40AM -0800, Laveesh Bansal wrote:
> Fragmented packets are dropped on a vlan filtering bridge with bridge
> conntrack when the protocol of their vlan tag differs from the bridge's
> vlan_protocol, an 802.1Q tag on an 802.1ad bridge for instance. Patch 1
> handles the tag when refragmenting. Patch 2 adds a selftest.
> 
> As discussed with Pablo in the first posting
> (https://lore.kernel.org/r/atck-NoWvemxIsF6@chamomile), the
> DEBUG_NET_WARN_ON_ONCE() change went to nf on its own and is now in the net
> tree as 683ff28ab18a. This series is based on that commit and is meant
> for nf-next, which does not have it yet.
> 
> Changes since the first posting
> (https://lore.kernel.org/r/20261020000308.37362-1-laveeshb@laveeshbansal.com):
> patch 1 keeps the tag together with the ethernet header instead of in
> separate fields, and the selftest runs its checks even if the kernel had
> warned before.
> 
> I used an LLM tool for the analysis, the code and the test runs.

Do you have a usecase for this?

> I tested the series on arm64 and x86_64, with and without KASAN, lockdep
> and kmemleak. The selftest fails without patch 1.
> 
> Laveesh Bansal (2):
>   netfilter: bridge: refragment packets with a vlan tag moved by the
>     bridge
>   selftests: netfilter: add bridge conntrack test for vlan protocol
>     mismatch
> 
>  include/linux/netfilter_bridge.h              |   4 +-
>  net/bridge/netfilter/nf_conntrack_bridge.c    |  46 +++-
>  .../testing/selftests/net/netfilter/Makefile  |   1 +
>  .../net/netfilter/bridge_ct_vlan_proto.sh     | 198 ++++++++++++++++++
>  tools/testing/selftests/net/netfilter/config  |   1 +
>  5 files changed, 241 insertions(+), 9 deletions(-)
>  create mode 100755 tools/testing/selftests/net/netfilter/bridge_ct_vlan_proto.sh
> 
> 
> base-commit: 683ff28ab18accb25268741a724645eee839d41a
> -- 
> 2.43.0
> 
