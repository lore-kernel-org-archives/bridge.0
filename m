Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3592C5B1E9
	for <bridge@lists.linux.dev>; Tue, 23 Apr 2024 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874667; cv=none; b=LXew90n+GZZY1dfW+rD/68mfS6LvKXbUxZBuwsYXuljOwfQqLzs9T+ukxRTBtK6zmdwKMpGBWSp4M+KtkBVnb4NuiVXiHM1nfi7ox4PwbXOW5/ZkXnYxQT6XX05BwI6mHilzvOu2a3ShOnQa+gunhAtdOzNrtQ3lkXhpzigNcOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874667; c=relaxed/simple;
	bh=YgMJQsKwEunfF3/JdKkVmjQp58JV4DJ5yZc+F7jUYRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rUgYb16S2ZwDs11zKOZKKowMPX+Vsd1u0kZsfjBU9GtE21Ma5rgvg/AMcQ3WA53Kxj7UgXXRVGXLEGk5LMi/M2sdNyE7IdfAO9qFJFTIzAG4BHpiEJzHpGm0rBnwzsllClFzhMo29PWURF21NtHN7LuCVBUBvNex6+9sq6eSQ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=k0WDPxIY; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="k0WDPxIY"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5176f217b7bso9334422e87.0
        for <bridge@lists.linux.dev>; Tue, 23 Apr 2024 05:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1713874664; x=1714479464; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ObSuVk2cCyYOq9cHChsdNHrTyXA1CAw6LSbkNl700bk=;
        b=k0WDPxIYo9o6MmX5fCSLRAATsYaIJa7DYPkr32M69HPqNS/HwDw6R2MvVvQL/fdQWn
         oU6IJ+YncSMcZSc0qT1mOnxe9aUyXDO5PBqnuX/V+T1YqOP+oEH7EDxGpigYbprFNHKf
         Jd7cwHBWZWNvk0SHTBzFnG2tOCt3qVPQNrU9/G+/qf1L6z5oXPeIhlWD04+omdOk/Hue
         ClHHXFLOoxyx8KvoxuBITONCg7+8A01lgoiwpiEpgeK7nN/3BXRLFz8WQOVEWcsVmgLt
         cL/CAtiZEzCxeX3tm58Y1rn1FFEJU6/h14ckRU7VdpMrmz1Lt3JZQNWReoD8A+aORRVx
         v71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713874664; x=1714479464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ObSuVk2cCyYOq9cHChsdNHrTyXA1CAw6LSbkNl700bk=;
        b=PbtPkgkY1whZ2vwpb2DUN3WFJJEdwGwG2dAeeOTDZEgMt3eexH0xwB5a3T+EYxg0Cr
         pcM4b4+Wous4S1apBcvzPUgDBtK/rIlXxR+1p5sHePnJ8RYbJN0AJtXLXLkF6NwdOOy/
         DD9S226HMfQDZynuMxq2X0J+53pX2R8GUeLi/xustAhRl8LrpmlWgfzGxfqnjeWlVZzG
         DGdajIQ7buKRH1JOQyqza5vlJOKYM4JFkiV0KXT1Z8Ru8INhbLy3dhsyTsegie6kJViE
         7LaKHuh8T0VTYM9iDas7knRSf1Pu6At4yhcES/GdVYQlJeeaUUSdMnY9Eir+9l9YiB3k
         qWAw==
X-Gm-Message-State: AOJu0YwtNkiY5T+MVq/B6WTn2Ic06N0b9Xh6YCJxUG+sMyxumz7mi75W
	2NFOXyvO51cf4J6CGyGW31Wvo2CK5VqjSpiI0UAX0H064N2ZXH8P51weCbXJgL4=
X-Google-Smtp-Source: AGHT+IEbnWgJXLndC4r7PMxi12FrfMpBRS1OcRoxhe3SZwm2w23Miy6gbq0HCIfRAKRI1UckQV81bw==
X-Received: by 2002:a05:6512:48c6:b0:51a:f11c:81db with SMTP id er6-20020a05651248c600b0051af11c81dbmr7260880lfb.30.1713874664054;
        Tue, 23 Apr 2024 05:17:44 -0700 (PDT)
Received: from [10.100.1.125] (ip.82.144.213.21.stat.volia.net. [82.144.213.21])
        by smtp.gmail.com with ESMTPSA id e6-20020a170906044600b00a55b9424832sm2245777eja.30.2024.04.23.05.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 05:17:43 -0700 (PDT)
Message-ID: <054555f3-4a59-4f99-9b32-244f466c4ae6@blackwall.org>
Date: Tue, 23 Apr 2024 15:17:42 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bridge: remove redundant check of f->dst
Content-Language: en-US
To: linke li <lilinke99@qq.com>
Cc: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, roopa@nvidia.com, xujianhao01@gmail.com
References: <b1fccc7c-3c9f-45e0-979f-f83dfc788613@blackwall.org>
 <tencent_5C4968C62CB4BF868761113A754124143108@qq.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <tencent_5C4968C62CB4BF868761113A754124143108@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/24 14:58, linke li wrote:
> Thanks for your advice! Should I submit another patch with subject
> "[PATCH net-next] net: bridge: remove redundant check of f->dst" or
> "[PATCH net-next v2] net: bridge: remove redundant check of f->dst"?
> 

Please don't delete the whole thread, just reply below it and snip any 
unnecessary big chunks if needed. As to your question - maintainers
usually take care of this so re-submission is not necessary but in case
they request a re-submission please wait 24 hours before sending another
version. v2 is expected in the subject, also please add a small 
description of what changed in v2.

Thanks,
  Nik

