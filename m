Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF43517D2
	for <bridge@lists.linux.dev>; Sun,  7 Jun 2026 00:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780790575; cv=none; b=an7yW5qTrMk4/B3A2QBD/eWwpaEyR/H9LgI3zS+RGpcJMF1gZrVlM34QBJZHojmN6v4tjlGW7XKTKgHu/aDW4kMy1aLfKm/l1GKqfANm2DTuoFJS0wjjul3vhFF53YcMwxuh8ABvpnRtOsgdnghMcgQXn+nuRulYooQJunB2hPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780790575; c=relaxed/simple;
	bh=8hVkpC7bX4xMCmPcT0UthYQRtEB1BSpcwEOBuRelzb8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pOA2o7BQgL14+CA/XifxTBeekhUDSdZH3xIUkF9EVJtAoPBSWX2yRu3Y4MDvfGT9SmMkBiTASh3fp1JoyOtk+6DPbNd2sUYM5O35Lqr5S34dJTtr0WpTti46uZrJp7+O5EeGjxgB4Ehsq/pS9mhSJ4yQpEpaZ4SEinTdHtfJ6Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=VWXVQPtv; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="VWXVQPtv"
Received: from smtpclient.apple (119-18-22-158.771216.mel.static.aussiebb.net [119.18.22.158])
	by us.padl.com (Postfix) with ESMTPSA id 737086087D;
	Sat,  6 Jun 2026 20:02:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780790571; bh=8hVkpC7bX4xMCmPcT0UthYQRtEB1BSpcwEOBuRelzb8=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=VWXVQPtvK2agwHU1t52PLHkKapCjGdjM54Ae2bIw1HIWYkpYv9u2o9chr1iqt3hjH
	 S1xRc4k52BwlDyBguEw7rPC6IYR3MPK/riOck1+X60Xa5fcf42PU3UDH10RAJNWfu8
	 kXRvGLXg+LZfZvwOP62aRVBZS50YpSHI7YAKg4LKsbMgiFs5fUSHhBx6owxScpIsqc
	 CaD9ahafkW86aPBUEQWzcdH9fzwRuVvSS6SQAv3Y8tWJ3NhcEBa3oNsaT97C4dNeL+
	 bYmEugDzZVAWQsV2grSnt66M/dfjf2D6RfUqhvOYbwqEHvLw3T5tZkFCpiGHECoE58
	 FVujk2R2DhfMg==
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
In-Reply-To: <aiSbrmlOunfxwvGu@penguin>
Date: Sun, 7 Jun 2026 10:02:32 +1000
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
Message-Id: <0A7F24BE-2F75-4120-8615-758DA6F28D0C@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-3-72be14522e7c@padl.com>
 <537410c3-ff4e-43fd-834e-775cd1bbe89e@blackwall.org>
 <E1253C6D-F6F0-407A-AABF-FCAB57100A1C@padl.com>
 <n2pi7h5nvxg3xvshtcxqeizpukp6hphqa7kodbe7b3ioc3kcq5@n34fgocvaicm>
 <d0e650fb-4011-4d64-9780-a0ddd0ca1cf3@lunn.ch>
 <CCF20D32-6C9F-49DC-9838-592EFB5E88D2@padl.com>
 <a63eed7d-b674-4830-a690-1b55dfdc9a72@blackwall.org>
 <77CCA8EB-145D-4B76-B6F4-9B775C361995@padl.com> <aiSbrmlOunfxwvGu@penguin>
To: Nikolay Aleksandrov <razor@blackwall.org>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hi Nikolay,

> For the MDB to have a dynamic reservation entry means someone must've =
added it,
> these are not dynamically learned, so you can just as well build the =
table
> in a more appropriate place which can tag or filter the packet.

Fair enough, also a reasonable argument :) Without 802.1Q Dynamic =
Reservation Entries having first-class support in the MDB, I don=E2=80=99t=
 think there=E2=80=99s an abstraction that also maps well to the =
mv88e6xxx.

I=E2=80=99ll keep thinking about it, but for now this had probably best =
remain a local patch. [1] Thanks for taking the time to give feedback, I =
learned a lot.

Cheers,
Luke

[1] https://github.com/PADL/linux/tree/b4/mv88e6xxx-8021qat-mqprio=
