Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAEB7580A
	for <bridge@lists.linux.dev>; Thu,  2 May 2024 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714651976; cv=none; b=t7JSXqbcd1wolSrkvEP6ImiCvZWMuYP80LC6Tba2qDfGUJ7xu1xpr82SbiaPz/ZMnyR6nE1RANcjJ90Bc74Rhrc46y4rzxYovbLnGBl3UMvlvC5stYU/4gt5E1eg0lZzD5YkUvkXbTKf+VxDlMhI87HLY0AKmFun4AZDVpgirUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714651976; c=relaxed/simple;
	bh=U0+9t/DUTI7wv+JhYa4+yvPwHRkQr5ZuSHZ6s20Plk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LcO2l+ufy7/flf36ydGuZgPHmIy88o6RUFVyKCZDGk2pjzSH9xu54jUyboCxN738Eus6lR4PlRxoxSwipruEO3KUbg9gv8TeFNDe3JK0SIorWstfTqBGPYbZ0epxm1/z8O8lWQbW6DJqf1oM1e1hrIxWIUbp6Z883ty4fQUEyhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=OwQxr1O1; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="OwQxr1O1"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so195218a12.0
        for <bridge@lists.linux.dev>; Thu, 02 May 2024 05:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1714651974; x=1715256774; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=672JpQGQxN2adDtGURkG6O93oWu5Ah9pxezBGrFTATk=;
        b=OwQxr1O17lbFxRW7h6qxbOseD6A2y5qSME8gRSlErf4Z8uv3buPyKQxZDquOmM4vg3
         DkUeeD7jMi4LYXkb7cMvR5CRkT82PVLbR4yblaVp1WxAzqSy3haPw5ngFzmjy6f1xqHm
         +8xDAkFD4+ILmVojT3jbQnbhQRJFleVyi3+sDvyiIJGFWFMLTDrAHjcCcbIxz6uy3JYT
         7AZWM0WiqG6GmD57IbF/2UUTz0z2fMWAfmnkFn5OzSkc4iNPPO3ZYcJT+V1XrJnR0907
         /bhEn/kHdF70sbdlBeqVklJQzxVbb+DK0WuYU+Y65YE1qI9AIQnPXXDZwVwhAM27A0Vy
         W3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714651974; x=1715256774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=672JpQGQxN2adDtGURkG6O93oWu5Ah9pxezBGrFTATk=;
        b=aq+wn0qP9Km029V08VZbzQURn4Z3o1bu3hTveOfrb8gWZYCcrDn8wC2BY2uijU1Mnp
         z7tdyR0kA2BKjM8xBGu9N9C4HHEDIjQcaFsYmyGSxzX32ygFm4RWAdbY5AWXm2NsEuO0
         zR3El9n/L8ymgh5mIbwODmCCBdyBaKMUfRdKe+ROu07fevQ7e3QrlJ2YxV85J2mfFnhp
         SmzLpV++iNS4/SMFgD4OgorWG5yAWjoEanmnodLg9GhG5bDU5BkGU9dxU6Qha7KcOBf3
         c5NBRsNNeAtxvbeiLfYcK89KKmwAdpKtyFGWB0EhmU4WBH5p5abNOIj30LihQRi0chK/
         BPoA==
X-Forwarded-Encrypted: i=1; AJvYcCWO680rPfUR67JeuPZenHibGDeYv2iFjDirb07SRGbY1xtOWdBfCjsFI8RgiU280c1EhG2+NqyXw5kQIHlj0Jwt+xvz5Anx
X-Gm-Message-State: AOJu0Yx1cda470ikEbSSlIPBkoEOf79bp6rymfad50rHMmS/OaelAMAQ
	xSv2pOlMUBDnDVIABVc+6rJUyoHCxL9GkppZGcyWBL0wQxigpuh2pLPVpd20ZR0=
X-Google-Smtp-Source: AGHT+IGBveCIDdwRLjqeRHzu8Xwq+nwSoG7CgDOi9YvahOmP7DijvF4W2bSeOpwFts4MR/jGuXktPw==
X-Received: by 2002:a50:d613:0:b0:572:a198:49ca with SMTP id x19-20020a50d613000000b00572a19849camr1953208edi.20.1714651973540;
        Thu, 02 May 2024 05:12:53 -0700 (PDT)
Received: from [192.168.0.161] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id t17-20020a05640203d100b00572c15aba54sm465190edw.17.2024.05.02.05.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 05:12:53 -0700 (PDT)
Message-ID: <431e1af1-6043-4e3e-bc3b-5998ec366de7@blackwall.org>
Date: Thu, 2 May 2024 15:12:51 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 00/10] MC Flood disable and snooping
To: Joseph Huang <joseph.huang.2024@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, =?UTF-8?Q?Linus_L=C3=BCssing?=
 <linus.luessing@c0d3.blue>, linux-kernel@vger.kernel.org,
 bridge@lists.linux.dev
References: <20240402174348.wosc37adyub5o7xu@skbuf>
 <a8968719-a63b-4969-a971-173c010d708f@blackwall.org>
 <20240402204600.5ep4xlzrhleqzw7k@skbuf>
 <065b803f-14a9-4013-8f11-712bb8d54848@blackwall.org>
 <804b7bf3-1b29-42c4-be42-4c23f1355aaf@gmail.com>
 <20240405102033.vjkkoc3wy2i3vdvg@skbuf>
 <935c18c1-7736-416c-b5c5-13ca42035b1f@blackwall.org>
 <651c87fc-1f21-4153-bade-2dad048eecbd@gmail.com>
 <20240405211502.q5gfwcwyhkm6w7xy@skbuf>
 <1f385946-84d0-499c-9bf6-90ef65918356@gmail.com>
 <20240430012159.rmllu5s5gcdepjnc@skbuf>
 <b90caf5f-fa1e-41e6-a7c2-5af042b0828e@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <b90caf5f-fa1e-41e6-a7c2-5af042b0828e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/04/2024 20:01, Joseph Huang wrote:
> On 4/29/2024 9:21 PM, Vladimir Oltean wrote:
>> On Mon, Apr 29, 2024 at 04:14:03PM -0400, Joseph Huang wrote:
>>> How about the following syntax? I think it satisfies all the "not breaking
>>> existing behavior" requirements (new option defaults to off, and missing
>>> user space netlink attributes does not change the existing behavior):
>>>
>>> mcast_flood off
>>>    all off
>>> mcast_flood off mcast_flood_rfc4541 off
>>>    all off
>>> mcast_flood off mcast_flood_rfc4541 on
>>>    224.0.0.X and ff02::1 on, the rest off
>>> mcast_flood on
>>>    all on
>>> mcast_flood on mcast_flood_rfc4541 off
>>>    all on (mcast_flood on overrides mcast_flood_rfc4541)
>>> mcast_flood on mcast_flood_rfc4541 on
>>>    all on
>>> mcast_flood_rfc4541 off
>>>    invalid (mcast_flood_rfc4541 is only valid if mcast_flood [on | off] is
>>> specified first)
>>> mcast_flood_rfc4541 on
>>>    invalid (mcast_flood_rfc4541 is only valid if mcast_flood [on | off] is
>>> specified first)
>>
>> A bridge port defaults to having BR_MCAST_FLOOD set - see new_nbp().
>> Netlink attributes are only there to _change_ the state of properties in
>> the kernel. They don't need to be specified by user space if there's
>> nothing to be changed. "Only valid if another netlink attribute comes
>> first" makes no sense. You can alter 2 bridge port flags as part of the
>> same netlink message, or as part of different netlink messages (sent
>> over sockets of other processes).
>>
>>>
>>> Think of mcast_flood_rfc4541 like a pet door if you will.
>>
>> Ultimately, as far as I see it, both the OR-based and the AND-based UAPI
>> addition could be made to work in a way that's perhaps similarly backwards
>> compatible. It needs to be worked out with the bridge maintainers. Given
>> that I'm not doing great with my spare time, I will take a back seat on
>> that.
> 
> Nik, do you have any objection to the following proposal?
> 
> mcast_flood ->          default/    off         on
> (existing flag)         missing     (specified/ (specified/
>                         (on)        nlmsg)      nlmsg)
> 
> mcast_flood_rfc4541
> (proposed new flag)
>      |
>      v
> default/                flood all   no flood    flood all
> missing
> (off)
> 
> off                     flood all   no flood    flood all
> (specified/nlmsg)
> 
> on                      flood all   flood 4541  flood all
> (specified/nlmsg)                   ^^^^^^^^^^
>                                     only behavior change
> 
> 
> Basically the attributes are OR'ed together to form the final flooding decision.
> 
> 

Looks good to me. Please make use of the boolopt uapi to avoid adding new
nl attributes.

Thanks,
 Nik


