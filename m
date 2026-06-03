Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EEB18CBE1
	for <bridge@lists.linux.dev>; Wed,  3 Jun 2026 03:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780457440; cv=none; b=fZpPrh71GX54FBn65i131mPLBiZNDjtyosQNp2g6zRCpC0GEEF0kMS0XF4WNT420QlsLPdEM/MjBTaRpdGKbL9UV784IRHwe4OFJxIT93DFS7eHqA0WL7tD0sLKbum5ADDBRCMGEe4h0hY3/AYzCH5zSyiq8JQQJqBhLOzt7U64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780457440; c=relaxed/simple;
	bh=gqIbzrXWPAjinn/p8sMbvR/ov2hajbGhcdxtuYxTUTc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DIlysuGz/pvWqhd0g4HK/YHayMuw2ledz+N682JQ/4iiaBE4X3CYFNfAmPkSEGb6A1u7kszIIBnrJ0T/7WyTVZalONKqYjzYir3jNcyLfHdEAaRkpgAV2h4rlywnafClB16/n3ZfmlP3c1r1EfuzKmhO6KmfFsWZnGBGr4mo5e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=Foso4T0d; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="Foso4T0d"
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 6533U3NK016913
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 3 Jun 2026 04:30:06 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 6533U3NK016913
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780457425; bh=wx5DCxJt3YBq96RHEuIIDg/BZOK9odKQ5UsrE25SgK4=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=Foso4T0d818lz5Kaxvgkp4h+J28ag6wakQFjxAz3Ob02+thhxQrkElR4PdcvAWwpw
	 s3eNbvcsWiShMirHBrEEjC0tdJFXZZFS9qQDFYt0aa5xhQjuA0y7TDJHCaCJ8FGoZ0
	 w4jgrQHVBXhn3bubbpjyXsOSNlQPB4a1arIpesetTFfRHGZuNozyLDueqoYE83xsNG
	 5F/9mOG9eh7/EDDQVPkIQYtaTC5Pszhm6NC8bXX69D1Pe6M6PkHgMUlD8z+iGYTflx
	 pffnBX5vf2OQdTv/IR3xR3p/9YRVGjjZCBuOgJgm83M85HA1szU/ELzbJQlouSii6m
	 A1X3jI7hQGHgg==
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
In-Reply-To: <72af0cfc-9011-4713-9862-710eea5f1cb0@lunn.ch>
Date: Wed, 3 Jun 2026 13:29:53 +1000
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
Message-Id: <1735AAB7-948A-4634-8920-D4BF9731A28D@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-5-72be14522e7c@padl.com>
 <t44kmhk6gqxnwhdvo7svouexwelwsya7zgukpbv3cxpfsmutqa@y3rjoj3tvqce>
 <A662D3F9-18DD-43C9-A43D-912E5A8A4360@padl.com>
 <8C6AD966-2C28-4BEF-95C4-1B2AC3751513@padl.com>
 <29c09316-c911-456e-acc5-e18402da4bd4@lunn.ch>
 <0402DFFF-634A-40C4-BC1E-B038F20926FF@padl.com>
 <89BA4203-110E-4767-895C-A2808602FAF8@padl.com>
 <72af0cfc-9011-4713-9862-710eea5f1cb0@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.700.81)



> On 3 Jun 2026, at 12:41=E2=80=AFpm, Andrew Lunn <andrew@lunn.ch> =
wrote:
>=20
>> We could add (e.g.) bridge_setup_tc to dsa_switch_ops, which (in the
>> mv88e6xxx implementation) could validate the bridge contained all
>> user ports. But it would not be possible to block a port from
>> leaving as port_bridge_leave cannot return an error, and tearing
>> MQPRIO config down silently would be a different sort of bad.
>=20
> There can be multiple bridges, even as far as one bridge per port.

Right, per the above mv88e6xxx would return -EOPNOTSUPP if the bridge =
did not contain all DSA user ports. But without a means to block the =
removal of ports from bridges it would not be possible to maintain this =
invariant.

> For switch wide properties, you basically have to allow the first user
> to configure it, refcount additional users get added and removed, and
> only allow the last user to change it.

Indeed, that=E2=80=99s what this series does. But it comes with the =
discussed caveat that ports without MQPRIO (whether or not they are part =
of a bridge) implicitly inherit the global FPri to QPri mapping. I think =
that is  acceptable given that users should have no expectaitons about =
the default mapping, but others may disagree.

> The alternative is return -EOPNOTSUPP, and let the kernel do it in
> software, if a user wants something different to the global
> setting. The hardware is only there to accelerate what Linux can
> already do in software. That is the model we use.

Yes, this is how it is implemented.

Luke
