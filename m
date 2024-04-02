Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED44159910
	for <bridge@lists.linux.dev>; Tue,  2 Apr 2024 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079836; cv=none; b=i0QiVOTGsyDo2NEaSI4h5ufK98EVVT+ii3vI/9ydjOtcEoISKDcx5iAYiBu0gSs87t4XpgHCrlE57W8p4xelzn0ywxfG0zWsbff6DCmMn3OIQaRMpxurIdYfyDivrHqZ/wNjcrFiUD9xaRJEBtr7KH218/gRLoOwBDgsDzzwBI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079836; c=relaxed/simple;
	bh=9uFKBEZ+jTSZSHC4IJ8ZjKJhk+5U54ScceL4P119hY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAdP20zVWkxclSipFvQI4+Dffvenxo9ghh8ww72iaJiQl6W3ZmMosgbTex/f8Kh7I0TbCh2WtzhU+8bpqIzyzN6BjmG6JjL4rl3CwBW5E+u5xp764vFAZhRYQUy/ouRfWYSnq28plAFtDQJtymlS7YifALi6LvO5umUX9FBtx+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwEOYtjW; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwEOYtjW"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4e62f3e63dso311261566b.0
        for <bridge@lists.linux.dev>; Tue, 02 Apr 2024 10:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712079833; x=1712684633; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q1U6HAKXhhezsA9SEW8MoU/AGoBW+xsxrufA0vT6Ds4=;
        b=gwEOYtjWm2/lOjoRGhNv9cPXvjulUfby0abnj6KDnviFZBMtY20TjLvdE4bYtJ6Pk7
         UK8bJCbsNDZFeUpLtfYwuBa03+IlUltGGCqQ0FRwhkw7qyNd78MkU1FdHKilw/Z+DV5X
         Ow97yku+k0ppQ7QK8VrxUDd+yy901Umx/ghfO8eQ4SjlEoqL92aTqmpAA+otRiylaV+z
         L6abBwN0TBAL5k9qmzOH+kz2aO2/8t7FQGyZ19E4Jm4kaHhTtxYBgRI+8KrWZLr3SbFG
         k+aldfO8LMEb2qhGyRhg1OeAWRjcwM71+8fIb64//Qm+iXYwSvSaojFtvXdRs299uVeu
         8+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712079833; x=1712684633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1U6HAKXhhezsA9SEW8MoU/AGoBW+xsxrufA0vT6Ds4=;
        b=knyRnk+ryXcRV3yqLxNT4xnRgsS/EF6f4HyoFdwsTQ93UOlBzrhg9+AJDAlnJ8ddKV
         h9J5q3QF6OCpxy11OXaRBnWYM5heSfrRomTHyyRQ7Lwsn5eXftami1SvHgXcHJ3hBHWS
         G7Cpm8nHb2G8g5Eqh8OH6X4uDTzCCl6CE5R47KRc8zNGLsNVOKii17rMZBagpGfqnVYy
         uEPLpy/LSmjrPhF9eXM3wHPCqxSjTnTWj+0F/1KCfYN+bFlEhBcq016a4s4b+IICuK8m
         PhOkcNosZ21ZPb9qcIOD2IRUtcTTwoDC3QKPxNuyl8Ibl1FwEwhX5R/Zw3MiNZRJ8f5z
         7KGg==
X-Forwarded-Encrypted: i=1; AJvYcCUQQskPJLdS7a5zzOiLPb1Q2TIFgmzbk3C10c4t5Jg57nFlOiZ6JD4t+hsZIAm0NGZiRNj4Hm/39MmWEV5W/ZCNOe+nb84J
X-Gm-Message-State: AOJu0Yzo2M9ZfTv2EevrnxvffgSHH7udGPv8txswg3RImUwy+1XQNlSZ
	lj+JvaP7zmVDGPzr3LI9mrrBFpa38EW7fNykJH/uu1wkI5X5c3j2
X-Google-Smtp-Source: AGHT+IGbjo9a7II81wJZE7yvGIsqmk4ELHWFPT0Xo4t03Mb3LTWDHJDj0Vy415xHzy+PwPE+bj14Lg==
X-Received: by 2002:a17:907:ea8:b0:a4e:51aa:b409 with SMTP id ho40-20020a1709070ea800b00a4e51aab409mr7562662ejc.59.1712079833049;
        Tue, 02 Apr 2024 10:43:53 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id gl20-20020a170906e0d400b00a46c39e6a47sm6832789ejb.148.2024.04.02.10.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 10:43:51 -0700 (PDT)
Date: Tue, 2 Apr 2024 20:43:48 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH RFC net-next 00/10] MC Flood disable and snooping
Message-ID: <20240402174348.wosc37adyub5o7xu@skbuf>
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <7fc8264a-a383-4682-a144-8d91fe3971d9@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fc8264a-a383-4682-a144-8d91fe3971d9@blackwall.org>

Hi Nikolai,

On Tue, Apr 02, 2024 at 12:28:38PM +0300, Nikolay Aleksandrov wrote:
> For the bridge patches:
> Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>
> 
> You cannot break the multicast flood flag to add support for a custom
> use-case. This is unacceptable. The current bridge behaviour is correct
> your patch 02 doesn't fix anything, you should configure the bridge
> properly to avoid all those problems, not break protocols.
> 
> Your special use case can easily be solved by a user-space helper or
> eBPF and nftables. You can set the mcast flood flag and bypass the
> bridge for these packets. I basically said the same in 2021, if this is
> going to be in the bridge it should be hidden behind an option that is
> default off. But in my opinion adding an option to solve such special
> cases is undesirable, they can be easily solved with what's currently
> available.

I appreciate your time is limited, but could you please translate your
suggestion, and detail your proposed alternative a bit, for those of us
who are not very familiar with IP multicast snooping?

Bypass the bridge for which packets? General IGMP/MLD queries? Wouldn't
that break snooping? And then do what with the packets, forward them in
another software layer than the bridge?

I also don't quite understand the suggestion of turning on mcast flooding:
isn't Joseph saying that he wants it off for the unregistered multicast
data traffic?
