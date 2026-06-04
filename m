Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572B13D647F
	for <bridge@lists.linux.dev>; Thu,  4 Jun 2026 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780554395; cv=none; b=cpYGrg4gaxb49M3e5AF+NwnTX1sYwpqckfbWx+UvV1PrCg2qhj3D2uU5iFHHxCqOiPj8ldlVwkR7grHK0H+6t7qbadhtApPfw960uykoxf63v5PZXKau1KidD+R/ICIgPZfTijiaDcL5gvRq2mo+AFVKGnny3FBP4f8fMP0EQOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780554395; c=relaxed/simple;
	bh=sr7dm4jSiwdx4gH+9MhfeJ9VnpLOlxcEa0kFuKIlDVQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pvioFCPJ2Sz6SuXPTZ9AxAaGcfbNCMJXO7NPVt3VG7s/bc7WvQ9xuldH8pXYaU/HqwRxh7F7FA7SfnDqIUkzBQ7N/7qp+uXGgiPR+3vGvkdLbUS98kpy11xU4rkDTIYhZ4FyYRPZIPxGhOWinbDMIfZKVxaLLmjUDsjxHzRfHkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from smtpclient.apple (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id CFFB260059;
	Thu,  4 Jun 2026 02:26:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com CFFB260059
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
In-Reply-To: <1735AAB7-948A-4634-8920-D4BF9731A28D@padl.com>
Date: Thu, 4 Jun 2026 16:26:16 +1000
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 David Ahern <dsahern@kernel.org>,
 Shuah Khan <shuah@kernel.org>,
 Vladimir Oltean <olteanv@gmail.com>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 bridge@lists.linux.dev,
 linux-kselftest@vger.kernel.org,
 Max Hunter <max@huntershome.org>,
 Kieran Tyrrell <kieran@sienda.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4E7395F9-7483-4756-802F-CEDA75A5B683@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-5-72be14522e7c@padl.com>
 <t44kmhk6gqxnwhdvo7svouexwelwsya7zgukpbv3cxpfsmutqa@y3rjoj3tvqce>
 <A662D3F9-18DD-43C9-A43D-912E5A8A4360@padl.com>
 <8C6AD966-2C28-4BEF-95C4-1B2AC3751513@padl.com>
 <29c09316-c911-456e-acc5-e18402da4bd4@lunn.ch>
 <0402DFFF-634A-40C4-BC1E-B038F20926FF@padl.com>
 <89BA4203-110E-4767-895C-A2808602FAF8@padl.com>
 <72af0cfc-9011-4713-9862-710eea5f1cb0@lunn.ch>
 <1735AAB7-948A-4634-8920-D4BF9731A28D@padl.com>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.700.81)

> Indeed, that=E2=80=99s what this series does. But it comes with the =
discussed caveat that ports without MQPRIO (whether or not they are part =
of a bridge) implicitly inherit the global FPri to QPri mapping. I think =
that is  acceptable given that users should have no expectaitons about =
the default mapping, but others may disagree.

It appears out one can set the egress QPri with a TCAM entry. So we may =
be able to correctly implement MQPRIO with an entry that matches on the =
PCP and sets the QPri and DPV bits. We=E2=80=99d need to be careful that =
the flower API couldn=E2=80=99t remove one of these entries.

Luke=
