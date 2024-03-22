Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7351CA80
	for <bridge@lists.linux-foundation.org>; Fri, 22 Mar 2024 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711099514; cv=none; b=aY/Mtwo2aho+wmOgpAAWEENk7xbBvEGH/zRcNrTpKXFqUbbMLQeGUbVOGKw9fup0gB1tP8f36eu8LevZCZcbaD1RKoOu4unxMUM4wC3GMA4OnUhLa6zg0AkgMtoc/BefIcVrGCLI2R3nwwXoTcVg8hDayJ5+qwCVyrEaCcpWPo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711099514; c=relaxed/simple;
	bh=1if7BFQwgLxVx3voiZeovJEVGof6kBRuuF6ODWwx63A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a53467ehqElRhsD11VKPLPDNfE/GPqaM1hEiT1j6SWLptEIzkb/dMujBEMfCawBGMWV+t1Z8udWNpArWlq/puSlbirlPjLkyDOCP8oxNHmJkSdkNaCStXTXtlK7OGwkUh67taABGU6Nrn5BHpHpDbgCqBeI0u0m072q7gz9XIEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=EdnvkVGo; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="EdnvkVGo"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A78124182B
	for <bridge@lists.linux-foundation.org>; Fri, 22 Mar 2024 09:25:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G0VYY8u80HdC for <bridge@lists.linux-foundation.org>;
	Fri, 22 Mar 2024 09:25:11 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 86B5B41830
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 86B5B41830
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=EdnvkVGo
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 86B5B41830
	for <bridge@lists.linux-foundation.org>; Fri, 22 Mar 2024 09:25:10 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-56b8e4f38a2so2430285a12.3
        for <bridge@lists.linux-foundation.org>; Fri, 22 Mar 2024 02:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1711099508; x=1711704308; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X5MkR1b8nFs9KfPBt6iM0maCCgb8ISKgftnjTVxrIpw=;
        b=EdnvkVGoEdgU754kt7FrqGk05cHqkWUmKG6nhQRXVCEWIYiQVsFL/0HXxC6uaTjNJD
         n3KHPzOXUVC1+Hn/uLavQVt/53rEAI4y8Vk+YoLoTzbtTyttiBThwDdOodcPE2yhi9+A
         uxY5QJcStJhzBlRmet9EthZx6z2l5CfI2vTMEFRKA2QKXocOB3s/aUwtvKLjPMIOFWMA
         Z0CpvsF5uhWTR0HDkrChfOKplXrVFwg7Ri77w4iCUihrBqf1WQQGeqJ3WVngwaSFGUh7
         rrBAfT/jIPrwtPqUTf8lqxbIhazXCD1uwAcXbZ9vsNzJvDQYKybqWTujq61gh6C4Jbaq
         oDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711099508; x=1711704308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X5MkR1b8nFs9KfPBt6iM0maCCgb8ISKgftnjTVxrIpw=;
        b=jx3EtVgoVcHi025vRXPR6UGOBQ7mMEk0zZXBcwdnNvxy+4BowA01XgZ42S0INt8y/v
         bP0Zvo7LhIAre4nqGe9/xVEeTD6gkOkbibm6GfpURDQl/2xHug/yApTW1unsoc0blc1G
         QNHz8V0OGSF7AmL1dmUmEa4+X6sGD6fqkYfo2zDN9bR/qWpS8wQ0PUPMI7aJQv3O4WWa
         5BSsIhbhPpc3W7pdi0F/NxRI6joGEix7EWMuLhXxSoe5cczTGEY/9c/Q9FbJKSrSJllF
         kANT7ki2khEVxvuKJD5Zoq8bFsEUndTnN0db/Ul1n2unbmp1C3UKg5744RJE+JNToUT9
         D/rA==
X-Forwarded-Encrypted: i=1; AJvYcCWFsNyqvF7iH4cqipXuKXbFfe4zlJHVt296ywSwmQdrzYVe1icyjouyP0PylZcXfZgaq//Z3bjzwDzgKpumvLh4adDj5kbNLGMAMTvGslGAVzM=
X-Gm-Message-State: AOJu0YyHiUGiLDP2IljMJpfNhPKQuPtwXlIWNirwdtFFMrMVR0TESoF5
	XccLQk7ufqHqT1SXSt4LaO5jDMBX+KG3ch1DwFZqsBwC4E4SR0Vn4C0eA2ygK1k=
X-Google-Smtp-Source: AGHT+IFk1iUmTb8JHnehQTzSV1HCFuqRyGHJRY7MUXy/JchuLjhlff6jbCzAZ5z14JSAhRpufCzw5w==
X-Received: by 2002:a50:aa89:0:b0:568:7be0:50a4 with SMTP id q9-20020a50aa89000000b005687be050a4mr1138845edc.11.1711099507868;
        Fri, 22 Mar 2024 02:25:07 -0700 (PDT)
Received: from [192.168.0.106] (176.111.182.227.kyiv.volia.net. [176.111.182.227])
        by smtp.gmail.com with ESMTPSA id fj26-20020a0564022b9a00b00568d2518105sm818655edb.12.2024.03.22.02.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 02:25:07 -0700 (PDT)
Message-ID: <d6ac805e-1bcd-4e06-b3eb-58fc2bb84461@blackwall.org>
Date: Fri, 22 Mar 2024 11:25:06 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bridge: vlan: fix compressvlans manpage and usage
To: Date Huang <tjjh89017@hotmail.com>, roopa@nvidia.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
References: <MAZP287MB0503CBCF2FB4C165F0460D70E4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <MAZP287MB0503CBCF2FB4C165F0460D70E4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/22/24 10:56, Date Huang wrote:
> Add the missing 'compressvlans' to man page.
> Fix the incorrect short opt for compressvlans and color
> in usage.
> 
> Signed-off-by: Date Huang <tjjh89017@hotmail.com>
> ---

Hi,
This should be targeted at iproute2. Nit below,

>   bridge/bridge.c   | 2 +-
>   man/man8/bridge.8 | 5 +++++
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/bridge/bridge.c b/bridge/bridge.c
> index f4805092..345f5b5f 100644
> --- a/bridge/bridge.c
> +++ b/bridge/bridge.c
> @@ -39,7 +39,7 @@ static void usage(void)
>   "where  OBJECT := { link | fdb | mdb | vlan | vni | monitor }\n"
>   "       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] |\n"
>   "                    -o[neline] | -t[imestamp] | -n[etns] name |\n"
> -"                    -c[ompressvlans] -color -p[retty] -j[son] }\n");
> +"                    -compressvlans -c[olor] -p[retty] -j[son] }\n");
>   	exit(-1);
>   }
>   
> diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
> index eeea4073..9a023227 100644
> --- a/man/man8/bridge.8
> +++ b/man/man8/bridge.8
> @@ -22,6 +22,7 @@ bridge \- show / manipulate bridge addresses and devices
>   \fB\-s\fR[\fItatistics\fR] |
>   \fB\-n\fR[\fIetns\fR] name |
>   \fB\-b\fR[\fIatch\fR] filename |
> +\fB\-compressvlans |
>   \fB\-c\fR[\fIolor\fR] |
>   \fB\-p\fR[\fIretty\fR] |
>   \fB\-j\fR[\fIson\fR] |
> @@ -345,6 +346,10 @@ Don't terminate bridge command on errors in batch mode.
>   If there were any errors during execution of the commands, the application
>   return code will be non zero.
>   
> +.TP
> +.BR \-compressvlans
> +Show compressed vlan list

s/vlan/VLAN/
also the explanation is lacking, please add a little bit of details and
what the default is

> +
>   .TP
>   .BR \-c [ color ][ = { always | auto | never }
>   Configure color output. If parameter is omitted or

Thanks,
  Nik

