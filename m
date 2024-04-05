Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AAA17BAA
	for <bridge@lists.linux.dev>; Fri,  5 Apr 2024 21:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712351709; cv=none; b=F3rW8WW5I0chj6qQ7YgIFgYoaeF2ZYO+NkeOZkZ9kx8ekkIMAp1M1pt84uMnIw2W+csfIKI4bYJcbTonqIgHqqbMWcyiXtHMnsUmM98ZWKNrKIm/gdp7kNTqausZWWhB6+x2/EdSLdzwZxwdDNkaLMRxQR6sMN1YqR611apGYQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712351709; c=relaxed/simple;
	bh=HeNEhIGrzcGEZrocdkVTvsddhLnVgsVIbEn+zKxLMn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/migCLxZDl/p0UBlJlVCKaawu5U87Dp101ANqzh1oGDeiho0TkIAGRdmNmbLazEIsGOcv6iMn/lLP55h0tqKwYBBQyIZhTGVHccFnBBwgbWrce9MpgRsmZQrZc+pPJqTw9FJjwvB43n8366em54Kq2I6O5j3r22sx/4OM3gFfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/5Nr2nO; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/5Nr2nO"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d485886545so47026851fa.2
        for <bridge@lists.linux.dev>; Fri, 05 Apr 2024 14:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712351706; x=1712956506; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o2vV+ljPu+LnmovF94XbYF/3sqJWOm/WOolsuT6CmUg=;
        b=B/5Nr2nOKH7XJMP0max6YINFIUeEyzPPQegMDP7p3Kcd/sJKUyMsry4MZ4jeXtlFOT
         BSaqBgYNld33NPK8Y6+9jrFamSkScIs72ajOkVIhH3+SVmFFtTuGm1CxOkBRjSaX3xmn
         u3nBq9lrO0x/RHDP1AJ4yC+m+WCcAKsqVOTYzWDtPIPYdTRPp5avbq7ep9jcat9ZnOOe
         s1bdRAUShNqUda987ZDPsfXDpZTgbC5GIIg25zlUXNxoZnglH1H8atC4ZPjdnr+VOK++
         4yIUpa/0pQITkAThUIj1/Mt5epxd+iI9re4tezwjtxqlD8RKemA/qrrvLh9DR/ZyV0ak
         H4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712351706; x=1712956506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2vV+ljPu+LnmovF94XbYF/3sqJWOm/WOolsuT6CmUg=;
        b=VsumIWqlXC6fJRp5o7t6ghGN140zXGnwcgFUrVVLvHFPUuO2tz7T006ELgH0dbxbaX
         UW/T7PfSawUgoPrsDZpAnLSnaZslFpg8qP/qtvG8xXkSWInwDbAL8szDsDv0hZfaaxpG
         pGRWnUynLxdPuoHOoisG4VNFCS5CQDA1yvgRevnNabeh2x4eGLBt3mIcehpHAJIQDcYP
         HY3Cee2b7JzseTz9oKmyEtVfJzlPCfKahkDHXxjA0rOsotRH8oyjVZrzybbn3Z+npu4Q
         Cy4wcFSBFnp8OsiA/meiZQvJYUKbPv1lM/sAXEAZ0PuGTf+utqMczx0DUz3gvbGHz07B
         XUXw==
X-Forwarded-Encrypted: i=1; AJvYcCUGZu4zaUFBohGAqoimJ+/SzPRDZC+swMO2EEJIqrIj99fIWg7lZbZAuklhk5OblZabA47Y7wqqR2zrAuaXMaA7Wvk3bWox
X-Gm-Message-State: AOJu0Yz76NUpOZRScWefWV5C+oza05+RU275tHKogqO8Qicn+xQX0wCG
	HdbLqadDmuRM9FwbXaLxksClmyr9wi1huCltUJ5QfQ+tinv6VvRH
X-Google-Smtp-Source: AGHT+IGvqldN6HhRWWnSY5+EnUP2pam16riYtoUm7Q1wDs8Ky3sSiGU3pUJdfw1lLyEvKoUGXAwYHA==
X-Received: by 2002:a2e:8ed5:0:b0:2d8:6b3c:1eb8 with SMTP id e21-20020a2e8ed5000000b002d86b3c1eb8mr2430875ljl.4.1712351705883;
        Fri, 05 Apr 2024 14:15:05 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id de26-20020a056402309a00b0056c1cca33bfsm1169683edb.6.2024.04.05.14.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 14:15:05 -0700 (PDT)
Date: Sat, 6 Apr 2024 00:15:02 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Joseph Huang <joseph.huang.2024@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH RFC net-next 00/10] MC Flood disable and snooping
Message-ID: <20240405211502.q5gfwcwyhkm6w7xy@skbuf>
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <7fc8264a-a383-4682-a144-8d91fe3971d9@blackwall.org>
 <20240402174348.wosc37adyub5o7xu@skbuf>
 <a8968719-a63b-4969-a971-173c010d708f@blackwall.org>
 <20240402204600.5ep4xlzrhleqzw7k@skbuf>
 <065b803f-14a9-4013-8f11-712bb8d54848@blackwall.org>
 <804b7bf3-1b29-42c4-be42-4c23f1355aaf@gmail.com>
 <20240405102033.vjkkoc3wy2i3vdvg@skbuf>
 <935c18c1-7736-416c-b5c5-13ca42035b1f@blackwall.org>
 <651c87fc-1f21-4153-bade-2dad048eecbd@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <651c87fc-1f21-4153-bade-2dad048eecbd@gmail.com>

On Fri, Apr 05, 2024 at 04:22:43PM -0400, Joseph Huang wrote:
> Like this?
> 
> bridge link set dev swp0 mcast_flood off
>   - all flooding disabled
> 
> bridge link set dev swp0 mcast_flood on
>   - all flooding enabled
> 
> bridge link set dev swp0 mcast_flood on mcast_ipv4_data_flood off
> mcast_ipv6_data_flood off
>   - IPv4 data packets flooding disabled, IPv6 data packets flooding
> disabled, everything else floods (that is to say, only allow IPv4 local
> subnet and IPv6 link-local to flood)
> 
> ?

Yeah.

> The syntax seems to be counterintuitive.
> 
> Or like this?
> 
> bridge link set dev swp0 mcast_flood on mcast_ipv4_ctrl_flood on
>   - only allow IPv4 local subnet to flood, everything else off
> 
> ?

Nope.

> So basically the question is, what should the behavior be when something is
> omitted from the command line?

The answer is always: "new options should default to behaving exactly
like before". It's not just about the command line arguments, but also
about the actual netlink attributes that iproute2 (and other tooling)
creates when communicating with the kernel. Old user space has no idea
about the existence of mcast_ipv4_ctrl_flood et. al. So, if netlink
attributes specifying their value are not sent by user space, their
value in the kernel must mimic the value of mcast_flood.
