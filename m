Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F953D6474
	for <bridge@lists.linux.dev>; Wed,  3 Jun 2026 03:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780457439; cv=none; b=f8+weBufuk0mGRnhWHymW3WGaPtXVd1uKHg8SOw7DwA9U+yDi+WRBW7zkU1gcrOWdHP4nUNfUkWXjzJXVisb1pAcfXY00sgiUZX5tAmpUKGMokEidwdSShpmzgo1HGH/lqfxaCxDd2k1KR1uR6XSP3ssec52qklu9c6tvaZ04EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780457439; c=relaxed/simple;
	bh=HckXV8SgUm6gBOsERf+KnMnS8zcCmg+Nd4fBgn+6UKE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NcPs+P5QK3V03xf6oycM9BLHx6nktJ8MoEoE+UL27c45TfxRC75+qx//6DOyRI7xI6vN0UaCg5QaNqTqo1cOK+PB4YrDT8PtQQZCPel3NzH3Wp7lbj2xOGCaY63w/NqngNIgwZD459xvf0ZcTaDRug+2Ybtp84/Ri2IwNR+CQm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=d8rdz33I; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="d8rdz33I"
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 6533U3NL016913
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 3 Jun 2026 04:30:28 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 6533U3NL016913
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780457433; bh=HckXV8SgUm6gBOsERf+KnMnS8zcCmg+Nd4fBgn+6UKE=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=d8rdz33IM4nuvC2/SuI5GfmrcXoUs7Y+TClzQ9w/tqCO76IXp8eP+1V77i1IbHrfL
	 TYAi+ZIBdZbbTv68ZfRXmhwsDc3k2ify599r8hP/NEVGJ8bkmIZossNsjQ/TIW3TJs
	 kbqtkEByC+SkJxeGOnQBV8UExxPI22phHCxEOPtYn3mYrRap8Fns8DwJ1bZpXnB5Ln
	 Wy+cqdZ5dKhJXZMJuOosMd7efPWTG5pVLAWf8/8QOGD0RC2hSae3AURl9EcAnhRQc9
	 4erwzfqDqJ/HFntNib8RkbVFNZwQoWzqo1EO3/Yg9Nd59zuO0ba5j8KF+N8KkDWKxj
	 PmXH62RMp/vWw==
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
In-Reply-To: <2AC04CE3-1760-49B4-A25D-170629AAD38A@padl.com>
Date: Wed, 3 Jun 2026 13:30:17 +1000
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
Message-Id: <C9A205F0-0F73-423D-86C4-A0062E8475C9@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-5-72be14522e7c@padl.com>
 <t44kmhk6gqxnwhdvo7svouexwelwsya7zgukpbv3cxpfsmutqa@y3rjoj3tvqce>
 <A662D3F9-18DD-43C9-A43D-912E5A8A4360@padl.com>
 <2AC04CE3-1760-49B4-A25D-170629AAD38A@padl.com>
To: Cedric Jehasse <cedric.jehasse@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)


>> Good point, it=E2=80=99s interesting there is egress mapping on the =
6390 but only for FPri to DSCP. The Frame Priority Table set ordinal one =
would expect for egress QPri mapping is =E2=80=9Creserved for future =
use=E2=80=9D. (Be nice if it were an undocumented feature.)
>=20
> I misread the data sheet. Egress PCP to FPRI mapping is possible =
per-port on the 6390 family. This doesn=E2=80=99t resolve the other =
issue (MQPRIO-less ports on the 6352 family). But it is good news and I =
will revise accordingly in the next patch revision.


I did not misread the data sheet. The 6390 family does not support =
egress FPri to QPri mapping. It supports egress FPri to _PCP_ mapping =
(i.e. the internal and wire representations of the priority can differ). =
Clearly needed a third coffee.

Luke=
