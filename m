Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D3B2868A9;
	Thu, 23 Apr 2026 19:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776972150; cv=none; b=rrE6hAc2ivPJYSKoI3m567YBc1NPIo+NJap5vG5walfAHHKMX86YgDm12I7ZVG3epeXWmcgoxTewyn7OfTFjf18n8AROh35vZD/Oc/GCzcj1a8PWHJhKe2PGQrsUTKqHBRtWBYIKQbOWH1IxN4fprrDqWAOznPWxu4z6jAShqbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776972150; c=relaxed/simple;
	bh=j0GPDBAm0I4zxAqI6YWcxfV5/1mdBezPe3eBd3FNm2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gi2VG95TxdZN+le7YqM7tYvPT78+W4vWqgXTq48vI0WSBZOcqj3taclrqA+ZSGYQo5IsB1yCcdew26XfH1NUy/5l6hPuynW3omuxXjQcJhSDfmlL5X3sPtWSwWo9zYkdrWDfXjqjjHTWkzyHaAKjJ0fYwJTfQwiMmcsgK++kqx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkcJgQ3H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkcJgQ3H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F940C2BCAF;
	Thu, 23 Apr 2026 19:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776972150;
	bh=j0GPDBAm0I4zxAqI6YWcxfV5/1mdBezPe3eBd3FNm2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jkcJgQ3HiRK14i/gFeArWLm8dfXNLDyZb/CpBpi/bg2TjV1D156Iw7VojatmxrCTw
	 Uk4tMSO0ptQJ3yEQ0ywEKSb1noOxH3OwK1MnLTfCM/vq9XfmghTzfaPgRrnppZ1Xgc
	 kFGzSEE8ml9Lbt3IukhfRveZZvqCqsyklMKvJD9kYlTLUyI39eU5IDbvCjRrrN4D+e
	 q1PAjGln/6wuqEz86fqtMAJMuyI2Y/8d/SXUWnZV3HJ0AWUZwmmzs7/C/dV6JI9dze
	 fRINV2aLL+GLGFZ48Gg+iryNpEsCaDM6wS6VAlLzaTOEQrnL0UAwaNb1jnF63pRK1a
	 pr6UfVB7Bhukg==
Date: Thu, 23 Apr 2026 12:22:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, linux@armlinux.org.uk,
 tsbogend@alpha.franken.de, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, 3chas3@gmail.com,
 razor@blackwall.org, idosch@nvidia.com, jani.nikula@intel.com,
 mchehab+huawei@kernel.org, tytso@mit.edu, herbert@gondor.apana.org.au,
 geert@linux-m68k.org, ebiggers@kernel.org, johannes.berg@intel.com,
 jonathan.cameron@huawei.com, kees@kernel.org, kuniyu@google.com,
 fourier.thomas@gmail.com, rdunlap@infradead.org, akpm@linux-foundation.org,
 linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bridge@lists.linux.dev, dwmw2@infradead.org
Subject: Re: [PATCH net-deletions v2] net: remove unused ATM protocols and
 legacy ATM device drivers
Message-ID: <20260423122227.1454f68c@kernel.org>
In-Reply-To: <aeh0CV3UQw1quCXv@ashevche-desk.local>
References: <20260422041846.2035118-1-kuba@kernel.org>
	<aeh0CV3UQw1quCXv@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 10:08:57 +0300 Andy Shevchenko wrote:
> Since it's almost removal and it will go via netdev tree (same tree you are
> maintaining, I suppose) the -D would have a big help to review the changes
> (and not see removals at all, as 32k lines of one email is too much).

Good point, I'll remember for the future deletions
