Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BB53BE17E
	for <bridge@lists.linux.dev>; Thu,  4 Jun 2026 05:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780551591; cv=none; b=EJyVWxsHnrv867Sz5UJiI4F92EoUE834kU4e5rmrjvoO+lc3krhAANf3bIyPJuPQE2eqBOikv+YAgEUusvXQi9rvfXqOAHc4wRI86GmoTXNP5xaLqftKEAcTvvbxMKWPeEOz1uqj5O8Iep95Qcs2PzDS+goQB3tmYXRVaBJLKOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780551591; c=relaxed/simple;
	bh=/71IDNAYlaYhMk27O2rluNJgQT68JB+md99aDpuFqFw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=oG3RLKMcCKn83n3KndzQAd5fL1ftO2aXZtsaybAnNavkGBJXBdS/4PX3f/QCmAhTJmDLZ9MibPau2KhgKYsIFBmSYIcIXgyyI9KdNlNqqFKOpmeVqIUb8us6Ms6e1EmMySx9OzbtzHrPWOh/o09AVTUsL1YjrFuj38rXRoY7ghQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from smtpclient.apple (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 7471B60058;
	Thu,  4 Jun 2026 01:39:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 7471B60058
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next v2 3/6] net: bridge: add 802.1Qat stream
 reservation admission control
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <537410c3-ff4e-43fd-834e-775cd1bbe89e@blackwall.org>
Date: Thu, 4 Jun 2026 15:39:25 +1000
Cc: Jiri Pirko <jiri@resnulli.us>,
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
 Kieran Tyrrell <kieran@sienda.com>,
 Cedric Jehasse <cedric.jehasse@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E1253C6D-F6F0-407A-AABF-FCAB57100A1C@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-3-72be14522e7c@padl.com>
 <537410c3-ff4e-43fd-834e-775cd1bbe89e@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
X-Mailer: Apple Mail (2.3826.700.81)

On 3 Jun 2026, at 5:35=E2=80=AFpm, Nikolay Aleksandrov =
<razor@blackwall.org> wrote:
> So looking at how this is implemented, why not put most of it in TC?
> It is testing for skb class, for tc qdisc, I don't see a reason for it
> to be in the bridge at all. You can filter the mcast groups and =
simulate
> the "reserved" flag, it has to be set manually anyway. Adding new
> tests in the bridge software fast-path just for this is a waste.

This makes sense. Maybe it=E2=80=99s better to use flower+TCAM to =
implement this, and have our SRP daemon manage flower entries in =
addition to MDB entries. The mv88e6xxx driver=E2=80=99s TCAM support is =
recent (hi Cedric!) and does not yet appear to support the 6352 or =
matching on PCP/DA, but one presumes this is possible to add.

Alternatively, responding to your comments, the bridge could mark frames =
with a =E2=80=9Cstream reserved=E2=80=9D DA with a new tc_skb_ext bit, =
which would be surfaced to flower similarly to l2_miss. The rest of the =
policy would live in the flower rule. MDB_FLAGS_STREAM_RESERVED would =
remain but IFLA_BRPORT_FILTER_STREAM_RESERVED could go (we would =
dynamically enable the equivalent in mv88e6xxx by refcounting =
MDB_FLAGS_STREAM_RESERVED entries).

Luke=
