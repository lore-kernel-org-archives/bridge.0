Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C29148300
	for <bridge@lists.linux.dev>; Sun, 24 Nov 2024 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732485676; cv=none; b=m/CJI0YRqgPYCWEs5q2dqjqGVzj0yjHWYuTMYM+K/Hxna2KzQyEkDYx65DEhpR28QY3JgkozTIp35bGHKq5X4S/QcRzQtuKBX0Kw4n7KdvaIrLhhy0SaW+pnCz1K81nAnKlwg97/XGCGZ+N+EqvJLYnBptmp9DgIPn16AM0Emdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732485676; c=relaxed/simple;
	bh=B6ZExtlrWDpdVkh4NrErlj5TWXl10njXAk3D3IVXvjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFu8mUtoMYSqmD7EpvvlzQW0zBdyq5LnlA6cBLnRiM0xHNKla9QzUhTHFM4pCXjbC2vBW+rEUMXH67f0GDnajTJu9kRdJahyAUix5EkAocJFirf5cnOvKnPJV7X3bS6V1r7aNjmFVUmUhImLq44Gfp0d6jbv+RldZd7fIrBCihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=2zUAWzy9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="2zUAWzy9"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431695fa98bso32269985e9.3
        for <bridge@lists.linux.dev>; Sun, 24 Nov 2024 14:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1732485673; x=1733090473; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WO0cvhOCCYEcMHo4t/kUcC7+MddOiWfvg8yPqnsazn4=;
        b=2zUAWzy9/aMOIo2eGKxjZDAb/znSRcvRmdnx0anOW9Yr6H9kM089j3HSOnK24ZOhsz
         v8VgC05cP9IF+bl71uTx9mv8OFK7V/rg8Tq+v1lIAF7eFEEvppp1GdleHICKCRi6JZmd
         PfGjSYOXYhjuMnk+Lsj/5ImYfk3NBcLIJF5VbT3z7LMRGurccwqL3lTF+Fnhi1X+MJaR
         gbTy+QtACYRslPX9fO7N14+hppjJ6crUUnVbP5KG91ChKnZWqkGAGxGQ3NSduqCvDtln
         GU9nROJaphwB7/tl3EiaWrlp4SG02s9V7H6Js5DkDUbKLAsBsH4GlOVOP6K9jdqApt88
         NTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732485673; x=1733090473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WO0cvhOCCYEcMHo4t/kUcC7+MddOiWfvg8yPqnsazn4=;
        b=ZMEdt1nRviOfm2OzFbChrrMbKe1JM8swutlTXh5wz7Ro9sWaj+2jIZbbFBQNaxQTjR
         JvZm+1LSw9stv0ypKpymgt+l7ihHqAlWjRlC+rlQMnlEG4ZvKjei84marlamxeIbQ1DQ
         0M+geV1dET+BuEEZy/feph0+QU8ZMp1m4W9l3zxcd7TziP/fjNiyMnhVfWFJkgs6zS7c
         3vAN+FQrFMNa3a1sXxgTQfDiJuHIjQmg3d8ylsqvd8u0P5RpRibcFRGhdhkq6+mLxAPV
         Nc9ZlqgjUclgs91UHCQ8lLl6R1KzlLy+v8RDPYq48884N6gFuFyIY1Ta6qAzxxEImuSA
         BbDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1bXRGErqlLTUwPgKGp0TLtztnM3tRIXOnYpCA5oQ5iz9VLxgfmtu9HqpZ6AEYfgv3daZb7gA=@lists.linux.dev
X-Gm-Message-State: AOJu0YyL4/0eiiZwrKUae10d3O7bzxlT0wCUEoTOwZJotTkPRepbm6sc
	//wxJkm1BCZY0bB9ikfjkizjGAhVmi7k0kLFikwX+tQjNbZlnoNo/zei1nygBzU=
X-Gm-Gg: ASbGncsawHtrS663Vsf0eoiKZUqroZbM34nEF+YTYbbj0GyAuObiZagoBcXGwXketAc
	ZgnnzFUwzf1e5pVVJsjsPBSth3/hbuDGDbCy7WBQDOe1sm/XmAeuzqAVeIWOU8Wb30PXnj5KQGH
	2mt3dEUIvYFYjtpst14OvNIb8qx3W+wDo1QVTVXNJOf6PSCCQt8ko+VIAUOUaNI5tokHcgD4/mG
	GpcXRCEvfp3Nmn47s0Zg1CKz/fQzDXQhRiZFYAmQxehHJHjYEtS
X-Google-Smtp-Source: AGHT+IEUmJWNVT/yCHIU4DpWfoBtu4D/gDbWjN7B8ekkI1xXmQ3BxXPpdtKlYrC7+KrVS7KrV9+AEw==
X-Received: by 2002:a5d:64a1:0:b0:382:5aae:87c7 with SMTP id ffacd0b85a97d-38260b89369mr8791101f8f.31.1732485673204;
        Sun, 24 Nov 2024 14:01:13 -0800 (PST)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde0db3csm105665385e9.10.2024.11.24.14.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 14:01:12 -0800 (PST)
Message-ID: <87d8a49c-41e3-4b18-9ada-cb64fa66fe9b@blackwall.org>
Date: Mon, 25 Nov 2024 00:01:11 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next (resend) 1/4] net: bridge: respect sticky flag on
 external learn
To: Elliot Ayrey <Elliot.Ayrey@alliedtelesis.co.nz>,
 "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com" <olteanv@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "roopa@nvidia.com"
 <roopa@nvidia.com>, "edumazet@google.com" <edumazet@google.com>,
 "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
 "horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bridge@lists.linux.dev" <bridge@lists.linux.dev>
References: <20241108035546.2055996-1-elliot.ayrey@alliedtelesis.co.nz>
 <20241108035546.2055996-2-elliot.ayrey@alliedtelesis.co.nz>
 <f2ac33e7b8ec0fefa48fe7cd3b1004abab67dcb1.camel@alliedtelesis.co.nz>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <f2ac33e7b8ec0fefa48fe7cd3b1004abab67dcb1.camel@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/11/2024 23:01, Elliot Ayrey wrote:
> On Sat, 2024-11-09 at 15:32 +0200, Nikolay Aleksandrov wrote:
>> So you have a sticky fdb entry added, but it is still allowed to roam
>> in HW?
> 
> No the hardware has informed us a host has _tried_ to roam.
> 
> As I think about this more, using the sticky bit alone probably isn't
> the best idea and it might be better if this mechanism were related to
> a port being locked? After all the port being locked in hardware is
> what generates this event.

That does sound better, but we should have the same functionality
in software as well. Perhaps optional to avoid potential flood of
current users with unexpected notifications, see my response to
the other mail for more info.

Cheers,
 Nik

