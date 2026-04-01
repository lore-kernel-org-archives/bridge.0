Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED8B35F5E1
	for <bridge@lists.linux.dev>; Wed,  1 Apr 2026 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060776; cv=none; b=jEmHkSKU03d7ghg5pQcAX3Dy4Pfi21cvXGwYsge5KjifN2dVsiB1vpCvYbZdtBuZonbzk8Bqh6ndkM7lCLpj0D647Mp8s4KEbTB+dUwga0TAxnFsGtwXqNTLn0O3wqh69Y51gRP4H/nfsHWWBcoFYpcmAzUPd0/0L0yZBOaaELQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060776; c=relaxed/simple;
	bh=ybEdMnj+IV21R50M/Nq06VgnFb302XMUbdzsNI1SGq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ak21jNLc3MyKpF8r40NaEgkPJKTz0fkYioyq9+nbQ7w1MDBaFe4aYDqnRVMCdY6VCe4NHmLOxWONcI1BwRiEQpJuQ7yFLICaGaYok3dqxT/ncMAQ8ZB/i5EFkk7F9zmtzfsAlu1bi1+BtzmLcs+vO/0poqxoBggC5KK5tH0RrsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BsovLBpK; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BsovLBpK"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9c01854477so350775966b.0
        for <bridge@lists.linux.dev>; Wed, 01 Apr 2026 09:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1775060769; x=1775665569; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wMfn5M+yor9qcHDuzn1ye+wM03ph8KGxN0vfAlP2l30=;
        b=BsovLBpK2S0asgFz3YROsi7D+gZGp0C7dY254LOFMLttjmOh+oaMxzjAr0szEFLWvs
         qR9VyC4ud4ZCNHhxDYyIePW2McjXbNjphBNYhX7nVuEqo50vYnhnVCtlYnw9aC2MmtQi
         8STQ2sxrIkB4fROO1kNPYIxa8Ziy7qw+rCkgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060769; x=1775665569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMfn5M+yor9qcHDuzn1ye+wM03ph8KGxN0vfAlP2l30=;
        b=naFs/z57VUlNidRt4lYDmwMtqWl14jl8wzp4bGkQiP2UhCq7zJfjznrqB6FUz42cgR
         e4tQMggPy7AsOa2+/TdCPFkjHVZDa47F7Y1CBSjq/IJ34UKglh5xUkpNngLSqssiwDo0
         +niziwZPAtepFUxkvS25vmTsEjE7lkq0ry1Imcvy7FmIzMSkTBYy2TuMiGWj3E0mTTDo
         paU1eBFJ8MrWJ61whU8goCSwUu37qYeLiUQz6r6q16JPqfcR/9R12FEd0zMmnlzBhXbk
         yozG/B2XguA+YZZXQ8O7MWvz8YW+8jWvrC9n8dR7QTBt1+JrkvmFhkesAPMPLjJRUDJM
         MQpg==
X-Forwarded-Encrypted: i=1; AJvYcCXYQwPNFBqVrvSFMMmlHS5pqwvt+YyjGEP1iQmaBgRpcSSOR5dmpSHm2FfUYnvAZn+/JFKmdNw=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywxxzn8S7QRbj75WzD+i8edH0Crai5mub+njzr10DZRtS49OFmB
	ik7ZVXYcSy4WjbLu9X4jORSHoy6LKOcZyHJYugWOrxvNQA375Ne8NI8r6SKFx1o12sgWSwiwbDp
	dd1ZUX2AieA==
X-Gm-Gg: ATEYQzyw7OuYZQYt9f8gOfyim2NCt/0QlH6yeFH1ELlEKKBikJkNT8ErPwYP1eqRlxW
	Vxq5xgTWc9cJA0k8oR7f0Kz6MVXIoujCbzJG6xUDDCQTcF0GoBe+jFHOih7Uz4PPcRlHIk4ibF7
	lGc6U2tB+qqgXQGER2KLV+wAznE3hddDWEXz2iBVLq29BvXLDRn9xeuddTWRH+snlMkpXlFT3MT
	HkWXOaWJ+cuqRGGpgwwZCMo8h3EdgX4HQkM+NtjVxRu8u7CPtumu6zOXi/WtWJ4PRNYTikVPQ7a
	LQkVg560eyugjtuuGM539VAMXM3Ex+uLcMbDMoRDhp1YNC9wTSOanCx28y9g0fDIDCTEHHEw7R3
	d+zVZY9CEWLAxun0QwYsZEofw9JdNC7mFRb8EEtqQUsqz3ckz1NbHUFPoFB7UZCj5c2jFYZ8pHT
	ZH96UbwYYQu4cS18OZHBzfXXx1tMc0D5i07s+VSN1khFQn2TsLeykIt50N3X75xIrQ8SM/37xw
X-Received: by 2002:a17:907:ca22:b0:b98:2732:3dd1 with SMTP id a640c23a62f3a-b9c13b7acd6mr78179566b.42.1775060768539;
        Wed, 01 Apr 2026 09:26:08 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e033ba245sm4275a12.20.2026.04.01.09.26.06
        for <bridge@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 09:26:07 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66bb4d4fcb4so7465942a12.2
        for <bridge@lists.linux.dev>; Wed, 01 Apr 2026 09:26:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUddnbXWr2InzBGM2AcDJBTRIGd9DGqLL0wSo2zFWDj9yjrBKHHsaFTmYd7gBvIcQKGBZWQmyc=@lists.linux.dev
X-Received: by 2002:a05:6402:35d0:b0:663:4315:7271 with SMTP id
 4fb4d7f45d1cf-66db0cfbdaamr2927572a12.23.1775060766098; Wed, 01 Apr 2026
 09:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260401074509.1897527-1-dwmw2@infradead.org> <20260401074509.1897527-7-dwmw2@infradead.org>
 <CANn89i+GHkkubJp3MTKZ_r4tde1qLejfsxUh+w0gPZ3ec+YdjQ@mail.gmail.com>
 <252823d75e9221647e7f8ccef6105432aabe8d6f.camel@infradead.org> <20260401080657.70cd9bd1@phoenix.local>
In-Reply-To: <20260401080657.70cd9bd1@phoenix.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 1 Apr 2026 09:25:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5KW97ZHUi_5kCwC+Lh53_sj2HJ1SnBU1pQAOtnk7oGw@mail.gmail.com>
X-Gm-Features: AQROBzBuhMzLrgonz6WGspEvkWFhuj-ddiDGEYTFKbMu2F_LUT3de-t_k_EwsPU
Message-ID: <CAHk-=wj5KW97ZHUi_5kCwC+Lh53_sj2HJ1SnBU1pQAOtnk7oGw@mail.gmail.com>
Subject: Re: [PATCH 6/6] net: Warn when processes listen on AF_INET sockets
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Eric Dumazet <edumazet@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	Guillaume Nault <gnault@redhat.com>, Kees Cook <kees@kernel.org>, Alexei Lazar <alazar@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	oss-drivers@corigine.com, bridge@lists.linux.dev, bpf@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Apr 2026 at 08:07, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Wed, 01 Apr 2026 10:28:23 +0100
> David Woodhouse <dwmw2@infradead.org> wrote:
> >
> > Maybe on this date next year, we could make it not possible to build
> > the kernel *without* IPv6... ?
>
> There are some government agencies that used to require that IPV6 was disabled
> for security reasons. Yes they had broken old firewalls

I think you missed the big clue here. "This date".

Sigh. It's going to be a long long day.

              Linus
