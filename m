Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7629207653
	for <bridge@lists.linux.dev>; Thu, 13 Feb 2025 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739435894; cv=none; b=KxHIdn4W9ObxekaoDcwwqAnnCITPeRtdCGslQFzlIFiYS8UrFq7nr0N1qxCCT3PsXc2IEBH2Njsa4vqZ0cvoAz4rdD34a/Qxsq5OIHCxrhAbsk5ytws/nSau3ApwOejMZVqNm9nexKWohUiIsTrk4tMJqj02ZNX90ZSNzNyghUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739435894; c=relaxed/simple;
	bh=V6goxLXN+yG7yW8tdELZQRKGodN4+Plo7TAYWn7z2WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7jO1jE+QnUDuiuGYW6g3aRdhpX9M1PA7lrDbtnpxgAeVhp7eLSVyTIf537d7wJR4WKA6F/MAhwKm7eH8N/1K6/odb3sm6kMXQZLmhebhyq++Pmi5UNkAN4Gyx4y5iqXjAGkGs7qY2k2BSsVHMxX5n5JFaDXrK5F8lZApiGScNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1ncec+w; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1ncec+w"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38dd0dc21b2so248027f8f.2
        for <bridge@lists.linux.dev>; Thu, 13 Feb 2025 00:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739435891; x=1740040691; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N497oJdjUhCNRwjALBc63pGnF5BIugJi+C5NT1OFjnk=;
        b=D1ncec+w8oy6bNpxHfLL00DutcNVNPxBSO8zTVq2vhD0tbLkLun4zSWDaNW0Iv7JAp
         SZXjg+LRGhbrzsyiCMDs3+VaSzw1vCjSmKmodFx6SrnfQN7XHRsQ13TCKExkG+rQaMU5
         iPgNuqCRCJXcX9bM2vp0PKIhge7Tf5jmKQaj4iy3BurOA/wYLfS6j5tyZTsXamP5E12E
         QjYY2275Eg8JIYwxql5hOGepeA1SQvW9A8xwQtgBE1sl0okASnybFuXWWEjBLhk4yWvd
         +woY+vccmYTE/GVEl9OU78n14XJlo/5YuhKIlWqQfu6DLoMFWuzZKzWXWNd2JBAiBRCc
         M1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739435891; x=1740040691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N497oJdjUhCNRwjALBc63pGnF5BIugJi+C5NT1OFjnk=;
        b=GCOZG46DFW57IE8xu1PMZw9+LCNbLSQKppLh4PRs/BFOG2Tiv1ylHRQfbNa4H4jlwu
         fjb94dRCsdA7lzgBkK7cNhvi1hr5l4U/3lUb4cL5/W2vT1sWwX+VNnq3LyDy6YRA1tTq
         k5K9ufStE6z0CaLk5tssK03FDtgf6yvSO9Kmui3EdXBACunrgIlXjipf53TyS0njTebY
         Evmydpdu2SlX2zLHAtcA5dYJP1GmH0Yn0VVvOdNBLBnIhmXKOuLuceRL5d6SzosmAwT4
         icUJneOGqRNv6X+uE7WLIw6VS0tpwuDmSwc7toNJUQyrpy7dMh+Yn7lU7bpQAAAXGH0v
         iPVA==
X-Forwarded-Encrypted: i=1; AJvYcCVHCgmH2j2xl4zKlDw9dK9FTR3IwpL9njVvlsZTUSNJdwQB0/KKgm1+t+KWNo0q9EHF8hSsAjE=@lists.linux.dev
X-Gm-Message-State: AOJu0YztTdw5awBhBe09Jb4uFWMOTPyEFh9NQKANNNJnjGOqg+gXwSjk
	wlFebLltxR1LH2u6JL1mmkrogkbByM/JUElosJbw5xh2BrFscczYq7sfVJ8Ts2b33QKbNtSQdZ1
	kAw8L+WvCv3Q3RDHiB7aSH+mV49E=
X-Gm-Gg: ASbGncsPeTYSaUzQ5/pxZbuLxZFE+Ew8Bm3G+qn1saHE+4hJN/pRQF8AwJnIwERIk8D
	9QPOT3NloOfPorbRjXzDlQeDktGHFOU2X5ewZvMcmevxZBVTxiI+tWMMp1gZRcQmrdowk/W0=
X-Google-Smtp-Source: AGHT+IGWOHKGGlDa4+BOJnu+aApZc9NQsBvpdTnebLsDtomfgfUQKAEsY8KxAxXyKMsTrm9S+vIZHhG3h4B48IT9F4E=
X-Received: by 2002:a5d:47a1:0:b0:38d:d299:7098 with SMTP id
 ffacd0b85a97d-38f244d4b2fmr2390520f8f.10.1739435890988; Thu, 13 Feb 2025
 00:38:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250210133002.883422-7-shaw.leon@gmail.com> <20250213070533.9926-1-kuniyu@amazon.com>
In-Reply-To: <20250213070533.9926-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 13 Feb 2025 16:37:34 +0800
X-Gm-Features: AWEUYZmLH4fO7VI_1h6eRsVKRwr1I73htkPFG-ZDVD1uQ9yC1n8P3g2_7anIJyE
Message-ID: <CABAhCOT8sCV4RgBWwfYjCw2xoZbdiYG8yuWReigx-u5DibTaiA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 06/11] net: ipv6: Use link netns in newlink()
 of rtnl_link_ops
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alex.aring@gmail.com, andrew+netdev@lunn.ch, 
	b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org, bridge@lists.linux.dev, 
	davem@davemloft.net, donald.hunter@gmail.com, dsahern@kernel.org, 
	edumazet@google.com, herbert@gondor.apana.org.au, horms@kernel.org, 
	kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-ppp@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	osmocom-net-gprs@lists.osmocom.org, pabeni@redhat.com, shuah@kernel.org, 
	stefan@datenfreihafen.org, steffen.klassert@secunet.com, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 3:05=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
[...]
> > diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> > index 863852abe8ea..108600dc716f 100644
> > --- a/net/ipv6/ip6_gre.c
> > +++ b/net/ipv6/ip6_gre.c
> > @@ -1498,7 +1498,8 @@ static int ip6gre_tunnel_init_common(struct net_d=
evice *dev)
> >       tunnel =3D netdev_priv(dev);
> >
> >       tunnel->dev =3D dev;
> > -     tunnel->net =3D dev_net(dev);
> > +     if (!tunnel->net)
> > +             tunnel->net =3D dev_net(dev);
>
> Same question as patch 5 for here and other parts.
> Do we need this check and assignment ?
>
> ip6gre_newlink_common
> -> nt->net =3D dev_net(dev)
> -> register_netdevice
>   -> ndo_init / ip6gre_tunnel_init()
>     -> ip6gre_tunnel_init_common
>       -> tunnel->net =3D dev_net(dev)

Will remove this line.
