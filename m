Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF1917BD3
	for <bridge@lists.linux.dev>; Sat, 30 Nov 2024 22:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733005727; cv=none; b=est51s2tiH19ZfygQvBbb87hQ4N/9LEXwIjJG+UQHLVfEDwSi4Hr3i4Lg50+hsFQBVci3iN5o+WpsXEW5JKSLj9SrQGCZzEXsRqFuYI/ponCthjktS1SpFgQt7p4eZjL8Cqv60sqAhmgJ8ye15iP6ck3Ii8dg1O/0oFwElK7s4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733005727; c=relaxed/simple;
	bh=7Wdetpt4bdjb03TKiWu74j2GUFJllbRsXuM68hzws7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lU2bP41UrfgodMlsi52ORRbszA3t4JgUgtH5GEWJSsMWyQQqHWEo/K30g120CMgs/MRf3B7w6MEhI14WJT+Qfe0znlLLlvGsvgJWE0Gd27zrhmN+a7lcG0A06pbGpEt9Ian48z29q6Bh4QI5B0XT2BfgmkSgrkJkFSKq8/TSR+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com; spf=none smtp.mailfrom=andrewstrohman.com; dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b=hheXIMOA; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=andrewstrohman.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b="hheXIMOA"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e398dc7864dso1344798276.3
        for <bridge@lists.linux.dev>; Sat, 30 Nov 2024 14:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrewstrohman-com.20230601.gappssmtp.com; s=20230601; t=1733005725; x=1733610525; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7Wdetpt4bdjb03TKiWu74j2GUFJllbRsXuM68hzws7A=;
        b=hheXIMOAldH0ix8Pmjohth8FJPSEd5J5qJopV1n2JiR3THzh7pk5vlbM0jRwYwJHQZ
         pHWMlgTi0/OIpQH2oU7KxGBSaqoAoc6krQ4r5EKhaGI9hwHsH6ut/L0VLgAo+Mw3ajb+
         7VhLhkuOK/EKUCUxR5INRU0fgxB/t9Oy/QhrNqeU+8aZqFsRaNsfFbvOwvGTWi9PuJNF
         qjYlREvGnjSZt99hWQDWWHOQ7feCcFpvFb6LWak2KYaISVudUQB6cWEqFX6q3DTWcTfR
         LeXj7iswT+60/ctagd3fYWyTLLYWgzWayBDqlXx4ZFf9/d2/uor145TE4Tvk/jwiWDYq
         3AaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733005725; x=1733610525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Wdetpt4bdjb03TKiWu74j2GUFJllbRsXuM68hzws7A=;
        b=k//jromYNHS3Ut0nn8L5IlmMNZLOcZRFKs6D+cTcOWqyM7MdfFRt0oRT7kuJg9J1vD
         b+VzhPChbzQuagVUbam7Sn4EXoAcZpwE1ReBOi/2SXm3lPgGXxmEMFKWSW/5kZesMt9T
         YBxk59++oiuNtu0zHtAgUA98XHe8rko703/EK+prd5hQN0vG9WHDb7vRb/dkry+52X7P
         LU1KNHy1rf9opbzqTc8cSidBUP5V+4Z8IqQsqXvRz/T+NfaC1TZGgMbgwqyuTzzBKew7
         K1lDrdDwg3RkVw44dez52rx9kxNMzCTJvA7DdNotr52CopndBeg8yn0dpuzKsBe+q2w1
         5G+w==
X-Forwarded-Encrypted: i=1; AJvYcCUkMul/+LpThGQ90EL0intdgI5dalhkbK4n03ufptgRSa5p/YdU/TRlSIUipbEeUVYMAWP/t40=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy85x43YLZfc0b9BePo1ZEsZQmgjKHRiarWNnoUpoQh0VxrJH0c
	l5m7rAbQN+nL7DHPBF77go2IRVa17WADXSjEm8CuF96F9yQ2ThL58svFGf7lfi2LoL6qE6Ms7by
	IE4uxg8DblzJUK2Ji2HsSA++Jau/TFUF+DfFL2w==
X-Gm-Gg: ASbGncsmIWjJrbfCkifCWURJ/jTLR/kPoFA8a21o2RbRmaMOFECyxxnrAvpLTXfCO/8
	qvaHnmKn8ipSBNb6bZQ67N14Nz4Bk3UA=
X-Google-Smtp-Source: AGHT+IHfnTZT06dr55uMoGVVPSi3LB207JWWsC6/9JeXc0W+4fBNcHyu/kAuUK9CXwsbr7aiFeRwXRPIXc7R/5ScSg4=
X-Received: by 2002:a05:6902:2087:b0:e39:84c6:3041 with SMTP id
 3f1490d57ef6-e3984c633afmr9172615276.22.1733005725180; Sat, 30 Nov 2024
 14:28:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241130000802.2822146-1-andrew@andrewstrohman.com> <Z0s3pDGGE0zXq0UE@penguin>
In-Reply-To: <Z0s3pDGGE0zXq0UE@penguin>
From: Andrew Strohman <andrew@andrewstrohman.com>
Date: Sat, 30 Nov 2024 14:28:34 -0800
Message-ID: <CAA8ajJmn-jWTweDMO48y7Dtk3XPEhnH0QbFj5J5RH4KgXog4ZQ@mail.gmail.com>
Subject: Re: [PATCH net-next] bridge: Make the FDB consider inner tag for Q-in-Q
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Shahed Shaikh <shshaikh@marvell.com>, 
	Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Simon Horman <horms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Roopa Prabhu <roopa@nvidia.com>, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bridge@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Nik,

Thanks for the review.

> This patch makes fdb lookups slower for everybody, ruins the nice key alignment,
> increases the key memory usage

I could make the additional, inner_vid, fdb member variable's existence
depend on a compile time flag, so that these penalties would only affect
the users that want the feature.

> and adds more complexity for a corner case, especially
> having 2 different hosts with identical macs sounds weird.

I admit that the use case is rare. In this commit message,
I focused on the duplicate MAC scenario, because I thought that would
be the easiest way to describe it. If the problem is hosts with duplicate
MACs, that's probably best remedied by just assigning a different MAC, or
translating that MAC before it reaches the 802.1d bridge.

There might be a potential DoS opportunity, if an attacker knows
the MAC addresses on a different VLAN. Consider someone on a "guest" VLAN
transmitting a frame sourced with the MAC of a server on the "production"
VLAN.

My personal use case is about simulating ethernet connections and VLAN aware
bridges, so that I can test networking equipment that provides VLAN
functionality with IVL.
https://github.com/andrewstrohman/topology-sim/raw/refs/heads/main/docs/Topology%20Simulation%20for%20Mesh%20Testing.pdf?download=
describes it, if you're interested in more information about it.

https://docs.google.com/drawings/d/1FybJP3UyCPxVQRGxAqGztO4Qc5mgXclV4m-QEyfUFQ8
is a diagram that shows what I'm thinking about. This case is not about
duplicate macs, but rather a frame being bridged in a way, such that it passes
through the same bridge twice via different ports depending on the inner
VLAN. In the commit message, this is what I meant by the poorly worded:
"L2 hairpining where different VLANs are used for each side of the hairpin".

The diagram depicts a network where a layer 2 segment is partitioned by a
L2 (bridging) firewall. I admit that this is contrived and not a typical
way of constructing networks.

In this case, my testing system would use a 802.1ad bridge to simulate a
VLAN aware bridge between .1q #1 and .1q #2. The problem is that the .1ad
bridge would get confused about which ports hosts A and B are behind.
The bridge would see them behind different ports depending on whether the
packet was heading to, or returning from the bridge mode firewall.

If these nodes were connected with an IVL .1q bridge instead of the .1ad
bridge, this topology would work. So it's a scenario where connectivity
failure would be due to my testing system (topology-sim) instead of the
networking equipment being tested.

> Fdb matching on both tags isn't a feature I've heard of, I don't know if there are switches that support it.
> Could you point to anywhere in the specs that such support is mentioned?

I've never heard of this either. It's just an idea that I had. I don't
know of any
switches that support it.

> Also could you please give more details about the use case? Maybe we can help you solve
> your problem without impacting everyone. Perhaps we can mix vlan-aware bridge and tc
> to solve it.

Thanks. I tried to give the relevant details of my use case above. I think
that using tunnels instead of VLANs would fix this for me, because the
switches would not learn the inner MAC. But, the tunnel header has more
overhead compared to adding a tag.

> As it stands I'm against adding such matching

Fair enough. I also have concerns about complexity vs value, myself. I
just thought that I would give this a try in case others found it useful.
