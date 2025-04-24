Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2311FDA82
	for <bridge@lists.linux.dev>; Thu, 24 Apr 2025 21:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745529960; cv=none; b=oP8qPgbAVHxfgqVT0MmBtqUwIvktS1MNrdoXlJc1cOHO6BBba8pC2rJhC/J6n8sE8hcylKU4OywgdE+VKEXT3qCWUHpfi4XhMpm3B0JOC0OJHkQ0WDpvvl+GMPNe9PV0GgWRniAu7IWSgip7GI9m513StPThHuoirBkbDKxBjPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745529960; c=relaxed/simple;
	bh=b/0+yurGv1ACW+6C36BhVgC/X61hgTJAj/RwtvOObx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXW6r9lLwGWoniqR8q/GSN3ezqDb4gsYIo+kXOm9oneNZn2Y6ImFKCQtglALP2OLcoOeNS7w0ok2Qd2pp59Zgs0BS3wqzZZvvu0LTVwAKKFsuuLYykEPWpUu7SR8G/B2JXfYcKWhESJlCp/eCcSu2ze/nBnk3nfc8Ql5wa2bBMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=vvDrmGub; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=gEBZPTRC; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="vvDrmGub";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="gEBZPTRC"
Received: by mail.netfilter.org (Postfix, from userid 109)
	id 86FE260630; Thu, 24 Apr 2025 23:25:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1745529957;
	bh=3AKJ0o15XjVsSUO1ySJBAwGn/VtjV0+jASv1w9bnHUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vvDrmGub+Rrn1dm82HyfP6QDVzlu6X/YS9XFSVnc9FFrtm9GX7u8IlQBTSnoMaFqG
	 39l6LR0JdWUpNTpsyq8FmnyV8QdspPwBzbrQCEZ7CKx2NM+pDe/S54vnjX4KZEmGvX
	 ugkZeiPAP/4wRo8uPglGot9u7jgAj+ecKfaX1GO1jMc6vpgkT7+0Nfgcqg4sKYZGBA
	 dx+H9V9Uq+J89b/whott10l1mBn71cKaly6Z0BehrHUC6Q3Qg2wBL8IQgLAmkErUhv
	 gU3CxPlt32GCzaWG+uyJFqIwyLymOtX5YgsaR+9k1Ecz7bJs0J6i/JhbccS2fgnzfP
	 KbmMZNR8vujuQ==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id C06AE60581;
	Thu, 24 Apr 2025 23:25:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1745529954;
	bh=3AKJ0o15XjVsSUO1ySJBAwGn/VtjV0+jASv1w9bnHUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gEBZPTRCX50VNlbMKODscp4KGeLWCZOcEzk6ZljEDACdCT/Rr5W1t+53eO7WMLPpx
	 020I2H9/hzYcLTtS23bFAZj0LMtD2X/zIdtWE+Emv1nWFhxuX5INAJDQaluZw9YpYl
	 VZVki8gklpabUg7C7Su9/XNE8tftNvT0YV54RNUKbjipdc/OeX8NsbcCcnvREFkUnT
	 9188YTV4DfL4yiJXu9jZSDddrLAWkTOshdTRXuxi1pTYl3WToCWHlR0iqIfeNdjPOh
	 TTDPd/bmv7Ymv1Vk0SLTFY9fcYlMtAuiaou2ncHIT4h5HeHa0qMYgPo9GCCC4JuNLf
	 XYPSjEHxDaHEA==
Date: Thu, 24 Apr 2025 23:25:52 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: Huajian Yang <huajianyang@asrmicro.com>, kadlec@netfilter.org,
	razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: Move specific fragmented packet to slow_path
 instead of dropping it
Message-ID: <aAqsYBIlbhdtnblW@calendula>
References: <20250417092953.8275-1-huajianyang@asrmicro.com>
 <aAEMPbbOGZDRygwr@strlen.de>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aAEMPbbOGZDRygwr@strlen.de>

On Thu, Apr 17, 2025 at 04:12:13PM +0200, Florian Westphal wrote:
> Huajian Yang <huajianyang@asrmicro.com> wrote:
> > The config NF_CONNTRACK_BRIDGE will change the bridge forwarding for
> > fragmented packets.
> > 
> > The original bridge does not know that it is a fragmented packet and
> > forwards it directly, after NF_CONNTRACK_BRIDGE is enabled, function
> > nf_br_ip_fragment and br_ip6_fragment will check the headroom.
> > 
> > In original br_forward, insufficient headroom of skb may indeed exist,
> > but there's still a way to save the skb in the device driver after
> > dev_queue_xmit.So droping the skb will change the original bridge
> > forwarding in some cases.
> 
> Fixes: 3c171f496ef5 ("netfilter: bridge: add connection tracking system")
> Reviewed-by: Florian Westphal <fw@strlen.de>
> 
> This should probably be routed via Pablo.
> 
> Pablo, feel free to route this via nf-next if you think its not an
> urgent fix, its been like this since bridge conntrack was added.

Thanks, I will include this in the nf-next batch.
