Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1399A1EA7CE
	for <bridge@lists.linux.dev>; Wed,  3 Jun 2026 01:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780450883; cv=none; b=p1/nd0F48Zrs7sn4JZoV/vu9W4vD7yBbvtNSMpAbXXsJU4YFHXYonLqLYJq8FPT/g1hpBeKQPHzYUeBlf1R8Zj/L/nBd+GuyfIiEpX1JKZd7X7+ib2zRZ5A4bmg0plZK6NcCS2KvrIef44qPgl1i7FhYUrCQZ0pUm4XRbMKu4+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780450883; c=relaxed/simple;
	bh=antjUfKm4W1pYTqXE3aEg6NNOtkzJSasuEtZZhVeWPo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jKbU8gqTdm+U+r980Gv24D/wsGEL4MtLZ4TfoUPYYb7kRU22RKDIqhwwCrueWVz7Y7tv9x+gx6pcJZPicnNZzcivnpKKqyLVBTSFb37RHiy5Ru3XYd05/KExItddKXArkrlIBjL42igKyBEzQDLoNOTvuKmVehJMNKz/FxHGN3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=HZYcnj18; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="HZYcnj18"
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 6531ejR5029996
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 3 Jun 2026 02:40:48 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 6531ejR5029996
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780450862; bh=antjUfKm4W1pYTqXE3aEg6NNOtkzJSasuEtZZhVeWPo=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=HZYcnj18IitgOS7y9h3kj9PC7MkBsLr0ZomZLhWAz6cVgJAEBnvbPmmhk/86wwVZ/
	 fhbmfhGqW9Ivv20UURwfmRjBkrlTvzmEsQPvws7Vv1WeWXVfnF1qbfow2nr/TjiLWo
	 REhTyfcWjq+1dZA7TI6viZfkcojvQiXaXlkKIqpRWZnvsQqrWxp7rFjJFxCjyQxK8/
	 SNAx9/AWWsgR8nI0jHJNBVA4lP155dM8eqOJGp6ZZCUCHsPddHwgwckc30IUrhHrLb
	 nGUAEwZL91Ic69VLMzokm1Y8lL5AuRW+YIiUYzyThIgudVoOsPdHymkJo63BOODK9v
	 +Z/Z7+fiMAF8g==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH net-next v2 5/6] net: dsa: mv88e6xxx: MQPRIO support
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <0402DFFF-634A-40C4-BC1E-B038F20926FF@padl.com>
Date: Wed, 3 Jun 2026 11:40:35 +1000
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
        Ivan Vecera <ivecera@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
        linux-kselftest@vger.kernel.org, Max Hunter <max@huntershome.org>,
        Kieran Tyrrell <kieran@sienda.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <89BA4203-110E-4767-895C-A2808602FAF8@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-5-72be14522e7c@padl.com>
 <t44kmhk6gqxnwhdvo7svouexwelwsya7zgukpbv3cxpfsmutqa@y3rjoj3tvqce>
 <A662D3F9-18DD-43C9-A43D-912E5A8A4360@padl.com>
 <8C6AD966-2C28-4BEF-95C4-1B2AC3751513@padl.com>
 <29c09316-c911-456e-acc5-e18402da4bd4@lunn.ch>
 <0402DFFF-634A-40C4-BC1E-B038F20926FF@padl.com>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.500.181.1.5)


> On 3 Jun 2026, at 10:15=E2=80=AFam, Luke Howard <lukeh@padl.com> =
wrote:
>=20
>> On 3 Jun 2026, at 9:55=E2=80=AFam, Andrew Lunn <andrew@lunn.ch> =
wrote:
>>=20
>>> But there=E2=80=99s an alternative, more invasive, solution where =
the MQPRIO
>>> configuration is attached to the bridge itself.
>>=20
>> What about ports which are not attached to a bridge? They are just
>> standalone, have an IP address of their own, etc.
>=20
> That is a good point. So, barring a switch feature I=E2=80=99ve not =
yet found, I think the only options are either to drop MQPRIO offload, =
or to accept that ports with no MQPRIO mapping inherit the per-switch =
mapping. Arguably that=E2=80=99s the case today anyway (each chip has =
its own default frame priority to queue mapping), so the user should =
have no expectation of queue assignment on a port that hasn=E2=80=99t =
been configured.

We could add (e.g.) bridge_setup_tc to dsa_switch_ops, which (in the =
mv88e6xxx implementation) could validate the bridge contained all user =
ports. But it would not be possible to block a port from leaving as =
port_bridge_leave cannot return an error, and tearing MQPRIO config down =
silently would be a different sort of bad.=
