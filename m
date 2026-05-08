Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B507B30C354;
	Fri,  8 May 2026 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278627; cv=none; b=spmTQo9mnUaAVJ7kYsyThoQa8EtWswzXUNxXJFOyWiBfJpEx8VGfIVjFKghSpmME2k3FbZpMfxbSMcmwHGOPfK/dVexWCYuGKYUuitJB8Xv39Gj7UP0HfzSLd/NLslau/YhyhTYLhO+cihnlMTm2h7ZoBPP6/DDpfJatxgiqVG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278627; c=relaxed/simple;
	bh=eqTk5pb5JyocaCQTV74wIppxWYFjYa11HBl05trmdNk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6nJOHbNGUB8upaY5onGirIWD58sOEMIo6t7zvxsSWYLI++Y9cIVMpbOfTWKzdDH/2Oxq9WZVUQt9QYbKuZSCO34l4AwdvnwwJB4TFzUOVAEgvyv2NB93r84XDUN+Qb7rfcu43fVhxoGNoOmOHxk9usCyzGTaI/BOYECOj87q7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tg3csxur; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tg3csxur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8A1C2BCB0;
	Fri,  8 May 2026 22:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778278627;
	bh=eqTk5pb5JyocaCQTV74wIppxWYFjYa11HBl05trmdNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tg3csxurp/psDxpXOL7DfWtPv9bg8PwnwVckWoC0cZZdobXc8ZdMyQIfG2YmdsU2r
	 DlFNsdXkwpU6V3M3v+u/Klut6Pn8jijBUoPYRrIOXYdhbzQGRnBTEpu+vbGTj3GSEI
	 brjemlQ4htC+GR+KVq4UX89D8NnWp+sYeFq+Lk6vmI/9Hxs0nHKmVq5+PtyOJK2IR0
	 Q7P7dCdprByqQx3cUER6mvwAs9tUHEZUihs/vZKvAYVnopYP21ICESp443aLBV+0fd
	 YToMMNvEIuaTL1ptnacKwlT9E0ixdTHD/MawKvvepFHhGj5XV0gIQxMV5l7iYppDW1
	 uu3k5QrNVJ0xQ==
Date: Fri, 8 May 2026 15:17:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aadarsh Chandra <aadarsh.official.xz@gmail.com>
Cc: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
 netdev@vger.kernel.org, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: bridge: replace simple_strtoul with
 kstrtoul
Message-ID: <20260508151705.2d1ae5bb@kernel.org>
In-Reply-To: <20260506172447.9770-1-aadarsh.official.xz@gmail.com>
References: <20260506172447.9770-1-aadarsh.official.xz@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 May 2026 22:54:47 +0530 Aadarsh Chandra wrote:
> The simple_strtoul() function is deprecated. It does not handle
> errors or overflows correctly. Replace it with kstrtoul() in
> brport_store() to ensure that invalid user input is caught and
> returned as an error.

Your email server (or something else in the pipe) is breaking the
whitespace, this patch does not apply.
-- 
pw-bot: cr
