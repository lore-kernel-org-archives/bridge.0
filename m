Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0862EB0A
	for <bridge@lists.linux.dev>; Sat, 27 Jan 2024 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706383950; cv=none; b=KxQi5POjY8Eab8RXMtcI9VUsGnrJ6Vih6IGPSbxmrOmkkbFFQZjKep64rQs4uauaXp1EGDeQ0X2hOeuaFiQtWGqjdr14H6zav59ayL4jTNzOxe2j3q2B8Uhty/hcri+KRCrsjcLbLSbFoyz7Kqd4T7JBxFdnny9lmCHXorUXtN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706383950; c=relaxed/simple;
	bh=OFosktua+nK1lqL1BScwNQWTYhvw0nvKXrNIUt/Ki8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VBTOmcJTnkTrD5tYEmlkPSbhcqPW9nACKNHBGkkUpH0Dk8bcBHF5Pv4hV9jGBMZ/Fv0B4Kd0F6qibNKIs43ZYRaGLOo1gyPzjzA3KD+yl5P13W14h0PhZoCvWe+FbVnAe9LWK3ztbIfa8fmoAmQoSzHv60OAi8qbRRltdWkmn5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=PBI2BAX2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="PBI2BAX2"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40eec4984acso9495855e9.2
        for <bridge@lists.linux.dev>; Sat, 27 Jan 2024 11:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1706383947; x=1706988747; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gEpUxuHvkxdnVuo1JHby3iXUNzNjMXHPh3NuTZ9HCOY=;
        b=PBI2BAX2ns4D9zEU2NfT/u/8ALrXDQJIxj/F4ujXUdEuOYaXBBfDy7koR3ur7MP5Hf
         TMJj4qk835h3wTmSPDCYogNbl4O9TUZnbWCCym6cQ1/bpwq3nIT5VndgXFUj2ZF65+Fp
         pvR4uIyV55QQHwtfpSgiUOgy75djYzSZ2DZXPxZ+nnWCdvRLIUVq19Q+6zlnyLnhjzV+
         NCNYP2bbcxJwJNIXviagtXR8kfHxTAfVyNLMzUzqrtQ3cLPvsXVt4TUTjQQjYeJSUwde
         8tJaVTt563WcOGlJsKbwJiiKMkWEk+TMxe1Y7HAyxDbezO79jTR+3pvMMIWYfAR519kP
         fatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706383947; x=1706988747;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gEpUxuHvkxdnVuo1JHby3iXUNzNjMXHPh3NuTZ9HCOY=;
        b=d3fJrPdoqUcWOvldOx/6/QFtbFEBRMX983F93SCi5FpM9gdGIe21e5UmlR8LpFCnw/
         uKmDvZFshz4nTophur2bhnieuqAviTf4bmPtNCroPLBrdFWa/pabKgQGO4gOJBvDLbhK
         yPjLd36UdfR0iI5XIBjsod7mQZzHme0C6clHngSetkEx7ruDyqQceJnZRQSXbDzPqT2c
         Xj+faGqHkjw5fjLwXhBBOHSXgNsPBOTYW6kgxrxUroyLoImOAbR5dl0NCR2grdMTK8dv
         aNs6EONZXQunrOeQYvH5yHzuXd4Yc9L28lZyp2MXvpfax5dB01zTEYc26ITm3W9SREoX
         badw==
X-Gm-Message-State: AOJu0YxkZ8Im50GIQzJrJd9JkkbEUSQsJNITDzrNiKe5T7WCOgxYlpYb
	aDlkWZuCogr9eRtTOgnPNZF68QhX6H8YRP+jV+q0Q1wBm6DjigfVpZ5O0Hm+Fkc=
X-Google-Smtp-Source: AGHT+IFIburJoW4BFrmc+K2ya7vO19XpEC4+2WG74/eThfZcJLQyym2s9GswrAXPsaEejM+mq4MJwg==
X-Received: by 2002:a05:600c:3493:b0:40e:ef00:af57 with SMTP id a19-20020a05600c349300b0040eef00af57mr1308153wmq.36.1706383947218;
        Sat, 27 Jan 2024 11:32:27 -0800 (PST)
Received: from [192.168.0.161] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a11-20020a05600c348b00b0040eef2aed28sm1999515wmq.23.2024.01.27.11.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jan 2024 11:32:26 -0800 (PST)
Message-ID: <43a266e9-7cde-472a-9846-c16756be8c09@blackwall.org>
Date: Sat, 27 Jan 2024 21:32:25 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] bridge: mcast: fix disabled snooping after long
 uptime
Content-Language: en-US
To: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>,
 netdev@vger.kernel.org
Cc: bridge@lists.linux.dev, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240127175033.9640-1-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240127175033.9640-1-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/01/2024 19:50, Linus Lüssing wrote:
> The original idea of the delay_time check was to not apply multicast
> snooping too early when an MLD querier appears. And to instead wait at
> least for MLD reports to arrive before switching from flooding to group
> based, MLD snooped forwarding, to avoid temporary packet loss.
> 
> However in a batman-adv mesh network it was noticed that after 248 days of
> uptime 32bit MIPS based devices would start to signal that they had
> stopped applying multicast snooping due to missing queriers - even though
> they were the elected querier and still sending MLD queries themselves.
> 
> While time_is_before_jiffies() generally is safe against jiffies
> wrap-arounds, like the code comments in jiffies.h explain, it won't
> be able to track a difference larger than ULONG_MAX/2. With a 32bit
> large jiffies and one jiffies tick every 10ms (CONFIG_HZ=100) on these MIPS
> devices running OpenWrt this would result in a difference larger than
> ULONG_MAX/2 after 248 (= 2^32/100/60/60/24/2) days and
> time_is_before_jiffies() would then start to return false instead of
> true. Leading to multicast snooping not being applied to multicast
> packets anymore.
> 
> Fix this issue by using a proper timer_list object which won't have this
> ULONG_MAX/2 difference limitation.
> 
> Fixes: b00589af3b04 ("bridge: disable snooping if there is no querier")
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
> Changelog v2:
> * removed "inline" from br_multicast_query_delay_expired()
> 
>  net/bridge/br_multicast.c | 20 +++++++++++++++-----
>  net/bridge/br_private.h   |  4 ++--
>  2 files changed, 17 insertions(+), 7 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

