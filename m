Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD9625B0BB
	for <bridge@lists.linux.dev>; Tue,  2 Jun 2026 21:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780434783; cv=none; b=dxr8h9waS0q/wjC9x7Qk7hN0AsLMgsaSAa1lnLo3C3gRG7n2ZhiAXZxksRTqxII8pgpi74IHxHA2oQmvlXDfGkKVgh9LullUi8tpisyArWrn8RbrM56mPq/TOV3rrVWqvN5bWoF5ioW5p9jh1h27b3tHy4I6zuKBR6t7/+8Z9hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780434783; c=relaxed/simple;
	bh=HtE+CUeOQe9K5828UtNu62LtqQ103MigfZnxhbdVnDk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OwYB8DToeaOxyZzK+aJeR+g8QkJjWLdMi1fHY4CDYfpCkKPjGG5bjlEKCIdS+oFhuP/68OPovR/Mc24yJDV28GUMaCedCitUe8JZ97ln6/tLKFbKw72esjtXrZkuIw8HYhZhLHPabsDPtH/+ATmCvs9AIAyjisTLrU/6oiOSl+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=leG9Z8FI; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="leG9Z8FI"
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 652LCNev015764
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 2 Jun 2026 22:12:25 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 652LCNev015764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780434768; bh=HtE+CUeOQe9K5828UtNu62LtqQ103MigfZnxhbdVnDk=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=leG9Z8FIM3pJZ4l6nIiMqriryyD81HF1WcqASUuCAQC8YfQnmGHBXnHR5AcsC0Jrq
	 gSqqwc7tYZzHhwa2HhW62nORQsr6432wwfL8PK6DaY1cayHxN86pW/bM/HUZO/pK7m
	 nleseDQe6n0C+CHprDUyKRtdYjFjCVezsm/+DG4MRDHmhD2SLKIjGpH5THZ7Gh8B63
	 4zU3b21yxROV26YPWKFd85WM4/0H8Oa2DEmZRw8XwDvQqDMZIpD1+gf1JCRvs7KtYj
	 so1tCNwj9CwPQDYR+Kgjni5Zw1fwzKeSTqUSRYG0mA9lKZYHvTQ6cTINnN0Dz9wpB5
	 jTOqOPufiACwQ==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next v2 5/6] net: dsa: mv88e6xxx: MQPRIO support
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <t44kmhk6gqxnwhdvo7svouexwelwsya7zgukpbv3cxpfsmutqa@y3rjoj3tvqce>
Date: Wed, 3 Jun 2026 07:12:12 +1000
Cc: Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bridge@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Max Hunter <max@huntershome.org>, Kieran Tyrrell <kieran@sienda.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A662D3F9-18DD-43C9-A43D-912E5A8A4360@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-5-72be14522e7c@padl.com>
 <t44kmhk6gqxnwhdvo7svouexwelwsya7zgukpbv3cxpfsmutqa@y3rjoj3tvqce>
To: Cedric Jehasse <cedric.jehasse@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)

> In case of per port priority mapping, i don't know if this is working =
as
> expected, as the IEEE priority mapping is done at ingress.
> Eg. i think if MQPRIO channel mode is used to configure a pcp to queue =
mapping
> on port 1 and a different mapping on port 2. Traffic received on port =
1 that
> gets forwarded to port 2 and egresses port 2 will end up in the queue
> configured by the mapping on port 1. As mqprio is an egress qdisc, i =
don't
> think that's expected.

Good point, it=E2=80=99s interesting there is egress mapping on the 6390 =
but only for FPri to DSCP. The Frame Priority Table set ordinal one =
would expect for egress QPri mapping is =E2=80=9Creserved for future =
use=E2=80=9D. (Be nice if it were an undocumented feature.)

I will remove the per-port mapping for the 6390 so all ports share the =
same mapping as they do on the 6352.

> I have a patch that hasn't been submitted to the mailing list yet =
which
> implements support for the dcb app pcp-prio command. This is also done =
by
> configuring the IEEE priority mapping table.

Definitely happy to take a look if and when you submit, but I do plan to =
continue with this patch series (originally proposed as an RFC in =
September 2025).

Cheers,
Luke=
