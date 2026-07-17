Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C2332AAA8
	for <bridge@lists.linux.dev>; Fri, 17 Jul 2026 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284947; cv=pass; b=DYCATxaJ4WJY2plY1IB1y5O4hnLRUpme0amtGiR8ZKv1/6F1D9YdJNNDojKJvRpcxOgEy39qCqDtpAlJwkV+Gn32gr3oUFXO86/stZn9jX2qYkp4pyJ4EHI+AAOg4nNt7Vo6px1y2/SU6bhYNf0A4PQMdzJSBJUH5TRtTMGu4HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284947; c=relaxed/simple;
	bh=0R8llm0EFrqZ2IbxbCOlkG+jKbWRlRuWRiKKZa1D7l8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VzPMBGNTWZ3cCKqMWvqSnlE1fTI++NoSHDkJIKuRbpR5FJopyM4g7iuHmW8oyORt8WwnpzitWygCXHqhxWZy1gaJuM2HQbjcnxy7Y+WsI0C3dxixVhrkvHKT4mvDhlrRBiGzCmRGGeIgRgkLC/tS5gsoA5RYZrPwUoz1h1PTLVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l31MN2xL; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l31MN2xL"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69a50189d25so13721429a12.3
        for <bridge@lists.linux.dev>; Fri, 17 Jul 2026 03:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784284943; cv=none;
        d=google.com; s=arc-20260327;
        b=S1RPh0LArqGVSglSKrxxl8JNNz+hFGwoJXXVct+FBun9VJdOo0nsyx7PvJUstleTxx
         XhgyLH0EsTBg9Sd6GtCYy0tz11Z40MPIGojdMgKHqjm9NERB5aejtFG3L0jUqiUu1cT3
         bzt3mpT5TxagJJhE1F7L4K60atNPxpnwfocL4umueUTbIPwKHwQTud2Jd2OBuHDHC0o4
         xxgT16eDC9Ctqgdwes4xE9GRs/sy46xpytWjy6RatWXIyvSK1Bo/T3je+BK+QwTVVyDU
         02UgR9NbexWVMmiJ1/15l/xdYfJJsT0xPBzOqEw6nDavq/yphFbL2O7I6hp5rntJNHSr
         GF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7CDNeDBUT2qdP6O3Gq1ihGrb8xj5GO5o5nq7iOfnSkY=;
        fh=YlGwlmeF2ch5m5XlW+UicagvaTZy3HIFj4smT1Bz9j8=;
        b=I2dxKP2rxXU4HCIq5R556xCubl2Rf+21wHJY1fGYvmTVLM7aQppmI1dSHT3xJBLf+O
         HTUNK9MkKcWuNaIW1yvKB3I3ozMAWX42XEgg0/vpYwnsQK7zxMuWkaF7H2KjkjJqAtGn
         /7pAzC/rBgxEPcWhIYnWCjEb9r/VHxLfLtjhCWrRjndPGu6ChvymL5OIS9JjSwqnmMsW
         2UvW4PIEI5E6hlHnyYAWQKglU7O0VbydnrGfyAHJ2gyUMnzkTU+ID7Du6RHto86TXuSb
         Hsy8Dd0Os5vmLw6c3l/ytC8Lxn/TSJCvjUoM63f2L17jiPS5LNmPLgFch2EqEfk/7XqO
         wjfw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784284943; x=1784889743; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7CDNeDBUT2qdP6O3Gq1ihGrb8xj5GO5o5nq7iOfnSkY=;
        b=l31MN2xLc2WOp7Dnkd1GnOC+zTAgWLS6N9QtdJSBMYKZyTFUNqXOD21G7LX9Cr9Xn5
         z5dabZMPum0L5XQbHXhn1GrcrpUQf93QGM3KYCJT0Kbx2GcCyOA9pFZ5vHUqnU6dMzWR
         JSm3OCKyWNGaPKlYUABP6IQd57kBp577ih1IvnoITfE5sIJLb3yEYmUtvYOR0VxoyLg3
         8uS+8taDq6Bis565VNimgDzHUhDkHsxo8/F/L5o4VI+xPSvn1ikt0xymx7LhbJheHIXx
         UQKIJTF+7SpJ7GE9ZhibDq+qZ8gGgmHdjP75rvsubJj8GbdZgBqCwOA04RVem+GVmkKE
         uFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784284943; x=1784889743;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7CDNeDBUT2qdP6O3Gq1ihGrb8xj5GO5o5nq7iOfnSkY=;
        b=bquOrf1eN7I1Snsf/p74BhhySlDEG2NwVurMVc16Rub2xjKS3fFatYG0FGPbSChxFF
         Okou0U+IGbiyAhxJpp7imB1b+VgxF8PR5Ox+OkO6YcCxGA3NK3eWObBr0j9ozhq7BA67
         puXzlxVbc94vp4U0t1+N+bpSNsNxGB7xXN3CaEX+LJPrKmrB5+q9ii/To91DB+bnCZHH
         XNCNVk7fsyBtQbX81gD91zzVNjm3kbZRJB8Cu0qnWOFYxq9gI29znfMgCjpn/ESnWQSI
         xy8ruAeG33abVaxolrbCT6jZ9ptaFoj0+bizMlB95DpBe5bq07+YEivi79UxulbTB6MJ
         fCgg==
X-Forwarded-Encrypted: i=1; AHgh+RqlK8jXhXwQJrTymKBrirO9mV5OoYBkAi3kUyuHZ58k1+R+BPz1kIVu7wgnkJsVlMI51vcnlcc=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzitqs87R9yFiBUK7QX7nLT8a4t2F53pJImkbyulz8giSY0TfB0
	IgUlApGBdgNeVf/jpomrMxNptyCiRqp1SGGHJtCty1wAcBhWCKl/zTr/oLyqwpTgYJrfCXicU0S
	K4AwRu4cHDYF6vfGPiL5ZERJ7fRKzS8Y=
X-Gm-Gg: AfdE7ckKC5Z8ONgQiZKn/49dTAVOLQ4v8/qzlYeN5nOw+uVWbpnxs+MQxxT1a/CyK4j
	TjfMgEPZLFM9L1CCuEzLqBFXlFaRpbIdPvw/dYmTf/uZvyHWRqWHKhB9Op4Tnh0tVem93lJS89l
	ggikUDvEPfUYW1wTmexTZCDkj1gBhx4IUnHH506yFVaBetFFA/jtIDQORVIuOcSHH2vUQSrIqqN
	3iZPVqVW7RiUUDuig5JQRpxRtCjXjZMK9Vuw6GIDW+YWeRoDajgKOPplu+XL31oJG06atA=
X-Received: by 2002:a17:907:c0b:b0:c12:6d25:2c7a with SMTP id
 a640c23a62f3a-c16b46e02camr92779066b.17.1784284942904; Fri, 17 Jul 2026
 03:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260709101327.9508-1-royujjal@gmail.com> <2026070925-delay-gauntlet-bc7c@gregkh>
 <CAE2MWk=mm8_bkd54Gv1mdox6rfvx85Dd3AjOCxPz0fPAfyuWYA@mail.gmail.com>
 <2026070954-activist-left-8303@gregkh> <CAE2MWkmcQdhGp3LTMtpgAse3AFcfKcAcpQe89+iijfP5e0w_QQ@mail.gmail.com>
 <2026070948-lively-exchange-a458@gregkh> <CAE2MWkn3L7V3x8i0F-soGLxsBBo_Umgs1pJ3FwCw1OW7=U55zg@mail.gmail.com>
 <14350a31-ffc7-41fd-84d3-6cfb2cb96841@lunn.ch> <CAE2MWknt86W6yCtuS_RupiuwiDqXT8wZqENM2DjiW1R=eY8qdg@mail.gmail.com>
 <797773e2-b155-451b-ae97-e8a005fd2d86@lunn.ch>
In-Reply-To: <797773e2-b155-451b-ae97-e8a005fd2d86@lunn.ch>
From: Ujjal Roy <royujjal@gmail.com>
Date: Fri, 17 Jul 2026 16:12:09 +0530
X-Gm-Features: AUfX_my1PzHSS8WAMVOk58Ferv5AB7ZeFGvF439u5znvXo9fyXEAn2XHzEUmwqE
Message-ID: <CAE2MWkmbdDrCw1HUKm17QG7dyihuxg_1VGTUNeBq9v8NVwJV3Q@mail.gmail.com>
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to 6.1.y/6.6.y/6.12.y/6.18.y/7.0.y
To: Andrew Lunn <andrew@lunn.ch>
Cc: Greg KH <gregkh@linuxfoundation.org>, Linux Stable <stable@vger.kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>, 
	bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> It does not force the users to use a value < 128. You would need to
> return EINVAL for that, which i'm not proposing. Returning an error
> could break user space.
>

While I understand that clamping avoids breaking user space, silently
modifying the value might lead to unexpected behavior that is
difficult for users to debug.
Because of these side effects, I am hesitant to proceed without the
Multicast maintainer's input. We should raise an open issue on this
topic to get their official decision, otherwise my preference is to
ignore patching this for the stable kernel versions entirely.

> By clamping to 127, we don't break user space, but we do avoid the
> kernel bug, and at least to my superficial reading of the RFC, we are
> "language lawyer" compliant with the RFC.
>
>         Andrew
