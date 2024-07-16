Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80229199EA5
	for <bridge@lists.linux.dev>; Tue, 16 Jul 2024 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136656; cv=none; b=Mu1DeE2h/9mEfGg+7M/gX41T1Zi7H22/lu+UVCCNgFMImvOKDYCN4xR/0MrnNl9gqGgRWgm4f9PApUjRsb3KsxcpgO7JvGgFlc5MmmEtB5O78fCiOnnN9m0EEffpHfzRwYqllNo2Im15+d05OqZcdt3nHciAKYOK+Ic3GjYGUCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136656; c=relaxed/simple;
	bh=/crOubLp6udsD5zhjxldO7SEGmeDTBHhP0I0MWVD0zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1yGTe0JB+VXTBc4UCAxmsN4VaIC41B9ekciI950/IE2pJBry5g6mu3N/qFHKkAn8Bu91cTM6DGTWfSyZUloMc5D2B5DN5JAxDPTtT90lOcHLSTzZtXM+ArQ9xEcWHIXrs245IY4Gb3t9RVyfAL688C+tTZ5pcv6mUHVwJVOBC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=cENWMD0T; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="cENWMD0T"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4266182a9d7so35487145e9.0
        for <bridge@lists.linux.dev>; Tue, 16 Jul 2024 06:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721136653; x=1721741453; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YcLBf72AGLqz53r/avJkjakt+ekctAYLnsPdlsvC3fU=;
        b=cENWMD0T9qSdi2Icgj18Vmj9Pep3ukAeOhw26HFzYg7yVU2pQ+BjKSXs+n8gj1XVgN
         YanZhj4NPVb0AGWh+K0HA4PE9PRmLz79y2ssnlZRHNHUWn9Bis9Fnd7litNmqJOycxGZ
         oaQboHMpJ2aoRdH5wGFGJp214syHQiXSlDunvbYtUA93IxIGhni9c5qcGonPdp/OnrRO
         KQxpvvMHyaBwWlYz6C5gTmALbcysRKD9W+acL2yb9m7WLOPNxSZKIIGel9jsA8M3rA+m
         mgkrsS5kejZ6MtHRD6ZO2r/rgbGBWVgyQYQJ3jiK9528UTjc+PpnBR0wJ7t+o/cVMJ6n
         3eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721136653; x=1721741453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcLBf72AGLqz53r/avJkjakt+ekctAYLnsPdlsvC3fU=;
        b=NVMv5JKKrfPISvwMs3U+6udHoVzvIrhzhPNBxGnXxH1f9P7qBpMnLAgQU1q0wC1P/i
         yJ7i6wTgoZktOqHdlO9mgnRN3q2+TIkZPrEnIo8ioaZhXKyqxMMwYlVf+wBBrxNcrFgF
         mJrv3p7I52izTiP8/zdvADZqyFXJOhKzryQ5AQnKDa3Z5EYSHKTYDKRTho77MiuAQv6t
         y2juPe4bTrpJiynHLt0pWhiqfa1cdMg3p9dUe+ZiUmGuck4UtlPYzzE0zx4UL5bhyJaM
         IeYGe0HKOwW5KKlPva/r60AoUHrVItu7HINH34M8Nz3PQBtDgxBLTL86/zzAUjEyQG1u
         XWxw==
X-Forwarded-Encrypted: i=1; AJvYcCX0cEhZKlzeq3o6hkxv4dXrjqeVKRxa9kOzE/EUl5JSp2SpIIwT2qd62x7scyMGsu0ia1Wr9cxrSIAVDvSWTlpNcJmp05Wj
X-Gm-Message-State: AOJu0YwpbwVgqSXPb/0F+xjRQKLqGu2pZrJnP73mwBCrur29uiZUaKcu
	uOFH7gWEbXZ/zfvLb+TJizEGP2/SEDc3bMU8av8/BOfH/AWTRcnB+C3Ll6sRAZk=
X-Google-Smtp-Source: AGHT+IFKdR1AsGx4POLKWxsTeU6zlw8fAns+4xpz4w4ZoyIBkhXGrK+6JHZOeNFPpEg5EVVeMjtCnQ==
X-Received: by 2002:a05:600c:524f:b0:426:5269:9838 with SMTP id 5b1f17b1804b1-427ba654c24mr15602675e9.4.1721136652680;
        Tue, 16 Jul 2024 06:30:52 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f23981fsm164204555e9.4.2024.07.16.06.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 06:30:52 -0700 (PDT)
Date: Tue, 16 Jul 2024 15:30:48 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Chen Ni <nichen@iscas.ac.cn>, roopa@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: bridge: remove unnecessary cast from netdev_priv()
Message-ID: <ZpZ2CA5h8hsCu4Id@nanopsycho.orion>
References: <20240715024457.3743560-1-nichen@iscas.ac.cn>
 <7476d4f9-3a45-4586-99c5-9e878d4e02ac@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7476d4f9-3a45-4586-99c5-9e878d4e02ac@blackwall.org>

Mon, Jul 15, 2024 at 10:04:26AM CEST, razor@blackwall.org wrote:
>On 15/07/2024 05:44, Chen Ni wrote:
>> Remove unnecessary cast of void * returned by netdev_priv().
>> 
>> Fixes: 928990631327 ("net: bridge: add notifications for the bridge dev on vlan change")
>> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
>> ---
>>  net/bridge/br_netlink.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
>This is not a fix, the code isn't broken and it doesn't violate
>anything.

Yeah, it's cosmetics, send it to net-next without "Fixes" tag.

>
>Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>
>
>
