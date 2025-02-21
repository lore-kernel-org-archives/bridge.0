Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE631FCFCE
	for <bridge@lists.linux.dev>; Fri, 21 Feb 2025 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740123307; cv=none; b=G0iS9Ymwg8bF5bmpK2iObfo4qVynM/RUEhYkVLIsyuIkcIexkgPlg+pSUBBI751FYKs97rr4xa50wV3juey5gbIfd2TqtrKYAP5hJw8lRT+Jltrgn8iWARJBtwXgiD1zmQfSekPzCOXHw4V41Y6rZo80xDwgfBa495nBFgHKEps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740123307; c=relaxed/simple;
	bh=T1VOQiQtQXiQ9wkvgL+WC9xJqcl7iT4O6gvw688nMkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udBIafiy8mpy5ULEuGxuht3LzdHn/7U6dr10U7rsu06kkFkWs9QeGu+s7yZwCLUKxxWdtRkZE+/WVXBx694fxSMk5sAl+JdeP6KthDalOmq+H8ndYPI1+vZtyEiZgzDbsJ1SShVlIgDbbURH7UuhVVm/bhvVVNTxCJDxPafEQ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B77JSJJY; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B77JSJJY"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38f504f087eso1501113f8f.1
        for <bridge@lists.linux.dev>; Thu, 20 Feb 2025 23:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740123304; x=1740728104; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+QeLQVPsYwD13WdLTO9iwIZOqXlzHUuuYA44GHEnsU=;
        b=B77JSJJYxzXsujuq2eCo8xDfQeujONs65yuG0IB23FeIyVgWQXV8csw0PXPmeSnr9c
         OVElH6/4/kbj4Qa/DP6PzSliw0zWTUapLFRr/TOCP58Wwg7GhrBVlVQN7zxRb7qqjrEk
         UYVm+P4iIYOgkvhZepmc80MdYFSbtf/moMxdjGoIbj8Y58nCe5fZcJUziDIUJfTRZ4Cz
         5K0O+JGYTXE8Ftc0naa57LlQUqJ0GSPbDjmLEkIAFK+yOVSEo4lHz2gFRZ5oAYyF9PWc
         MCIjaHRU0DGRT2iS/N1gswBRUI/k64HeFwUtQY0kao3bzDUBwp3oSZK3+puSAASq+4Wb
         jsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740123304; x=1740728104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+QeLQVPsYwD13WdLTO9iwIZOqXlzHUuuYA44GHEnsU=;
        b=GcARsQW6eSWjBdSMGz8wRHcTkphjNzIMeqpjhNh5uYMN6v+S7oEDQmzDOLeC2sH2XG
         z5uJaa80KxmLuc49xrhojdSyHkj8alwK9bzL3fBnc8aydpc9cej/mvzHDHPL8MXhj47n
         8Jg4q8tM5ijQ6ZgssLoixWwYRRfHlnOpy6tr48tV0whMAyGDzEdaMy8EEguCHmGv1VAv
         C/y0yVMiCbS+8rzPdDT8XPwMp9mKFbmlab1HM9gGUpeRaXjOmXaAeKElqI8uQqN5M2B3
         85D0gtjS8Bnlz0HIKKhiz+5ED8AIzCMo3HO/of5qYzhkms9xVUa21lQVC0mUE9skjequ
         OPeg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ5c2ephn4hIwk02KMLmZvVbWIf6EFpWpWZl825kbUwbGBE1MjWCfQ5OzQ3cU+/fcB/GmBpkw=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywx2Y7OFIifz+djxCmLCn9fmBdBGzHjeOBueTavqjY6G79mNnu8
	BSMyYM4anAwajSJgB1oOI+qVatZ8Hdv0i4LxPRf5NJ3FYr6u8MwxnrMCzLXW8RbXhANcQyVt5Wu
	hq3i9OLdfIywTBgZEpYZmm5DZRZs=
X-Gm-Gg: ASbGncsRRTI2r7k58WcBXX/ZaMKoCLFlEkd+aWHwSSieYGujWhR+W+xUCwH8zqmFTNz
	+QhMsFqMtHqkOzjTtvtoIgU5+TSGwa3k03L2QlKtKPBpDLLDNVP6t8i1MmvFceGDNKeUs1qVBB8
	zIcy8FGg==
X-Google-Smtp-Source: AGHT+IEnf7T/XWdU9Kctt2h3J5gBBMYg3Bh51JvuIgDPQVVK7cGhz8HpBuMv8GGd62Uk1SqkypkvwsyahBFfgLBFMsQ=
X-Received: by 2002:a05:6000:4026:b0:38f:2856:7d9a with SMTP id
 ffacd0b85a97d-38f6e7563cfmr1756891f8f.3.1740123304054; Thu, 20 Feb 2025
 23:35:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250219125039.18024-8-shaw.leon@gmail.com> <20250221040641.77646-1-kuniyu@amazon.com>
In-Reply-To: <20250221040641.77646-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Fri, 21 Feb 2025 15:34:27 +0800
X-Gm-Features: AWEUYZnNy9JuajIA_7tDw52YSOa4CSIEVEzv6mMTGyYFjN7-s6b2UXlhoSAg5e4
Message-ID: <CABAhCOS3BC+spLNrb_P8Ovzo18BwHU6UEc6Aq80_YKUoc8rfMQ@mail.gmail.com>
Subject: Re: [PATCH net-next v10 07/13] net: ipv6: Init tunnel link-netns
 before registering dev
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

On Fri, Feb 21, 2025 at 12:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Xiao Liang <shaw.leon@gmail.com>
> Date: Wed, 19 Feb 2025 20:50:33 +0800
> > Currently some IPv6 tunnel drivers set tnl->net to dev_net(dev) in
> > ndo_init(), which is called in register_netdevice(). However, it lacks
> > the context of link-netns when we enable cross-net tunnels at device
> > registration time.
> >
> > Let's move the init of tunnel link-netns before register_netdevice().
> >
> > ip6_gre has already initialized netns, so just remove the redundant
> > assignment.
> >
> > Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>
> left a small comment, but not a blocker.
>
>
> > @@ -1565,6 +1565,7 @@ static int ipip6_newlink(struct net_device *dev,
> >       int err;
> >
> >       nt =3D netdev_priv(dev);
> > +     nt->net =3D net;
>
> This hunk is not necessary as we'll call ipip6_tunnel_locate(),
> but it's harmless and not worth reposting the whole series given
> we are alredy in v10.  You can just post a follow-up patch after
> the series is applied.

Seems ipip6_tunnel_locate() only sets netns for newly created
devices (for ioctl). ipip6_newlink() is calling it to check for
conflicts, so we might need this line.

Thanks for your review!
