Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795348926;
	b=Bzl/DEhzJyMVgYKbAvCU8LhweeT0pnv/YO5RUkJMLVbNrX5yBsGqkuQXiG9e0sIWmHLF
	 XdJ/lURhkM+7YxvOjg9YcRojrTbMpW2CLBfVpro5CDC1Hx/OeyrUslxR9OqzwQh6pj9N3
	 3hwCO5mwcn946lhAGLAO96HPjg7xQapPeU8PNTBleFzA7iL1jRS3BZPZzGHINSexujoDB
	 bPu6e7TB+Q+ZZNTGO/8OsA9f7tinF3O1lMAm1uCqxf55OdMM7t2TTv9J3FUdQpdAUFgOC
	 s/GraOnUdeKPH3L1dQrFQ06cpB7ZcJaBPeTCym43oig855YAgTWNM2UNdeW71IEHIrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795348926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=VDAY2l0Py9SC2OiRZKfmkxrUpoDnsAjefW9a1e5gT+g=;
	b=DPEtwDDSDfnAd0eyTkbkH7lhNpialqZk8j2+GEzMpKTX7mVJ6bSLl3jWoykHCUIPUKFl
	 adCpuiGoU9BHgjHhCUQ3Bthpb4koD7Upzs6B+X0nSrFU3xyX4buEq84Dz8JjiBwK4N+cv
	 nusD79OXQpemjX/eU6Rzln7VZ6FqcpR2tjRhFZpTRCf1CW3zINou6GczciuVxp8tkYFXS
	 ZADjnICLvWFnoA2MhLhDHkYBBw97yfOzYZNb5mh4TM1Wy79PgpRS6I/mra1g/5UqQz8tQ
	 DJCrUc//gtt5UMtwtg4n/rzUNx2WleaCGgYNvqplaXgr3Qk53GVbrMYgbQgpcT660NA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=dHQOf8gG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B09606A32C
	for <bridge@lists.linux.dev>; Sun, 22 Nov 2026 12:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7B09606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=dHQOf8gG
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b4c2da74c0so13649907b3.1
        for <bridge@lists.linux.dev>; Sun, 22 Nov 2026 04:02:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795348925; cv=none;
        d=google.com; s=arc-20260327;
        b=FsRkB+N8GujQEIRXyn1S5Um8HaDGipmADGCngxAnLUDLhnWrPSFSJWm5QlhzE7YgNM
         JtKfN1pU8pJBANLjLKHMZ+4hn7ClNIg89YBxF6AJL7GzpdyKj6CE/Ox17w9fl5h+ucfw
         I1aJf0ZTFSQF9ZlGw/7GUrYgavbgmwRlWJDIuSHxYWJw4mNEozxlxTXKeOBn4cBNwNpa
         Dqb8LmUUVAuUpNG2dgDZkBFgKm7NajjlfEIq9snk6RqprOlizPPuihcki+elTfI7nQ8b
         X8SqRWn2S/2XKtaC8vpeKziImNvyT43vAHGoCtCHVAkRQOJKRUXwXFRV4UV0pHHw/Zdx
         xbEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=VDAY2l0Py9SC2OiRZKfmkxrUpoDnsAjefW9a1e5gT+g=;
        fh=W/SS/lqBudPEtLyi8GErSJQu5qsLxRAdkzNRRyDa4w0=;
        b=e3VDghTC4PSj76l2iMyz/QBr4THSahvdGNa3ndlh+hiiufinxUpRt7Xh52Pn/m/NMR
         bMWjpyf0NQ4rk5iqUr263TTeDznxHl3eLZJb58CsvAIUS1McClKZxV5n6e0NB2h/qwXV
         LlqwjbQ19NUUgNI9Z9heyON1MvxVkhJwulzqw/Now+H70TaJU6JlOwecVtoU2gneSrGN
         tI+Em/e6g53pJFA4f5J/oy26uRXNGbBEG1RzdQvcvwszdBmFImPiC/O6f+wsfSezi8Ge
         IlryhcJbimZ/pGs4pnmPbjQFSphFICckmJqdGjQ/1XonwU17yYsnt4xeevKnPdes2xrL
         ieEg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1795348925; x=1795953725; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VDAY2l0Py9SC2OiRZKfmkxrUpoDnsAjefW9a1e5gT+g=;
        b=dHQOf8gGOodWTsaKi5dgfQNsLTkRXIRY7JVT0QBt5GWmt5sAPg2VkmlMtcdJ0LeF84
         Xu8jT40A4eXSq92wL5v8Dt6kzbEBbm9Z4SA6gb7IIUoBqGWE2IJmsQn1MKCz5E0b16pv
         0fbGYmqiG1jMYaYkX2scq1jbOwhexXQTpj1UQej36YKtEuawplCVLDtbmMC1v6mceiWv
         HeinbDtqR+rNsQu2rRMi5o0fRDX071TyqvpRHjoUEyLCcjXhiI4rVND/QVzDVrvGt6tL
         +XeltXPqSHv+++/OWHqufEX5T15Cj8njNTh+4xeBZfvG675uFvb39V+2Bdi31pYtuk3Z
         q1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795348925; x=1795953725;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VDAY2l0Py9SC2OiRZKfmkxrUpoDnsAjefW9a1e5gT+g=;
        b=Et2gfJ99eQU1sP7l7iXEXfw148DzzEdvdTKaPOw8P5MhUZNtmTv8Tc0HtkLw46lMfI
         ujFz4FazPjIHaedtzKR8S0IoppNlgOttdIgcECEDKWiTmmkFbJOj3FdUnTUzgZB6KrZF
         GNWaYQ9Hvl0sgWPGYhUHg2YnjYTP3uU4iJIRFS6nMtAFZR6zALKZdvNxGM503ivY8uUA
         R3YC13amoc3g7UNo9S/Y2iU1gCMOjI73E2G+xho74MqOaWxfthlzie9BOf4h05lj1kl5
         yHxZW/6NfLQq7wKkkTKIFzU4+Uoxf6D0g0vsdiKn5TdpAEntLosmPpnC/n86MsozRrE/
         mplQ==
X-Forwarded-Encrypted: i=1; AL+hErHSrEucBRfAAzxnGLHrw8tjAENNHd2zbwM9aA4F7U2n7qc2Dxyst+WQ6F0V9OTGO3jrK5kYLDQ=@lists.linux.dev
X-Gm-Message-State: APuU4Z+FOzjzMi9qFduzNajxyfiH5e+x3cDmfpeM85Fpy58FLpmSAoUq
	IXtAV3VEGUn+lmetNgtpeb7odrlfxVIObUxN3+ra3myxEDgXjlbc4YrUmU4+a52RDxt41lnce8y
	xFtizKnrETBgDyyIiRiuUyNYsoTlX/Yu0rm+20qeB
X-Gm-Gg: AZFdTZdzRQnY3nUsdq+H1qsZe3+YTOmmhQYeUCJfbitO4p2+OQQjmxPydQz41x5F+Qf
	YZTqcRqOFfaPsvcBarsLGoaZHq0QEC/EHt7hPWO89NyMWYrKOzM8NrL792KsV5iPVk2EIwlpdSh
	AMc0Lzzb+mIrXAcoceU/7Aq3+kAGyA2yuzsu4KQrbD1eaPc5MQUJsE1AHRJL18DLgIwu07NfTtM
	S625RZUGGzYTm+shPOSba1HHF966JBrc2HRWiv7lgKNPqwg2302hsxSxLsAFMhH5mKGGAvxBdNA
	6vgd/j82LlAGo1thukhCRsOe6AoUxDaYFV6niQvzk7G4AjYePtMjwsgt8pzxaRFju5eMDqlZk1B
	o/CrzusVWKREFxr26t2j1O/Ph+fVwtWYO/DDDckdtyYIEBgLYP1+WGHlEL9aC5yuTidwTcTNsov
	GGI7o7kDV8Iweu+WWQHAy4PixpI0XY8DcYo8PAFVGx11bBgtfUhzC9ZPA1SCSnpOxM6ZLG4cbhE
	z7NWQguULIoZR95uA6CICzD1w+lLHghQDKPW0dCDTlUfeZSZ0kIw2A8GiMPIW+83XfdT4vts3c4
	enDgRjqouqSUWPtrI92CcsOjyQso08lqRbqojgLEB4o0Objap2x172gebRCjrYXGTGPEs3htJCQ
	WelsihCchAQv7WugEa/exk9d7oUG1y29oKInpv7HQuzf2UTUOUPM=
X-Received: by 2002:a05:690c:88d:b0:8b0:d646:95ae with SMTP id
 00721157ae682-8b520436e42mr29583277b3.18.1795348924716; Sun, 22 Nov 2026
 04:02:04 -0800 (PST)
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
From: Julius Bairaktaris <julius@bairaktaris.de>
Date: Sun, 22 Nov 2026 12:01:29 +0000
X-Gm-Features: Aa3M54pGP5Y5GelDYyIRXPac7qaJVRqnpPRHmYC1fODXTa_3sxZD5zd8Qe6ua_w
Message-ID: <CAC1t37+WBG97C5ZeimO9SXAKChk0BU1kRC5E6yKAaOHXvWDpMg@mail.gmail.com>
Subject: Re: [PATCH nf-next v11 2/3] netfilter: flowtable: tear down direct
 xmit flows when the fdb entry moves
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>, 
	Phil Sutter <phil@nwl.cc>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Eric Woudstra <ericwouds@gmail.com>, netdev@vger.kernel.org, 
	bridge@lists.linux.dev, coreteam@netfilter.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, Nov 21, 2026 at 10:10:15PM +0100, Pablo Neira Ayuso wrote:
> > +struct flow_offload_br_outer {
> > + u16 vid;
> > + u8 present:1,
> > + link_vlans:2,
> > + link_untag:1,
> > + link_8021ad:1,
> > + inner_tag:1;
> > +};
>
> What scenario are you trying to support with this?

A vlan device of one bridge as port of another: br1.100 is a port of
br0, which has the router address, and the host moves from rr0, a port
of br1, to rr2, a port of br0. nf-next offloads the flow to rr0. After
the move only br0's entry changes; br1's still points to rr0 until it
ages out, so the gc must also look the host up in br0, through br1.100.
That is the "stackout" case of 3/3, which stalls on nf-next.

And thanks for the review! Can I send out the other patches to get
some sashiko reviews, or do you want to keep the rule of 1 patch at a
time?

Julius
