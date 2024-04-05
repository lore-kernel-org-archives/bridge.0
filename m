Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796F516193D
	for <bridge@lists.linux.dev>; Fri,  5 Apr 2024 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312440; cv=none; b=sBygFGMCFxcDBCPUeM7ReENL5YRd9z7Oclels1K4ytz3NQVBABhfxryekIsbW/JD45iqLOYuV7B8J18MYhmumb80Ee99wTgYdqyj7MiSsVe/AWGlymk34VXYcvAN+Rq23hOMo1dNS1Vdn+qxpPP5O+ovQfec+IDmEWDBKVDPUOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312440; c=relaxed/simple;
	bh=epDKG6z8Wys76tNckad5xGVbR4DAr0bp6dvNStvP1C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJTBn5ZPjZ6fUo9MTiunMYMVVEyBRFDDf3OuePTNuCGmFMcsCJE/t7Z3cLxzocjSS1eAKiMM/f022SFxKG82tzpmylRAgod56EoBfuNfYk09+VJKUHPRW9xs/iOdvZNweetjNywHrWesvkG/DVDQmx93yNlKsMv18PUxSZVATxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSSpvZPu; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSSpvZPu"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a51ab73de8aso28706466b.2
        for <bridge@lists.linux.dev>; Fri, 05 Apr 2024 03:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712312437; x=1712917237; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=38SWrSmTZWs7KDa7oBODYF0O5nAtrKs9S3NxjeSZaq4=;
        b=kSSpvZPuaVOevmSYqgYjtbz8FR1YGtsXusut31+xAlWaQf5H50KsS7CrrMxN59HUzF
         bOipJzKppXxC227/h1OiLtHuIvgw4gDP+40NiBdTDZqBAkKhqlUWtBeyVAi8pPWQmkaP
         JppYbU++Uo9cUeYmAYJbhrazCNuIhhMUZVEOf5oQ7Mt3XPWUZj9t189gKKgD0irAGsKa
         2q2ahMeqPUv1/95GEAN2CYMV+fFny4eT2BV+mEJAYX00/nqeCXFn7UMAisDPItoCJjq7
         RVz1CJE5cLZbPzqoC385WEFuKXdxtGqdWweS89LUpdhHCQgB4CHKob/xJHD+KRZ9XB9Q
         vvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712312437; x=1712917237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38SWrSmTZWs7KDa7oBODYF0O5nAtrKs9S3NxjeSZaq4=;
        b=Yg6Gf7C+/FYRVKbA8Yu3VXP5Kkdm+CuIUn1Pfp109VNs+k5LXhTxv0rD03k/0P4eNL
         gDoHM+9IcZUI0PqSI/+Oqj4j+kio0zmqn3s8J3jwZKXQYYJHx5VnNAXw4eVdfYFic1cj
         uVGqDBmzTDrNeLBjIGPEtRgFeQ00UDLKK1/duiiiq+ead1rzgjT6KCXlShTTZR/Dp2BC
         yyotGXmu0PupXDsmyiFHNsOMUh8Bf5JqP59u4kZ/zG0sy0sAEAvKK9IpDAhyu3w/E4+7
         /Ig4zvLfKk45Yx9yJsx8H9ChlDPBylqKilIaxmf/xzp/qeN7dkyhhXki8MLbwm8UGx4i
         2hrw==
X-Forwarded-Encrypted: i=1; AJvYcCXCXl8ckrNsoXhQry59EnaF03qPCwnxrJR1KKSADJ6EaKGWBsJTID5FBAoGYlF8aNDzSSMRBpr19bodwl9GwslNMg8Wm+zZ
X-Gm-Message-State: AOJu0YxN/yzMfxVZL7UWDSTG3bM96Yd1z/pTCnXJYsdDkXYeq54QBlox
	0HKnKkz4FGnuXC9ksmXVEHm4Fs2AhY4FImWPLe2eE1nxW2CXzlV2
X-Google-Smtp-Source: AGHT+IFzAzEM6HnQJr2tKMWx1hqTxU9tn1IAVVfhSzf33DWUScYbAaumh/DzJ+2Ebu854plrEnueXQ==
X-Received: by 2002:a17:906:b213:b0:a46:e8c1:11ac with SMTP id p19-20020a170906b21300b00a46e8c111acmr636309ejz.18.1712312436499;
        Fri, 05 Apr 2024 03:20:36 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id ks13-20020a170906f84d00b00a46d04b6117sm665637ejb.64.2024.04.05.03.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 03:20:35 -0700 (PDT)
Date: Fri, 5 Apr 2024 13:20:33 +0300
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
Message-ID: <20240405102033.vjkkoc3wy2i3vdvg@skbuf>
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <7fc8264a-a383-4682-a144-8d91fe3971d9@blackwall.org>
 <20240402174348.wosc37adyub5o7xu@skbuf>
 <a8968719-a63b-4969-a971-173c010d708f@blackwall.org>
 <20240402204600.5ep4xlzrhleqzw7k@skbuf>
 <065b803f-14a9-4013-8f11-712bb8d54848@blackwall.org>
 <804b7bf3-1b29-42c4-be42-4c23f1355aaf@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <804b7bf3-1b29-42c4-be42-4c23f1355aaf@gmail.com>

On Thu, Apr 04, 2024 at 06:16:12PM -0400, Joseph Huang wrote:
> > > mcast_flood == off:
> > > - mcast_ipv4_ctrl_flood: don't care (maybe can force to "off")
> > > - mcast_ipv4_data_flood: don't care
> > > - mcast_ipv6_ctrl_flood: don't care
> > > - mcast_ipv6_data_flood: don't care
> > > - mcast_l2_flood: don't care
> > > mcast_flood == on:
> > > - Flood 224.0.0.x according to mcast_ipv4_ctrl_flood
> > > - Flood all other IPv4 multicast according to mcast_ipv4_data_flood
> > > - Flood ff02::/16 according to mcast_ipv6_ctrl_flood
> > > - Flood all other IPv6 multicast according to mcast_ipv6_data_flood
> > > - Flood L2 according to mcast_l2_flood
> 
> Did you mean
> 
> if mcast_flood == on (meaning mcast_flood is ENABLED)
> - mcast_ipv4_ctrl_flood: don't care (since 224.0.0.x will be flooded anyway)
> ...
> 
> if mcast_flood == off (meaning mcast_flood is DISABLED)
> - Flood 224.0.0.x according to mcast_ipv4_ctrl_flood
> ...
> 
> ? Otherwise the problem is still not solved when mcast_flood is disabled.

No, I mean exactly as I said. My goal was not to "solve the problem"
when mcast_flood is disabled, but to give you an option to configure the
bridge to achieve what you want, in a way which I think is more acceptable.

AFAIU, there is not really any "problem" - the bridge behaves exactly as
instructed given the limited language available to instruct it ("mcast_flood"
covers all multicast). So the other knobs have the role of fine-tuning
what gets flooded when mcast_flood is on. Like "yes, but..."

You can't "solve the problem" when it involves changing an established
behavior that somebody probably depended on to be just like that.

> > Yep, sounds good to me. I was thinking about something in these lines
> > as well if doing a kernel solution in order to make it simpler and more
> > generic. The ctrl flood bits need to be handled more carefully to make
> > sure they match only control traffic and not link-local data.
> 
> Do we consider 224.0.0.251 (mDNS) to be control or data? What qualifies as
> control I guess that's my question.

Well, as I said, I'm proposing that 224.0.0.x qualifies as control and
the rest of IPv4 multicast as data. Which means that, applied to your
case, "mcast_flood on mcast_ipv4_ctrl_flood on mcast_ipv4_data_flood off"
will "force flood" mDNS just like the IGMP traffic from your patches.
I'm not aware if this could be considered problematic (I don't think so).

The reason behind this proposal is that, AFAIU, endpoints may choose to
join IGMP groups in the 224.0.0.x range or not, but RFC4541 says that
switches shouldn't prune the destinations towards endpoints that don't
join this range anyway: https://www.rfc-editor.org/rfc/rfc4541#page-6

Whereas for IP multicast traffic towards an address outside 224.0.0.x,
pruning will happen as per the IGMP join tracking mechanism.
