Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E591B412D
	for <bridge@lists.linux-foundation.org>; Tue, 26 Nov 2024 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732612813; cv=none; b=UmlDfLMFGsLtWp8Hzq+Bhly2L+KGumUM0L0XZlNOs8NgLxMV49NEWAw+K7eaAltPzX7hYH+bNQEYv+D4ErmnQnbnLpUd/FK0u0njctXhPxt7FCgRGuTfhGAjy1KGNkXKki1VrYZEvF3ofDKUGqKOH9v4I/y55QEu+w8QYOL05PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732612813; c=relaxed/simple;
	bh=UlH9TeFdyUK77c5LaPyqc8+xM8w7w84iAaAxA1vgaiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AM8DTwWvxeBLBzcyjEwWvv9rdZIUHRYjQ8mfm3PimD/vTO3hvMtFCrgAGduIh+FxuG2q9EsqgTL+P0u0bWNMZq1g8V5rpEWS+sA358EcCOcPVcctIS1Vm3z4IGp1ZUpUUdMm9K8eEluBcEmLCNtiS0cGr+lvukFbWHsnv18KE6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=z8ws8w93; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="z8ws8w93"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A56080F33
	for <bridge@lists.linux-foundation.org>; Tue, 26 Nov 2024 09:20:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bixa8_1K2zC7 for <bridge@lists.linux-foundation.org>;
 Tue, 26 Nov 2024 09:20:06 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::12e; helo=mail-lf1-x12e.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4A4CF81112
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A4CF81112
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=z8ws8w93
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4A4CF81112
	for <bridge@lists.linux-foundation.org>; Tue, 26 Nov 2024 09:20:04 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-53d9ff92ee9so6125559e87.1
        for <bridge@lists.linux-foundation.org>; Tue, 26 Nov 2024 01:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1732612802; x=1733217602; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kaF0hhFeZqJ53nXGAucayOM39WQN5SbER/LsZp1+LUY=;
        b=z8ws8w93OdmforTwshFyhNEvIGZBo9yiW6lLVguBfUxVJMCvT2Zm4Z+imJSK2qVA75
         /6px/ZFVO2+yynGnCOvt8LyG2nLOYiPq4hckRPB60SlLkrWUwE9HTbhdZjras7xqJN9J
         A/6qOKv2dLJNWr0i3l6I3xsmdwKlp1XEdwBhIFw3B5sKNNHj0S8KsAaKFrL6s88LMApe
         2WMM1sJW7ZRnJm2t0jRDVr2/z3D7QVdRSGD3AAZeYeb0gk4J0FqNGXJYRzaOJiNQeyWO
         YHnrwTfTwIAOpV2PTBsoYwwQ8cPCk8BMMmMW62oWOl5aVFPdkqRgKobx5pNCO3zJz7ls
         aOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732612802; x=1733217602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kaF0hhFeZqJ53nXGAucayOM39WQN5SbER/LsZp1+LUY=;
        b=aSuAJiZC1dfB9thHU4LXksvd1IUfUoQjlsuwNsEzxYBmhy7gdV3smTBTDOohEnTt+6
         bG+pkkEHyA2tqt+4+UoQoyec29GtWMc8MMVKJG3FLmsGf6uNLdHXwEmOruKIK3h1bmnZ
         C/Pb9ZyQn7gfd5kY9FSP0NIf2BNKbCMTCkbmh7Xxskjg41vBRRG53E2KWviISs6U3fiH
         rK8DH+lPkjhraDUzJsmAzKDcSt6yhDlF9NuLCBFUpAV9WnELVS/sksLnkp2p3COvg23D
         fWonskhKQSWIvbvSMSxjES6tC2J+CETLyUNUN7QLY/bPtQNrdlJMTcrAyIliDFzmWnHw
         8ijg==
X-Forwarded-Encrypted: i=1; AJvYcCW4ZNGFCcFIQ560/mCnBnYbuptD/D/z8cnILtMvN2JOedE9TXFPve7TAYiOCYuOyr3crg+/rmU=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzZ+TTE5dn28vi2y6wCYJHxLvh6iCy9r65OLQmt+z/Ffybo5/1Y
	URurSW/ms+Y3VtObw3vIEdGrjTgpMgNXej2hmAlsjhC6dLGQ+cxw/FaRSq5fpro=
X-Gm-Gg: ASbGncvV/ECfYsSNNATz9wds55fqzU0zv/bq0aT4dF7ks+NLB0J1Z5uLxJf3leR4SdP
	uyIGRkeQfhOi6EgGYbz1A/4Fr9g+BI9wpk5xKHIYr9y4aGuyX8KKU4r71OsZphDPRiX0ntYWMEP
	C0/g6i4c4YVE5vBvkUI4KbuUbr2GJhuWK4oDhPEmtmTqxqbof6/VsZLcpJiGIfh4v5SwDTroK+4
	nPLZ3Qf7fJPIFLVLGR+3yAjdYlLDn9cb5ZRfqAM0kWAE2+4Uxhm
X-Google-Smtp-Source: AGHT+IFMQlMD/+sEPnsIN/xKT487wNnAGDZa0f++OBznM+1stx5PfMyoV8Jo1hWXVzxuOONvvXULsA==
X-Received: by 2002:a05:6512:3ba2:b0:53d:a883:5a3e with SMTP id 2adb3069b0e04-53dd39b0e57mr8021529e87.39.1732612802387;
        Tue, 26 Nov 2024 01:20:02 -0800 (PST)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a4b0af1csm25796725e9.40.2024.11.26.01.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 01:20:01 -0800 (PST)
Message-ID: <80c68c36-8d24-4231-9808-f3d3b76a099f@blackwall.org>
Date: Tue, 26 Nov 2024 11:20:01 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2 v2] bridge: fix memory leak in error path
To: Minhong He <heminhong@kylinos.cn>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, roopa@nvidia.com,
 bridge@lists.linux-foundation.org
References: <385b4ead-8d43-4845-ac66-4218b285be32@blackwall.org>
 <20241126021819.18663-1-heminhong@kylinos.cn>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241126021819.18663-1-heminhong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/11/2024 04:18, Minhong He wrote:
> The 'json' object doesn't free when 'rtnl_dump_filter()' fails to process,
> fix it.
> 
> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> ---
>  bridge/mst.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/bridge/mst.c b/bridge/mst.c
> index 32f64aba..37362c45 100644
> --- a/bridge/mst.c
> +++ b/bridge/mst.c
> @@ -153,6 +153,7 @@ static int mst_show(int argc, char **argv)
>  
>  	if (rtnl_dump_filter(&rth, print_msts, stdout) < 0) {
>  		fprintf(stderr, "Dump terminated\n");
> +		delete_json_obj();
>  		return -1;
>  	}
>  

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
