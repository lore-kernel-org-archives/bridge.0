Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836FA255226
	for <bridge@lists.linux.dev>; Mon,  7 Apr 2025 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049735; cv=none; b=dhjDPkg7803QrmWniWDibelLwaTG8K/46Z9ymKiKDhrQ8ws238gjTE+LU8lwC3HOKHMmJ7UqVgSxBguBY7T3M2JJHX98f5dPkCinDOejPF/+m9/WUDGq2azR9qARvLSSiV6ogVsepy8ddK9riawR30tNVAuunc8jJy/xeMi4Mas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049735; c=relaxed/simple;
	bh=0DGW2GtE/wbTFy6zNvPW1hLpO8FevOBzZbFxsl4xPjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cb/F3/4ST82D2Dyjt7BWZGJoWlD6BOKA7E8qBus0EDJREsg9e7IQrd3W4LzNXIfqWpP0oz6ViESAa45BHmKMXWjM7TliwLke/466x/GADmv4WSRaBTHqyRAtM+4Ha5dwzO0JvgRZK+mfTWo7vFKEPpbVpvsus1pguHQH7pAu4Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ektic5m4; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ektic5m4"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-6febbd3b75cso43631827b3.0
        for <bridge@lists.linux.dev>; Mon, 07 Apr 2025 11:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744049732; x=1744654532; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W+y7j0d94ESJiQTrZdM7W+yXTrmSLOAkjPT20fXhISA=;
        b=ektic5m4xGiOWpUslH23YoiYq+GEh+dqH+19noYy1xepS/c2Lj9Vntt3UfLsNTgdvu
         K+yV6x4tg+OX9HSJxVzE4ODzEV4b72ZrHln7PsU9dhyrwsC1PypeHf1vWHD3NR0b7hqd
         SHZ6p1+2x7QaguDm3R+jj/taDL4J2fYHhuPre3eYVBFGbsIgH3ZtQpGAd/F0QfPtPFYQ
         Wg72GMkKoRNTMHK86esOamPdlOEJU/YMizED7X4fIOyqWRfIQ9To9Ud8YkrI46knX1Le
         8HHZFTdN0NH/6isuNw5ZenZ19LDmEifILcMxFiO8NoIV6Gfm0OY9ubu1ChN7vSQj6UA8
         iYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049732; x=1744654532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+y7j0d94ESJiQTrZdM7W+yXTrmSLOAkjPT20fXhISA=;
        b=wKqjkqEqlQVfHOh7nTf7BjU341mM7vQrEIegwNzAJUmHGHcUnVTpZ8fC9T+b97ytO9
         Oiaa3R2swDg+x/nZdcnOb7geZcGU+prVspdBysos86ktjg7Tgy8xQ2Yqe8Ou5upjOQ7i
         OlLZ2mx59T6eN21Zolsoc2o7eA3mmxYVMw2D2g+bTgqVpEXFnHaE+qjKcVsEQz9i6XyL
         S+SxdpcME37HipXk4S/ULcmi8bZt0/0NL5kJtO4hvpVfleZU9TKMaURk7nKLox+m4qf0
         3IxfVZ+0qYyC32/FdYoDbdFmH6sJm9ZErFECljH152Bmtu5rIDSOQgFazM+WItW46/8b
         I4bw==
X-Forwarded-Encrypted: i=1; AJvYcCWyjw20b46mnw0OpqX3Ylin+FCHIQCP0pIeB8Y8Ov78HgaZCOh0UpEls0UC7weTeuO5e6LfMNU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzg6n4caZMur4MrFS3sUX4wyB0IeuxWvJWiTuh+NWw/9fbGv/nT
	z3H0c1zMLWfC7Cg7YYy9Rcvsuhm2J2R8DxHcnZ2WocgdSY2wdyeq
X-Gm-Gg: ASbGncvY1m1G6Kx9x5nWwmMyETZlOL65JbkgPBFOCd8/WwjLEIv6j0CxvjW6D4bOTIu
	C8yilTPkKc2942L0psf2ad0Ugl6jyIJoNVo0ICmpxAEPdmfa/stVbwWZixX8hGYcYXuZAzMpzxA
	oll42BuX1T1bktkH3EbWcfrmwByDJBrBaqZW9Xj1eJ+eupV4tnsJBFeuAn9NOpEJ+BZ0GJQ0bPe
	xRXB8xIf0xY+u3XNRA10L1afWn+roYMKlqcNLN9ljIIMzXD+w4wQ9cPIXI1fR+dxzp/Na/rD35t
	c3aF1uGn1ItNXrVR11ioKt2y7IPnBNc9oaYfCbOeJjdZIcLlr4KH3oZOIKiL4ENeyy0kqncxKdf
	L8g==
X-Google-Smtp-Source: AGHT+IF2uFzNJUA+HFuJSyLd8tdsQvhlIigDoTzGOxEQtLXp81AorTYnwP7QptlT3IUmR4B0WPnQ9w==
X-Received: by 2002:a05:690c:2506:b0:6fb:9389:3cde with SMTP id 00721157ae682-703e14f8287mr237326997b3.3.1744049732407;
        Mon, 07 Apr 2025 11:15:32 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-703d1fa6f24sm26502997b3.98.2025.04.07.11.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 11:15:32 -0700 (PDT)
Message-ID: <af01e665-08bb-4b60-ba0b-1784dd8a5ce3@gmail.com>
Date: Mon, 7 Apr 2025 14:15:31 -0400
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 net-next 0/3] Add support for mdb offload failure
 notification
To: Jakub Kicinski <kuba@kernel.org>, Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250404212940.1837879-1-Joseph.Huang@garmin.com>
 <20250407102941.4331a41e@kernel.org>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <20250407102941.4331a41e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/2025 1:29 PM, Jakub Kicinski wrote:
> On Fri, 4 Apr 2025 17:29:32 -0400 Joseph Huang wrote:
>> Currently the bridge does not provide real-time feedback to user space
>> on whether or not an attempt to offload an mdb entry was successful.
>>
>> This patch set adds support to notify user space about failed offload
>> attempts, and is controlled by a new knob mdb_offload_fail_notification.
>>
>> A break-down of the patches in the series:
>>
>> Patch 1 adds offload failed flag to indicate that the offload attempt
>> has failed. The flag is reflected in netlink mdb entry flags.
>>
>> Patch 2 adds the new bridge bool option mdb_offload_fail_notification.
>>
>> Patch 3 notifies user space when the result is known, controlled by
>> mdb_offload_fail_notification setting.
> 
> You submitted this during the merge window, when the net-next tree
> was closed. See:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
> Could you repost so that the series will be re-enqueued?
> 
> Thanks!

Sure thing!

A couple of questions:

- Should the re-post be v3 (no change) or v4 (bump)?
- Do I re-post after 6.15 is released? Around what time frame (so that I 
can set a reminder)?

Thanks,
Joseph
