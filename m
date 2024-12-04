Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F181953A1
	for <bridge@lists.linux.dev>; Wed,  4 Dec 2024 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301458; cv=none; b=NR4v7iyJ01ugzXgziWLapi7BaHipqvlqMoIDgc/cPlNB4x6waQ67yN3iCh0xrUSQ5dk5PPW6/xJGun1b2VIOoxF/aHU1NlgPg+5o+rCEo4rQb+aimdpccGe2EiJJbYVHeuKvew3CyeKcjA3LnidjQ3EdDcPaQQlj5lsh5Zyu2rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301458; c=relaxed/simple;
	bh=EoVke9SqFUpCaQKo+qnhyQ0iycqkcohJkC/+ji9nimc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqDPHDiZuC4qXqm1z99VSZxR74Yew8AKvjEU4xASCtQNPhBOWUIfU81Qd3Xy4q20sl8RSw+rhNySVdCOuO6VzK3oudUdWN/cg5FPJVXRJPzFNN5qkre4SFw/pdhHF/F0bKE0WjmVraiyiiSl7cjmI1+ytrxcSCeOstr4g5p9IHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com; spf=none smtp.mailfrom=andrewstrohman.com; dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b=en1ONjzc; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=andrewstrohman.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b="en1ONjzc"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e3824e1adcdso5453276276.3
        for <bridge@lists.linux.dev>; Wed, 04 Dec 2024 00:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrewstrohman-com.20230601.gappssmtp.com; s=20230601; t=1733301455; x=1733906255; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EoVke9SqFUpCaQKo+qnhyQ0iycqkcohJkC/+ji9nimc=;
        b=en1ONjzcwWLIbTAgpgLak/Z4SxI6lzdy6uffA7IcUhWZM66Ww5A1X6uGIyuVzI7uR4
         Xexb+k76sRJftViSap/hYcAm6j3vqOTkcdZLqWZXBGkDuugiZFuxh+UuBqbu+CYNveUM
         ccycG7tdgT0JHLcTsMMpddc+0CxzIeamDSmxvzz9NtudOIIsW4aNtbM6HI4bhYSkRMhH
         fk5eUEsU+j7f5DH+KFzPFxmTOsTC0uoSYiTYbYzeFGFvyJ58equ6FecGm5a1Mx09Kc4H
         WQGdiQjAnQrTnn1phuNqWruJqCGQqYrDb+5RCSllPa20PLgiZgYTZDzTm2WNdrVAK5YC
         NquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733301455; x=1733906255;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EoVke9SqFUpCaQKo+qnhyQ0iycqkcohJkC/+ji9nimc=;
        b=vWZlKR4RKHFEMrN63oYu4h/qd66Mi3BUVYCQpI1UPQ7cttJgEmHd6KQkBTE5mA5EjC
         79TGY1BGpkAnz6Lgo8BvB7p8WbOpq9CwIguy6zJD+wiLKMB5tskAd+PIO9Pqj+uE3IRe
         xkYHJDrsmfYHGQSCFQwCHv8Vpdt+9XJyUAAQxv6/iuQlBP+vjaUMe+IGVb+yIoI1uZC/
         V43BF/53DC0NEgtB78643tXqVQEXdLHbeyo6dfswjj+0yImnIZfY1Scx2/x7xOwXBcv5
         kuQtKD9mHh3rlKr4kL28GQy8giG2QjoUMRneB4ll8/mSSPGYa6Qgbo2xPmEAD3ovfz7z
         gx0w==
X-Forwarded-Encrypted: i=1; AJvYcCV6MmMjFYVbPDuap3Dfoo7MFdvRvgwofad4MPSjp1pVL4T60+ULhBCNcK1Cg6hPDASuX6JYBbE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxppe2+Tccgkliz9sJI3qDcdaAVJJTAgLMBQNTAxlv+o+ULV8nK
	vYcDog1iH8PNxuv+TVgXifP6MrwcPoLPEY81528z/6uSv8rN6DT4iFx5OgcgpQGCQqQ0kxt6JS5
	fIPFgC8wJrG39FvVmBByz3ijOX9lxO9A7+Dx+8w==
X-Gm-Gg: ASbGncsqWb+wwj4fxOAcVm7U7DUjlNDLXuVteYgU9ooUwPcDYBLwUqCrwcEBrP/YgZk
	IbhAXcnCHC/vkYVByN7LNevfMk1RkijY=
X-Google-Smtp-Source: AGHT+IHrKkSgA4hGlK8jn7mrWKSIy07H4RXZ4L/gvYx86xaKYNomvgbtV66jTpE9OVKxPCEslG9WFAbqVeHjvw6aGX0=
X-Received: by 2002:a05:6902:150a:b0:e39:9032:122 with SMTP id
 3f1490d57ef6-e39d4389535mr7493688276.44.1733301455300; Wed, 04 Dec 2024
 00:37:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241130000802.2822146-1-andrew@andrewstrohman.com>
 <Z0s3pDGGE0zXq0UE@penguin> <CAA8ajJmn-jWTweDMO48y7Dtk3XPEhnH0QbFj5J5RH4KgXog4ZQ@mail.gmail.com>
 <20241202100635.hkowskequgsrqqkf@skbuf>
In-Reply-To: <20241202100635.hkowskequgsrqqkf@skbuf>
From: Andrew Strohman <andrew@andrewstrohman.com>
Date: Wed, 4 Dec 2024 00:37:24 -0800
Message-ID: <CAA8ajJkPzpGRXO6tX5CkgX7DjGwR6bPyT4AXjZ0z8kXBk8Vr_g@mail.gmail.com>
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

> What stops you from changing the 802.1ad bridge port pvids to unique
> values, like 3, 4, 5... instead of 3, 3, 3, and making each other
> j != i bridge port be a non-pvid member of port i's pvid?

I'm not sure if I understand this suggestion.

I tried to draw out what you described here:
https://docs.google.com/drawings/d/1UcOpENFgr-s6p8Ypwo-l4yTvtUZFM6vSLxLiX2FOMLU

I'm not sure how host A can communicate with B with this configuration.

Consider host A transmitting towards host B. When the frame leaves
".1q bridge 3",
it will be tagged with .1q tag vid 7. When the frame leaves the .1ad bridge
heading toward ".1q bridge 2", it will be tagged again with an outer
.1ad tag vid 3.

So ".1q bridge 2" will see the frame as having an outer tag of .1ad vid 3 and
inner tag of .1q vid 7.

Is that what you are thinking, or something else?
