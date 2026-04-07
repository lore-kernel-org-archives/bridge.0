Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257BB1F8691;
	Tue,  7 Apr 2026 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775525106; cv=none; b=Ou6CQC1Kjzu5Nt2GfMX7e4py6a0RviDLTEhMee1keVPKIuy5zZ+tm2AWNv0GyxFa13ry0jkGPMhZGLvrEEQyHdiKbNkqT5MPxvYGyTGdPLG5bP+U3QDIQGvZ6KcGJHuqzdigjf0Sb90nPU3WVfMTyfwoTGHUGuzZfgH271119vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775525106; c=relaxed/simple;
	bh=LKaanIRB0mVTM6u+vUqwo3v6gkW7YTy7tjioKxkgS7M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXDOkAe95CKa8Bxh0s3Q2OwSEKcJi24QTI9OIP/ULF2kUPvSPi8UM2d2AdS7f0HvQTTgJZGGN6eM9cjzXMUl5NM7Gj8ZSdWX0gy5R3JmEaIh6URpe0MRjOoJh7uqFd72GerD7c7Tt1et0oGHGsbEr/4LvJoXPOAbbSaY+p2imyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrSGLug5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrSGLug5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C02CC4CEF7;
	Tue,  7 Apr 2026 01:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775525106;
	bh=LKaanIRB0mVTM6u+vUqwo3v6gkW7YTy7tjioKxkgS7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PrSGLug56Hz+rqzF+K21bcj59K+C1m+LyKp6JTfTh00e6ti4uSMf7BD55kOjzKoR6
	 7eQloHO+XzAINp/2uzCNhntk4NLo7BcukjoNTnfZ3Hk+DT9Yzz3aI5Akp/qDs7WuYX
	 p+PdMacOXiSeEdJ1k/pnT8R7Cri81IJvLRQHBzYmqd00M17MAe4BSeHw7nvPDbt2Ei
	 wZ8MJHCMDijkZO/yiZhORR9Ktc1rF2BCXtu9uvY6lfspnbn5WDmv5UcWrL8IBV1f7x
	 mKfc6VbheFR+d2Tt3PV9mxdXZkrZ/8tPFuKV6PeJYnRVn8o5AovlsHyEqLU2Z8y/jP
	 EtK6t42zgwBSA==
Date: Mon, 6 Apr 2026 18:25:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ujjal Roy <royujjal@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
 <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, Yong Wang
 <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ujjal Roy
 <ujjal@alumnux.com>, bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/5] selftests: net: bridge: add tests for
 MRC and QQIC validation
Message-ID: <20260406182504.52a03794@kernel.org>
In-Reply-To: <20260403150050.1235-6-royujjal@gmail.com>
References: <20260403150050.1235-1-royujjal@gmail.com>
	<20260403150050.1235-6-royujjal@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Apr 2026 15:00:50 +0000 Ujjal Roy wrote:
> --- a/tools/testing/selftests/net/forwarding/.gitignore
> +++ b/tools/testing/selftests/net/forwarding/.gitignore
> @@ -1,3 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  forwarding.config
>  ipmr
> +mc_encode
> +mc_decode

please keep this file sorted

> diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
> index bbaf4d937dd8..a26da846632d 100644
> --- a/tools/testing/selftests/net/forwarding/Makefile
> +++ b/tools/testing/selftests/net/forwarding/Makefile
> @@ -1,5 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0+ OR MIT
>  
> +top_srcdir = ../../../../..
> +
> +CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
> +CFLAGS += -I$(top_srcdir)/tools/include

Could you please keep the format more aligned with the ksft
net/Makefile? Also is the -I$(top_srcdir)/tools/include
still necessary? KHDR_INCLUDES don't include $src/usr/include ??

> +TEST_GEN_FILES := \
> +	mc_encode \
> +	mc_decode \
> +# end of TEST_GEN_FILES

Also needs to be sorted
-- 
pw-bot: cr
