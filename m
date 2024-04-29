Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7096140E50
	for <bridge@lists.linux.dev>; Mon, 29 Apr 2024 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421647; cv=none; b=uEX9rrPYjR9S4dPIhoBs7JfSBcqug1feAJB5dBeCh/m8KGdFPLN6q1xEQMJ6zx1GOrsf4uQArWCqUksBc0Y0H1+I/H89SM13pbJUKINqgm8lix1TBanxIVNQ8fZGvZpJ61y+iPcm+JPAm+fefojOcDenfPp/ehHeogIhlFfaJys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421647; c=relaxed/simple;
	bh=0At8lX7yDVT99lf+2YRT4XjVI4sYgWI0I8ADNXSCQ7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rh0d4Xb0XfJfW/kH50rr745QRI8St47/zB0hfc1y+kUIlPVRZ+zvz++ozeTTx+53aaTXDGtYJx6CDeqO5sStBwZXvy9l9PEDd+IqE626/IrCl4nbR+v3lLXhvpQGSkW0aEZmanHivrfIOHcIIDdWTxEETdkzLY/enPK69NcYf+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXRCKk8A; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXRCKk8A"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-61ab6faf179so48336937b3.1
        for <bridge@lists.linux.dev>; Mon, 29 Apr 2024 13:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714421645; x=1715026445; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ztn8VHREGAsyACExpYLYeMgJIaQby/N989yJJGpHZlE=;
        b=NXRCKk8AZA5/bBz7mWjpmbY7A/JULCu0OU3FAQy3i+/afjgYdi6XK+x1N8ber3I/bS
         ag3Uw0IvgWQJlV/844MDqbndi5olhpI+ggMXLZ6uHD4N+atYYz8Lht9ZVDU5Y+IRDcHY
         zrW4+28nOlgQn/JvXkWx/1obSXIrkMN3w80XagyLP7kC/+F33GBqf8bNwgu01THRT599
         h6l9Rw62seTO86WqRL4/cefvKAH5wV0SJIEdyduF6SVQfzMwealLeVPlJMuhE1vSSzSA
         sXu4DhTNv5K/Czchk/q7BYoyTM3ti2HPn3H8jk2gigmM7ID4Iv472pAukSETsuTT+BaR
         JtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714421645; x=1715026445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ztn8VHREGAsyACExpYLYeMgJIaQby/N989yJJGpHZlE=;
        b=eOpSOhZt0CWom4iGEoDkRKP5Rf64O6n6ZN7BNc2/Pp5whwlyPjUElchLxcahMaHYeH
         sW8+V6WljTXwpmfFYpTM/MSFsFaaDHuURPgcAHjOeez3HYhdPE2wEv+tM591zwMoJIq+
         FKDYswQg3qXzmmdg51UFDqbHkYInaPLRfrnlYUHsUdMbdIoeVB93ArWmQp8cvgTSQdhm
         zgFlsT0g0AJ+W8qFJEdBiaiY39K7/hATQGXUFDs86gLR9TdDQ32aXqCXwp8aiIcMvXzV
         ghnRbwOlNfUL27JNBJJHC5O59EsHPQep+3K2NDj3oopGcCMD2N9z3iYL1xraA7md0xjd
         Qp/g==
X-Forwarded-Encrypted: i=1; AJvYcCV7EHsY5RvHj9DhzYv1rVTfkwfhLTariBdz7CxNhejcrBaFuKeUsfUc/jxaS7ONPWGsLx6mJ7ned8FGIqKXk4wxXlv1Z+iE
X-Gm-Message-State: AOJu0YzMhGhRl9Kpbteab4jJF4y8Ynlpw5I9r0wbbjakwJZL3PvNSYX4
	/qKAddKoD9H/K+SlP7H/G7f5yIBNWlQS/qLpGduk2PjI/vaZux/o
X-Google-Smtp-Source: AGHT+IHQoR1nSmOx/G+v5N8K3+cuxrNIBxvrRympbd3Mm+wPCW8AuTUjgOFvvBvYxSJ9xKs2J6P1lg==
X-Received: by 2002:a05:690c:678a:b0:615:22ff:b57d with SMTP id ib10-20020a05690c678a00b0061522ffb57dmr13364123ywb.42.1714421644855;
        Mon, 29 Apr 2024 13:14:04 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id k19-20020a81ac13000000b0061be678259bsm144572ywh.36.2024.04.29.13.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 13:14:04 -0700 (PDT)
Message-ID: <1f385946-84d0-499c-9bf6-90ef65918356@gmail.com>
Date: Mon, 29 Apr 2024 16:14:03 -0400
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 00/10] MC Flood disable and snooping
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
 Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, =?UTF-8?Q?Linus_L=C3=BCssing?=
 <linus.luessing@c0d3.blue>, linux-kernel@vger.kernel.org,
 bridge@lists.linux.dev
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
 <20240405211502.q5gfwcwyhkm6w7xy@skbuf>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <20240405211502.q5gfwcwyhkm6w7xy@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/5/2024 5:15 PM, Vladimir Oltean wrote:
> On Fri, Apr 05, 2024 at 04:22:43PM -0400, Joseph Huang wrote:
>> Like this?
>>
>> bridge link set dev swp0 mcast_flood off
>>    - all flooding disabled
>>
>> bridge link set dev swp0 mcast_flood on
>>    - all flooding enabled
>>
>> bridge link set dev swp0 mcast_flood on mcast_ipv4_data_flood off
>> mcast_ipv6_data_flood off
>>    - IPv4 data packets flooding disabled, IPv6 data packets flooding
>> disabled, everything else floods (that is to say, only allow IPv4 local
>> subnet and IPv6 link-local to flood)
>>
>> ?
> 
> Yeah.
> 
>> The syntax seems to be counterintuitive.
>>
>> Or like this?
>>
>> bridge link set dev swp0 mcast_flood on mcast_ipv4_ctrl_flood on
>>    - only allow IPv4 local subnet to flood, everything else off
>>
>> ?
> 
> Nope.
> 
>> So basically the question is, what should the behavior be when something is
>> omitted from the command line?
> 
> The answer is always: "new options should default to behaving exactly
> like before". It's not just about the command line arguments, but also
> about the actual netlink attributes that iproute2 (and other tooling)
> creates when communicating with the kernel. Old user space has no idea
> about the existence of mcast_ipv4_ctrl_flood et. al. So, if netlink
> attributes specifying their value are not sent by user space, their
> value in the kernel must mimic the value of mcast_flood.

How about the following syntax? I think it satisfies all the "not 
breaking existing behavior" requirements (new option defaults to off, 
and missing user space netlink attributes does not change the existing 
behavior):

mcast_flood off
   all off
mcast_flood off mcast_flood_rfc4541 off
   all off
mcast_flood off mcast_flood_rfc4541 on
   224.0.0.X and ff02::1 on, the rest off
mcast_flood on
   all on
mcast_flood on mcast_flood_rfc4541 off
   all on (mcast_flood on overrides mcast_flood_rfc4541)
mcast_flood on mcast_flood_rfc4541 on
   all on
mcast_flood_rfc4541 off
   invalid (mcast_flood_rfc4541 is only valid if mcast_flood [on | off] 
is specified first)
mcast_flood_rfc4541 on
   invalid (mcast_flood_rfc4541 is only valid if mcast_flood [on | off] 
is specified first)

Think of mcast_flood_rfc4541 like a pet door if you will.
