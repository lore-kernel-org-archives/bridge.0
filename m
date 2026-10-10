Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381323546CF
	for <bridge@lists.linux.dev>; Sat, 10 Oct 2026 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791649674; cv=none; b=llTbCAizRGh9BtrEMyD6OgzqORuWc1sh544fLFnhNPP/FHfVrFicGfOIs0WbfwM/dKFpqBKf4xrLY7AhwJlwGEsjo7fwEX01B7nyx9Zo00G7gkV6w0ol87yn21lqw6lvDsnpDB7O6dTgqUnog57Z2eYuYxTIqJGdWBNqSbfOojI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791649674; c=relaxed/simple;
	bh=SZnjtIBKL1hdvA8/K3thIvkJHfNjrGKGyksa/PcBVzU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZ31MBaAiCaQJrTGw7hLGqQ+9h/EFuHge0vO9yOjnilrX30odmMYT8nlzCPytQSL2vqq4pMWw9tfuhTRA3acZrTVz4BCKSIXS/1apJ2KZmu0bBW57AsqjOvQ+DZ8UUe1ouIydukPwUrB3Ic3f5Dbo68ASQt/JIHc7Tguu5HkrXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=dXdqaiE3; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="dXdqaiE3"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc4b1f7e8f4so303617a12.1
        for <bridge@lists.linux.dev>; Sat, 10 Oct 2026 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791649672; x=1792254472; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5DXAcsQcMb0rpwsXjv7XvaNNDyUfIbkRwoU5NHe4eL4=;
        b=dXdqaiE3kLFV+aV3inFCEXJ/WI7SMt9cOqjNjLyw/X/QoJKURymIYU0cJ57xwemFSF
         2BPd/A26Bhf0YCoQ9Qz9i5dcri9SAnt64dFH/kDmkYtc8uT2HgNSfhJpVgE/9NmKiz+U
         Q3PPfEPMkNv3aC8shrpqc7HrYlNdAk1jKtnkMzTWT4TH09h/B5fcJhXKMI16dXETzH+Z
         Zgy9ntpNL1iNqVsm+SerKUGjL5EUzMq9amKgK0+X6DFF07tsdiB9uYnbpRVHArqfCdG7
         PGQbjcf4YASHudwQmcDk+uAB0tW8LF1i+K2n+m5bYSpMTW7GbdKdG/SAAVNt1uUlpoTi
         U+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791649672; x=1792254472;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5DXAcsQcMb0rpwsXjv7XvaNNDyUfIbkRwoU5NHe4eL4=;
        b=YrhyvLd/ryK2a4snVPg41JsMI2sYqkqlQcaGE7agroZnNPj16om1PROuHn61hl4Nak
         bGW8UUjB15rNDG0uVmv+ReWAILx/NUY5j6L3lCh52O92Ds4vMgDUxVFoTFktN+xMW/mR
         HMMoVW42DW0vekDALXXxCFPDHfaa1QuEw470H80/jpyo6u0YsOwWhKNWH0i+FaG3xFom
         jEp3j07TadTl0a9lYXf8uJX1lmuLcvv7XGF4ljJWFbZD0Kzh1Y7uKqddCN1ePPvNGyCl
         3SFI/w2R6tcr+Qx3E/G9BJNHT9SdTZJEvvLvEcHUUQsBx0uauUYA5olpVcU5SQIMyKM4
         ljIQ==
X-Forwarded-Encrypted: i=1; AKwUvBzXUtWa/OyuKj44N9K/wfZb4ejNiUxOEVGmv8SrNUuhwiH4jWgxkKWxL3JxTYm5/FZyidrPltw=@lists.linux.dev
X-Gm-Message-State: AFq9FYLYIfyrLLmumiggLHCnNSrg2BwAL65/RXK9H22EhJ16hOtFuoUG
	XCYNPzZ2XjnE9wWwPA02WvSXVYFx6V+GGB7GmlHStJuyZqSTBlZqq5GsmE3iO+WQQ4g=
X-Gm-Gg: AYBFou2tBVvvhyy+b4FJ51+UV2/BRZrM9pImhM+jZlbs5Dt20R4id1qO3+cgtmo9gj/
	oIoryv0291Bgu3ZeUFg+PowIMAQNmg7lciP9XoE6Ya7kNcmXyljJMLwcNF7azts6+3/BmzIJLUO
	70PlZF09XwbtSP7e29+pi7tSdFznKsnoQU30j0k1OHkZgc2ophUs64ebKr6KSS8kWIKIxbN7mpP
	7Ry4OLRyZ9FP2+o1TNIpzCb16i/g8m/EJY25qXLNrg5QrcevMmZYfPcWBojZ14JXJ1pZKlab83q
	HqjVKORBsLDH6chKGP4HeHs+hqewxdPqQWxBhLbr/NbuqJbmK9AdSnSKK1t3ub8ZUTQ6EQhOo++
	tSHmXqiU/mjzzicGBsQJmWwKQmmC2NwkvWxCvtRoPsFZ0EdW4hkeofQdVerKutzwZtkrMHctSmU
	Dr4dqyYvO2oqTeNbRVLYyYkoziKEfOmnSiZUn3Sa1Ou/xklJqmtjBcRDNru+KmCsh3ukcTjQ3q4
	L9znfz8RJkruWN6GpwZYDAtR1iDikRbMn+hbFs+
X-Received: by 2002:a17:90b:1d48:b0:3a6:582e:5e17 with SMTP id 98e67ed59e1d1-3ab3ab25b70mr2906005a91.48.1791649672479;
        Sat, 10 Oct 2026 09:27:52 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab339684f0sm4573627a91.1.2026.10.10.09.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 09:27:52 -0700 (PDT)
Date: Sat, 10 Oct 2026 09:27:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Abdul Wasey <w453y.me@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 razor@blackwall.org, horatiu.vultur@microchip.com, bridge@lists.linux.dev
Subject: Re: [PATCH iproute2-next 2/2] bridge: add cfm command
Message-ID: <20261010092749.6bfd087e@phoenix.local>
In-Reply-To: <20261004041307.2683990-3-w453y.me@gmail.com>
References: <20261004041307.2683990-1-w453y.me@gmail.com>
	<20261004041307.2683990-3-w453y.me@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  4 Oct 2026 04:13:07 +0000
Abdul Wasey <w453y.me@gmail.com> wrote:

> +static int cfm_parse_interval(const char *str)
> +{
> +	if (!strcmp(str, "none"))
> +		return BR_CFM_CCM_INTERVAL_NONE;
> +	if (!strcmp(str, "3ms3") || !strcmp(str, "3.3ms"))
> +		return BR_CFM_CCM_INTERVAL_3_3_MS;
> +	if (!strcmp(str, "10ms"))
> +		return BR_CFM_CCM_INTERVAL_10_MS;
> +	if (!strcmp(str, "100ms"))
> +		return BR_CFM_CCM_INTERVAL_100_MS;
> +	if (!strcmp(str, "1s"))
> +		return BR_CFM_CCM_INTERVAL_1_SEC;
> +	if (!strcmp(str, "10s"))
> +		return BR_CFM_CCM_INTERVAL_10_SEC;
> +	if (!strcmp(str, "1m"))
> +		return BR_CFM_CCM_INTERVAL_1_MIN;
> +	if (!strcmp(str, "10m"))
> +		return BR_CFM_CCM_INTERVAL_10_MIN;
> +	return -1;
> +}
> +
> +static const char *cfm_interval_str(__u32 interval)
> +{
> +	switch (interval) {
> +	case BR_CFM_CCM_INTERVAL_NONE:
> +		return "none";
> +	case BR_CFM_CCM_INTERVAL_3_3_MS:
> +		return "3ms3";
> +	case BR_CFM_CCM_INTERVAL_10_MS:
> +		return "10ms";
> +	case BR_CFM_CCM_INTERVAL_100_MS:
> +		return "100ms";
> +	case BR_CFM_CCM_INTERVAL_1_SEC:
> +		return "1s";
> +	case BR_CFM_CCM_INTERVAL_10_SEC:
> +		return "10s";
> +	case BR_CFM_CCM_INTERVAL_1_MIN:
> +		return "1m";
> +	case BR_CFM_CCM_INTERVAL_10_MIN:
> +		return "10m";
> +	default:
> +		return "unknown";
> +	}
> +}

Iproute2 already has helpers get_time and print_time.
