Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF068248B
	for <bridge@lists.linux.dev>; Tue,  2 Jun 2026 23:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444157; cv=none; b=tLnGOqjhugzV3sI6C+iJeg+fjY5eL0PDpV00svc5szFGTikGqSrFkLDdx13zJciLYLslH++C1Y3USSWK9AKrB9RxmTLu+/eLegGllDAFTWga8pEijtGEpBJFoYg+3kvjUPSHcym6El1X6UNErSx/bSTs9rClDhJpC6WRBfvObHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444157; c=relaxed/simple;
	bh=JN++q9ViOYyXmmlhWxb4sc7AKbNJ1H/BZasY2l0ayeo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=J8AP1RwjiFy0YEs1dcfVlZauIf5aagicdlDSoWtCWEEiwRGZ1uf6R+HElMgXhL4X3RlEEysCGGJ6tTqV7J92Z90nvEewGqJGsRN/DjDoZRfF6krM4/3/eUVYA1FzYzO/bjEdyDHRyq93w9iHeceLsUMiCvJ34dbFUeN3sYlySkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=Ps3+sYrY; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="Ps3+sYrY"
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 652NmoD3010575
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 3 Jun 2026 00:48:52 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 652NmoD3010575
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780444150; bh=JN++q9ViOYyXmmlhWxb4sc7AKbNJ1H/BZasY2l0ayeo=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=Ps3+sYrYuR3H3YCBAlVsDgpMVkOGZ3MV7Ld0Z4ioop5zQJyhZ5vc3B242tEBo1dqo
	 bsXAZgnhRDBBkk3fYc6cPQ6JGuBUCZf6esSO2Z4APqveUPSiw7I+iFZeF7BemvEy8O
	 KOmRA7LTXTMUejNlFaUAmeVaA3bPNTMibL2AEgLCty6ZffJuAHgNodpOqkrXVWKhlG
	 RcggvDOhUqKXNTyuGEqOgZhehvMtpfMQ7JAUK/Ni+ghrgqh4YUlfxW5VBMdz6108NJ
	 p9C5lpMURWlA9yXgEhTbf+9jEY9dLcVUcXClj3tRLNS1XKBn3tzBFynSZrlqG89k7f
	 tAme8GNcbBciw==
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
In-Reply-To: <A662D3F9-18DD-43C9-A43D-912E5A8A4360@padl.com>
Date: Wed, 3 Jun 2026 09:48:39 +1000
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
Message-Id: <8C6AD966-2C28-4BEF-95C4-1B2AC3751513@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-5-72be14522e7c@padl.com>
 <t44kmhk6gqxnwhdvo7svouexwelwsya7zgukpbv3cxpfsmutqa@y3rjoj3tvqce>
 <A662D3F9-18DD-43C9-A43D-912E5A8A4360@padl.com>
To: Cedric Jehasse <cedric.jehasse@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)



> On 3 Jun 2026, at 7:12=E2=80=AFam, Luke Howard <lukeh@padl.com> wrote:
>=20
>> In case of per port priority mapping, i don't know if this is working =
as
>> expected, as the IEEE priority mapping is done at ingress.
>> Eg. i think if MQPRIO channel mode is used to configure a pcp to =
queue mapping
>> on port 1 and a different mapping on port 2. Traffic received on port =
1 that
>> gets forwarded to port 2 and egresses port 2 will end up in the queue
>> configured by the mapping on port 1. As mqprio is an egress qdisc, i =
don't
>> think that's expected.
>=20
> Good point, it=E2=80=99s interesting there is egress mapping on the =
6390 but only for FPri to DSCP. The Frame Priority Table set ordinal one =
would expect for egress QPri mapping is =E2=80=9Creserved for future =
use=E2=80=9D. (Be nice if it were an undocumented feature.)
>=20
> I will remove the per-port mapping for the 6390 so all ports share the =
same mapping as they do on the 6352.

There is actually a slight impedance mismatch here which I hadn=E2=80=99t =
previously considered.

MQPRIO is a per-port Qdisc, but the FPri/QPri mappings on the switches =
are global (even, as you point out, on the 6390 as far as egress queues =
are concerned). Whilst we do validate that any MQPRIO-configured port =
has the same mapping, we can=E2=80=99t do anything about ports on which =
MQPRIO has not been configured (otherwise we would never be able to =
configure the first port). These ports implicitly inherit the per-switch =
mapping.

I think this is acceptable because, if one has not configured MQPRIO, =
one should have no expectation about which egress queue traffic ends up =
in. But there=E2=80=99s an alternative, more invasive, solution where =
the MQPRIO configuration is attached to the bridge itself, and is copied =
to (but not writable on) the user ports. This would require =
dsa_switch_ops changes.

Luke=
