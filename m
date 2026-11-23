Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.245.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424309;
	b=iCiHtx+cB01Qo5Nthb8Y04NY0c7yqLvqxgtlZOUFshRCnhHQcL/8AJ7X1vtETaBrz67c
	 VBr1Mjz5BgxLN05jT+iMwAtlatXjS6T1OPPiv1kHkr/XSJiWp7eaxf9iXLefGkEpGFVib
	 Ppp0tecraL55jwZvtXStQvXROtWoDdX6lt/e6hbtXzylYVqS+xMyoPhff/ZUvw+oeDDTo
	 ACMU1MMNJJ3x5E/gI3pZVGuRT/CB7NmPTuH6batpTIQI7NoXF+t91DZkXpcFFsGoEWlja
	 ZMWCdXR6WXVLj4XOe6PbNrmI3pqbg2Jrd/5t3DIOyS7njQG85OlA3utygG8elAWLHpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424309;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vbKrmB77tnLk732CDqH5TeR0U0lScrnOuHU1O7c9bH4=;
	b=yea9ensuPZCdYzpjFusk/a5EYZoSv79BSNkGuX5ckr4laK1zYwxXxLFkxukYH/BdNMrW
	 xX3ncnpCUoaZCF3GCRz2h4KkIQJPfxo4iNoKSWo61XrVzE97jFrYJWCp+VD+O3uafwPia
	 tFN2bahl4pMn9wwv3kiEh2xyJQ83iZW7Z3c/LDXgwcJwDwBjsFqoPu+nbImrrubMVADCt
	 //GnL+k/po7iXRYN0S929KKnzg3Yx6McsnPHOiFZ2eCQJuDpdf1JHpPn2qFYIygvrtf08
	 hzsj4OEtXE6QGb5Ac7gImjNrqzOujjNC7sTxfeacELGWUBSgAZ+X2OznAhkWC5E6Vyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=strlen.de;
	spf=pass smtp.mailfrom=strlen.de;
	arc=none smtp.remote-ip=91.216.245.30
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A0E606A31E
	for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 08:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00A0E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 57AC160858; Mon, 23 Nov 2026 09:58:19 +0100 (CET)
Date: Mon, 23 Nov 2026 09:58:19 +0100
From: Florian Westphal <fw@strlen.de>
To: Ren Wei <weir@nebusec.ai>
Cc: netfilter-devel@vger.kernel.org, bridge@lists.linux.dev,
	pablo@netfilter.org, phil@nwl.cc, razor@blackwall.org,
	idosch@nvidia.com, davem@davemloft.net, vega@nebusec.ai,
	sashiko-bot@kernel.org, rakukuip@gmail.com
Subject: Re: [PATCH nf 1/1] netfilter: bridge: detach conntrack template on
 invalid IP frames
Message-ID: <awQAKzVc0--XeUiK@strlen.de>
References: <cover.1795348417.git.rakukuip@gmail.com>
 <b2d3ea42b2d8d4d9c97452a123dd5f6c3cded1c4.1795348417.git.rakukuip@gmail.com>
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
In-Reply-To: <b2d3ea42b2d8d4d9c97452a123dd5f6c3cded1c4.1795348417.git.rakukuip@gmail.com>

Ren Wei <weir@nebusec.ai> wrote:
> A bridge rule such as nftables `ct zone set` can attach a conntrack
> template with IP_CT_NEW to an skb before nf_ct_bridge_pre() runs. When
> a frame has an ETH_P_IP or ETH_P_IPV6 protocol, nf_ct_bridge_pre()
> performs header pull, length trimming, and nf_ct_br_ip_check() /
> nf_ct_br_ipv6_check() validation before invoking defragmentation and
> nf_conntrack_in().

Acked-by: Florian Westphal <fw@strlen.de>
