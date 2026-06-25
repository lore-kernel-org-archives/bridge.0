Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C19F37DAC0
	for <bridge@lists.linux.dev>; Thu, 25 Jun 2026 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782399015; cv=pass; b=uDPro6aqXsdSLX1IQwgHRvZyrLhYCrU+dcKmd7YgVY6JoT5xfhzbgK8kByukrZltzPN/5xTrjkQXVZftaqW1XHOb3IWzSi9bUc/RDe0W6zHHOUFe49G/ai4mozROQQOgheWhCu3BWPsxOzC2fsiJhejwIgl4DiwkUWdZblfRLiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782399015; c=relaxed/simple;
	bh=GI5tVeQv87M6l+52amLkQdtG+5A4bT1WM7+cRRv8Tow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCxOtyJgpSU+6NLI/AgVMEMGgobopJHPQSOibo7RN7PTj3LDaNb9uRjtU1ECndT6ngi4JJIab9BOlQx+/eoJL4+u/mzdv2MB2UyGWznza1hxLp6Dkdp+L8HSdRyBWSKd1aIf8/ba/4lfxmBWgKhddxxzt8a+mdo+LsUmt5pAVc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3qNwKMH; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3qNwKMH"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c07c67ad9f2so256347966b.0
        for <bridge@lists.linux.dev>; Thu, 25 Jun 2026 07:50:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782399013; cv=none;
        d=google.com; s=arc-20260327;
        b=TKiX89UdBt7+3bgur85eNz1uLu5BAVBzcGE3v0KGgEH/NJTuGwsch00Vou39NWKXId
         JuaMtwuH4mHmmrY2CYykGDAbHyiMBsh6gDWLjZCGH4giAAs8U+7fxUtHVM/DQkm4Rc8y
         6hjvL2B1pC5lUlLC2Sx/2S3uBN6XTJSDkpQ33mlo15W/XdKfSwKt3XMGdxig2DRkdNAn
         XoqtTszmNq9iZSBoq3CdJKrRUHz/Q8++c0QtGFU5tHB5Yf4kFf4HqY7No3udYE0htSo7
         qTFnd9NGjOTN5xW9uA6x7NFPEUDrT+GtEC+ykZZnpR7zgLjP9KvcxDO/cS4XdOHRDkmM
         amQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GI5tVeQv87M6l+52amLkQdtG+5A4bT1WM7+cRRv8Tow=;
        fh=zDD4Q2P54NUnkZWtkdCxPovE7KPzhUYgVIiVjKWFaro=;
        b=QjNKQf22cXMwBLZgDssLtqNF5wYh5mMcmtG2J012BEOHPc5URvxeHLch8Lg/1RRj2A
         1hA9+0d6FsbQVtivzy02OBud/OwydROBKH8M+wSDHXrzsZjiAUETWi5SAsgv5t5Gu6a8
         2/ad2NhXotiGoLo7z8f+XFbTNp3ZpcqRoraiwbNxY5X/OtTKSTxaq7TuBwq/3PJTjqXg
         yJk4VjgpsZcIsvhsNDq/zlOaCecg0Wl7UDD9TRZeCyZBhbpPWG2YLw/tWBQubSft8LSe
         nJRuNDEZUaNMAWZD2Rt1ph/Uxu6Alz80cmah2ha2tWOB1v1C/FUWHBDKZyiWUr0odFx8
         H+8w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782399013; x=1783003813; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GI5tVeQv87M6l+52amLkQdtG+5A4bT1WM7+cRRv8Tow=;
        b=J3qNwKMHWvMTUvVGL3aslP4UYjKvU0rEYJE5PCrYYNxmQVe+Y4nU6US4VJWzRXig3q
         DSMGQu7Vx6beMjy3c0d5wdThdSuchtOqd0m9Loy8aH72bRh0OEd45nCxj8KlWJ8/WkYu
         Wfq8Gx6a93JGeSU93qZ2x4kidm5RPcbQtcZonA56U2+nIFojfmMNYj3G05doi7kPgHf1
         z5E66Vl1+2spPsOKEr+XMiYwOpUYIHvMQl458Kzkr6izu4/gcjm+MhobdRYNTfej5UPC
         w1Twgx2gfGQ2l/MXGJn10ehzdT6n4HVg8VK339xKmu8DX6S1CNNZcMNddEe2kcD+9Q4b
         8MAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782399013; x=1783003813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GI5tVeQv87M6l+52amLkQdtG+5A4bT1WM7+cRRv8Tow=;
        b=P2+cZRVBP3/eXxpIzwgsOozkg5q4fz0deMIDfb3Cy08JT363VyOHOJZYQ8Co79BmSN
         TApE0e8d8gJ+isu3dX9O0H4efXT71/kr2/+JCZ7t1BQAtXnMmu74OWez0oieG2Wf0Bj5
         mE4wBTEUXENWP24+eF0kE0GzX/YpQipWzvEaPb/LWwhRbaVq4VWuW6VXNq0xBo6bikkw
         SEAS3aU9UEJbN6SzV+lwpSlJJ1om9okiZv6Rpa1p++JOoSj3vNg2bVta/VyOWHqj+1fT
         u3zlZ/ltBesDrdbyGayL4KubFmnPLwPk3ky+2kyqrfHsWiDLOV+2OYK/Axp8mUSxvgSu
         mErQ==
X-Forwarded-Encrypted: i=1; AHgh+RpgVUCMLgu5RCQk+L0NFE1s1XlSEUJZejukiMCFGCz2vyQA8F4+cQkfRPZshHdVDP+zNmFXd2Y=@lists.linux.dev
X-Gm-Message-State: AOJu0YwVCAZSy/NgGVS0bgGaM+rEn1WHLBLQ1aIhxOqIyqra0GAA/ofk
	/1FuOEm+Tiv8vvLj0SMfjFuagrFcorJOdgJag+TSXuw/dhOf1F3Js84uo0r7IyunpNwY1SLTNuX
	S/zIbW4DVJlgkQdcmtFXeGoGUE36VC6k=
X-Gm-Gg: AfdE7cm2CR0lDQbj6aqySEzZ7mexKQbtVlbcNYB8KQ2R7oyTL2hd3RNPCtFct8BY46j
	lH5mb5DNaEfhEHCb9dZxbWPEzsgycKgVTXiDLNzsumuIxDmefVxjHUn9LZFmmR35PQhjoeJEsOS
	JMdEDk6XUKnwzezJlsXbT4A0P1F+op/SxsN0G9yVe52K2w0W1E4f3byrFgOLhacdModYoKEhCvB
	yky8alA7poaYljyjMnRWFfv0FWCRqYiysvqMTaAnUlp8sFMJRcrzTzsEzVS1Z+uxh2xF/U=
X-Received: by 2002:a17:907:8b95:b0:c12:8a:7d7b with SMTP id
 a640c23a62f3a-c12008a8cc1mr211733066b.1.1782399012826; Thu, 25 Jun 2026
 07:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAE2MWknz4X_gcNo6jkR87Lg8F0zfubkOc4Ujr57CS3aBMWrjEA@mail.gmail.com>
 <20260625054005.0016.bridge-mcast@kernel.org>
In-Reply-To: <20260625054005.0016.bridge-mcast@kernel.org>
From: Ujjal Roy <royujjal@gmail.com>
Date: Thu, 25 Jun 2026 20:20:00 +0530
X-Gm-Features: AVVi8CcTT3l_BpCVPjAw-OuIdN6h756FNAzVYw4MZY-iVizeSs0vzY6v--L1Ouo
Message-ID: <CAE2MWkn=azz3gUKGBYc1jjvVnLxDHuHk9M7wAJHdAW8v=dP5GA@mail.gmail.com>
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to stable kernels
To: Sasha Levin <sashal@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, stable@vger.kernel.org, 
	Greg KH <greg@kroah.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev, Kernel <netdev@vger.kernel.org>, 
	Kernel <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 4:12=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> > Please backport the 5-patch bridge multicast exponential field
> > encoding series (726fa7da2d8c, 12cfb4ecc471, 95bfd196f0dc,
> > e51560f4220a, 529dbe762de0) to the stable kernels.
>
> I tried, but it doesn't apply to 7.1. Could you provide a backport please=
?
>
> --
> Thanks,
> Sasha

I will create patches on top of 7.1. But tell me what about all other
stable releases? I have to create patches to all stables and how to
share the patches to you? Via this email or any other process? I am a
fresh on backporting my changes to all stables.
