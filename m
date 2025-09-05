Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C5626AAB7
	for <bridge@lists.linux.dev>; Fri,  5 Sep 2025 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757071426; cv=none; b=u+AixfJv26KD4Zjr7IXedvbXYFmGdSL27XgX9YoUvUr1lNuhUFmUUYCJoG6XFKyxiDLnZGJpYkaMlpHwUuJ4QGC9qhES+sY8RML4lFujy4rdRVx1s1EtKgWuvZ83aXauBFjpRv5NqdEe0w1ktdmeKWsh4TwLOEeZDjqAYwo8T6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757071426; c=relaxed/simple;
	bh=SAnAeq90b52cRN3J2dhK7tdcZAB7hzZ117Wc6jSvgeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAYPlKLK7eea0ZIJRCdNg1L1rlC3uHP7tic4oFHqhU9k1/DSyzZ/3mTXnXGw5w0hFsAMg6ma9ueWvhwtSM0naQ8igjbmkO2RfEm1XGe7G6tBIZ++AW4FE/GoDdG1TBKulzGfbgGkKaRbYxQH5KCFblMl/WUgQv3LPTW/usO8Wtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Ab2E5gNv; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Ab2E5gNv"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55f6f7edf45so2065402e87.2
        for <bridge@lists.linux.dev>; Fri, 05 Sep 2025 04:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1757071423; x=1757676223; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OjePcgGVxRdnlx5tgUBvUSH1J9FdMgeg+3lood9bc5E=;
        b=Ab2E5gNvD+JsFJMdMYn+aZbm+9RY6R8zV02NClRnTzIJNrC1Kpl42NAtX/Gm1qgbQ3
         WaE99pl6vsPCtoBv0su6xjSXyF9M2g04tf0fafsRuJTSN0kfn6RbSNDF0iVJcipbz0KQ
         ch0VFtwIuyQopejLjCltaQGwpBJBBUUckvCi+zndAQPlEu8vGGeDuTSVcIjenEdy0ye0
         mX9AU+lW8oeNuf9B52XnwpOqKZKCMeTnlCI0dI+jys4PqvUSDCktEYd4zHjOECCsbaU8
         5KfOigJIZCrAS8MI7oLm/RZ9sV88QeOUCgl4jrittRxiZfbJEQJgqYSs0jQ8OuYS4qp4
         y7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757071423; x=1757676223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OjePcgGVxRdnlx5tgUBvUSH1J9FdMgeg+3lood9bc5E=;
        b=QwzObsnTSqzBTMa6HoWsrqAa9b0hNigNIm17FaN93WFK20CT/nuRuXAeoRpErHfyy/
         87YVLkFL5UTq3cOsL3kKSoY8594vgDw4TfL28efEqdHczqnZ8NwqacZ9NFdiWUqnhYkE
         gGaxALOWvCreLX/4c0fF1QWAmXZLAegnMsxdVxmhRgNWskr83exgzZp06IaViAHS1sk0
         pzsfw/IbLxLf60jtCxF8JtrnEToCv6sflkrMrT5LsqFJIet4ITVuFAdJEFnBuP8nywZI
         T6R+v4vYpY1IQ/X0P2qGuMHoN28AiBQCBC6bGHpZI0oVkpTDbEwxdIkPcpTBX1OO+Qv7
         gWPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBWtA3Cj34e4EJle4q4AuuCCSHyY+PQ4ANvqvtRFA4UHV7CGyYFeF+cVBpeTIu3eG8IEO1h5I=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9S4UGbCYsVXX1H0JeudBTRpVe5LCg351+8jKxKaUNb8W+7sGr
	uihKnKqMgg4oZ+5N9rPHUUzSABcHHz/LXPtSsRBhxPUdvB8OxB3b1iJHnp08VfUk0zA=
X-Gm-Gg: ASbGnctz+D6SyMQZR752dj7+9ShZxg5eo8WO1dGmXIrroK6d93P+H+HWjACjQA/CUWF
	jnggsaFXoQ8cerUa6jXB+xCNgO6+X8tlh0KUh2QrOhoCUpBg3sUG9gvpy7APjaGQ8Gs7bKDG9o0
	e1VXMpEXvpVL3fH9HqIsQI6mpzfNGent07WA0sUPH5bHlQMW8hQZeWwox1rkd65ouaKJXaztRPW
	vJzPc7r+GC1ymLHplSo1VO9GNvbvwEl59LtUWK7RgNLA03T+4nIpsjdpb0/cxntAGd1pc6AObYN
	OFj1G9Win8NP1RoDTvfYM8u9TO9oFo1RvsxG4pvh+b4pA/jEQzdUHT3tmCpsjVhJdmcMqQas2pl
	PvBD2WWMUxJ+tg6cj+PZcNQH9KvmI9QDSZK3T1O7Akq/ApHZhd5K61HakbEjWCN5e2TzpL7aQtE
	ZUaA==
X-Google-Smtp-Source: AGHT+IG7XfHY5EKO16EPZ02JXxyYGpGUowCGrABENprb58m965+F/rB1M7OFT1GyVqHp4CDfW0yTjQ==
X-Received: by 2002:a05:6512:10d5:b0:55f:63ef:b2bc with SMTP id 2adb3069b0e04-55f708a3797mr7677199e87.8.1757071422320;
        Fri, 05 Sep 2025 04:23:42 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad4e2e3sm1737828e87.147.2025.09.05.04.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 04:23:41 -0700 (PDT)
Message-ID: <f47c15da-f574-46ef-9ed5-e5c26658b116@blackwall.org>
Date: Fri, 5 Sep 2025 14:23:40 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: Bounce invalid boolopts
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev, mlxsw@nvidia.com
References: <e6fdca3b5a8d54183fbda075daffef38bdd7ddce.1757070067.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <e6fdca3b5a8d54183fbda075daffef38bdd7ddce.1757070067.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/25 14:12, Petr Machata wrote:
> The bridge driver currently tolerates options that it does not recognize.
> Instead, it should bounce them.
> 
> Fixes: a428afe82f98 ("net: bridge: add support for user-controlled bool options")
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/net/bridge/br.c b/net/bridge/br.c
> index 4bfaf543835a..512872a2ef81 100644
> --- a/net/bridge/br.c
> +++ b/net/bridge/br.c
> @@ -346,6 +346,13 @@ int br_boolopt_multi_toggle(struct net_bridge *br,
>   	int err = 0;
>   	int opt_id;
>   
> +	opt_id = find_next_bit(&bitmap, BITS_PER_LONG, BR_BOOLOPT_MAX);
> +	if (opt_id != BITS_PER_LONG) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack, "Unknown boolean option %d",
> +				       opt_id);
> +		return -EINVAL;
> +	}
> +
>   	for_each_set_bit(opt_id, &bitmap, BR_BOOLOPT_MAX) {
>   		bool on = !!(bm->optval & BIT(opt_id));
>   

IIRC at the time we did this was on purpose, the mask that is returned should
show which options were actually set without disrupting the call.

Anyway I'm ok with returning an error for such options as well, thanks!

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


