Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F9739D6DF
	for <bridge@lists.linux.dev>; Wed,  1 Apr 2026 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034706; cv=pass; b=deGA5S6QMQcnrvztt9QJej+PLYIs1sXYi5xX19yir8pOuX/MUpx1YnNngz4ZoO5f6AQloB0Zy+C+jFkYgtGlsXqUXhhB2Q7a1uGAPzk0z+/UMao+PGh3nLVSwYcMYkt97PEf98abT4y3VlqLelVr/5+V/QmwlYUOF2Ikfa8j31Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034706; c=relaxed/simple;
	bh=dmaTcuAy6jfJ+bmzS1Jm/uyBrkTWgyDnScrFaQ2/nas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkmGih7acj6veWXVgU1FpAVN2SxTACTj06JBZdFjuMjv6xqRkTNtn5IyvXpT3yapl23KQL2Nufxw7nVSk2t5O6PaGxsE+GcnJPLFbDom3s2M4683aWjduIs639pAgi9+121TB8Y98BW3meM4mhD0MyeK/vQyhTWzPqW5kkyYaTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JZhPgCN8; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JZhPgCN8"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506aa68065eso57355031cf.1
        for <bridge@lists.linux.dev>; Wed, 01 Apr 2026 02:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775034703; cv=none;
        d=google.com; s=arc-20240605;
        b=XQpsr9Evbnh/Zp/YSqJ2So9QR3J1vbT11FY/0M9eSdrrHl2SmeF41Y2qdLHD2UBnLx
         IMcPysYmii/I5b2YreZELpckCJ3EZjNWUFovylOSbjZwHaUqTKGJp+EDLsPRDa6IBtkV
         7pDO9U7cS2XCcomitcooYYtcXd+Pc/VPZ4Q3Vaqofu8nveohZXsMT/WrkvgSoESAvRqo
         KW/ZdLsqxHsxTDbD9Iy6QfdolxkWrYzGkJhoYOIvwuoT72JjK2sYpHhTY7v/rg4YUNTe
         6EraNxOk20Zeyg7YAXO7R+ETGHnrv72IwFZuN/dh2EGGgHPP2h4xO+LvIUM4DKbFocFG
         1akg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lctUVgmnSzTUnScobr+jAtLkB/onmBi35F0YaMEt+UE=;
        fh=6SO8cBGuv9tVGo0SsW3/ld0RQm9ei4rKvgg3VJIM5V0=;
        b=kwQjkDL0hznxsn7uv7Nk0NAtCI0YpUhCbHft4hvGrQTizPzy80KJgJHP5m5tKbrIvO
         te/Csgz9j6qIRFSXmLVYqQXWHswu3RqbkU+uHUTbpBvDdLzSmEHhicyXf6CNpQZHXkIl
         UwdulgBek2OM2JLZE6kcZc9z7H0S0j0ojgZATIp3VHyo8h9xe7aPxEKR8BakVVvf+630
         mmwB8cPtoF5qWk2ipsGGLwxtsc6p3PemDd4I+zHBWL6ZRj3D3R5MXtyXNGXHjcKkXGiD
         DX7DBVna4pxIo/IdpJy952pW9dD7PWxRAZiyKMvY3kzPPEoSi3iBqiGYZ4xc+je/dt0D
         3cmA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775034703; x=1775639503; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lctUVgmnSzTUnScobr+jAtLkB/onmBi35F0YaMEt+UE=;
        b=JZhPgCN8ruXWd0mtFbM2NKR95FdjycFNGfnMctri6aiGIoFbWIKTf0Bnu12e1zSnxB
         LxIYW1LIY9zOiwPiPPO4GtYvlDHBZql+HiquaRsTFej8b7WwzRnrYB/efKmsF+s/jHVI
         GFQmzjcLyA/pIK+/BXRRCIjZvIq2C2QCJ2PNODVAK3GNK47y2AWTL5moOkDrfzSuER7Z
         QhT01/VWSnj9twL7tXkM9tHrI9Fgn2Gh7Y6MFcw0AEHL8DQbmL+ApEfw576tvmiAjNqO
         Daw/rDK6ZCLP2iyySkcxYVyGpEaKHcYqS5fljKuhutNm3XAujcbaLga3u+/upQ6y7XAy
         hGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775034703; x=1775639503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lctUVgmnSzTUnScobr+jAtLkB/onmBi35F0YaMEt+UE=;
        b=gIpxlCSFvGvLNiWW+SJ+IebvjjH4xqeSOFqjUQFyGQr1D0+tSCsOstiqjV1qiJuWvX
         5dnbXnv/IBAuGXJ4+NdXZmE7Qr5MX/CKyo5lAhq3PjYoTWtU9F/3aQo59I0GNFMuQqU3
         IoV2wr7FiEXTrZ6V5i5N/GoHjtoZoujKwMLOj/eLp5COGVeu7+m8mDQnKTJLGuVjZajQ
         zNvCtiRfWq0kMQLFV63AXNlxVTZYt1vE/lXFjCBMgST5bi6vhU4MNMIjYCUJw6Uk9sdJ
         l0hO7F2Ge3dmTMlGzSgr9Uq8IY/8n5dc7Q9Y41bq/S4bmN0dJ5cHDYDvjIapRJAeHchT
         ipYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfUfuLLsFhg5vRIGkK+kN8AReoz5IpLcU0xSBHZb7+0ORqVPFwf559ARd9J/kk7EyU75Ekz9U=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzu6hKqNE1VklCpFWq0OMdNcSqzVJq019yqYqTiCAl334eLMXzz
	Ye1BjmfuoYR+njR5Eeeidi6ngyc3TBdfLh8Udgr2iHtKXLawhGikOZF/4M+xkRGms1ab+tt63Dr
	JjNTx/F3V2x6ajoNWT4QLmnPG10lnObGs2SkjRnvM
X-Gm-Gg: ATEYQzwOmO0oDyp/ahmZCRAHoL5O5sErrOGBISmtxwsL+4YM8t7SU+zI8Qmy1lfw4/K
	2MhSjxP82slYor5mMW/7r1W9ifv3Z2Fqhw13W16I/zIweFMFQiMF7owC4NBBt/bfpDHY+RhU3pV
	8tN2j9Nd1kBQtwsNuqccqRpWP1nEcPq2plHhvyu4NYIZlXcv0N1QnH1KG3hLBWtb2R0czf0iGE4
	MahOvw4KCmG7b2pDSBeL6ChfXm+XYE/lWJ00g5BCLrINa8V+PB5Eebc5lec+BzE6MyaJmABSqj2
	94sHMtfIuv+jWdj3
X-Received: by 2002:a05:622a:5909:b0:4ed:b2da:966f with SMTP id
 d75a77b69052e-50d3bd84b29mr44808651cf.31.1775034702251; Wed, 01 Apr 2026
 02:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260401074509.1897527-1-dwmw2@infradead.org> <20260401074509.1897527-7-dwmw2@infradead.org>
In-Reply-To: <20260401074509.1897527-7-dwmw2@infradead.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Apr 2026 02:11:31 -0700
X-Gm-Features: AQROBzDMpjzScINQf3v40GgXHFr7zNRIwe6Qb5aBvyyAycV5Up8H_bwJXHOzd_8
Message-ID: <CANn89i+GHkkubJp3MTKZ_r4tde1qLejfsxUh+w0gPZ3ec+YdjQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] net: Warn when processes listen on AF_INET sockets
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
> There is no need to listen on AF_INET sockets; a modern application can
> listen on IPv6 (without IPV6_V6ONLY) and will accept connections from
> the 20th century via IPv4-mapped addresses (::ffff:x.x.x.x) on the IPv6
> socket.
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  net/ipv4/af_inet.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index dc358faa1647..3838782a8437 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -240,6 +240,9 @@ int inet_listen(struct socket *sock, int backlog)
>         struct sock *sk =3D sock->sk;
>         int err =3D -EINVAL;
>
> +       pr_warn_once("process '%s' (pid %d) is listening on an AF_INET so=
cket. Consider using AF_INET6 with IPV6_V6ONLY=3D0 instead.\n",
> +                    current->comm, task_pid_nr(current));
> +

Some kernels are built without CONFIG_IPV6, so this warning would be
quite misleading.
