Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FE4391851
	for <bridge@lists.linux.dev>; Mon, 27 Jul 2026 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785153461; cv=pass; b=PKVGSixlIM92xJvg8Fj6gaH9/O93qNb1sGFbxeIpm+P1Zwp0v4XtkpglV+vIP7kUcMl0PP2uWkkTRaA5g9ZPV1Izm1RA5HnHIGzr7D/dIMczM+ysHwppW7gjJkZPIoh58KeTDdXsgnoxTFOBMp5+hTyTz22cJaZQhCE9ZBhdnF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785153461; c=relaxed/simple;
	bh=2k5B3idJmT6bC8h+ilrKx0XVLWjKGNXuCUQ2oqNbk3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S881Q98/JmrfvMUiPOuSXWM6EaBfxbZpxgPk+cmdsRlkc8peMpXlI42M1bNha+3TWqeHbnI9J1EllpGq0asues7BUPzq8oFv/kausW8XLZME0Na+aTTLAPctUbs98Mjt/i+N6a1dCmatem8JqQQMry4RtOgaMNZDxzjLTC8py6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPcv/GZD; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPcv/GZD"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1c4c7ddaf6so375681966b.3
        for <bridge@lists.linux.dev>; Mon, 27 Jul 2026 04:57:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785153458; cv=none;
        d=google.com; s=arc-20260327;
        b=WnPqB4SwWtOM1NGhwKc+NDk9KnQuVM9210t1qBpFdyohnYx7h64/Pn99vznd873lZ/
         vVo7BkB2V6xq0plUr8Mr/ErHxSG/cD/xJavgcX1LcA2+e2ouPKwul7cZ3UKTLLaeN/bG
         JmFFAqQ0EmHI/ZDlgQPItefa6p53de/qKKN07Y9Sb9eke1Kupm2RySaok7bdl+cJZ9FC
         8PoyXfAXVZdouKYv263fhWoVtKyDhAkAX3CaxIrDjo4w6voWpmDZc/L0R+gCLssrN2Ak
         FGPhpaqRUPdjmmGptN0uyiw7SQvO4GMl+bLUpSJT9imAWGrXW8zJGJWfaDR57C0pCYet
         smnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2k5B3idJmT6bC8h+ilrKx0XVLWjKGNXuCUQ2oqNbk3I=;
        fh=FnkVSF8Duae++b7DdbENNiGtkYa6zjqwlQX1+FXatiI=;
        b=kxvDwbbHZLvmq5YLKy8gP2J7cZ7VMYuRvgLIeyMw2sCS1nU+fI1PiFIYFHBV7T96Wz
         IV008ZT05h2Lspe8B1+sCVmiEqwy6g2bkIcPtqlt/wxGIi6bapT2J79sA7ME5yOYMg/9
         c/PDNLsBWNLmZanXqUgDaZD25asVG/8+PDj2k2o3/i4skoQXLIYwuw6lxr+67oNvIZ2y
         KfmaYBiAIfyKMTJ9Z2jcJUgmsADR/AUpCtUdcVzvV31k9rykEyf1hunxpZWSkQvLz0va
         P1KuNhFuBqViyIS+AcdSMfG8MlB7dcTc8XvqXVRsrwuqo2k7wivc5d6oghO/HrAGL0rz
         8dGw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785153458; x=1785758258; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2k5B3idJmT6bC8h+ilrKx0XVLWjKGNXuCUQ2oqNbk3I=;
        b=PPcv/GZDbiGecsxq0ayNjyR3RLOAajoCuZLVY2WShyDQe91cmZ04anyL5kUBppHV61
         ptUJVoZr7dbg+McTHQG2Ejl2+iYFKLfOizCzRDUAkQ/0jRUMbVyRHt9G891RLlUDWLWk
         GncFUM+MFGGFON6vkNyidBHoxBXeu5zaFiDnJYZmZgUdB5r2Suu66lQnE8JIURUrwGF8
         36GArtihOVFKjmtpfLMvZ5X+CNtViC3LKEdDSJkU8zrc4eCYsbSPP36ZhfY24aq4f1GQ
         IXDtGUs4AqmNrWws3LdDlL79X7CqNJKWlqYOAWQpeuf3h9ZT+fcKI2wgvsshc8TL128V
         V2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785153458; x=1785758258;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2k5B3idJmT6bC8h+ilrKx0XVLWjKGNXuCUQ2oqNbk3I=;
        b=gTd4B40JwkOlKSErZY8x1BS1c8vrDrbN91AGmoHoAGUdcAHaLC1aqR4Wb1NYEk7pYH
         kOjsOt5yQIDyzt4NUCJV4TDsofX+SIfWibNldOQms7ffG65SR9VIfEVR45pX4KfgPxG8
         HxWU7yV7sA8+x9i73k5Hp7b2BelwORsXYnWaNUdGE1YfRbwNrUdVuPjzPNAeqwsmi3sA
         ZypnNS6Nkl902BssltuY9gw41f+5VM30sxWa4LnTjowyEEGuWNP8Qsmjl4aiB4SUeZNp
         xE6C6yjY/5H4eJpe4Yo6Rd2baTMWMyk9L6JEppsTqs/keInpclZKtlAUKWaAMx2JBbnW
         dYdg==
X-Forwarded-Encrypted: i=1; AHgh+RqLOv6p7fyXOxTaZ6jctiq3ovAsyoxhOIso+eaU9PPGSx/OuexIgnFfZ2h5LRjOiWSHBt5bFcw=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5MT6+ygK0QTXSlk+Fsyd9906rJ1VMGmBYWBLYsex7zmPWiGxM
	wABzmDfvV/bYeChp3rinU8V3B1RYY2l/MjK90Va86S2tldS34zAX9tB/CmH2Lmdj2Vju5Mbb7/g
	QQv45dEE0YveRHC8Qi/PrZTHIiPS4bEY=
X-Gm-Gg: AR+sD12LtAmXwN5ub513C8fGcM5gvq20LOxZQMYytfemjqXohs4dcjFxMAspmW/sVB3
	2HitPyOrwV/ZxY+to78b6Bj1akat999kpfW3FI6vBMa33gLY3riqpVvV5N8bgZuTXAkDMDFUU8C
	851xaeN2huEpnuCRYPQED98kfKgqbP5WAm5vfl/Bpq7mHGGGUE+CKtmrmAOEFR9DoH6LCVZQZXN
	AbqBCk3j4d6+cHpWvlbLr/vouqt3vYypDu0Lnp7ZEqB0UROdnbb/Cu5uxdW
X-Received: by 2002:a17:907:d641:b0:c15:ca27:5818 with SMTP id
 a640c23a62f3a-c1f1eeaa320mr395955766b.28.1785153458189; Mon, 27 Jul 2026
 04:57:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <2026070925-delay-gauntlet-bc7c@gregkh> <CAE2MWk=mm8_bkd54Gv1mdox6rfvx85Dd3AjOCxPz0fPAfyuWYA@mail.gmail.com>
 <2026070954-activist-left-8303@gregkh> <CAE2MWkmcQdhGp3LTMtpgAse3AFcfKcAcpQe89+iijfP5e0w_QQ@mail.gmail.com>
 <2026070948-lively-exchange-a458@gregkh> <CAE2MWkn3L7V3x8i0F-soGLxsBBo_Umgs1pJ3FwCw1OW7=U55zg@mail.gmail.com>
 <14350a31-ffc7-41fd-84d3-6cfb2cb96841@lunn.ch> <CAE2MWknt86W6yCtuS_RupiuwiDqXT8wZqENM2DjiW1R=eY8qdg@mail.gmail.com>
 <797773e2-b155-451b-ae97-e8a005fd2d86@lunn.ch> <CAE2MWkmbdDrCw1HUKm17QG7dyihuxg_1VGTUNeBq9v8NVwJV3Q@mail.gmail.com>
 <20260719082223.GA1899043@shredder>
In-Reply-To: <20260719082223.GA1899043@shredder>
From: Ujjal Roy <royujjal@gmail.com>
Date: Mon, 27 Jul 2026 17:27:22 +0530
X-Gm-Features: AUfX_myN8vMPcj0vJcxFKIYLNoX74G7CTQydU2TzsiEAmJ7bTFLP5Hg7T5Y7VYE
Message-ID: <CAE2MWkmE3N6q=_bOv7AaMFS15+SizkzVQV-SCMumc-D1rWcv3A@mail.gmail.com>
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to 6.1.y/6.6.y/6.12.y/6.18.y/7.0.y
To: Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Greg KH <gregkh@linuxfoundation.org>, 
	Linux Stable <stable@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, David Ahern <dsahern@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, Yong Wang <yongwang@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> We asked to target these patches at net-next because they don't fix a
> regression (the encoding never worked correctly), so they are not
> relevant for stable. Users that require this functionality should
> upgrade to a new kernel that contains the patches.
>
Hmm, understood!

> Regarding the stable-specific patch, in my experience, stable
> maintainers don't accept such patches and prefer to backport patches
> from upstream, even if it results in more changes.

Then I feel we can skip the changes for stable now. Hi Greg, skip this
thread and the changes from it. Will be in touch!
