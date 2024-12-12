Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751D3211A21
	for <bridge@lists.linux.dev>; Thu, 12 Dec 2024 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734008803; cv=none; b=aam2S0lM02cB5R6QZt3yPGl3ZxlOdMtzGAolPNkqswCXSIcDenkr8wEu8C2Wp41DKQWwlY1n1gTz5ctEdKgoq2CP/hbLEBDJAN2cOhzkI1oyU9vHv7bf2Dp0htTUZfumZ9uzq4o1iMIMxeQ/RwFXeVTpEdawXKPpri7pEI+W3xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734008803; c=relaxed/simple;
	bh=QtnJQVvfbhujzCBbhdoVTuAqzhIPgOKP0r086zlDy7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/Apqum03kGBI+CNFfZGWhkzLEQmxNYF0KuZVnuHx+YcgGwq44qEy3hC4R8j2eZWka8LGPclmJEdvFq+Yxb5Ev8Ce4IuTWQVkb9VRVgHAnNwW6KwKrBeph5RV6HU0GLD3rvLXGaXzcQ4hCIKniWZDSqm2vZItpfc6t0c4l4j7r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6fSbvX7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6fSbvX7"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43622267b2eso6030175e9.0
        for <bridge@lists.linux.dev>; Thu, 12 Dec 2024 05:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734008800; x=1734613600; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqYxTqAiECe9wyyAXaPuVyEXlxRKQjZazVAEQa5Qpbg=;
        b=B6fSbvX74Oeb79WvJcruC5WnNhrYsJqJqLG+FHGbAYLBBpJiihNFULZbvrWH/q2B2v
         LcaKNMxLcVX37T73LNOzyCG78z/JovSVr8b3J/E0CfG+OwZcvj3csyLgy85kRz7yJS4o
         K+EwzJZRHo5OLiEMDH+Ch6j2Azg4xsDLHPBVvvwM9y0ag1qkjQ9Cy+3n2klCjTytBdvk
         ZNtSoNJFxhAuD2x2ozAYOCfXomHrJ1e5quudq66rPV/U0/sUtzY7IYVGzwrpAoJtZJji
         zbbD2xLzzYJ8NK7Xo4e5sK1hDotQ7e3LaRPYN/oHoueMSTIcTMBj+TNkLf8e5p849loR
         AjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734008800; x=1734613600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqYxTqAiECe9wyyAXaPuVyEXlxRKQjZazVAEQa5Qpbg=;
        b=svdj1Up+Eb5HAWMgw3Wjx34zJVCYMQHcYDWW8Ybb63mAAuBsaYddPqu0tDe5VnQzFW
         wbVcU6JVVRb9qo5vI0yAEpMZw9KlknE7FsspubPAp79bR14Uwp4tJn/epGq+nyr2T05a
         QpPDW19FNPYazwG57fyBy8QK83EC0Nwt6uRODbzkNmRkfho7tMhbCDx1VVxdt5phUUSd
         eKSO5dEXtnAP2yLt4YPQZwZek3YVCa17vhKQpZiFfRwwS7Lxl8ZFwtEXnu/G6yRB3dff
         5rNy9GaxYmqL8BLWEXJKFD7OgHJznbvXDlrgWBuhWtg44JrifnrKqJr2FnPxPEERrF69
         EqOA==
X-Forwarded-Encrypted: i=1; AJvYcCVTbBCEm5UiF1b7mRj8k00qrrknRsQzj1cHJdbtWDqhmHqVZdnNxZp2WCD1TpBEmSaeXws4OOI=@lists.linux.dev
X-Gm-Message-State: AOJu0YyK0SDjjyHZm+e/40u8hf0IbTN3WAbPaWpn8+ynu299IiBVsu+t
	SAeGFcFbLNPBm7LKbP4G+/QQUl8M8GVB2ByZ6ZQuyMI3Pt0YCgrKxLb9WeX1/eP8UgNalhBOsCC
	kzvFopXk2v+jKvI6Cxapzh1twkMU=
X-Gm-Gg: ASbGnctanSP07rSHr1fJcDnEz1lDn6aH74LGs36EuIQKug8ckbFTbbGK23tiBtTIdO7
	WgB27B2z8rWH/aXlK22LTPvMofLzX7juulFvn
X-Google-Smtp-Source: AGHT+IEgToBDxS7Y2rJTQaW+KRxkcbBuEM1S3SQpzBBgB7EfM9NZPQ+SlbrHysoSI6mEreAZ9kYV8K51n0HSyiFVXHg=
X-Received: by 2002:a05:600c:3acf:b0:434:f8a0:9dd8 with SMTP id
 5b1f17b1804b1-4361c345006mr53002405e9.1.1734008799513; Thu, 12 Dec 2024
 05:06:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241209140151.231257-1-shaw.leon@gmail.com> <20241209140151.231257-6-shaw.leon@gmail.com>
 <4a2fe99a-772d-4df1-a8ef-14338682b69e@redhat.com>
In-Reply-To: <4a2fe99a-772d-4df1-a8ef-14338682b69e@redhat.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 12 Dec 2024 21:06:01 +0800
Message-ID: <CABAhCOQnMGm8y5bVj_fg5veJqim1PEEa02oZHqFt7ZPEQMpFzw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 5/5] selftests: net: Add two test cases for
 link netns
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jakub Kicinski <kuba@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
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

On Thu, Dec 12, 2024 at 5:40=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 12/9/24 15:01, Xiao Liang wrote:
> >  - Add test for creating link in another netns when a link of the same
> >    name and ifindex exists in current netns.
> >  - Add test for link netns atomicity - create link directly in target
> >    netns, and no notifications should be generated in current netns.
> >
> > Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
> > ---
> >  tools/testing/selftests/net/Makefile        |  1 +
> >  tools/testing/selftests/net/netns-name.sh   | 10 ++++++
> >  tools/testing/selftests/net/netns_atomic.py | 39 +++++++++++++++++++++
> >  3 files changed, 50 insertions(+)
> >  create mode 100755 tools/testing/selftests/net/netns_atomic.py
> >
> > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selft=
ests/net/Makefile
> > index cb2fc601de66..f9f7a765d645 100644
> > --- a/tools/testing/selftests/net/Makefile
> > +++ b/tools/testing/selftests/net/Makefile
> > @@ -34,6 +34,7 @@ TEST_PROGS +=3D gre_gso.sh
> >  TEST_PROGS +=3D cmsg_so_mark.sh
> >  TEST_PROGS +=3D cmsg_time.sh cmsg_ipv6.sh
> >  TEST_PROGS +=3D netns-name.sh
> > +TEST_PROGS +=3D netns_atomic.py
> >  TEST_PROGS +=3D nl_netdev.py
> >  TEST_PROGS +=3D srv6_end_dt46_l3vpn_test.sh
> >  TEST_PROGS +=3D srv6_end_dt4_l3vpn_test.sh
> > diff --git a/tools/testing/selftests/net/netns-name.sh b/tools/testing/=
selftests/net/netns-name.sh
> > index 6974474c26f3..0be1905d1f2f 100755
> > --- a/tools/testing/selftests/net/netns-name.sh
> > +++ b/tools/testing/selftests/net/netns-name.sh
> > @@ -78,6 +78,16 @@ ip -netns $NS link show dev $ALT_NAME 2> /dev/null &=
&
> >      fail "Can still find alt-name after move"
> >  ip -netns $test_ns link del $DEV || fail
> >
> > +#
> > +# Test no conflict of the same name/ifindex in different netns
> > +#
> > +ip -netns $NS link add name $DEV index 100 type dummy || fail
> > +ip -netns $NS link add netns $test_ns name $DEV index 100 type dummy |=
|
> > +    fail "Can create in netns without moving"
> > +ip -netns $test_ns link show dev $DEV >> /dev/null || fail "Device not=
 found"
> > +ip -netns $NS link del $DEV || fail
> > +ip -netns $test_ns link del $DEV || fail
> > +
> >  echo -ne "$(basename $0) \t\t\t\t"
> >  if [ $RET_CODE -eq 0 ]; then
> >      echo "[  OK  ]"
> > diff --git a/tools/testing/selftests/net/netns_atomic.py b/tools/testin=
g/selftests/net/netns_atomic.py
> > new file mode 100755
> > index 000000000000..d350a3fc0a91
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/netns_atomic.py
> > @@ -0,0 +1,39 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +import time
> > +
> > +from lib.py import ksft_run, ksft_exit, ksft_true
> > +from lib.py import ip
> > +from lib.py import NetNS, NetNSEnter
> > +from lib.py import RtnlFamily
> > +
> > +
> > +def test_event(ns1, ns2) -> None:
> > +    with NetNSEnter(str(ns1)):
> > +        rtnl =3D RtnlFamily()
> > +
> > +    rtnl.ntf_subscribe("rtnlgrp-link")
> > +
> > +    ip(f"netns set {ns1} 0", ns=3Dstr(ns2))
> > +
> > +    ip(f"link add netns {ns2} link-netnsid 0 dummy1 type dummy")
> > +    ip(f"link add netns {ns2} dummy2 type dummy", ns=3Dstr(ns1))
> > +
> > +    ip("link del dummy1", ns=3Dstr(ns2))
> > +    ip("link del dummy2", ns=3Dstr(ns2))
> > +
> > +    time.sleep(1)
> > +    rtnl.check_ntf()
> > +    ksft_true(rtnl.async_msg_queue.empty(),
> > +              "Received unexpected link notification")
>
> I think we need a much larger coverage here, possibly testing all the
> update drivers and more 'netns', 'link-netnsid', 'peer netns'
> permutations for the devices that allow them.

OK, I will add more cases. But I'm afraid I don't know how to build
valid parameters for all of them, and some seem to require hardware.

>
> Thanks,
>
> Paolo
>
