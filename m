Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF123CBE64
	for <bridge@lists.linux.dev>; Wed,  1 Apr 2026 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034901; cv=pass; b=PoMLz5szqzwPje/vPdg2Ys5q60rXkMGo0CBZtRqguy60BK83lDAcPqeuS6PNV7PFsP4N47f0VZdVQ689zuaKiPbokbsy6zPbRf5VirOE0glizqHXFq1S5SFDdfEdXmEicv5ddSRDJfIHm03GXwhqmWrdjeukVzs2cYemV6dPpy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034901; c=relaxed/simple;
	bh=Px8VZ/mZa/wVBiSvlhUqswxvgLPunBza8vM2mBYbtJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ND3vOCHk6MNKIxh0xZ/lG2DHhWD82OIq7uxy4RpSjIpUNmdgD4mMcm7PdOcLmuO2mP4OCN6mC5oOMEDlduCJHe2VrMcJ+1uAN56qgJbRzCVxdhQV/82GqzxD/wMYvENuSYrfqKSZ2t7HDoASoYux/2LRziXjuBtOvDDEMjQ1ANg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SfhNIYDo; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SfhNIYDo"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506bcb23a78so56595221cf.3
        for <bridge@lists.linux.dev>; Wed, 01 Apr 2026 02:14:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775034898; cv=none;
        d=google.com; s=arc-20240605;
        b=JDti/i2NbuovgjN2cIme/lLxyvbuPDpP5MwIklnB61KmlfrOJFj+puv3DgiSKjPACP
         enjxAac3F7GVM2Qj+nN+I3efHDMhAxHy5cyCS3LjaCMrTDk061TzOV6SQ8Nbsa5wo73X
         G5IrgzcOUArI9HD7AZqF11lQuCnnXAz/xE+SIt7WSsICCBRAy8u5bMVSwtJCyFuTrut+
         fMH8owyK+A8+ri0XGQNWZvsVBair4a5ram48gGlc900ha0GrJX2fJ9BunaYAYp0L8XVi
         T9t1Wxiqk8zya54f4UnU4JqtQWbnfG7NxM1zwgcFs9XdnZ1uqrfKiBQx6dS3LoYEvcKk
         cp/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QNCKy3dqIhDpgGkChFZLtJKaP66u94+8Bb0TUa2FxLg=;
        fh=jZlrEWyyX6OLoLf9V9Cv0Qm4JW2h9TTr0xGTKjCZ/FM=;
        b=i1soeauNBVZstUvI9WB/usjWhYdnIjXHIOblai5npkdKcheWCMp4dC949EYPhCid5p
         2WgS87y6ohLyFE0UldznCvkHT20vT6tuU2dlFrudC5tclB27JqhXxyKaxIsIcO2fY1SL
         O5A8eUzLJbU5/yFcvDpjqGpcgN8Z/ZUsUf7q0mCkjlbacS/SzxFSFoOYVU6KFdP2/L3m
         cREboYXHx6cuu/lBjzRS528PgtSXcpc221Qv6NdbQFETTuoE7O9tmCbJFO3DmmZ2Rwo1
         IHdKFmrxhBuYfngWaXWjY/1b7p/F6ZMQuJ4OqROgknYXRds/a34WLEI7vZb5Au71PVL8
         Wgwg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775034898; x=1775639698; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNCKy3dqIhDpgGkChFZLtJKaP66u94+8Bb0TUa2FxLg=;
        b=SfhNIYDo2X4pkdWgwIGAQpo5IkV6FoxJMyWsH0oYsZQ7IM5gRVkJGoCJoz229iF7SJ
         hooEKmVoU02uZacOP5GP+y6jTJn6BiZZd5cnV+CmDB0/vm2qQFa7dxuC3DL0u3RIKOn/
         OSGkWFpt5f4aoRWo6CNo59m6TI1VmZuNIJnJK7d29llAFeICeKOn/k797KJTC7Nq1PRL
         WCM4NdnXVGlRZ14wFPVPmI0kIgEwpT2OPGVJtNSk32DrBFxu1SgUjT+uuIsms3bKwCBw
         bCckZy1ifBq3BrbqUE7gRL0Y3pCqWoPV6dy0G/FuT4NSyvGuHhxPsnIn0XoDoACFfd0u
         Fr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775034898; x=1775639698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QNCKy3dqIhDpgGkChFZLtJKaP66u94+8Bb0TUa2FxLg=;
        b=A0oC3kE8S5mvHflE6XKGss/Rnp/Mzbha05SDHlo8rt1HIFvot8V/lrzNIpsglDVV3A
         U4bz+dChVue9JGDZuVqBYQPb+LreiyOTSrbH/q3t60DhWLFE2aWvvilMj3vO0+jSJmn+
         EzcGcwNcFM83sc2hc9Xd7eTn0ShOdE45iJak9aB7qwggdpk/ZrrayxX8yfrU/blg2DK/
         7BcCmmPwUvDJ6/XWWaejO8RxKUhrO43YFyqmGqmkhBCLdRBdSxEnyvyqwTeCX3szvLha
         WQdMoEC+wM38drt413qHfKww1cT/xD126sbrrNEpn9b4g/oFw4CoemwihRvJqUs3Rh4a
         ukaA==
X-Forwarded-Encrypted: i=1; AJvYcCXmuLR4hAN2GZuipj9P314erAVTtMyGzWB9ZUJSDP92aPiCgY6CUKfObcJ2Bl8BY6wdsQGml1U=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywdfs5d5Nhmc32DQbSaRDeHwxs2FwFtCGBIceGnHlRNqJns5Iux
	jMQIjimG5Ntl0PvlTe9eeNEqHmM7G4pxKToDWygmqUNwgExpJAetqILjnsWaaSueOMz5mnJ+F70
	AIj5TDpwMCpnDmUSM87h7fuHJOA4nSwFQAP56T6kP
X-Gm-Gg: ATEYQzwb3AFXax5X0a0YLgFzXI7Gn1azJtUdoD+dTlAgywSPeYmPhesBdn8DH5JqKCc
	gbtV6mtmKlcUmRq++xepN5Tt4r8Bu43e5ado7ZMT3JejD/RDSbZifjV8PRgRmMsqKZi63l0Vofj
	iJs6x7GnfrsZZQ8TaxLQ4D7LWzUXYCxjtIHpijQ7c1QbEG18ZWuMfNu/nAZbCW5HcRU1Uhk9ZxH
	1uc+3lViRHLU3/EzWXMeBE64r0SzS4qVLnjR0PcUdzx3zVu0IQL0ijR8Bj9W2guRX2gL8MY2/8M
	4kNssw==
X-Received: by 2002:a05:622a:1c05:b0:509:2ef7:7034 with SMTP id
 d75a77b69052e-50d3bcf5f5dmr36705111cf.50.1775034897967; Wed, 01 Apr 2026
 02:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260401074509.1897527-1-dwmw2@infradead.org> <20260401074509.1897527-4-dwmw2@infradead.org>
In-Reply-To: <20260401074509.1897527-4-dwmw2@infradead.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Apr 2026 02:14:45 -0700
X-Gm-Features: AQROBzAoGbAvZgGI1SP1QOjEPB9AfHu4JQqffzH3Pc3uWqwtvvbxFW3VGI6Tc4w
Message-ID: <CANn89i+iRUgqtd+eirfSUM3k+keNZKzLwsHxZtwE+vHdv7H5PQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] net: Guard Legacy IP entry points with CONFIG_LEGACY_IP
To: David Woodhouse <dwmw2@infradead.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
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
	Guillaume Nault <gnault@redhat.com>, David Woodhouse <dwmw@amazon.co.uk>, Kees Cook <kees@kernel.org>, 
	Alexei Lazar <alazar@nvidia.com>, Gal Pressman <gal@nvidia.com>, Paul Moore <paul@paul-moore.com>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, oss-drivers@corigine.com, 
	bridge@lists.linux.dev, bpf@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	torvalds@linux-foundation.org, jon.maddog.hall@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 12:45=E2=80=AFAM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> Wrap the IPv4-specific registrations in inet_init() with
> CONFIG_LEGACY_IP guards. When LEGACY_IP is disabled, the kernel
> will not:
>  - Register the AF_INET socket family
>  - Register the ETH_P_IP packet handler (ip_rcv)
>  - Initialize ARP, ICMP, IGMP, or IPv4 routing
>  - Register IPv4 protocol handlers (TCP/UDP/ICMP over IPv4)
>  - Initialize IPv4 multicast routing, proc entries, or fragmentation
>
> The shared INET infrastructure (tcp_prot, udp_prot, tcp_init, etc.)
> remains initialized for use by IPv6.
>

...

>
>         /* Add UDP-Lite (RFC 3828) */
> -       udplite4_register();
> +       if (IS_ENABLED(CONFIG_LEGACY_IP))
> +               udplite4_register();

udplite has been removed in net-next.

I would think your patch series is net-next material ?
