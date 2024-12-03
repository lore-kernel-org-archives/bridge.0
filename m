Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FF71E3DC2
	for <bridge@lists.linux-foundation.org>; Tue,  3 Dec 2024 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733225169; cv=none; b=OdcvncSNhSv84T8Lz2shOhTXTf0gXKO9VZWA5M2dJPk+IkFjbBvKbEyov1tQO7P0qI+gDGvMB3enljVeBd/MIDhW3HQS3THHqU4TmBb+ClsSg093QNYazmtZbcISWG94TBsUiGn1JDpKV0FnP3nfcPoR4SvT9NUZU9FDx41QAIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733225169; c=relaxed/simple;
	bh=xOHhJS2e7BRBffjVgA/oI7/rkkIN9hsNagUIadI5S4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXDa2iqRetUsNdTSnktsjGawdnhZRqALIC7BOqzlqWsj2rnIRjYphoBISMuirn1s7dcb/Uv0eJBd1OMilD6NmHPbLO5QFYX8GxE0X6YTDcmvEL8APjnZ9fO0kABdhfMenCq9SOukGyARRupIIRn1aYmm/kfOScyh8jiNh4KWOXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Yi5cGQtR; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Yi5cGQtR"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6527181352
	for <bridge@lists.linux-foundation.org>; Tue,  3 Dec 2024 11:26:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6aJqucEkY2us for <bridge@lists.linux-foundation.org>;
 Tue,  3 Dec 2024 11:26:02 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6F27C812FD
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F27C812FD
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Yi5cGQtR
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6F27C812FD
	for <bridge@lists.linux-foundation.org>; Tue,  3 Dec 2024 11:26:01 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-385e0e224cbso2481346f8f.2
        for <bridge@lists.linux-foundation.org>; Tue, 03 Dec 2024 03:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733225159; x=1733829959; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EQKk0snMB1vmn3SCZ7cY178GX753db7hlE0FmDcIMDw=;
        b=Yi5cGQtR38p4mVW0EHu4Yevrbw4TVWUq+NuE3p4pnTH3d7RTBrJgFg/KiPVPNvu1rA
         64tLTH0N+ObW4IpryVDeMbgBDBvKZNqetWzByoDPjUkCRtLJfMBL94mVce4siuq2FgSI
         TXpxmpOtUHfLcQdxnKuukJDGQDR/VHEYXLxpv+rfiAC49sSRTzfq5b4H2gYuMjDK9Nyd
         N/q4Y9jdeLKC8ivYQOelk3cUxHSoQ/zlFUeDptXs16ljiflxrEpp4dUEMLyf4mcHES4Z
         nNZ2WaLAooOEFXW3DNPc7aXiSfVJsQazvSFfQH3UBLdmdHUtApZJPn5RSnzj5JA5ZlyH
         WFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733225159; x=1733829959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQKk0snMB1vmn3SCZ7cY178GX753db7hlE0FmDcIMDw=;
        b=lE8/n8ovgsQEQY23g5KCYZ11ZYPG+VdbDLz78dlUygIw8FnrEWPVQClK3RC+axhKce
         HyzoWNjQOK1IYwku66W1QHtrlkmwzi3OO2bm4NF2S6U2I3eZDluYS59PsFiomlt1cSjT
         09RG9fP2HSIGHWF9VTdlCFj8HYwSBnRA3fNRhRFRRJC1170TVAHO6kySBSZht3eL7Cla
         U8V0eTOD7S7rT/9x0rcyiSW0/bBHtfkJFDSfF3fXiu328TLokwnXwbb37Nw7nOsAVPXz
         pIh+tgBL+appvWXIzEH5gHp2UDuouasJr2Kqhapvik3Szd86Y5leBvjJ9V88g/qcAvR9
         ZNIA==
X-Forwarded-Encrypted: i=1; AJvYcCVbAVjQtZ/+gFOkyhgmMyPFDofsm/A93qaZyGtICr387FTLJnLn7t8/lmIAM9qrlIFvhsF/coc=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yz8xuqM9KaTZyWhZw3k1My4/eeYGCaUNoHkIrOLyAyD8BiWcLR/
	NQ2J1jjt6l+pjkatqaANPrMhYzMRioOZYFJxYUEwMqKurRk0qWcQpBW5nvvamKU=
X-Gm-Gg: ASbGncs/zWdIxmx/Apu2mRzXn7k+MZFaSgn2a0d/+RM9UCjVspzQTcXI1uBN2EqBiH7
	wiEgzOBgjUw24lIiYNttaSRk7Ye0hvI8WHf8NN5WVLZlgCcvnJ2vdWRQeftJ2x50VyO7BeyP0bO
	2mCtUGo7vFRNsF7cybsOG8Tocm6kajHrdn4FezjiwJEVU7t3ugYWgMGnw8CnBT/F3yeLfgf2f2V
	psRMRj6/Ewflydm+Zy6Sud3eqF4nZTbdtI5J0VkOHTKr6suxqdH
X-Google-Smtp-Source: AGHT+IH3FlHetTjK4CzZkif2fE0r9/KIALDBxHfHCk9zvdHQilSiS+hU1hVlXIzPFyEvWRyjrEjC1A==
X-Received: by 2002:a05:6000:1fa5:b0:385:f560:7911 with SMTP id ffacd0b85a97d-385fd3ce08dmr1925269f8f.10.1733225159151;
        Tue, 03 Dec 2024 03:25:59 -0800 (PST)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e4a54b71sm9594496f8f.79.2024.12.03.03.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 03:25:58 -0800 (PST)
Message-ID: <12a687d5-cc87-4993-aec2-07ea799ce334@blackwall.org>
Date: Tue, 3 Dec 2024 13:25:57 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 iproute] bridge: dump mcast querier state
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, entwicklung@pengutronix.de, roopa@nvidia.com,
 bridge@lists.linux-foundation.org, stephen@networkplumber.org
References: <20241101115039.2604631-1-f.pfitzner@pengutronix.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241101115039.2604631-1-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/11/2024 13:50, Fabian Pfitzner wrote:
> Kernel support for dumping the multicast querier state was added in this
> commit [1]. As some people might be interested to get this information
> from userspace, this commit implements the necessary changes to show it
> via
> 
> ip -d link show [dev]
> 
> The querier state shows the following information for IPv4 and IPv6
> respectively:
> 
> 1) The ip address of the current querier in the network. This could be
>    ourselves or an external querier.
> 2) The port on which the querier was seen
> 3) Querier timeout in seconds
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7fa1d9b1fb179375e889ff076a1566ecc997bfc
> 
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
> ---
> 
> v1->v2
> 	- refactor code
> 	- link to v1: https://lore.kernel.org/netdev/20241025142836.19946-1-f.pfitzner@pengutronix.de/
> v2->v3
> 	- use print_color_string for addresses
> 	- link to v2: https://lore.kernel.org/netdev/20241030222136.3395120-1-f.pfitzner@pengutronix.de/
> 
>  ip/iplink_bridge.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 

Sorry for the delayed review, I missed the new version.
I have one small nit if there's another version: drop the extra new line between
the definition of bqtb and other_time, other than that looks good to me.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


