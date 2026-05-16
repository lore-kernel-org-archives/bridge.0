Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A5B2FC893
	for <bridge@lists.linux.dev>; Sat, 16 May 2026 20:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778963743; cv=pass; b=tJMFzLORMpCwL70EtLuGeHux7dpEMGUX6zbnH8BU2OKarn7Ea558F3FKRDtEsOD3szeCqgCozeGj55sCS+gZuFNWE44Zi2KfJ5NM/TIA2XhFhUgEIfiFeqnGpmpGW0Hh4LzLOqf1TpA8P/TblmCuZN/30wk/tbnSVGOdxMWUmx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778963743; c=relaxed/simple;
	bh=QDKONued7/xd2RqstwrJGKmy0uPXkNmeq8jOp4roBKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EoSJi8TT12aybj/J/rYettDDlOfb6nZu8U96cG9RrFj12oAP4yrMiz837kzsMuTkPtfP8KrDI+Ct+KsqLZ5pdT0Ml7ewZ/9BTJvnvtn83IDciu7/qfGGbROs/Xkk08ivyk1B5JS1zbv/oH+DEikk9Sr1SdsYN+LBa31jWV585Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmgyCG5O; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmgyCG5O"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-439c00ed7e0so951779fac.0
        for <bridge@lists.linux.dev>; Sat, 16 May 2026 13:35:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778963741; cv=none;
        d=google.com; s=arc-20240605;
        b=OHdEFEtLu4HcYSbVHPI4qA2YVlUfnLPjlQDk7qzcj9RY9z+ilU3zIPqTYKxEThnveP
         gVAmlkM8UhjLoyFqxSC+MyYCQPQC/bJYF/yvMZiTioj4+IhwJ8wjSrMEpJPpbWs9qwU2
         vy47GV7iCXgkYCr1ljjDCan3A1orOaHPrxgi1DWESLcRX5ZXRRjLiLl41e0PX6EYsn3D
         Otr+VgANyMMGW8I8ppH+dowsNSd+Q83cHCdgqVHNy4v0jQ2Lkf5xxfnyBCLpWsanGknU
         WPB1LejHx5dEMxWNo8Wn9fhH/X+8RR39fqzvCWf3YG5QKyEBBhnrGG8zw9z9JVPRq2L6
         AItw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HHLDSY42IzpgtERPSbX/qbfMGmcCVU2Ad0Vzt2eV/jw=;
        fh=BJSEeeGGwg0gZ/wsFO4vdmr/s0B9/nuUAUgNLymGya0=;
        b=KTO3qCcwCmKJZHnXq3+YeAF0DY2Kqomq7E5HWVYFsnUlc/kqC4UBa/yP7D7+TSmmip
         VFv15sWseujeNWtEqRmGEM9CmMfUiU1REqn/I1fR47pYb9WbHuokeTddHaXy691rkP6s
         2b4LRrS3Spo0UPk0xWGDqkeNAbdI5+Bx62g+aNkCpN0Kl5Pkro3X2G2Ag38tUz8DgJM5
         bt9zjjzGXAHZ54YraISfMbI7q07QkJOeo2SpPXvIL73cPTpFg2BY8PSpUW8DCL3x76Sz
         Ht6IUjGxaL8NKcKh4LZvSnQDB4T/LYDxubuoSn9mdm+3FLf9+ntHtcpThYkGQIrrkUw+
         M3ow==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778963741; x=1779568541; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHLDSY42IzpgtERPSbX/qbfMGmcCVU2Ad0Vzt2eV/jw=;
        b=RmgyCG5OUDo4v/K5S/uD5yIK5z+nauxEeKn9jlE6ZhayMRDpMdxdpnWcooPYeZorLV
         VKCDrfCwUxxz1qCN7i69ZhHJAU53QN6aSn+NaMQFCqQ3XTemMHdpQqCsLzv4v2UHZJ0v
         94Uuw/V5rkaKZ+1176BG2cIi/H8IkAgInIaIHIfS3en5lNc5NmZ5TWHVVC/VfLDBO7AW
         ws8TRGRcEYI7ThgP1zcsfsZgFgjUG3HTj18TV0t8Rr7EuBbklz1rEwG/R1ODA3ZUHeOp
         S/UhnviX2d0DHjKWZLfj8Ux4YKzMB2/uYAJnBuMU5+wGuA7SVxAz7MIffv0fHoePaR06
         YTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778963741; x=1779568541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HHLDSY42IzpgtERPSbX/qbfMGmcCVU2Ad0Vzt2eV/jw=;
        b=iwzXgfba5nfBB89rVrr6CVbwFe5TOADlamekPL4dn1Wf6GkUAgqPbgE1sW/O8SjV4v
         PHeoqFbq6ua8dFbqAs4N/R8sq0RpIaThPrwYoiVBAAGpM58n2ezi/JPYLi9+lyAwvZZK
         jSqPmPUST4YYKlCF5Mp6AN56qOYKvp4AKDtt7plKq21r9bqINvRicymg6Kc2gx/j5rlW
         Ldd0StshA7f6BWKoPG+GJSjIkH9+KgMk/ACTff6D7BkI/6EU83XIc1MpOu8jgYzwZHZB
         FurgykehC8tez2KPq40XUkUeLfVZml5CyQclM+yd0wp9Tvy7LaXG4vg8LgXNMmPLaNGv
         XBsQ==
X-Gm-Message-State: AOJu0YweI9AYgYb5CGZUdHEmzZ3yyygZzlbKbHpSVvChfikgCnYMMotu
	xJh6Uc1sVGpbN2C1GocJe5li2aYEwm23PSuTESqlWhm6NOMMeUHObHR4ksu9eKbKnlD+Q5xz9fM
	vk3trS+raQCPQ6VF2W/xeT+sVumTqRPk=
X-Gm-Gg: Acq92OFrRZhN8Khglcnwsxu0wWcuPiUm41HMGK4VPaemJeIOB7X1FJpxDN1cIioUFgK
	vig7QmlXSakFlaPSfBiemA05xIizYggYND0chMbPRxNW6B4JQgyVSm4kVKzcHsvySZBC8ETwBzr
	mBS2oYfr+WH71EnrVGKbiqgePEeVs54ufxR7PYRikh7xIXE5c6Odje2WRt7V79PQ+2u6UhjICzM
	yoE2x4FvkbLxwwwfX+CUHUvahb43PGs/O2i3EHmSmDdo9nkwk6ElEwZkVY3knnPOJYDaDp/8/kz
	ZlaK+fuqugHyw/n6WMhvyW0VxO/z+yqV/L7K7Q==
X-Received: by 2002:a05:6870:440d:b0:42c:127b:a973 with SMTP id
 586e51a60fabf-43a2d8f308cmr6097007fac.7.1778963741602; Sat, 16 May 2026
 13:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260516050858.23858-1-devnexen@gmail.com> <20260516050858.23858-2-devnexen@gmail.com>
In-Reply-To: <20260516050858.23858-2-devnexen@gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Sat, 16 May 2026 21:35:29 +0100
X-Gm-Features: AVHnY4LUIoOncuwcab_LTMexQNoMCkZUK0QYYQEBIYnfrnDkO_0bRquj4-gjFnw
Message-ID: <CA+XhMqwo3KqfhPPjU25GPVD5o+c=yKByr_Yqo6AL291mn=5APA@mail.gmail.com>
Subject: Re: [RFC net-next 1/1] net: tpmr: add Two-Port MAC Relay driver
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev, razor@blackwall.org, andrew@lunn.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Ah, you already have it here. I still think this can be optimized.

  Fair =E2=80=94 the helper still memcmp's five bytes for every multicast f=
rame,
  even plain IPv6 ND or IPv4 mcast. I'll fold the check into the caller
  with unlikely(), and gate the inner test on the 01:80:c2:00:00 OUI so
  ordinary multicast falls through with a single compare.

  > This seems to assume that tpmr->ports[0] is filled first.

  You're right, that's broken =E2=80=94 after a detach, ports[0].slot is st=
ale.
  I'll iterate ports[] to find the surviving member instead of trusting
  positional order. The del path is already slot-agnostic.

  > Maybe you also want to act on NETDEV_PRECHANGEMTU and reject it?

  Good catch, nothing stops a member MTU change from desyncing the pair
  today. I'll reject in NETDEV_PRECHANGEMTU.

  > Driver version is meaningless

  Will drop.

  > I also wounder if this is the correct home

  I went back and forth on that. Landed on drivers/net/ because TPMR is
  structurally closer to veth/macvlan/bonding than to bridge or
  openvswitch =E2=80=94 no FDB, no port state, ~400 LOC. Happy to move it i=
f
  you'd prefer net/tpmr/, but my preference is to keep it here.

  Thanks for the review.

Cheers.
