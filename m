Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83162257825
	for <bridge@lists.linux.dev>; Wed,  3 Jun 2026 00:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780445774; cv=none; b=F51EOky9xzbau4QgMIQ9QNsiIMu1LtTjqvmd9uElzJcym8TmuqobGGl05+5iONCR91Ob4OQoKUVn0l/3m1IubTGG1UqT5g3/gr2A6DMw7vDHKLBqFEnTZsEBvyzKXkQzoJzwHx273P4kWRnwhVhzF2c1DbS6Ko+BKTosGXclonI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780445774; c=relaxed/simple;
	bh=LVAztwwvwVTuW1CFjVXsItGMpJmHC2uv3ruQzgYn1fM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=j5rWOrh5qe6uzrFtVHw0jVeO0fn2vJeB/Wv7XBN3mS+24JBQGy5qrzma7d4YZv0f1+ZBq4R+LXlTgL12dYmHN4XsP02WVf79C0l0JaTbxAiy8B3XmuIO7eOoNOEO3UwZuQUSudgR+wsCLrz6yzilpwjHt6XGvoJrA6sknpI+eoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=SGH5zm9F; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="SGH5zm9F"
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 6530FlGu015207
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 3 Jun 2026 01:15:50 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 6530FlGu015207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780445762; bh=LVAztwwvwVTuW1CFjVXsItGMpJmHC2uv3ruQzgYn1fM=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=SGH5zm9FfO+VgmI9KfnzrYlkK1zWS8U0bRuqXQatH7CNiilZS2+NFlgAujKpYELXI
	 fPcpfhzT7cbSU7y6XvV6YgIznvSWnK4qaYQ64LPUWUIOoebEcfk3yBjLGM0N7dSIFp
	 bGQR3g2n0xC7KXW7nvy15iQSzgAijWSd0DNnHwgNXFD3JmMEWST1d/t9c9/vzjqsBW
	 0scX4W1mXDRmB6PXZDGgSF9iFfFVOO3e0qJQnaN4dzNRtVk3b7fKPcPORd5qUXNRHl
	 F6bdpTa1UtTFUHj7XwhANR9GyhImJz1zrJx74LMn6C8Av9IvDdQE734cQxQ4kKgd+j
	 1Gp2QZMSdDZEA==
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
In-Reply-To: <29c09316-c911-456e-acc5-e18402da4bd4@lunn.ch>
Date: Wed, 3 Jun 2026 10:15:37 +1000
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
Message-Id: <0402DFFF-634A-40C4-BC1E-B038F20926FF@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-5-72be14522e7c@padl.com>
 <t44kmhk6gqxnwhdvo7svouexwelwsya7zgukpbv3cxpfsmutqa@y3rjoj3tvqce>
 <A662D3F9-18DD-43C9-A43D-912E5A8A4360@padl.com>
 <8C6AD966-2C28-4BEF-95C4-1B2AC3751513@padl.com>
 <29c09316-c911-456e-acc5-e18402da4bd4@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.700.81)



> On 3 Jun 2026, at 9:55=E2=80=AFam, Andrew Lunn <andrew@lunn.ch> wrote:
>=20
>> But there=E2=80=99s an alternative, more invasive, solution where the =
MQPRIO
>> configuration is attached to the bridge itself.
>=20
> What about ports which are not attached to a bridge? They are just
> standalone, have an IP address of their own, etc.

That is a good point. So, barring a switch feature I=E2=80=99ve not yet =
found, I think the only options are either to drop MQPRIO offload, or to =
accept that ports with no MQPRIO mapping inherit the per-switch mapping. =
Arguably that=E2=80=99s the case today anyway (each chip has its own =
default frame priority to queue mapping), so the user should have no =
expectation of queue assignment on a port that hasn=E2=80=99t been =
configured.

Luke=
