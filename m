Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F042F4A
	for <bridge@lists.linux.dev>; Fri, 14 Mar 2025 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948714; cv=none; b=aheOE1N0uMnMVXm15URhAP9oAMr0Q3qm4JxagEVqa9DyOTLEGcUiSqLFRJnmtk960B47pXoTb9rT74rFzRsAwNkFwMp9WLNTT2qJcn5ivPwThSwqW+CP+kbT3YTEyA8Vp+mRwNNlpfxWweshZM05pzgu5GGU9sCHx6OQVAR8iQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948714; c=relaxed/simple;
	bh=k/sk7VJfX+xc/DR6Xfyqsjt/6QLxyzLhgdh8tAXS6UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OsSQnKdLWv2OXY9gYkk+YmHcxBYpHFjqSWJMrVK5TEcqFMZdQyEp5aP611alyv8KyZjflmhibLbsj1lx/xvjeklbi2Xy2DdbC2pTruYmpayTK26hI7mFOfLp6oxIDcYUh+oyEn4x1EKiNuEqLcS7AKtM/O4k1w+7D35ZKMV6aPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=KhyMGVX8; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="KhyMGVX8"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5cded3e2eso3013758a12.0
        for <bridge@lists.linux.dev>; Fri, 14 Mar 2025 03:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1741948711; x=1742553511; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQa/B6nt3kgsdbkom5ifeTDrO/y61K0MNXroRuAN/O0=;
        b=KhyMGVX8U64+rf8ywfKt879Ud62Ym0TGSPm2xV0HMVU6XDFxPBvBJYfnkJg2o0Q1HF
         7CRML/Uoz7c0RW5aBkIh2Vsa1jlOpHgTA7bGAmt82HWpAKuRSWSSnJRSXjSu/F9Fybs/
         rmo0xT31KSHJ0FWHfwIciYCpta/9J7aVOt/fKNNIa/EgldSFkUX7HkF0w71JDx3+++nA
         ebl0lEksr8LlSWRe636d6PH/3EFV9lm7zZep+S8pZkvwwm4TcBZ81o2OfFoiBadVnZIk
         IjXwOHFrHlmT3ROS1DxZm7WlkUiYGHvhDIH6sWgqisE0V4ymrM0Kp+g7FTC6KyfaLDL6
         UanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741948711; x=1742553511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQa/B6nt3kgsdbkom5ifeTDrO/y61K0MNXroRuAN/O0=;
        b=wuVn4nGO1kUhZXQbbcv4BIjNfR7OzV2wxZa473YIB5aZTf6gaJ+o9SznCGxNDJa4Zg
         G699Ja1n0cc5058OcMhhtK4lFIbKbDN+9gu/nn4mM/9cNTWevXeSGW1DHLQg1/91Ipp3
         HHlgYqTVXYGYrOgRlCfjGfev21WsFrhhcjCVWsMNpnhRm/6Hncqy3uhQTCHvCX6ozXGx
         sbg/J/ddOwEm80alSrT1JgSx1GUiwpeANbby8NJ1ByLKtx4/udoB8EOWne1LOorGE8WN
         TFi/nC2MH0n1Jx2CgOjEQIXYqF3kGmCBaZuQDsn4/bz1CNJxZdheODEK7x/YEae4AkCI
         HnCA==
X-Forwarded-Encrypted: i=1; AJvYcCXDqrLg5HyfwRqzrqjZqhymyb0TK01UrfZOHw1/zdqDgAqxqb7+J1XQwpZXtkmWQlE47rxepk0=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxd6/y5xECKu2iRlJfkBNHqc6P/boVwufV11wD8Xx02ITTh3iqN
	rLjAi1ytc46212TtfebCvMcmIaVaOOPo7c17a3DU7O5c6KnwOVsPgs7zW7dx6HQ=
X-Gm-Gg: ASbGncsQ93HLrcdXYmBWSWLtyiUVwWJG2FefadZK0k/RclVYQKVwdOC/Srr0OY0zYad
	1iW1C6hvNppI/Hrvk6Ps+nF691eiNyU6oiPkLPNmAqqF3D4aBHImyPITU4PMsPKd6Si4Nufho3V
	cYKdvz+cT149SJnC6xRbH2kSx4/NPfh7bM9DrHbd57747QWdIIMHhCBrGJnyO/BBInM3Ya8MjT2
	VEbkq/KYU//0hh5elosFZn18IkJifSOuS8ZB4dKiEgCHUvhnvGx5sviUNSECLiXVWyuQ8jNYN6P
	xR101GxDsmrxF67DebDt7Qk+R1jrj98QZnNuFxQ+ouBGCiLo9y++w7js
X-Google-Smtp-Source: AGHT+IFU1yLu9tpv1nnF+kpniJQogZiPcfQZOJlEwm6IcPq3xU0Mz61gTDHjYh2+NgVH8czlWjjktQ==
X-Received: by 2002:a05:6402:26d1:b0:5de:dfd0:9d20 with SMTP id 4fb4d7f45d1cf-5e8a0c1450fmr1961696a12.24.1741948710739;
        Fri, 14 Mar 2025 03:38:30 -0700 (PDT)
Received: from [10.20.7.108] ([195.29.209.20])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816968ce3sm1818193a12.21.2025.03.14.03.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 03:38:30 -0700 (PDT)
Message-ID: <22026405-bccc-4b65-a5e1-f565b1257fa9@blackwall.org>
Date: Fri, 14 Mar 2025 12:38:29 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] MAINTAINERS: update bridge entry
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com, idosch@idosch.org, pabeni@redhat.com, kuba@kernel.org,
 bridge@lists.linux.dev, davem@davemloft.net, Roopa Prabhu <roopa@nvidia.com>
References: <20250314100631.40999-1-razor@blackwall.org>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250314100631.40999-1-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+CC Roopa (sorry, my bad)

On 3/14/25 12:06 PM, Nikolay Aleksandrov wrote:
> Roopa has decided to withdraw as a bridge maintainer and Ido has agreed to
> step up and co-maintain the bridge with me. He has been very helpful in
> bridge patch reviews and has contributed a lot to the bridge over the
> years. Add an entry for Roopa to CREDITS and also add bridge's headers
> to its MAINTAINERS entry.
> 
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>  CREDITS     | 4 ++++
>  MAINTAINERS | 4 +++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
