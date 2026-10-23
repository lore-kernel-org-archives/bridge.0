Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.245.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792737983;
	b=H/BVJtZ9qEnuJBEVrXTTYLpeSO+qa6CPB+1GZcMoLaiIhuPMcYWyxvIwW9tr4I9P8ixK
	 8VV3fdgreFlFxImnH7AA7TdSOIOT4XbITiXNtCyVuwzVooyUeGE5hX5KTg7mHhpch6y0c
	 /+Aw7464Si5V1vOYccL+wCOwXSyWvswnF8AdqO9M5xAj/MKvZMAh605U7lpR0t0gwI+om
	 iD4vwb3p6DXAwm1S8K+/RHwkl7YdFYpSU3sYKXoP6R0at1aIZdSG3eaVj4ziGWhr/ZMUH
	 CdrweFY/HSBqXGbspO5Iw9ATbco+vt7rDK9qgjm/tc27oCHzTkCjNpKkjlIulYtd+qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792737983;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yzphMCulyey7A6Hpiwuov45a4ASuSSbO2ebDQb+xFGI=;
	b=pvAUIssBMLmchg6o0g2rnf9CYgSv2vnBsDaBPPuL6FU7t8fixRNkITYnPfgmpIN7UK5c
	 BiTFjn6i8TRYtmNctwBJQzxIvUsD8zW4/QSbRNlq6iTENf8jYm4OkckLlljOQ+omI4L6o
	 nYkTkkPmE8H0RbXbQjK2xOileOm5UTP+e9ky48foJyAVf7Q1isDZaN+WYQKMzz7NLIVe6
	 BSv1xKdd6+2Zwgaqf1lsOScbD1zDDU1Ya+R8PbY4GDD3P63ypwv3dNghiCNVt0Y3ZigKA
	 mxUJeaRJsYeF/h2P34CDikvaweXKQ+s+m5b5pjJISRIF4FAxmhldSA/bWqjMrRMDt7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=strlen.de;
	spf=pass smtp.mailfrom=strlen.de;
	arc=none smtp.remote-ip=91.216.245.30
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22193606A31D
	for <bridge@lists.linux.dev>; Fri, 23 Oct 2026 06:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22193606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 30A55600C1; Fri, 23 Oct 2026 08:46:19 +0200 (CEST)
Date: Fri, 23 Oct 2026 08:46:11 +0200
From: Florian Westphal <fw@strlen.de>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netfilter-devel@vger.kernel.org, bridge@lists.linux.dev,
	pablo@netfilter.org, phil@nwl.cc, razor@blackwall.org,
	idosch@nvidia.com, vega@nebusec.ai
Subject: Re: [PATCH nf 1/1] netfilter: ebtables: validate compat nentries
Message-ID: <atsCs5zS3x9wxBSN@strlen.de>
References: <cover.1792733039.git.zhilinz@nebusec.ai>
 <280a41badb424f8dc5fa22d03d6abf82025d539e.1792733039.git.zhilinz@nebusec.ai>
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
In-Reply-To: <280a41badb424f8dc5fa22d03d6abf82025d539e.1792733039.git.zhilinz@nebusec.ai>

Zhiling Zou <zhilinz@nebusec.ai> wrote:
> compat_do_replace() allocates per-CPU counters from the compat header's
> nentries before it parses the entries blob. A malformed request can claim
> millions of rules while supplying only a single empty chain, causing a
> large vmalloc() before the request is rejected by later validation.
> 
> Each rule occupies at least sizeof(struct ebt_entry) bytes in the input
> blob. Reject a rule count that cannot fit in entries_size before the
> compat path allocates counters.

Looks like a nothingburger.  User could also supply a larger blob?

Also: CONFIG_COMPAT should no longer be reachable from userns:
ec1806a730a1 ("netfilter: x_tables: disable 32bit compat interface in user namespaces")

@Pablo: if you prefer to take this, no objections from my side;
it doesn't look wrong.
