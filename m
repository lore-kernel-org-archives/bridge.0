Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFEE1B0406
	for <bridge@lists.linux.dev>; Wed, 12 Mar 2025 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741821111; cv=none; b=CznQ6Pnk8fJUGwhpWtnOpLZ3eCnieBeoEqsSdqX8wSgtjt3P4l0ayhfJFulcuXCprN/x2xpejLN2bMACP7xgCV36gSYKODctMGMxAUW0Gj32ap1PUwSdKgfx/MYXpeztjBPNHfLOVt6eOaHl0vgDLUbYL440qR4ZDlv0K+ix7PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741821111; c=relaxed/simple;
	bh=2W3aVFmGwvClwVTmM7aCRx2KgO4A4R1U0tJDkBzH+nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyUcKwlaqXv7zMtQADwTmZmLwCo+AjDdPFl7/K/LDa2gFn38Dq5Zva412OIT2DztPDa0NQ3d/Y1C0pUMWJb0biIcn8hMlKUNdK3Wp03o+T4O/Onnhm86pLP56JjjhhtG44JO4OAqh3EepHR2kwZon+XKYqKRCg284l+yMygib2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=BgVlscR0; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=qbeolRdz; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="BgVlscR0";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="qbeolRdz"
Received: by mail.netfilter.org (Postfix, from userid 109)
	id D7E62602A6; Thu, 13 Mar 2025 00:11:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1741821105;
	bh=PQSKrOlMPfzl9nwDmSr8qh4iamX82LLyOlMFMg/9c7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BgVlscR0bPKC2X7R3pSjdNhFWP4KMQsM+aoW1Tr19RecQ38KdHVUMdbJLxZgSp0tS
	 Gnj7eeOeX9DWSAnDxE5AJ6ZLoAOm7gyGGIT0+yZ4z9dPlHpZlB6HMvPmIjfzY529J7
	 ccCIzen5Laej81DL62cQhF9fSNF9HFsvEn0YCw6CI4JzYhFzTzYVYfTOxbOatr7ez7
	 3f6r4MdHeEYuNIiQVYsbQMVQVFBK67r6VZAzQ91RJpdRjo0imU4EhnubJTzsxVZnW/
	 p/sPgj74aUGaHc948Na17hMZDIee1NUWnBf8BiJvThoraKA1ZQqggKTnhA92NkYjHq
	 uGttitNTKMf6g==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 49BB3602A4;
	Thu, 13 Mar 2025 00:11:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1741821102;
	bh=PQSKrOlMPfzl9nwDmSr8qh4iamX82LLyOlMFMg/9c7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qbeolRdzmWfAU19cU0ccSVcMVP9Fk4SSQN9BVqHZ8FLRhk39ZK03WcEJ+WQOmOxZF
	 cy23JB5bF5+aVpudZJXvgQrTaeLjetLivZIvhEEDf9Re9Itl0VnGNk2tB0s4w2+kXT
	 talIeV1XAVKL25ykSMxM5fUeXwDlOLPo7r2V1/53tyLuKpyHDKpWW+c4oRWWG6CHax
	 4zIHURnVcKBNHgV75Bd3agsDnngcIvT3lvGyOfj2Ddp/CejMNpCEnvtz+qkgNMldVY
	 o5hT/rRHam+N+4/Lhradu4N5nlIXFhpj14jDpnuYxuEfASgXrzhghIOpCK4MXyAr4O
	 CBArB71yfg7xQ==
Date: Thu, 13 Mar 2025 00:11:40 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>, Ivan Vecera <ivecera@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, bridge@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v9 nf 00/15] bridge-fastpath and related improvements
Message-ID: <Z9IUrL0IHTKQMUvC@calendula>
References: <20250305102949.16370-1-ericwouds@gmail.com>
 <897ade0e-a4d0-47d0-8bf7-e5888ef45a61@gmail.com>
 <Z9DKxOnxr1fSv0On@calendula>
 <58cbe875-80e7-4a44-950b-b836b97f3259@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58cbe875-80e7-4a44-950b-b836b97f3259@gmail.com>

On Wed, Mar 12, 2025 at 05:21:29PM +0100, Eric Woudstra wrote:
> 
> 
> On 3/12/25 12:44 AM, Pablo Neira Ayuso wrote:
> > Therefore, I suggest you start with a much smaller series with a
> > carefully selected subset including preparatory patches. I suggest you
> > start with the software enhancements only. Please, add datapath tests.
> 
> Then I will split it in:
> 1. Separate preparatory patches and small patch-sets that apply
>      to the forward-fastpath already.
> 2. One patch-set that brings the bridge-fastpath with datapath tests.
> 
> > P.S: You work is important, very important, but maybe there is no need
> > to Cc so many mailing lists and people, maybe netdev@,
> > netfilter-devel@ and bridge@ is sufficient.
> 
> Ok, but my main question then is which tree should I work in, and
> therefore which tag should I give my patches, [nf] or [net-next].
> I think it will get more complicated if I split my patch-set and half of
> the patches go to [nf] and another half to [net-next].

Use [nf-next].

> What do you suggest?

Probably I can collect 4/15 and 5/15 from this series to be included
in the next pull request, let me take a look. But it would be good to
have tests for these two patches.

I would suggest you continue by making a series to add bridge support
for the flowtable, software only, including tests.

Once this gets merged, then follow up with the hardware offload code.

Thanks.
