Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABA6346ADC
	for <bridge@lists.linux.dev>; Tue, 27 Jan 2026 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769513350; cv=none; b=PS525ddybHaLtCYOhJgLQKWZMLxqEoVmwqAmgKiakpoyYoU0/j7ZAydggQY1UQ0o45vMOxBjXekJNSl/RQn/F4i/omDVs+3/Y78H1+G8wQUS6fGdkiwS/wqYB/SwrZjkkjSsFyBQqN3isqVCyoLO1rlAZbU4GDBKCkaZZWnwZsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769513350; c=relaxed/simple;
	bh=J8onob1rjyOl4EooAMxh9Iy1UHZaEDzeMxJAqh5Lic8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTcxFbgNUmCr1E+isNbmoSjqqrgNdRq+mdyAf1yE1Y01DbSLKNvRIdcZL5JGQIwwf1rv+CCaWsccGABcIEOi9ITBW+hfH+v3QRTF8z6+gdvJxbT8NNyW5AgP5SGhggSpRr9OBdHQr0X357Kt61CO2VA7MCUCLUjCCepZEEjf74o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 82E446033F; Tue, 27 Jan 2026 12:29:06 +0100 (CET)
Date: Tue, 27 Jan 2026 12:29:06 +0100
From: Florian Westphal <fw@strlen.de>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: bridge: fix static key check
Message-ID: <aXihgjj_H9Gk2X0H@strlen.de>
References: <20260127101925.1754425-1-martin@kaiser.cx>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127101925.1754425-1-martin@kaiser.cx>

Martin Kaiser <martin@kaiser.cx> wrote:
> Fix the check if netfilter's static keys are available. netfilter defines
> and exports static keys if CONFIG_JUMP_LABEL is enabled. (HAVE_JUMP_LABEL
> is never defined.)
> 
> Fixes: 971502d77faa ("bridge: netfilter: unroll NF_HOOK helper in bridge input path")

Reviewed-by: Florian Westphal <fw@strlen.de>

@net maintainers: feel free to take this directly.
