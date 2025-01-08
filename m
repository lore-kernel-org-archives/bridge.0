Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36D11DFE0A
	for <bridge@lists.linux.dev>; Wed,  8 Jan 2025 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736325427; cv=none; b=TI41BbaBS5zctYLUMPCmQrmzP+yN6fGLp8N+qWBcbdOqkJuiYzsn44DqM5qbk8kIKI9Lsq4j2kJKClQxf4+NaDvhyYqokiBITI4wAYGmA4xTMFKnXHx78V6OtCHcDZX4bSNUrfGEit5VvpZeMNUQBiYA4EsmUkmKv+9PuhQCoUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736325427; c=relaxed/simple;
	bh=nxtV4VMFqi9OawJzTCLL5xTqLQUX4En71MCqEoFkWhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGhq08b60gmuQSYhD4NA0IOtPEloev+NFwMVNw3UydjSlO8yg8vMLjNd8JRBJ3AYUAQrrLKTXKw5L0dVuv1fBNYNKQjgpC4RvIa9kfZCBqJmGL3xUopEXWixZ1udyf6trUKaLRC0QGPvJobZrwv+xz8Seo6U2Rw/pnVNjo4t6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjD8yBdW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjD8yBdW"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-386329da1d9so7716334f8f.1
        for <bridge@lists.linux.dev>; Wed, 08 Jan 2025 00:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736325424; x=1736930224; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvettVxfJ9lYY3or3UxLpfyl/cdkwWLgR9kVNnFx6ho=;
        b=OjD8yBdW2FVpUdIrAQ0rp4oHBxYu7i1jYHpeQ1Huo89AdLMU3kFPjDAnnqQwDU6fXz
         2QzRmlIXiqD4ypbX7x3ggtgUic5/xQxpGSO2/FUHclpzWXXrwpoi6uSb4QaEneNIncbq
         gr3VTsSB77Jt1f0O716Y9+HGOrbIbL9Qc1ZQ11tBm46Lp1Jjw1W3yNc2MOA0hpot/vNG
         SJHfN6OezwLHYrZM+/Hr63cQGHeQJoDSJCGo1naQJAtXNYxYSonvrkxlccqGeqw5T4oX
         pIY0qxgE1kXZD8enlTBwrHj3ttuVNmrpNkblPfGoDEzcW0JZMSLfsciJqPVavxQIfHEA
         orxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736325424; x=1736930224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvettVxfJ9lYY3or3UxLpfyl/cdkwWLgR9kVNnFx6ho=;
        b=eWyrcV7vBHG1L2vaqiQheaK5tS+vlpYErPcdug+6s9XUM78kA+OC43EqPtKQ4wulba
         gbvPhhkNATSnVOV0efovBAHcMCiD0azQcE5pPyuLoc4rt3NFcLegTLvycqb7PpKqUtBM
         pNGCdkgiSV+6+vGEtXKH4+HaX2OdJInChuanSLWYwDyMkNHc03q5sVrfi1SE2pCEtor0
         4TDXmxbna8VjudiBmFEWvHe/+3EYawExJX+itpEDhLLYwsK6Fu6qEIaMe+U1Nn3TIcam
         OIFqm2zGUBH8Iy18pNEA1Fd3e5Ok+9m9hA2tcV2YSBCX8kT+i4mHwz1IzXLes8xODpZp
         xo1g==
X-Forwarded-Encrypted: i=1; AJvYcCVoYpixtvLrar/r60AEFzCYZXbjqkGD3q0IkucHYrpTM8+coXS68OvZpuWTuvyaxafsndlzWV0=@lists.linux.dev
X-Gm-Message-State: AOJu0YxNYYXvM5iRueJcmid2tXeaQFmd0JL8a/gYqh8BnJm1wlAMwf+h
	ZsOUy6XOphUI1qf2CkYsbtIJt/Jcuf17XWXLwdURHuvd4qtFAUDpRXHMn8jH6/6OjjTmBnHGaaH
	cG91y0WiLjeiuObkR6tKg0oz1i+A=
X-Gm-Gg: ASbGncvJU9u2eYO2+b9YYhJvnrR5aKoWL4TXm7L6smw43EX6J+tM42kzqrg0lQLth+j
	6hBZXwlD/1pC9z2ASSaHiBpnjJfvixQEvA1L9
X-Google-Smtp-Source: AGHT+IFnmy3aEmpEtSYOMGcp/W5oHyWUG1cZe2OhDShkb+8U3jvy3oPHzekY3BLrSLnXQaOhfCodhl5ttnW21/EGgAw=
X-Received: by 2002:a05:6000:4712:b0:385:f38e:c0d3 with SMTP id
 ffacd0b85a97d-38a8731a4d3mr1171129f8f.58.1736325423889; Wed, 08 Jan 2025
 00:37:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250104125732.17335-1-shaw.leon@gmail.com> <20250104125732.17335-3-shaw.leon@gmail.com>
 <20250107123805.748080ab@kernel.org>
In-Reply-To: <20250107123805.748080ab@kernel.org>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 8 Jan 2025 16:36:26 +0800
X-Gm-Features: AbW1kvZots7MSnDo6hVFO1pdLy0jTDp88J1frKk6l9Bo0g1-dsYfw260dsxsY30
Message-ID: <CABAhCORV_s9m-EJ8914zUXCXt6O_e1wsaOVdSKUtm0Rbvc4orQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 02/11] rtnetlink: Pack newlink() params into struct
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Donald Hunter <donald.hunter@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Hangbin Liu <liuhangbin@gmail.com>, linux-rdma@vger.kernel.org, 
	linux-can@vger.kernel.org, osmocom-net-gprs@lists.osmocom.org, 
	bpf@vger.kernel.org, linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com, 
	linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, 
	bridge@lists.linux.dev, linux-wpan@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 4:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Sat,  4 Jan 2025 20:57:23 +0800 Xiao Liang wrote:
> > -static int amt_newlink(struct net *net, struct net_device *dev,
> > -                    struct nlattr *tb[], struct nlattr *data[],
> > -                    struct netlink_ext_ack *extack)
> > +static int amt_newlink(struct rtnl_newlink_params *params)
> >  {
> > -     struct amt_dev *amt =3D netdev_priv(dev);
> > +     struct netlink_ext_ack *extack =3D params->extack;
> > +     struct net_device *dev =3D params->dev;
> > +     struct nlattr **data =3D params->data;
> > +     struct nlattr **tb =3D params->tb;
> > +     struct net *net =3D params->net;
> > +     struct amt_dev *amt;
>
> IMHO you packed a little too much into the struct.
> Could you take the dev and the extack back out?

Sure. I thought you were suggesting packing them all
in review of v3...
