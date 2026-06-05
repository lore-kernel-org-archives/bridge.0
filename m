Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0BE38F928
	for <bridge@lists.linux.dev>; Fri,  5 Jun 2026 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780699036; cv=none; b=t8aPJo3zsrstt812dxW/CGaqNO1AhGxvFiRq2f/kjV18MZ+fRjcLgVUo++0qyt5uMoevoyNAbqUVBlemaik87cWSG3R0hHnszFaOHAPkvDAqKItvCjhqIM2Cnn/cz/MP6o5dQFujP8+ck4sibT7IXbVwKMVR3PP2BbDHA1e6rzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780699036; c=relaxed/simple;
	bh=DrzvSPrOSjJW3+VVlhh9e7GElkZoHFD80o/e/bA+fv0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qh1CG5UGMEt9XKfmpXXwsqDJSdwN5mAt5LXCeWNFI+v8e36iiyrvFCx4GdomkSUBQhOWehTlQ52PKKwLXNRkqQY4iv/CjpmEg1RgbZTmjfc9samr88aQor7/vPylsDlDDoAfmBHbpTPpfRaUGPCmaTOUPEJiPAZkcjpm513cc8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=1OkXNAl3; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="1OkXNAl3"
Received: from smtpclient.apple (119-18-22-158.771216.mel.static.aussiebb.net [119.18.22.158])
	by us.padl.com (Postfix) with ESMTPSA id 3EDA160980;
	Fri,  5 Jun 2026 18:37:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780699031; bh=DrzvSPrOSjJW3+VVlhh9e7GElkZoHFD80o/e/bA+fv0=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=1OkXNAl3msO/YPjWFIsFkdJ2k+CFsQTZvRHO9RuEzmnjJIl1YFD72InK6c44/7IKQ
	 CdraLxwFb56KPO3bVWdYk3lFeztXgPOO1RaIIKPNGbdaU48ghq0GBXAsCakCplDIF/
	 wYRIXonhknZhYVqhKRRz0uX4WN3gz2fev6zKN6RRYbFFy2StAj2YNb+/JNdQPZyZvb
	 NJGVXCCFj7ebAFiMQKhtNFyz1UqCDFlaXsS72bPcDR0JQKM0V42yzY1GVtrBOUSxBe
	 HUo6mUxLZ1Xq8uGDlL/7LQLlLAYNwcIKWwCZsypoG3rlr8qhDZk29PU87/U/B0nnNo
	 mUS50ucs7hqlA==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH net-next v2 3/6] net: bridge: add 802.1Qat stream
 reservation admission control
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <n2pi7h5nvxg3xvshtcxqeizpukp6hphqa7kodbe7b3ioc3kcq5@n34fgocvaicm>
Date: Sat, 6 Jun 2026 08:36:52 +1000
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
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
 Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 bridge@lists.linux.dev,
 linux-kselftest@vger.kernel.org,
 Max Hunter <max@huntershome.org>,
 Kieran Tyrrell <kieran@sienda.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <950DFD0B-0975-4AAC-967E-C7E4750A496C@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-3-72be14522e7c@padl.com>
 <537410c3-ff4e-43fd-834e-775cd1bbe89e@blackwall.org>
 <E1253C6D-F6F0-407A-AABF-FCAB57100A1C@padl.com>
 <n2pi7h5nvxg3xvshtcxqeizpukp6hphqa7kodbe7b3ioc3kcq5@n34fgocvaicm>
To: Cedric Jehasse <cedric.jehasse@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)


> But the concept comes from the 802.1Q spec. The spec describes =
different types
> of FDB entries. One of these is Dynamic Reservation Entries, which are =
created
> from the Stream Reservation Protocol.
> The issue here is the Marvell switch has an implementation where we =
need to
> know if an entry is a Dynamic Reservation Entry. But the linux bridge =
has a
> simplified version of the FDB described in 802.1Q.
> By adding a way to distinguish between the type of FDB entries, it's =
possible
> to program a Marvell which has this distinction between Dynamic =
Reservation
> Entries (or AVB entries) and other entries.

If we only care about the multicast case, and we can depend on snooping =
being enabled and flooding disabled, then I think Dynamic Reservation =
Entries collapse to permanent MDB entries. Unicast is trickier.

The issue of reclassifying (or dropping) frames that share a SRP class =
PCP is separate. I think it could be done with a tc-flower entry that =
reclassifies all ingress traffic with SRP PCPs (e.g. see 802.1Q Table =
6-5) and then a per-stream egress entry that sets the queue and =
priority.=
