Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.245.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053442;
	b=vGWSTbOPgXLHp65ETseipEYaAF95RdIfHAsZSFjNX9DPcUgjZm92tzw7Zj26QX87IQcp
	 x2cVBxJKkvY/riI2fT82Mkv6xyPlNiv4g3+m27jfeNIX39lyvvrcd/j8wW0zjS+RzJIAj
	 Wr9KqQETXDvA8Vcppy8r+1Gl18fZ5jpkbVAsshFgaI+PNjnpTnEpmLTgxpYnCI0cJolKL
	 pl04iQzjVNwcozce1ihBxd6Pe3UNAapWBHIaMyWFWxlUZm1dSC+04apvOfJ77TQcd3ZKZ
	 g7KJLLaVIsEV2eUIxoiN1BSI0MrX1JHNHTeF9k2B0WMTsv6DdWEJpIYNJdBmd8xBkXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053442;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KEXVO5kUBVeSoqXVafost9ROdZlSxVie7Qj95Ex11JM=;
	b=JzJBJswi7sLv18JEeZCRXvc23HBmpHzT+z1dxJCXBou3XEkSLD0DlZ6vN+ney9ZJ4Zbb
	 doiU2JJ5YBUciIjv8YI5kdykWng7HwudTOi2oRZpfYf94w6A2RJTK6METUe6UD+skZUeW
	 jzOFvQcaQHbRWyB78kjtQ1bPQvx6lPQTMPJ6Vf4EL80q2it/B+uUvqNByKc0shLukcoKK
	 yEXD0hkPHEy0D8Sp3yoLLTFQMGoM8+vzxVHF1LzJfEbKXp8Txo0QA4vu4gi9L7Pbs6fLT
	 jeuuwmfblRTSSYt2XdM5ILK2jwsqenNt+1SnNIynXugGSHljLaWKnXtDm7MklMLH4wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=strlen.de;
	spf=pass smtp.mailfrom=strlen.de;
	arc=none smtp.remote-ip=91.216.245.30
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8513D606A32C
	for <bridge@lists.linux.dev>; Sat,  7 Nov 2026 12:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8513D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id C7463609FC; Sat, 07 Nov 2026 13:10:38 +0100 (CET)
Date: Sat, 7 Nov 2026 13:10:35 +0100
From: Florian Westphal <fw@strlen.de>
To: Kyle Zeng <kylebot@openai.com>
Cc: netfilter-devel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>, coreteam@netfilter.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, outbounddisclosures@openai.com
Subject: Re: [PATCH] netfilter: br_netfilter: reject unsafe neighbour devices
 for DNAT
Message-ID: <au8VOwNYrLAB7G7t@strlen.de>
References: <20261030042155.73844-1-kylebot@openai.com>
 <au7SdYQrIqAQOU24@strlen.de>
 <au79avuyDAz__s4t@com-75606>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <au79avuyDAz__s4t@com-75606>

Kyle Zeng <kylebot@openai.com> wrote:
> On Sat, Nov 07, 2026 at 08:25:41AM +0100, Florian Westphal wrote:
> > > +			struct net_device *dev = neigh->dev;
> > > +
> > > +			/* The neighbour queue must keep skb->dev alive. A VLAN
> > > +			 * device also holds a reference to its real device.
> > > +			 */
> > > +			if (is_vlan_dev(dev))
> > > +				dev = vlan_dev_real_dev(dev);
> > > +			if (dev != skb->dev) {
> > > +				neigh_release(neigh);
> > > +				goto free_skb;
> > > +			}
> > > +
[..]
> 
> The VLAN check is intended to preserve existing VLAN DNAT behavior.
> 
> bridge-nf-filter-vlan-tagged=1, bridge-nf-pass-vlan-input-dev=1, and br0.100, the earlier test can pass with
> dst->dev == dev == br0.100. The continuation then changes skb->dev to br0, so the strict comparison would
> drop that valid packet.

Then please consider sending a v2 that explains this.

/* The neighbour queue must keep skb->dev alive. dst->dev is either
 * the bridge or a vlan on top of bridge
 * (bridge-nf-pass-vlan-input-dev=1).
 */

might just be enough.  Thanks.

