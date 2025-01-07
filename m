Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EA01EBA1E
	for <bridge@lists.linux.dev>; Tue,  7 Jan 2025 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254440; cv=none; b=mWu2aKX8hg3ANTLaImb57hwVKE+tqs0oCGnpyzPUmRe8PXur1QVe9KLIAnQC92j79F0+CbwFQt/4sKhkt93jWLwQppYZ6S1hSX167If7O3FLUViZAV7EfOU/liIzX+v5E4rM2VlIroAld2ER5PxxZHyvBR/w4N/uguy/TnAXUxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254440; c=relaxed/simple;
	bh=inq18haWLx2b6yOB0em2RillkH2hQMFoTDPjGmfyXlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Np1nWXoiIYYydbRvvx1bySUGoR4D3tQRPNIqDnKcoEnt4+o4vrDwjssrSvsK4xb6MvNpmqND002eOQhi2FUkBXTVgAGp2tdTaW3Py/WRaMEdNHhdx4v3nWaeGuXf0z9RV4l/OOHsyX1ba6qfEndooZ0VRG4Psg8bPPLbJX9nVr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vb5qbrre; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vb5qbrre"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3862df95f92so6821153f8f.2
        for <bridge@lists.linux.dev>; Tue, 07 Jan 2025 04:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736254437; x=1736859237; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F66Eu0GAg36EcgkwSAQsoLttohjhJJSzBhrgfuDrfa8=;
        b=Vb5qbrrexEOIGU91vM2yhvihRiUWwxKWrXz5f1ilgv8HXvdqY/8BndsEXTKDHlOUdv
         B0Hl2NAx4IBNK6rA9nYhWyKHdg/PF5k1Af62nOFt3/W18gYFb50Y9r0MCBrdZLONTPFq
         GKTx5FywF9t+iumiKrL+WQh23sppF8PItBpb4yrM6PPJwA+LBI6MXm5lW7Pdq4uUsUwA
         vyv9JFfHxw/Nw/+Z/OrVW26vOyIS0gQtAQk9XK5m3QS1cADi5GJ3siE6l/5JjIfyKGJk
         dOGeA0wjXIvvxTlq24GEYU3leLFqAiaREcjlDBJ8r+y/IIV4w4Y/8BVoRyHB5KNb3UlO
         CAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254437; x=1736859237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F66Eu0GAg36EcgkwSAQsoLttohjhJJSzBhrgfuDrfa8=;
        b=lfnpevUlCQxdsVDHylSZ9zNPForiViZexsLKu1rLTc52zYvyVcG/MEU7noGzTFgy+Y
         EIresEckQFbMHZM7bgLRA0bWvzRIGMyg7S4x7nBm0B65kLXjjqMItqZUTy7fMRVyfZVZ
         9rNoLEfISpBjIqDRQN9cp17a0oNxHVtAFheBnzY1YzVMXAbvkRXRcL0Tb0Cm7A6M1QbS
         k4n/7AxfGuMWkX8lLxINYGJ9aSkFaGxm2B7zuqv+S+9EoJblpJhM58JYWJrQicW948Hr
         cHz5vDqmYhyaINB0L37YR4T13SDgBp1TODItpYiLh2P5wlMl0iPWGS7g7c0mpdW2YMPE
         QQZg==
X-Forwarded-Encrypted: i=1; AJvYcCUOilNe0utpocl9IDcWM6TZQKhZFmwpwqmu4FKCsUfyEaHP0DaFz82jFrUrT60htTDoUR9/M1I=@lists.linux.dev
X-Gm-Message-State: AOJu0YxDEI00CgJoGS9ch0XeSF6QDu0DGA+gzyQC0hwfnVj3I5CD4Qxm
	NMDIuAWxH3YG2KZhIn7dB+fvyLzHSJDCxFCMBJS6HQSatciwlzWMpFRiYJDZVT7a7P8+SOgwdYr
	ZgFEOpZRW6lMMxP0vVs4Q1i06yTg=
X-Gm-Gg: ASbGncu5/jnXXDr55c5hmq9uj51C/WSbHixVSGucnb0K+L/rviA0Vb8q8D3RzsGfNYM
	dyVzaGeplcNS7V6pfChCvCJruPgLkDi6EpP1I
X-Google-Smtp-Source: AGHT+IHLmQYT6Nfe/TxqetejkNmjRWULhNkXti9Y+FoSO0oNz6JKWmwppacRVdUE20hj8uvdZwuWTQu822tlGBPGUFc=
X-Received: by 2002:adf:a15d:0:b0:38a:615c:8222 with SMTP id
 ffacd0b85a97d-38a615c828emr14509037f8f.4.1736254436561; Tue, 07 Jan 2025
 04:53:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250104125732.17335-1-shaw.leon@gmail.com> <20250107085646.42302-1-kuniyu@amazon.com>
In-Reply-To: <20250107085646.42302-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Tue, 7 Jan 2025 20:53:19 +0800
Message-ID: <CABAhCOQdBL6h9M2C+kd+bGivRJ9Q72JUxW+-gur0nub_=PmFPA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 00/11] net: Improve netns handling in rtnetlink
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrew+netdev@lunn.ch, b.a.t.m.a.n@lists.open-mesh.org, 
	bpf@vger.kernel.org, bridge@lists.linux.dev, davem@davemloft.net, 
	donald.hunter@gmail.com, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-ppp@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-wpan@vger.kernel.org, liuhangbin@gmail.com, netdev@vger.kernel.org, 
	osmocom-net-gprs@lists.osmocom.org, pabeni@redhat.com, shuah@kernel.org, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 4:57=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
[...]
>
> We can fix this by linking the dev to the socket's netns and
> clean them up in __net_exit hook as done in bareudp and geneve.
>
> ---8<---
> diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> index 89a996ad8cd0..77638a815873 100644
> --- a/drivers/net/gtp.c
> +++ b/drivers/net/gtp.c
> @@ -70,6 +70,7 @@ struct pdp_ctx {
>  /* One instance of the GTP device. */
>  struct gtp_dev {
>         struct list_head        list;
> +       struct list_head        sock_list;
>
>         struct sock             *sk0;
>         struct sock             *sk1u;
> @@ -102,6 +103,7 @@ static unsigned int gtp_net_id __read_mostly;
>
>  struct gtp_net {
>         struct list_head gtp_dev_list;
> +       struct list_head gtp_sock_list;

After a closer look at the GTP driver, I'm confused about
the gtp_dev_list here. GTP device is linked to this list at
creation time, but netns can be changed afterwards.
The list is used in gtp_net_exit_batch_rtnl(), but to my
understanding net devices can already be deleted in
default_device_exit_batch() by default.
And I wonder if the use in gtp_genl_dump_pdp() can be
replaced by something like for_each_netdev_rcu().


>  };
>
>  static u32 gtp_h_initval;
> @@ -1526,6 +1528,10 @@ static int gtp_newlink(struct net *src_net, struct=
 net_device *dev,
>
>         gn =3D net_generic(dev_net(dev), gtp_net_id);
>         list_add_rcu(&gtp->list, &gn->gtp_dev_list);
> +
> +       gn =3D net_generic(src_net, gtp_net_id);
> +       list_add(&gtp->sock_list, &gn->gtp_sock_list);
> +
>         dev->priv_destructor =3D gtp_destructor;
>
>         netdev_dbg(dev, "registered new GTP interface\n");
> @@ -1552,6 +1558,7 @@ static void gtp_dellink(struct net_device *dev, str=
uct list_head *head)
>                         pdp_context_delete(pctx);
>
>         list_del_rcu(&gtp->list);
> +       list_del(&gtp->sock_list);
>         unregister_netdevice_queue(dev, head);
>  }
>
> @@ -2465,6 +2472,8 @@ static int __net_init gtp_net_init(struct net *net)
>         struct gtp_net *gn =3D net_generic(net, gtp_net_id);
>
>         INIT_LIST_HEAD(&gn->gtp_dev_list);
> +       INIT_LIST_HEAD(&gn->gtp_sock_list);
> +
>         return 0;
>  }
>
> @@ -2475,9 +2484,12 @@ static void __net_exit gtp_net_exit_batch_rtnl(str=
uct list_head *net_list,
>
>         list_for_each_entry(net, net_list, exit_list) {
>                 struct gtp_net *gn =3D net_generic(net, gtp_net_id);
> -               struct gtp_dev *gtp;
> +               struct gtp_dev *gtp, *next;
> +
> +               list_for_each_entry_safe(gtp, next, &gn->gtp_dev_list, li=
st)
> +                       gtp_dellink(gtp->dev, dev_to_kill);
>
> -               list_for_each_entry(gtp, &gn->gtp_dev_list, list)
> +               list_for_each_entry_safe(gtp, next, &gn->gtp_sock_list, s=
ock_list)
>                         gtp_dellink(gtp->dev, dev_to_kill);
>         }
>  }
> ---8<---
