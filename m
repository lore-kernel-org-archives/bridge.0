Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED65318146
	for <bridge@lists.linux.dev>; Sat,  6 Jun 2026 21:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780782600; cv=none; b=U7Yr229s78bkkUo5zzhjkz5lit+S5Vy0zXlX6Cg6BUpVd+TRx1KM4dwIgbt7vqsJkYcX9b4SqYxNZUK2WcoCLaAEvttk9F/iFnihOpHI2xbpoevF5cpGbwXTIjeGoI1yIkBp1t/cJ3MYsFTcNMpKRiACIyMilfORsbIE8itjvnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780782600; c=relaxed/simple;
	bh=kH5GmUToAQsCMzn7xCEan3Jr1hpM1EsUkr9u9YaFl0M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rUqA0xzLcCUK/0p6zSxHReV2sxC2uG413cseOwJY7a+Op6Bqm21IpKlfUxnFb5K6T3Kf2T7ylI+RSEWHJolX1ZMNEzsBsh1+l0hFGkoT2r28AxG87bsOZ6a4oVQ2NMTgzoyLFWcArGarxADlCON09IjEX28P5Dcq3IceNxp/WOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=mbjMyF3y; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="mbjMyF3y"
Received: from smtpclient.apple (119-18-22-158.771216.mel.static.aussiebb.net [119.18.22.158])
	by us.padl.com (Postfix) with ESMTPSA id 7472E6087D;
	Sat,  6 Jun 2026 17:49:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780782590; bh=an/MtvlsiwLyCHyABUS6ubjscBO1uA5s1tL3O5ntGDQ=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=mbjMyF3yQ4WxkFozgne07Bh1Pf/rPOy7p3+5wh57ELRXl2Rt8mVqnRZH07SIukO83
	 lLwni9P7jK9t+Imwa8Cn9ZWzhQlNfnbZL2azTR/+ZrYgZd6J/o6Mps11bB6+DOtuIa
	 1FPnSndTUkQ6vE9x4pCtdeCdfvDNFALAkgSvL09rkOF6CuS7849ABlomenzcU4NN9m
	 bmaCjtxFBr19fPA8s4jIAocQc67wzhi8jx1icW2Iv/ouH84YtlDzgvGWtvx7DhwIqx
	 iot0EhCgG305s+xLG1xiE6G4MpAxsMlALY7fwXPtBAXJv3dZPZUgHqvn5ci2mIeaJQ
	 gBhN0Ppf0OTQg==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH net-next v2 3/6] net: bridge: add 802.1Qat stream
 reservation admission control
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <a63eed7d-b674-4830-a690-1b55dfdc9a72@blackwall.org>
Date: Sun, 7 Jun 2026 07:49:26 +1000
Cc: Andrew Lunn <andrew@lunn.ch>,
 Cedric Jehasse <cedric.jehasse@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
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
Message-Id: <77CCA8EB-145D-4B76-B6F4-9B775C361995@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-3-72be14522e7c@padl.com>
 <537410c3-ff4e-43fd-834e-775cd1bbe89e@blackwall.org>
 <E1253C6D-F6F0-407A-AABF-FCAB57100A1C@padl.com>
 <n2pi7h5nvxg3xvshtcxqeizpukp6hphqa7kodbe7b3ioc3kcq5@n34fgocvaicm>
 <d0e650fb-4011-4d64-9780-a0ddd0ca1cf3@lunn.ch>
 <CCF20D32-6C9F-49DC-9838-592EFB5E88D2@padl.com>
 <a63eed7d-b674-4830-a690-1b55dfdc9a72@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
X-Mailer: Apple Mail (2.3826.500.181.1.5)



> On 6 Jun 2026, at 6:21=E2=80=AFpm, Nikolay Aleksandrov =
<razor@blackwall.org> wrote:
>=20
> On 06/06/2026 11:02, Luke Howard wrote:
>> The definition of Dynamic Reservation Entries in 802.1Q (clause =
8.8.7) might support the addition of a new MDB (or even FDB) entry state =
to the kernel:
>> - add MDB_DYNAMIC_RESERVATION (a state, not a flag);
>> - the software bridge only _classifies_ packets against  =
MDB_DYNAMIC_RESERVATION entries, and only when MDB is authoritative. =
Classification sets dynamic_reservation_hit on tc_skb_ext;
>> - dynamic_reservation_hit is visible to the flow dissector so can be =
used for policy enforcement.
>=20
> See, saying the bridge has to classify doesn't sound right. Why not do =
the
> classification where such operations are usually done, e.g. tc?
> You have to manually designate these entries anyway.

s/classify/mark, i.e. marking a forwarding bit for tc to match, a la =
l2_miss.

tc can=E2=80=99t see into the MDB to tell if a DA has a dynamic =
reservation entry so, without an explicit DRE bit, the SRP daemon would =
need to maintain a flower permit filter per DRE. Not needing this allows =
the user to set a single policy filter prior to starting SRP, e.g.:

tc filter add dev lan0 egress protocol 802.1Q pref 1 handle 1 flower =
vlan_prio 3 dynamic_reservation_hit 0 action drop

It also maps cleanly to chips that support 802.1Qav with priority =
regeneration or filtering, but which can=E2=80=99t support tc-flower.=
