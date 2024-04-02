Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E2315B54A
	for <bridge@lists.linux.dev>; Tue,  2 Apr 2024 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083858; cv=none; b=CwZftNXpKctgc/YdtFqOqR2IAqGJXbeWYGH7ZiRofiBhQbAMLZeb7O142w6+66a7YujDtzu01IM/tEHBS04QFK8KN3rdRI3svvv9TEQizvIYJpIU9nrHEsAUfYoitfMidvK+Ko+uIdcB1wfiSbs8+j4sxhWqwCNuduLm0Zvei1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083858; c=relaxed/simple;
	bh=vHE3t0v0uJDbSjef7CvRAdHduwYUH2/WlskUw+Mt/ME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+pb+0Yfm18/dMymSIKsLd8XYyY+HM9aRKWlmoOXpw7KHX/EEnpJtyHOJu4NxKXKkNk3s5w/PNArfCXqjz6/kccQ8zCNtvboWkWlFfM3tfBwLV5ycSVujeIJNfCDS5tjYW6tiX8v6pvQ2u8V1SrFYYuHpBdD8VxzsmN5dQNSqRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=YvAhSoni; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="YvAhSoni"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4155baa696eso20653065e9.2
        for <bridge@lists.linux.dev>; Tue, 02 Apr 2024 11:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1712083854; x=1712688654; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LIEcfz25WWX1hRcC//+GqxXzgFgNZ4EfTxo56dpiUx4=;
        b=YvAhSoniM7V0PrnFy/Yc0A9BpsC4dZkH355kJiWc8HOpVaBLftd+Z8VD0uZ6d2Gg/O
         bTCr1Z6ATgHcfR3BumbpZd43/Pg9xC+9hREzJdZ56HK2pO8R2scQpVyLw9GUk2BtO/gj
         x0wEaZ7nssz7AsiLNXBq684FNowK/MF2fF2si3sO9fcAQTUgFa6GrDIhe1zJPaA7f30C
         yGOoC1PR1xt5KHKFocY6fIa7O49DkicpwFQMpwDfuUOZQSfpM33+JIS3YYN9+Yh90iRL
         QZk9YY1gOq/r1h4yu3w4le3AT/mt6HIy7k0j+2CirF8lA1raPfryW+dHPKvMOW25TN7M
         yJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712083854; x=1712688654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LIEcfz25WWX1hRcC//+GqxXzgFgNZ4EfTxo56dpiUx4=;
        b=hNF0L+BnrvMq9W131mC0owupNI/ggyEPENXwIok3ZMNv7XsiYUzCciBkA0gZAP1I7m
         ylVGgDm0g60asRs8bQ4pmUMVKKwI+VcvJlD/CgZKf5FMz+qqKuL6bnL4Hn277ieKpldn
         qTjR4N778XT+KAlwMd7VmhGHzlBDglClJbXHUlTu/NOv8btCw43brW6w9HzRdBWwntNh
         KcGe0+t4Pe4/BmJBxV6SibopREqbFzhe/ixytbnalSC0+Z24fPpW2Levw7U7mIzn7g9o
         fGfKi6dCzErmam5PWKJO8gD+Ewu5ZnBEdFj2mrYGsBGJ61l6gMda0DPH9i9dMPtnqZwr
         f0Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUTzPpp153yQ6qK75AX2TBsYpk5l6FCIw5+hWybE1sAZk4PoB7UMswwhIzAERa42cD+mRD0YUxYezRKZnJcedg1lgsb9mld
X-Gm-Message-State: AOJu0YwrhWfmQKNE9K6Yx+M4tFtS6/9FRMSNbKz2lqQ6ftLAe4si3QoB
	igtvIRTKc8Kqing07wmj4F6Qxhwmp5d3YjCpB64DxmXck/fBZ5TpqT0u/l+LdFQ=
X-Google-Smtp-Source: AGHT+IHG2reakJAyifG34eCuPd2NY3AzmwK7mxJCbjBZSYQSbzpq8u6Qjn1bt7FV9hXw5WZDvMX8ZQ==
X-Received: by 2002:a05:600c:3393:b0:414:9463:d4c3 with SMTP id o19-20020a05600c339300b004149463d4c3mr504116wmp.0.1712083853740;
        Tue, 02 Apr 2024 11:50:53 -0700 (PDT)
Received: from [192.168.0.106] (176.111.182.227.kyiv.volia.net. [176.111.182.227])
        by smtp.gmail.com with ESMTPSA id q18-20020a05600c46d200b0041488978873sm22171138wmo.44.2024.04.02.11.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 11:50:53 -0700 (PDT)
Message-ID: <a8968719-a63b-4969-a971-173c010d708f@blackwall.org>
Date: Tue, 2 Apr 2024 21:50:51 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 00/10] MC Flood disable and snooping
Content-Language: en-US
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, =?UTF-8?Q?Linus_L=C3=BCssing?=
 <linus.luessing@c0d3.blue>, linux-kernel@vger.kernel.org,
 bridge@lists.linux.dev
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <7fc8264a-a383-4682-a144-8d91fe3971d9@blackwall.org>
 <20240402174348.wosc37adyub5o7xu@skbuf>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240402174348.wosc37adyub5o7xu@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/2/24 20:43, Vladimir Oltean wrote:
> Hi Nikolai,
> 
> On Tue, Apr 02, 2024 at 12:28:38PM +0300, Nikolay Aleksandrov wrote:
>> For the bridge patches:
>> Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>
>>
>> You cannot break the multicast flood flag to add support for a custom
>> use-case. This is unacceptable. The current bridge behaviour is correct
>> your patch 02 doesn't fix anything, you should configure the bridge
>> properly to avoid all those problems, not break protocols.
>>
>> Your special use case can easily be solved by a user-space helper or
>> eBPF and nftables. You can set the mcast flood flag and bypass the
>> bridge for these packets. I basically said the same in 2021, if this is
>> going to be in the bridge it should be hidden behind an option that is
>> default off. But in my opinion adding an option to solve such special
>> cases is undesirable, they can be easily solved with what's currently
>> available.
> 
> I appreciate your time is limited, but could you please translate your
> suggestion, and detail your proposed alternative a bit, for those of us
> who are not very familiar with IP multicast snooping?
> 

My suggestion is not related to snooping really, but to the goal of
patches 01-03. The bridge patches in this set are trying to forward
traffic that is not supposed to be forwarded with the proposed
configuration, so that can be done by a user-space helper that installs
rules to bypass the bridge specifically for those packets while
monitoring the bridge state to implement a policy and manage these rules
in order to keep snooping working.

> Bypass the bridge for which packets? General IGMP/MLD queries? Wouldn't
> that break snooping? And then do what with the packets, forward them in
> another software layer than the bridge?
> 

The ones that are not supposed to be forwarded in the proposed config
and are needed for this use case (control traffic and link-local). 
Obviously to have proper snooping you'd need to manage these bypass
rules and use them only while needed.

> I also don't quite understand the suggestion of turning on mcast flooding:
> isn't Joseph saying that he wants it off for the unregistered multicast
> data traffic?

Ah my bad, I meant to turn off flooding and bypass the bridge for those
packets and ports while necessary, under necessary can be any policy
that the user-space helper wants to implement.

In any case, if this is going to be yet another kernel solution then it
must be a new option that is default off, and doesn't break current 
mcast flood flag behaviour.

In general my opinion is that the whole snooping control must be in
user-space and only have the dataplane in the kernel, but that is beyond
the scope of this set.

