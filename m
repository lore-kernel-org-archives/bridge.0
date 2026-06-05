Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302913812E3
	for <bridge@lists.linux.dev>; Fri,  5 Jun 2026 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780664047; cv=none; b=qovZDXqsjso66zCczAFsTv0uHFxAvCq2pfG0S+PtBWRaD+8d+029QRw71qWj6YF+9y3qLio89qaSBEiwdXfP16TAqLVqnVLej+yP6S+95jb5MpNOwvDDD406iaXUfnBVCMi6zXF51h8+DzBr56yEzh+8wAe7yqBXDbq7H+S17MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780664047; c=relaxed/simple;
	bh=4BdkasZGBWmvzkcQMzObxj+iFSYJKYsxLTlK/a/FMVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L13oRt6oyUiZAMUJ9rA7mP7VUWAdXqFs93yudtrzUxkNAgBVQYUTConhGkt2gZ+XzjS9qMvduXCJa9In9zF0AjiCINCMhZebdqSi0udAUrXN8Sb50q6zcCMjfZJFTH0lc9Q/3E4vIcJ5I9HYqf6czLuzlqzEdMcb8HEYs5Ntkzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXL4BePR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXL4BePR"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso10394695e9.2
        for <bridge@lists.linux.dev>; Fri, 05 Jun 2026 05:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780664044; x=1781268844; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ESsFWXNVrBZDPrJPvZQn7pIbZnaDRK4mOzY9lR1X5Y4=;
        b=LXL4BePRLB+bQ1fHz0bFXjBHtAJfsr2yLzzG+mlVyANS5ViGqyNVo1Lw8vQoGrWHK0
         xzgyzdA/f7bWZSHZ281R9xY8pIjDhlJ7+/G2kxHT0I8Pj/rcVmicMdie5szkmEU5BZEa
         vGJ+wHf0olwPm/ZgbWgduH5i5Lq4POJXbsw0QKRQtY7chfy3il0oNn0II2+/VTBIgLvl
         IaoTynLy2sVei8ccRGCf/TiwuXbvUSJQUFAUFlY9rkrR6Nvde73v+01NZ5wCvd92tyBH
         qTs0680AnkszpeSoaR0GHtxteZjX652cT+Ued7iSWYrEGXoFEZ1mIFI6IPIRBJLHMNqv
         Fw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780664044; x=1781268844;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESsFWXNVrBZDPrJPvZQn7pIbZnaDRK4mOzY9lR1X5Y4=;
        b=SxoUfBohTXSOsvyfYNiXeYD8S6APc8XAhqF8e4omH12Ti+YBSKeyMWDQDS5j5dDT+6
         Pha04JleMaXMFr1Z7+1EmmJeSZZ7AdTo4wUuj2q8OQCm4X7GZkJ1O0coyeSI9olw5aXK
         UWayNgasLzU31rYytz7JKxxRvb05+f0q5E/bPpXRGn1WwOvBOwP9GyicjQLRYiKNZq5U
         +n4prM0fn07vzBhAluIKPWwZj59whsj6U+Ex2cyWv7MqO+UJ/MVJL/IfWhLftVvG7WbC
         e6WuDZ7F0zMGs+wejDM40HlIPmAgpz34H/LR29dD/827Q3oMBU7OLmqXkVpr1/tKBv8D
         xUlg==
X-Forwarded-Encrypted: i=1; AFNElJ9J3r9rwjnaEqm98WYclv1ZKKi8tEGiOjKQP7vZw4HmNWqRj8RLxj2pYc8gMZ2iSE0BJcLTK+Y=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+ha0m+nHirJQbG/qCy5lUZcMPp78LJOVLZbmFqbph49VmiFA4
	fi6juYHyzwR3jYUXVE2EWOcW4br65V/ESFsmUWCKIrQP4aadweyYNhNZ
X-Gm-Gg: Acq92OGm+UrzBK+P6FFBU7vnnTfmtaoaKOwpVl/f5Ziq6syUzjYlQPUFUoYhegTvct/
	uK2tOnAw0/cnFKt9CPJgJ9SnGSin+Po54glmG0QA2t16wqeiAbfW+8mGJKdjOsaTABWnKKfpdaO
	c7HMAqHeWfyHOudhoYxlWOaFHeTky5FO07FcakSx7ZlHtUFYPznrcmXV6KZBIpcbU/hUVBHOdw3
	vr4Ar6e5PoMjhn0t1OsmBnYWCaLuNjhUJnZwNh60H2TC0luIwGXx2Atb1opLccE9nm3cDE+cqU8
	T+ua4OuWOQOfvhtFTPry/PdEX8USrNPfxkzZa3NUdHi2eZTAmecn2X0/kQbMltYwIbAIN9cW2rj
	I2zw0C2Nc8x0hdGVCqjkrGWKuG5/S0yZceJDUjx1XVi9NCLnDUmeA4DSBnmN18JetCNWPFzUbKM
	mA1wUeE3hlZ72/mK3ijScC+vOhIn+YaIEwD49+k4PMRYU=
X-Received: by 2002:a05:600c:190b:b0:490:be9e:fd03 with SMTP id 5b1f17b1804b1-490c2589a02mr52233325e9.7.1780664044371;
        Fri, 05 Jun 2026 05:54:04 -0700 (PDT)
Received: from cedric-laptop ([195.225.166.186])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d60a79sm27083045e9.2.2026.06.05.05.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 05:54:03 -0700 (PDT)
Date: Fri, 5 Jun 2026 14:53:57 +0200
From: Cedric Jehasse <cedric.jehasse@gmail.com>
To: Luke Howard <lukeh@padl.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, 
	Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Max Hunter <max@huntershome.org>, Kieran Tyrrell <kieran@sienda.com>
Subject: Re: [PATCH net-next v2 3/6] net: bridge: add 802.1Qat stream
 reservation admission control
Message-ID: <n2pi7h5nvxg3xvshtcxqeizpukp6hphqa7kodbe7b3ioc3kcq5@n34fgocvaicm>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-3-72be14522e7c@padl.com>
 <537410c3-ff4e-43fd-834e-775cd1bbe89e@blackwall.org>
 <E1253C6D-F6F0-407A-AABF-FCAB57100A1C@padl.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1253C6D-F6F0-407A-AABF-FCAB57100A1C@padl.com>

On Thu, Jun 04, 2026 at 03:39:25PM +1000, Luke Howard wrote:
> On 3 Jun 2026, at 5:35 pm, Nikolay Aleksandrov <razor@blackwall.org> wrote:
> > So looking at how this is implemented, why not put most of it in TC?
> > It is testing for skb class, for tc qdisc, I don't see a reason for it
> > to be in the bridge at all. You can filter the mcast groups and simulate
> > the "reserved" flag, it has to be set manually anyway. Adding new
> > tests in the bridge software fast-path just for this is a waste.
> 
> This makes sense. Maybe it’s better to use flower+TCAM to implement this, and have our SRP daemon manage flower entries in addition to MDB entries. The mv88e6xxx driver’s TCAM support is recent (hi Cedric!) and does not yet appear to support the 6352 or matching on PCP/DA, but one presumes this is possible to add.
> 
> Alternatively, responding to your comments, the bridge could mark frames with a “stream reserved” DA with a new tc_skb_ext bit, which would be surfaced to flower similarly to l2_miss. The rest of the policy would live in the flower rule. MDB_FLAGS_STREAM_RESERVED would remain but IFLA_BRPORT_FILTER_STREAM_RESERVED could go (we would dynamically enable the equivalent in mv88e6xxx by refcounting MDB_FLAGS_STREAM_RESERVED entries).
> 

I don't know if this can be done in TC.
For the usecase of SRP the Marvell has bits in it's mac entries to specify is
an AVB entry. This looks vendor specific, and other vendors don't have it.
But the concept comes from the 802.1Q spec. The spec describes different types
of FDB entries. One of these is Dynamic Reservation Entries, which are created
from the Stream Reservation Protocol.
The issue here is the Marvell switch has an implementation where we need to
know if an entry is a Dynamic Reservation Entry. But the linux bridge has a
simplified version of the FDB described in 802.1Q.
By adding a way to distinguish between the type of FDB entries, it's possible
to program a Marvell which has this distinction between Dynamic Reservation
Entries (or AVB entries) and other entries.

Cedric

