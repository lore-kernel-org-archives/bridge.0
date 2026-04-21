Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683D319D89E;
	Tue, 21 Apr 2026 11:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776772286; cv=none; b=P+cte7Xs6GH8i9wDlDtm2L6TrYrikK26nZ1th6F/82n+9HfhqTRNgyw9nnUAFRivGuWezfjpPK0jmbPtVDMTW8jTk2VhsYZxTts0e0dSQFxGTOajy1QeC68L2tNJJSNTQk1PQYwuJyUEInfofmyFkLVG4ibVzGDrXXY8Wcq8Fmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776772286; c=relaxed/simple;
	bh=nO2HrpFcOfLbYEAEtqzGYNCRQRtbaOzBL2FTmFlYSJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHo0OKgKVYA6k8b126Sm5Rtfrb8LOcI5qfstWhCxMZrFkEsSVoPV7Tj9/9tgL9ov/Pieyktge03Zd1Vy00eY7GByTn1NWzO/AmfTX205TMsWJ7QijGgdnpEewO4wM+Ubur5ZHhah6CcpVzfQLix8YDsulTIZAFTa6dEQytSmpMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=cb0uNtWu; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="cb0uNtWu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=OwjntzVNeDypYl+gb8gCC9m3YpwtU8u86yLeBxwqWjE=; 
	b=cb0uNtWuFWwCwtmeaDWAtvbkC3Y8S6XHqngK5Wla5CxIYXescDcvY0ZvESkjzs7A7+GGcSLzH1H
	aWkhry4AoKM/X34MbmXMSHJ8Jk5FJoJFRuz4aSSt3EHCuRn4km27h2yChnahNdoNEFROqX7IAyxH3
	/xS6JeQ6icnUP8PU3MGN5/2+Ht5vSSPmwSmMQFkpuTMrXo7vy9IEmNeZaMb0tQ0bPTcBc6Iqk1jzI
	9ofZNvzOr2qUKNoSsJObv4qmR8V8vXWaw9/Tzb7VitfQ1s6LO48RCOr5r397r2maHXmbic/hx0MFw
	QxqwwuA3NfDRVgGHR6H7wBEsAfpjnmVjwiKw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wF9c7-007h5o-3C;
	Tue, 21 Apr 2026 19:50:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 21 Apr 2026 19:49:59 +0800
Date: Tue, 21 Apr 2026 19:49:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org, linux@armlinux.org.uk,
	tsbogend@alpha.franken.de, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, chleroy@kernel.org, 3chas3@gmail.com,
	razor@blackwall.org, idosch@nvidia.com, jani.nikula@intel.com,
	mchehab+huawei@kernel.org, tytso@mit.edu, geert@linux-m68k.org,
	ebiggers@kernel.org, johannes.berg@intel.com,
	jonathan.cameron@huawei.com, kees@kernel.org, kuniyu@google.com,
	fourier.thomas@gmail.com, andriy.shevchenko@intel.com,
	rdunlap@infradead.org, akpm@linux-foundation.org,
	linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bridge@lists.linux.dev
Subject: Re: [PATCH net-deletions] net: remove unused ATM protocols and
 legacy ATM device drivers
Message-ID: <aedkZ5bizasuBPI8@gondor.apana.org.au>
References: <20260421021943.1295109-1-kuba@kernel.org>
 <c7506c225ce22a71c03abc2673823cf84bbb5b0d.camel@infradead.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7506c225ce22a71c03abc2673823cf84bbb5b0d.camel@infradead.org>

On Tue, Apr 21, 2026 at 10:26:18AM +0100, David Woodhouse wrote:
>
> I suspect they don't have a huge amount of interest in the Solos any
> more, or the Geode-based SBC they sold with two of them on-board. But
> OpenWrt does still support them, and I even have one here (although no
> ADSL line to test it with). They were briefly popular as fully Linux-
> supported ADSL routers.

ADSL is history, it only ever made sense in rich countries where
physical copper cables were pre-installed in homes.  While rich
countries have moved to fibre, the rest of the world won't use
ADSL either because there is no copper cable to begin with.  So
it's actually cheaper to just lay a fibre cable for a new install.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
