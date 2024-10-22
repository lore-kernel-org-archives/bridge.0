Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41A5156231
	for <bridge@lists.linux.dev>; Tue, 22 Oct 2024 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729586934; cv=none; b=kfiPmHXAnTDkxYIVf0XwDcrUe1qzlzhfCRYnm9chTJNMfJLu/ojscQ0Lo65nyltscuKDLh6baoj02jP5QAMD01VNnrbnH55yR9qqdRNufxLsGmGP3iAg8maaOP93oSzWZpHmiEZdawitT/B2YYPrUF/RUMnW5Jq+tt9XPwy/isM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729586934; c=relaxed/simple;
	bh=BrXgG3mZIvjp5VteprPhQXe2uhCHZoadbc1SbaYA3JE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5PxKQXMrBwvrEM2ppwNbsLsD0dUx4Sz/UxGpmPODIlaA3SOOmrDvXARORSIuoqshlyVmXO0gkltZg5YjnAy67f3YvpKOOMnGxjILipuN1LwOU84oa6pa6pcypT/dAmSxyv8IRKlvfVLPY62uNmD4qAuSYo7OC1bsP7W3JqWjXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUUxKvMd; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUUxKvMd"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-6e2e508bd28so40751397b3.2
        for <bridge@lists.linux.dev>; Tue, 22 Oct 2024 01:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729586932; x=1730191732; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rdf6iyxgoydO05+DI1ZE9WtsllUDQOZhnJERRHa/4XU=;
        b=MUUxKvMd1cBi4721WqiBCOi/8IYtQI+0jiE4paxR18LVYylw5Uy5zPYbKhbgos8hWz
         +KEVwTFTuQt9ZxN9ChAxPt0eqOZwklGSlRxZXTiPzuaYhKudc5ylL6PXwgbA6jgrkc5D
         Judac1j1vcxFXDQRC29Pd3VsV5oIduCO1G8PWPNedU1Ayj82IFM1kfsRIDWJC46zGCOE
         U5bI39Eb+Z1NC1L2l2tcL5woyyPuPOUzH8dg3S5g8iDg6pABwp7G1cCyXy3QOitLX2M5
         eexr1GbI4rlQY7arfjoq1fGCrhWXt6y+z5H7JJzbK50snC6xpXj6ganAVRQYRvY7iEtL
         lcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729586932; x=1730191732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rdf6iyxgoydO05+DI1ZE9WtsllUDQOZhnJERRHa/4XU=;
        b=SCUCmEysCZEPEjLzi1qOQU//qalRuvqj3qb0taoVoAVze1g/8dUewL4hjDRPDTcE6p
         n83+CTwQM+TC5U5h+ASOGfmeG8U9U2YSL6lD+uFK08LMIN05t/+TW3uKvtxLa/ZRV7Oh
         5P5Oo7ngT3zdD9w12dlJtCj/SMt7vawJ1SlePvkynyK2O+OOYt9WqC1VFk00GjMil7ee
         sHTDSzzZFStMq2TPRAFO+b76xLdMWrI+pBwutI3xR6eTR/LY6sLWeN6VvIhffs7yA0KU
         xLd5JQTpAI/m/pH+qOqHtOR34QYvxNDmXydE9Izp8saADRrlIXmLsFX5/2cqqAbhCeV2
         H3tw==
X-Forwarded-Encrypted: i=1; AJvYcCUj/V6Zk9H3HA3txqjb8bCacncIIewRt/v+hh7tJbe78RU8thtSFH/OE82srUyt9+HInsuaYZI=@lists.linux.dev
X-Gm-Message-State: AOJu0YwkDB6UYKWVI1yT4binOro4/rbOdK78zO3MJcwHr1z152hJdf3S
	9zbDO/j7UIVlity07N6ng3RdIhUWWqNAChorwVUYGB6KZHTgl14rEAq2LIzTlA+vBFy9h9+BOgZ
	osmtQwiw20zG6Y3iYMMhbeMlTKM4=
X-Google-Smtp-Source: AGHT+IHPESBrda0KhCPYYllg4/MfLv0BjYbIDe6VspItnYGPEClLzmjPWeiQXptBhW3wuVXNgYoCrmc2BBLEkUbKEUE=
X-Received: by 2002:a05:690c:f91:b0:6de:c0e:20ef with SMTP id
 00721157ae682-6e5bfbdbe14mr128141717b3.7.1729586931792; Tue, 22 Oct 2024
 01:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241015140800.159466-1-dongml2@chinatelecom.cn>
 <20241015140800.159466-8-dongml2@chinatelecom.cn> <c6e8f053-32bb-4ebd-871b-af416d0b0531@redhat.com>
 <f792a828-8a61-4a14-bef8-ff318b5a4ac3@redhat.com>
In-Reply-To: <f792a828-8a61-4a14-bef8-ff318b5a4ac3@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 22 Oct 2024 16:49:47 +0800
Message-ID: <CADxym3b7r-YJ5x==A0wLO1Yuz1dp4E7uMjEzB5EbqfN+eoR3+A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 07/10] net: ip: make ip_route_input_noref()
 return drop reasons
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org, 
	roopa@nvidia.com, razor@blackwall.org, gnault@redhat.com, 
	bigeasy@linutronix.de, idosch@nvidia.com, ast@kernel.org, 
	dongml2@chinatelecom.cn, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	bridge@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 6:49=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
>
>
> On 10/21/24 12:44, Paolo Abeni wrote:
> > On 10/15/24 16:07, Menglong Dong wrote:
> >> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> >> index e0ca24a58810..a4652f2a103a 100644
> >> --- a/net/core/lwt_bpf.c
> >> +++ b/net/core/lwt_bpf.c
> >> @@ -98,6 +98,7 @@ static int bpf_lwt_input_reroute(struct sk_buff *skb=
)
> >>              skb_dst_drop(skb);
> >>              err =3D ip_route_input_noref(skb, iph->daddr, iph->saddr,
> >>                                         ip4h_dscp(iph), dev);
> >> +            err =3D err ? -EINVAL : 0;
> >
> > Please introduce and use a drop_reason variable here instead of 'err',
> > to make it clear the type conversion.
>
> Or even better, collapse the 2 statements:
>
>                 err =3D ip_route_input_noref(skb, iph->daddr, iph->saddr,
>                                    ip4h_dscp(iph), dev) ? -EINVAL : 0;
>
> There are other places which could use a similar changes.
>

Yeah, it makes things much more clear.

Thanks!
Menglong Dong

> Thanks,
>
> Paolo
>
