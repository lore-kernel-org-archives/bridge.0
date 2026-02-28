Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD02C175A86;
	Sat, 28 Feb 2026 20:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772310658; cv=none; b=igD+Wq89fQB8pNDkt5w+HDmkKJA5+uOLdQjX6oPf5GOf5t7t2kDhHMqgZqCk1rvnsC34LrC0yW5O+7vfpGmw2/I5PQpX1hQUfcLlV57p7A4UoIXsKza6i7KMCf1WIfT5+8p1jG4hiewBdzwJ5pwFVG4ybV2gnfuB6FXkz79kFa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772310658; c=relaxed/simple;
	bh=5osuwdeoFbtAVKtAuWPRvfoorRhWrOkgKlCC1JCHjX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbuE/hEmxWEcHB0hhiPUTmnltRMnMHXpUIYQjaIKwWB1qqC8UmpOfPnfUhg6pst1LrgQQcTdty4lPygSuGo54aBt9U4wVEmCztSXSHUIQew2Bzemt9H242089qZOvbr+eU95JFL1gOOiE8aUgsxnFYz3k5Y+uCJUUwRsq40aSbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukdzHTEO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukdzHTEO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEAEC116D0;
	Sat, 28 Feb 2026 20:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772310658;
	bh=5osuwdeoFbtAVKtAuWPRvfoorRhWrOkgKlCC1JCHjX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ukdzHTEO9sKeX64F965atQW/VYBfheZwuA/3E7Uj4JGWjCKt8pCAWXe+VgfntwdYK
	 TQsvsprRjBAItAb/WcHOTodq5M3gOpllVFQcJAgwmTjSBi+5HnhDmIeCFTIGioA0no
	 j1heXxnJCW8D+uXX7va59C+2WR9NTGf1h9LtQlrFTxEfE3daRtgPc/c4jN84gqerXw
	 4zj6gp5Cno8vuNkmXelrL74R4x/+G9lXWFjw52VV+gx+8u00qF8AMZeMvLStESzE1w
	 XmfryvVoKxggOAVL7HGhrLl7lRRno/gWlNkm4UCbCy8ee6RCxo+IfQrmBJEJewae+E
	 Xe/Fu4EhxHlqg==
Date: Sat, 28 Feb 2026 12:30:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
 roopa@cumulusnetworks.com, horms@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, idosch@nvidia.com,
 razor@blackwall.org
Subject: Re: [PATCH net] net: bridge: fix nd_tbl NULL dereference when IPv6
 is disabled
Message-ID: <20260228123057.14050980@kernel.org>
In-Reply-To: <20260226234059.19402-1-fmancera@suse.de>
References: <20260226234059.19402-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Feb 2026 00:40:59 +0100 Fernando Fernandez Mancera wrote:
> Fix this by adding a check before br_is_local_ip6() or neigh_lookup()
> call. If ipv6_stub->nd_tbl is NULL, return immediately.

The problem should probably be fixed by replacing IS_ENABLED(IPV6) in
the callers with ipv6_mod_enabled(), rather than randomly sprinkling
null checks?

> Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
> Closes: https://lore.kernel.org/netdev/CAHXs0ORzd62QOG-Fttqa2Cx_A_VFp=utE2H2VTX5nqfgs7LDxQ@mail.gmail.com/

I think we should also have a Reported-by: in this case?
-- 
pw-bot: cr
