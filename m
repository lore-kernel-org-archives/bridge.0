Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F0D4437F
	for <bridge@lists.linux-foundation.org>; Fri, 22 Mar 2024 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711112063; cv=none; b=gZ2a9RuHrLw79C0Uynrtceyex7LuCgpf7FxxlzX2FhCmfZMqrJtA4md8U2YOIBmEUvMaNdP8IEGHTeyIciT5agDD+GKC4yV4y+AY7AJU7YCytm5rQrwBqVxb9C/h4aX2onjdo97vfPL8hPh/Rn1KaFxenAtO1FgYa73psSWDVTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711112063; c=relaxed/simple;
	bh=QqV7VV5EObT8Q/oxcBr4k0DipDuTOpP52G2tdoq8gjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpPVPQjnLxFV8GMnNEiXnxSaJUI0eAUYsKOGA39c53zuktEgfhkt3vmAtI0sPIiLV/yPc8i0Mc/FQONNQkIhZtxLptBr3tOxlDcso2PUslAD4AoanhadNQS/32VRGgKn3r7utuPI7JLbuGXsIbTu1up+OuYBfZdyVblGkOZbmlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=YHFJS4/o; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="YHFJS4/o"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45B5F60644
	for <bridge@lists.linux-foundation.org>; Fri, 22 Mar 2024 12:54:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8AmBTbpNbjcn for <bridge@lists.linux-foundation.org>;
	Fri, 22 Mar 2024 12:54:21 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2AFBA60656
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2AFBA60656
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=YHFJS4/o
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2AFBA60656
	for <bridge@lists.linux-foundation.org>; Fri, 22 Mar 2024 12:54:20 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a46f0da1b4fso273578466b.2
        for <bridge@lists.linux-foundation.org>; Fri, 22 Mar 2024 05:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1711112059; x=1711716859; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J6RemCy6dcZjDYEdLINT2xX2A+yK+ZiPj+rD9BKuGTk=;
        b=YHFJS4/oL9NU9Di8oEwVedhsw6ZJyDMXbUIxSc6Bt9o7rA2XZAuE72S7hwdp2Cb6N5
         RzwfzSFnIhZ/ihZxspxe5MsmVHtGNejmo6MWakhFXIhWyWCD8GpIX/OqwydhcJCZyKSg
         HFpW9gOdlnhXssPN/vsNNZnz1uYVlDA39Ab5kV3nLFM2F6S1NLEQHtEigmydqsMxsWah
         17eWmRjSatWS+Dj/G7zigT4eucZmlAsAcVhLxbIENwiULawaYxdDHm7lZrVJBesPhcof
         4QGiGa8wmfZ4TRxKcM4Fqh4tmN9WVUAlYsH3SwwkT1zGUAqWChCfgw5spS9/W/0+w1dj
         CIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711112059; x=1711716859;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6RemCy6dcZjDYEdLINT2xX2A+yK+ZiPj+rD9BKuGTk=;
        b=cpkQ+s03Ou72xeWvwi7okmM5Al2UPBwXZsQJu01ZfrxTa3QEqgrUeHsPNrCdoRZLN1
         sXcRzKWokz4OiF1EPFPVDjCcUn21JDD93R3h5RQ//HpzaZNZHGwgaFj/qmAbYDfhrDJa
         x7nhmlTwSTSH4nKEU83fcU4rM1Gh5pJJ5Dpovgb0wZUab3+QYd6A9FNYkFO7P11z0Um4
         0MbbDnIqi3/ZSfZ3x3r8af8r9yHBGjgl3I4n+SPrwTcbpTmEtU8Sk7IEVbAaO5x6hwm8
         H9sbGGI/TZ8QLY1GsHrNru6LzrxYSaMAVYez1gq9HEa88RMyBbPXJQbw03tqzY1kzRBh
         3t2w==
X-Forwarded-Encrypted: i=1; AJvYcCU0z7E74Ofsm0bmXRa6b1vKxeueDZBgaOhvFVihY5WYRH+t7KtFXY/G3ZB8FoSATcjtAgKYk5EEPsL9ML2nDnBkO1MmDHmn/sDsQM73y1jest0=
X-Gm-Message-State: AOJu0YxKXj9g4wg/kKcPUPW3qfPi/nIthmyXN12US5gA+mEDafrs7eSB
	jnZJnHIGWBdHgbde+w0C/31asnDWnAZWfnIvs90SIHtycjVcEJkX0faxmeQIjjE=
X-Google-Smtp-Source: AGHT+IEOk/CQbPfNPXKEWjYKhI/+zm9LAWF+rORIUKr2/t6WfDjz6KaNKQe8OqPEypnYRDeg2IXDVw==
X-Received: by 2002:a17:906:6958:b0:a47:1ebb:d8e8 with SMTP id c24-20020a170906695800b00a471ebbd8e8mr1697819ejs.2.1711112058900;
        Fri, 22 Mar 2024 05:54:18 -0700 (PDT)
Received: from [192.168.0.106] (176.111.182.227.kyiv.volia.net. [176.111.182.227])
        by smtp.gmail.com with ESMTPSA id f6-20020a1709067f8600b00a4674ad8ab9sm980245ejr.211.2024.03.22.05.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 05:54:18 -0700 (PDT)
Message-ID: <7a59719c-c0c4-49e0-af78-dc3a6eed6cb4@blackwall.org>
Date: Fri, 22 Mar 2024 14:54:17 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 2/2] bridge: vlan: fix compressvlans
 usage
Content-Language: en-US
To: Date Huang <tjjh89017@hotmail.com>, roopa@nvidia.com, jiri@resnulli.us
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20240322123923.16346-1-tjjh89017@hotmail.com>
 <MAZP287MB0503BB0A5D2584B43A734CB6E4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <MAZP287MB0503BB0A5D2584B43A734CB6E4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/22/24 14:39, Date Huang wrote:
> Add the missing 'compressvlans' to man page
> 
> Signed-off-by: Date Huang <tjjh89017@hotmail.com>
> ---
>   man/man8/bridge.8 | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
> index eeea4073..bb02bd27 100644
> --- a/man/man8/bridge.8
> +++ b/man/man8/bridge.8
> @@ -22,6 +22,7 @@ bridge \- show / manipulate bridge addresses and devices
>   \fB\-s\fR[\fItatistics\fR] |
>   \fB\-n\fR[\fIetns\fR] name |
>   \fB\-b\fR[\fIatch\fR] filename |
> +\fB\-com\fR[\fIpressvlans\fR] |
>   \fB\-c\fR[\fIolor\fR] |
>   \fB\-p\fR[\fIretty\fR] |
>   \fB\-j\fR[\fIson\fR] |
> @@ -345,6 +346,11 @@ Don't terminate bridge command on errors in batch mode.
>   If there were any errors during execution of the commands, the application
>   return code will be non zero.
>   
> +.TP
> +.BR "\-com", " \-compressvlans"
> +Show compressed VLAN list. It will show continuous VLANs with the range instead
> +of separated VLANs. Default is off.
> +

How about:
Show a compressed VLAN list of continuous VLAN IDs as ranges. All VLANs 
in a range have identical configuration. Default is off (show each VLAN 
separately).

>   .TP
>   .BR \-c [ color ][ = { always | auto | never }
>   Configure color output. If parameter is omitted or

