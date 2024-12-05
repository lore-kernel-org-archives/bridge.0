Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E710219FF
	for <bridge@lists.linux.dev>; Thu,  5 Dec 2024 01:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733361288; cv=none; b=TU4htJ3Y1a62vin23vurzIF5jkV9qhgKuiskCAQJ5wsg65HAcB3LxH698hTBxXilZgHfJplB0YGx+/uujHs8i1lRsF1Wec2i14A9Qm61J2oLwKRPatAdG4AH8EHlkwvdeuTp/l+yX8Iq9iYd23wzjJh5zilOGqdmq5LDUqFA5mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733361288; c=relaxed/simple;
	bh=0eT/Lot6+vqxxD9AP/IubXTEz/4Dzp8TBFGS1OmCoxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1/5soX/Y9PjRmoRMOe+aY8YOD9RL5C3TTizTXmwR6PhA5LDfYyHoCEC0CvS/j5DMO+d54wQsFrluYsMIYqQXhLfkCHePERsE/Q4qqlKG1txckh6HlqW5XMvq5SGr06nKTJKrKME1+s+qJIL9EIPcMUbCJmLNMrFxqPxln+hZoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com; spf=none smtp.mailfrom=andrewstrohman.com; dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b=kZ0PVlIG; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=andrewstrohman.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b="kZ0PVlIG"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e396cc8c9a1so659450276.0
        for <bridge@lists.linux.dev>; Wed, 04 Dec 2024 17:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrewstrohman-com.20230601.gappssmtp.com; s=20230601; t=1733361285; x=1733966085; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xfZMYXPm/XnOBhZKHxlljIg3cpKjNn+y0on19a7NN2Q=;
        b=kZ0PVlIGFtlkpHYxVv5qiRmlHE/8pBH8ddXmj4SmW/V3AAoJK+499s9ZC3QflXM/d6
         ZRPU2JgvFJHt6D6BBkNknmZORmmcT0AVgXz5NmvLfqPjy1UKmc7xsvfNuF1n7PaZjBsc
         bd1ITkJxbwwll1Sk1mnqnzWxjmKq111kRxG2zcDxEIoYruXnjkVdwqkAl9+tx/iU/DGI
         eWWl132x8rF7da+/WFBYWfSLw75CSviiNnSbGubKlAuBdINe+vc/ahJU+RC9ghcBp5eL
         JDUfjh8wr08CJ8LwFSq00KPINofjXPVBkRDuDr70TSuRn/MPTOemZ7tj9sl1daQqAEXp
         fDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733361285; x=1733966085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfZMYXPm/XnOBhZKHxlljIg3cpKjNn+y0on19a7NN2Q=;
        b=eBDZJPuDt+veDxLiZs7t65yCRkumcbG3oLXnrvbO/TtqSLwcnCfTkvK857Ke4/cPuA
         XCl3hAw14NMi1/2p1CnxEc21PBLLn7ufDkHHBgnE0ebyTXjAUQlfgHCbnOMLdV5ZjMhW
         FHYD70R5bcmyLaDBrxBlD0fTTEF7nPbr9xf2qhCUPif+oe8fMXyhI0ezFHEat1Cg8yC3
         D0pYMW6rVy6aKKCTRQ9gpVs/CoXZu7/XbsPeHVBM4Z45r8K3IUGU/0s82ITPmCCS02H4
         ZKvadqolCUkFQfpK9wZGgdUvmxJllkmjkoj/Hk8i57DsJTNdMkh80jcVX25eppJdUEbU
         lxqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUuRfTB7ZWAl2WWbdT1r67FKssm4CrG9ADSRsZSVIkkocNHuLd8fDuvsOARk2neKJ8OE4t19I=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1ugqnCb0mVC3cnHn1lGNg39z6r77ReUI6vzwz1rALbPeXT7wb
	OPaP+OySr7DDPbdyNrLxvbVZVUvYq5TQ0qJ2SqRGiIrULVYEPihQBQ9E4dk8Nn8feDUSCqzBy4N
	i7wDEfOWxsOB28gpVP8VY+SFxqTb3l2/2qZ2+Sw==
X-Gm-Gg: ASbGncv9JKe+rOY9eiMRSLs2sSx3FymXJWgIIHUgcQNbSnwHTzPEea3oh6bWD1h/V4C
	IXONqqihn7Tuud2GwMvo4KZ8TcmJKGGw=
X-Google-Smtp-Source: AGHT+IHA0+z3aYrs1oHL7bfJ5mmSCDhOEW1KC+mJa23OdZXviguzJEU7KjVhNJq4otCChADvbWMuAWS+kWh7228uAqM=
X-Received: by 2002:a05:6902:2b01:b0:e38:230d:aee0 with SMTP id
 3f1490d57ef6-e39f2338efdmr1688035276.23.1733361285485; Wed, 04 Dec 2024
 17:14:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241130000802.2822146-1-andrew@andrewstrohman.com>
 <Z0s3pDGGE0zXq0UE@penguin> <CAA8ajJmn-jWTweDMO48y7Dtk3XPEhnH0QbFj5J5RH4KgXog4ZQ@mail.gmail.com>
 <20241202100635.hkowskequgsrqqkf@skbuf> <CAA8ajJkPzpGRXO6tX5CkgX7DjGwR6bPyT4AXjZ0z8kXBk8Vr_g@mail.gmail.com>
 <20241204084817.g7tort3v3gwdzeic@skbuf> <CAA8ajJnRPB=KRcDpQiAJww3Apv6ZGqWaAg5stSjOE99BOmkCjg@mail.gmail.com>
 <20241204105645.vwhnwyp3gyq5av4m@skbuf>
In-Reply-To: <20241204105645.vwhnwyp3gyq5av4m@skbuf>
From: Andrew Strohman <andrew@andrewstrohman.com>
Date: Wed, 4 Dec 2024 17:14:34 -0800
Message-ID: <CAA8ajJn0+tBL=5YtuJt5Y6NKWKf_sEctq6Jm=h_Jht4DDnBRkw@mail.gmail.com>
Subject: Re: [PATCH net-next] bridge: Make the FDB consider inner tag for Q-in-Q
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, UNGLinuxDriver@microchip.com, 
	Shahed Shaikh <shshaikh@marvell.com>, Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Simon Horman <horms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Roopa Prabhu <roopa@nvidia.com>, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bridge@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> Here the same thing. The 802.1ad bridge has the same PVID on all ports.
> Why does the FDB lookup have to be as complex as to take 2 VIDs into
> consideration, instead of just the inner one?

In all my examples I'm using the same PVID, because that's a required
condition for the issue to happen. I omit that the other .1ad ports in
could have different .1ad VIDs configured for them, to focus
on the concept I'm trying to describe.

But other VIDs can be configured on other ports. So, there could be
collisions of .1q VIDs across different .1ad VIDs. As such,
I don't want to ignore the outer VID during FDB lookup.

In my use case (topology-sim) the test fabric consists of .1ad bridges
that are connected to networking equipment under test.

The topology-sim user configures virtual ethernet cables (point to point)
and/or L2 IVL ethernet segments between multiple devices under test. They do
this to construct an arbitrary ethernet topology that they want to test.
topology-sim assigns / maps each one of these  L2 segments to a unique
.1ad VID.  This is how it keeps the "virtual wires" from interfering with each
other.

So if one virtual wire (ie .1ad vid 3) is connecting to a switch under test
that is emitting frames with .1q vid 7, I want this virtual wire
to be independent from another virtual wire (ie .1ad vid 4) that is also
emitting frame with .lq7 vid 7.

I acknowledge that we shouldn't make this upstream change just for topology-sim,
considering that I'm the only user of it. But these same problems
can affect, for example, metro ethernet carriers that use .1ad vlan stacking
to differentiate between their different customer's sites. I'm not
trying to claim that
metro ethernet carriers would be inclined to use this feature -- I'm just
providing another example to point out that this same concept applies to
use cases outside of topology-sim, because toplogy-sim uses VLAN
stacking in a typical, conventional way.

I'll now proceed to go over my hairpin example,
https://docs.google.com/drawings/d/1FybJP3UyCPxVQRGxAqGztO4Qc5mgXclV4m-QEyfUFQ8
in more detail. I think that it will help demonstrate why I want
to consider the inner tags. It's an example about a circuitous network
path where the same packet can enter the same .1ad bridge multiple
times, with the same .1ad VID, but different inner .1q VIDs.

Like I mentioned before, this network is contrived. I've never seen
this done, and don't expect that it is a common topology. But my
goal is to prevent connectivity issues that only arise due to how
topology-sim constructs the virtual L2 ethernet segments.

The network under test has a bridge mode firewall that is used to inspect
traffic as it passes from some subset of a L2 segment to another subset
of the same L2 segment. The way that the network operator achieve this
goal is by creating separate VLANs for each subset of the L2 segment
that need firewall interjection. This way, communicate between these
different subsets are forced though the firewall. The firewall bridges
the two VLANs to merge them into one L2 segment, one broadcast
domain.

Say the topology-sim user wants to interconnect two .q1 bridges via
a virtual Ethernet connection. topology-sim accomplishes this by setting
the same PVID for both ports that that face these .q1 switches under test.

Let's follow what happens when a packets it transmitted from A towards
B.

When the frame is emitted from ".lq #1", heading toward the .1ad switch,
it is .1q tagged as 7.  When the .1ad bridge receives the frame, it will
associate it with .1ad vid 3 and .1q vid 7 can be seen in the packet,
if desired.
At this point, the .1ad bridge can either learn that A is behind it's
left port, for
.1ad vid 3 (current implementation), or it can learn that
A is behind the left port only for .1ad vid 3 + inner .1a vid 7
(proposed functionality).
When the frame leaves the .1ad switch heading toward
".1q #2", it will just have .1q vid 7 tag. ".1q #2" sends the packet
to the firewall,
via its left port, untagged. The firewall bridges the frame, and
therefore transmits
out its right port to ".1q #2", untagged.  ".1q #2" transmits toward
.1ad with .1q tag
8. When the .1ad bridge receives the frame, it will associate it with
.1ad vid 3 and the inner .1q vid 8 can be seen in the packet if
desired. At this point,
the .1ad bridge can either learn that A is behind its right port, for
.1ad vid 3 or it can
learn that A is behind it's right port, for .1ad vid 3 + .1q inner vid 8.

Without my change, the .1ad switch's fdb entry for A's mac, .1ad vid 3, would
flip continuously between the left and right port.

With my change, for .1ad vid 3, the .1ad bridge will always forward
packets destined
to host A's MAC to the right if the inner vid is 8 and will always
forward host A's MAC
to the left when the inner vid is 7.

I hope this example explains why I want to look at the inner VID. The
fact that we can have
inner VID collisions for different outer vids, drives the need to examine the
outer VID. This is why, collectively I want to consider MAC + inner + outer.

Does that make sense?
