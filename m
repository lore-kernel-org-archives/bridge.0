Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0B91799F
	for <bridge@lists.linux.dev>; Wed, 30 Oct 2024 01:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252064; cv=none; b=rqeAxItPQKfigi5+8POKs4XKUHzf/9nDAfHkw9D2ehrtgJA5vnkCF/VUmr+SMFVehQ57CkzXO+ZHokEOYVnCldtFK2pcc0dfelX0VqKl3e6H9xmXV0S2E2fSa5RrbovacvtUZ+iEObw2MZlsZkWJp3lWaIcEqz3neEYa+Mn3G8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252064; c=relaxed/simple;
	bh=Yp66zOjBTkqdw1eyRFLXESGFpMB8EYkX1+UgnwBfc1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWjex5CQ4inD5C1APjoXWlZPTTQw2OW1qQQTlehfzP1WhcdW3ayisrQ8P6Bh9wEVKxPg61zjUuL4+O1+myaIzFSRF+WNR+TsfAxIICnS316t90Ar1IbSZ0xs+KUACWwPxQvd/eB5vTDS/axKKx79K6dn5OWd21QkkvwCsV4vKTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoEZYLuZ; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoEZYLuZ"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-6e5a5a59094so53338197b3.3
        for <bridge@lists.linux.dev>; Tue, 29 Oct 2024 18:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730252061; x=1730856861; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h//5h0dIiAWAEjEnhgHy2Bo5TCA+6MH9QdtoE5g4NIQ=;
        b=KoEZYLuZG4Zielc1wzpOzbxejYYBR9AzWcIZ/f2P9fMiXmMqOLm+RHg4nV3YiYJqHR
         BAB/jyp2l2N3/Lhs1UGpieDCJU98lFdU/1Aktp6tCgmFdCAqRDpiAFe3jtrRIv234uFU
         cShn3qbtk7loGGvYXlgIE8Jj5n0kqed6NVNrYXQnwEnJ7/spoOe5i3KH9dD/LE0wJ3HQ
         h+sm8l0iVfJqI/Pc3Lk8gkjMhXkQcxOTyXhICL6e38eYepEdoaRSHLiTrdOs+Ch3WJV4
         ToPv2aaLtbr9rEN8zPnozgbfSvLjGjrrl/QDSh7sevP7T8QzVCvrMeGHgR7UcgY74KRX
         hm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730252061; x=1730856861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h//5h0dIiAWAEjEnhgHy2Bo5TCA+6MH9QdtoE5g4NIQ=;
        b=GLMMmp1r9zSetf+99djtec8FSho8L5avY8ccEy15Mp9ZReF4Za6HLWMQmJECFbh9hw
         MiEdFs9aVbkUmqJTt/1yiqjKXwZV10dJFXZ3XTVTvuwUgcZGHkIxvTvhZDAlsKw/bsiM
         rwVeYUPOqWA0+BM0oLXfEajHQJP6zykOp5zypMkqqBJ58jeEMR6UlYUzUVYqDSNFurD4
         m2rjaMUbiSEF6znvWdvzsebHBlePF8VYIzPJx++NOPWH4rDMHoemgRrB+pQVLtvRcAjb
         Aax8LzKCHB/0lY3ydQsZhIfIZ5QDeLEmQjz2ZzD/BsyLeGdPmz1mQBzKDlQj9VIS9S2e
         VLdg==
X-Forwarded-Encrypted: i=1; AJvYcCX1O99xLNiF4dmIf/u9b82O8cegI49mIY3G3PSjKlVRi6/9jmDPoP0Ec9aiU+RrSHQx09tV3UA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5h3bmE7IysocRba8DpdXTVUc4BSg7Zbwg81n358cO2yDwCd6u
	syLcUwFJevx+YD2Vx62I+jn8biQ0MlHO9aDftF0ENKF54DvqJzks9BZwmU1BB+KdUBQPZcpuBMs
	zxkGZHiCos8u0mbeke7kD+oWO1uk=
X-Google-Smtp-Source: AGHT+IGmt0v/jSWrgx/76rpboLxL9IobAr7TI03JuBHGd40YJIScAQ5UnmQr1bHYch2Zxftv5X/RAJg5pl62ieHQRyE=
X-Received: by 2002:a05:690c:39d:b0:6ea:3313:fa1b with SMTP id
 00721157ae682-6ea3313fc65mr28460797b3.46.1730252061300; Tue, 29 Oct 2024
 18:34:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241024093348.353245-1-dongml2@chinatelecom.cn> <20241029170341.1b351225@kernel.org>
In-Reply-To: <20241029170341.1b351225@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 30 Oct 2024 09:35:24 +0800
Message-ID: <CADxym3bUKBuMkaG3NiQHavkgScLxRAgkSSmk-KbuYpMepSYDzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/9] net: ip: add drop reasons to input route
To: Jakub Kicinski <kuba@kernel.org>
Cc: pabeni@redhat.com, davem@davemloft.net, edumazet@google.com, 
	dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org, 
	roopa@nvidia.com, razor@blackwall.org, gnault@redhat.com, 
	bigeasy@linutronix.de, idosch@nvidia.com, ast@kernel.org, 
	dongml2@chinatelecom.cn, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	bridge@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 8:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 24 Oct 2024 17:33:39 +0800 Menglong Dong wrote:
> > In this series, we mainly add some skb drop reasons to the input path o=
f
> > ip routing, and we make the following functions return drop reasons:
> >
> >   fib_validate_source()
> >   ip_route_input_mc()
> >   ip_mc_validate_source()
> >   ip_route_input_slow()
> >   ip_route_input_rcu()
> >   ip_route_input_noref()
> >   ip_route_input()
> >   ip_mkroute_input()
> >   __mkroute_input()
> >   ip_route_use_hint()
> >
> > And following new skb drop reasons are added:
> >
> >   SKB_DROP_REASON_IP_LOCAL_SOURCE
> >   SKB_DROP_REASON_IP_INVALID_SOURCE
> >   SKB_DROP_REASON_IP_LOCALNET
> >   SKB_DROP_REASON_IP_INVALID_DEST
>
> We're "a bit" behind on patches after my vacation, so no real review
> here, but please repost with net-next in the subject. The test
> automation trusts the tree designation and bpf-next is no longer
> based on net-next. So this doesn't apply.

I was wondering how the conflict, which was checked by bpf-ci,
happened, as there was no conflict between this series and
net-next. And now I see, I just tagged a wrong branch for this
series. Sorry about that, and I'll resend it to the right branch.

Thanks!
Menglong Dong


> --
> pw-bot: cr
