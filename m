Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6963719ADA2
	for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842050; cv=none; b=H++6eOuSZp2whJkjG4nGStmYqfWyLVE6UeV+k3I6XZ5F0ekVApCaWAXvadPqiHzntMRODrAJMGrSP4PTHECakHD/1UBxW6Ik5dvG4bomYD4tVfxOiDwdtamn5tMFvOL2Wci/oDvRTVz7wBc0Wgm+cd+GKDRMv5+l7ee35/lOmQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842050; c=relaxed/simple;
	bh=fnM7XdZPmq4dQ8q57DyE5z4e346R3Iv66K4+vOj/nSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VahlkUPjpttRbxXtgd1l+SOkfTi9kJAQkxQj6A5DtggDUEDcIuKceHSNOhNCXGV4XxqbbRLvtFw3p3ZdovIfA16O4D6VaakFUK2OPnoj4YFgA/6EhkvjESicjsEfvwtgzIr3Mp+mIfVFgWeZevp48WPtj8x5ObfWsv/1eE14Ny4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de; spf=none smtp.mailfrom=bisdn.de; dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b=h6Su8rCk; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bisdn.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b="h6Su8rCk"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4669b3935e3so3417361cf.2
        for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 06:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bisdn-de.20230601.gappssmtp.com; s=20230601; t=1733842047; x=1734446847; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rzs1DO8cqSom2w5LB1plSfwZm2SKsh6MLmfHHtdFuyU=;
        b=h6Su8rCkmpy34HFwuvcAsqHjSli9oJfiCgzQMn0Ml6nWlf3qYsvfJnjaUqXq24oexa
         VlIb7oT8RdYfMVbcpedi9X2PGtPguJWQcFDXBGKKewEukWVpU2ZVslkMSzAJfxLQFvZJ
         VLU2n8trwli/VPYV6kS9T60aJYeLgWUlgx8jS13OEA5iePuHY1zD7ah0fyVontRhmP0/
         xLVWgOHElRzOM1lRiCc+Xvq/BP6mW6vpyQfuDUn/FpIn4X8gGN1blrtC4RMndwbM/t+M
         tOlz5p/2TazEVbqoVY6ftaok8SKSNc9MUdm4v1iioopGopVwCmE5pODEaM0aDxz6Bzie
         ygBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733842047; x=1734446847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rzs1DO8cqSom2w5LB1plSfwZm2SKsh6MLmfHHtdFuyU=;
        b=tAaBCeYK31BQGwXwKb4BirIgL9QVXcOOHAfjQhS4MVvwS+qZDDqKVd+s1mOAmTS5gz
         drpvuHeKWRmyvdat0941r2uduGthDBgm2YJyaJ3Tr8kxMybBELZq5ERq4hv4x4asWNjB
         zWMrcannwop1d+rNQ3w9l+ck4DFVCbqYVXtMb+9IkPv4YwnxiCnZVRn2vlrZNnNthBuB
         BvcR7IM4s+8ckzSBYBAwh1Xsgr9P3cuQbMBvPMHM2Tb5PF/0n46bm6wRYsrxul5PRvFn
         8CSWqUKdNywPjxtoZMd1hLSAJJtuEZZ1EY2JOueQBx+ehJnGs02awmjWpkluYi3Y9jlk
         mAaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG4g5kZVR6JOHU3xSg49jVESbIsReoBygDArfOEa0eQOIGb8BARqrbE43GXKmvOdLC16p0i7s=@lists.linux.dev
X-Gm-Message-State: AOJu0YwwUNUGY55GmYQJTo4KrKjtuaGypwytUC+4FML3S1Y9Yq+mjVOh
	KN0ZaVBD3yEPJFRPRgJ4TwHmwUVJLSO1fIGN5tllel2HHoJXHo67HWyyz3ghBN/C60ojzvzooz4
	U/dqgbfJEZ3jK7S6Sl5Ttc7VwKDpHOxY03QvEJUW1m8lic1o1TgJe+ECBeBVxlzwjIm8h/OtFZa
	/Epe+1DkssuuYyxu8Jksum3w==
X-Gm-Gg: ASbGnctz7383wl4Ht79GgwFu3KxCiHdsfsWXX3uyNtXT5+pnVM9Tn1lAY43BZZnrrDD
	Ad35OiI+LzeOlD1u8mqZE94gV3fcK/u3qVw==
X-Google-Smtp-Source: AGHT+IGsh2nFo1NsXdN/9EcCCJOyiewT7PU4OIYHkIeQY6kKt2wkQpzsETMHpFlZJixwWx1bhe0I8N/7iUts9Fm2jEI=
X-Received: by 2002:a05:622a:110e:b0:461:6599:b9a with SMTP id
 d75a77b69052e-467746ad834mr24853361cf.11.1733842047128; Tue, 10 Dec 2024
 06:47:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241210140654.108998-1-jonas.gorski@bisdn.de> <20241210143438.sw4bytcsk46cwqlf@skbuf>
In-Reply-To: <20241210143438.sw4bytcsk46cwqlf@skbuf>
From: Jonas Gorski <jonas.gorski@bisdn.de>
Date: Tue, 10 Dec 2024 15:47:11 +0100
Message-ID: <CAJpXRYTGbrM1rK8WVkLERf5B_zdt20Zf+MB67O5M0BT0iJ+piw@mail.gmail.com>
Subject: Re: [PATCH RFC] net: bridge: handle ports in locked mode for ll learning
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Hans Schultz <schultz.hans@gmail.com>, 
	"Hans J. Schultz" <netdev@kapio-technology.com>, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Di., 10. Dez. 2024 um 15:34 Uhr schrieb Vladimir Oltean
<vladimir.oltean@nxp.com>:
>
> On Tue, Dec 10, 2024 at 03:06:53PM +0100, Jonas Gorski wrote:
> >
> > When support for locked ports was added with commit a21d9a670d81 ("net:
> > bridge: Add support for bridge port in locked mode"), learning is
> > inhibited when the port is locked in br_handle_frame_finish().
> >
> > It was later extended in commit a35ec8e38cdd ("bridge: Add MAC
> > Authentication Bypass (MAB) support") where optionally learning is done
> > with locked entries.
> >
> > Unfortunately both missed that learning may also happen on frames to
> > link local addresses (01:80:c2:00:00:0X) in br_handle_frame(), which
> > will call __br_handle_local_finish(), which may update the fdb unless
> > (ll) learning is disabled as well.
> >
> > This can be easily observed by e.g. EAPOL frames to 01:80:c2:00:00:03 o=
n
> > a port causing the source mac to be learned, which is then forwarded
> > normally, essentially bypassing any authentication.
> >
> > Fix this by moving the BR_PORT_LOCKED handling into its own function,
> > and call it from both places.
> >
> > Fixes: a21d9a670d81 ("net: bridge: Add support for bridge port in locke=
d mode")
> > Fixes: a35ec8e38cdd ("bridge: Add MAC Authentication Bypass (MAB) suppo=
rt")
> > Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
> > ---
> > Sent as RFC since I'm not 100% sure this is the right way to fix.
>
> It was decided that this is expected behavior.
> https://man7.org/linux/man-pages/man8/bridge.8.html
>        locked on or locked off
>               Controls whether a port is locked or not. When locked,
>               non-link-local frames received through the port are
>               dropped unless an FDB entry with the MAC source address
>               points to the port. The common use case is IEEE 802.1X
>               where hosts can authenticate themselves by exchanging
>               EAPOL frames with an authenticator. After authentication
>               is complete, the user space control plane can install a
>               matching FDB entry to allow traffic from the host to be
>               forwarded by the bridge. When learning is enabled on a
>                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>               locked port, the no_linklocal_learn bridge option needs to
>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>               be on to prevent the bridge from learning from received
>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>               EAPOL frames. By default this flag is off.
>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Huh, indeed. Unexpected decision, didn't think that this was
intentional. I wonder what the use case for that is.

Ah well, then disregard my patch.

Best Regards,
Jonas

--=20
BISDN GmbH
K=C3=B6rnerstra=C3=9Fe 7-10
10785 Berlin
Germany


Phone:=20
+49-30-6108-1-6100


Managing Directors:=C2=A0
Dr.-Ing. Hagen Woesner, Andreas=20
K=C3=B6psel


Commercial register:=C2=A0
Amtsgericht Berlin-Charlottenburg HRB 141569=20
B
VAT ID No:=C2=A0DE283257294

