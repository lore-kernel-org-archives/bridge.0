Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9AA222562
	for <bridge@lists.linux.dev>; Sat,  6 Sep 2025 21:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757194267; cv=none; b=KFWIcY0uHWENoqOhijLeE2BbLWsLTQAds1MxdLf36gP7TUsYtDibXo5ezi5UC6+52vNkGRP0ucLn66xNZfBzICL5Ora7n2YADoRtU+CHQ20TBrR0an+J22CI+aPsJ2d7Oh7UCLpKtCJLhdT1X+bqJ6F1rYGEpLC+jAARlQIugR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757194267; c=relaxed/simple;
	bh=B3NDai3EYMJtFUSC5OHF5I2WpdMYx2oKldbYjXl75Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=if1AYjwWqe9NZ+o9HiQHKJxega/9KwYAf/j86tsoeIUOABvw0AQsAMPDmPcrbZdrdAG8U8ZejZob3j63OIro0zz/6MSDjD+vwnCG5u1sxQ1VpbLLTd1oJquEwoyw4cbmuUYt9DtExTpAsRou9Y6FFmHRHlJqx0CkvUYp4lUpOp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=RjUQB++W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bgn0NgRK; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="RjUQB++W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bgn0NgRK"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5F3BB7A01D9;
	Sat,  6 Sep 2025 17:31:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sat, 06 Sep 2025 17:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757194262; x=
	1757280662; bh=J5ZHF61t81pa1XZn1pVpiz0llRae/PIVgz4jSy9U4J8=; b=R
	jUQB++WHMzdQVl4mwYzCqmTAyYikFniioFtsubxhKZPdmnlo8CcJbPDqsj/B3XX4
	CUFpVnTvDl38a+0EYwnK+rPoczh5cf/iK1EwOwCUr5WBvz3Nv6FPcH00ghIs5jzR
	3KFIhlB+m8pd7/wuIIQWpz1Zedo5YCc0x3OSwLNtqC8HAaozqdEebO9rsogpSUz/
	9fradacieFV0E7oup5cKJ7wrtBiGlIXzy/znTESMboC9jCPAZdzDMRLOrcZX/Yzj
	7gTZaYP0LMyUCM6TPWnSOzWnDRjkP+3M1Mt1yqWLrc37m8n+LnyxXxWBNjdrY0qF
	klasllETe4FrZGHEHqFwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757194262; x=1757280662; bh=J5ZHF61t81pa1XZn1pVpiz0llRae/PIVgz4
	jSy9U4J8=; b=bgn0NgRKJKf5Wy2MDhtNR4YgmRDWK2mg9UzQzBUnqvQgKYj2M4d
	5QL9K2rg8RVUO0isXOk+23qoxAXZx13bhgpQAHsVjXmcmPG2WpVzzqjFt48G3bRN
	6f+G6U6yL87XY7APBxejhl36zO0OFlZUUYsNHMfAbCWtOLXZ8QH2wguOUfuSkA80
	FKS85QsUosEnWja57OYVai5hEAWJXSi+nT7PXh34UskvAL4LKEbWlCj5PTn1m0tt
	MkoWp4bxV7CseIN18wLBtHl8O/mb5N2vP3/D7y6PKf74pptgVRVbDpk9k5jgp3hx
	O2egOA8MsB33UmlNN5pKfBQdjA9jI7V99dA==
X-ME-Sender: <xms:FKi8aLaoW2MUdO7c8m-YMHmRSxeYY-VlK_ByGuzEe_5fmtRsQOExYw>
    <xme:FKi8aEoMIhBfbm6jYzGGhKT8nS-Xe9nn9ESIJXo64Hma8RmcUffP45tVmVZZS-nY6
    _NA12u7eFljOoDQ1Wc>
X-ME-Received: <xmr:FKi8aDZT6pImWUUTBYcVicwkNYgj2e2sU2B7S5gWyVY822aAunWE-qJh69s8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehlihhuhhgrnhhgsghinhesghhmrghilhdrtg
    homhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjvhesjhhvohhssghurhhghhdrnhgvthdprhgtphhtthhopegrnhgurhgvfi
    donhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhl
    ohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghn
    ihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhhirhhisehrvghsnhhulhhlihdruh
    hs
X-ME-Proxy: <xmx:FKi8aH4R7-g2a0V3hHdndfGVY3Wl5TuaJuzMWrkzBAf4VzfGe99Hkw>
    <xmx:FKi8aOQ9xL2SJyrGfPJZnOUTNPg17hVgTZKkLPmEirFsggMNNMr0Wg>
    <xmx:FKi8aHvxD36T3aPgmvfLx6f40jemsJ5KKViKxUdbYzySUUaQa77ziw>
    <xmx:FKi8aAYKGUtTq3puDmX9i2XU8AjWnGlhMjAqpkcQOPaAYcOsGUIcmw>
    <xmx:Fqi8aKKbWZlmitBH4AO07oYnLVDv7e18hWxDRWi0ysHL9Vyt5b52uIWx>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Sep 2025 17:31:00 -0400 (EDT)
Date: Sat, 6 Sep 2025 23:30:58 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv2 net-next 5/5] selftests/net: add offload checking test
 for virtual interface
Message-ID: <aLyoEiWnuvQ-5ODz@krikkit>
References: <20250902072602.361122-1-liuhangbin@gmail.com>
 <20250902072602.361122-6-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902072602.361122-6-liuhangbin@gmail.com>

2025-09-02, 07:26:02 +0000, Hangbin Liu wrote:
> diff --git a/tools/testing/selftests/net/vdev_offload.sh b/tools/testing/selftests/net/vdev_offload.sh
> new file mode 100755
> index 000000000000..78fc212efd4a
> --- /dev/null
> +++ b/tools/testing/selftests/net/vdev_offload.sh
> @@ -0,0 +1,176 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# shellcheck disable=SC1091
> +source lib.sh
> +
> +# Set related offload on lower deivces and check if upper devices re-compute

nit: s/deivces/devices/

> +# Some features are fixed on veth interface. Just list here in case we have a
> +# better way to test in future.
> +set_offload()
> +{

[...]
> +check_xfrm()
> +{
> +	local dev=$1
> +	local src=192.0.2.1
> +	local dst=192.0.2.2
> +	local key="0x3132333435363738393031323334353664636261"
> +
> +	RET=0
> +
> +	ip -n "$ns" xfrm state flush
> +	ip -n "$ns" xfrm state add proto esp src "$src" dst "$dst" spi 9 \
> +		mode transport reqid 42 aead "rfc4106(gcm(aes))" "$key" 128 \
> +		sel src "$src"/24 dst "$dst"/24 offload dev "$dev" dir out

It's maybe not something you would expect, but this codepath will not
check that NETIF_F_HW_ESP is set on $dev (you can verify that by
running "ip xfrm state add ... offload ..." on the same bond+netdevsim
combination before/after toggling esp-hw-offload on/off for the
bond). Why not use __check_offload again for this feature?

> +	# shellcheck disable=SC2034
> +	ip -n "$ns" xfrm state list | grep -q "crypto offload parameters: dev $dev dir" || RET=1
> +	log_test "$dev" "xfrm offload"
> +}

-- 
Sabrina
