Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7EE5BAC1
	for <bridge@lists.linux-foundation.org>; Fri, 22 Mar 2024 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122112; cv=none; b=Eg8ifH1aavoQ8f2xHhDTv0Tk01ttF6rvaCaUSBh3UCGf2W2ci0HYMdwqma53oJbdXQlY8Hpv0YLwKoYO26Ye/h88gmhQENe9Zyc4QcztTP2JevlZssCTbhIXL2mO+XEt2e6tZS1YtGCciOQsVOJazW+JmkEU0gyFduHjzaR2i6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122112; c=relaxed/simple;
	bh=B+/xFuqJmP6elqhGJxvQk8WSM6hnGTFg7P7zXygPy7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UsRM2hWZw0D71m0XpcrpRDhNgEuu9tGAytYPh+CcS6OJyHlVTIHJHOdKzx1ITUaNJt9LKN9HWXHKmRmbEjbkPSZwVYO3U/DWVwY/H/lmAM4NDdzFwnBhdOvYHTUbG31ieLGDejYwxc/SXoJq7QiVMGHM6V79+Xek8ipovQ0rlgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Bpu5CIVz; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Bpu5CIVz"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFF9541877
	for <bridge@lists.linux-foundation.org>; Fri, 22 Mar 2024 15:41:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xz44Ve_GARd2 for <bridge@lists.linux-foundation.org>;
	Fri, 22 Mar 2024 15:41:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=stephen@networkplumber.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9854241852
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9854241852
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Bpu5CIVz
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9854241852
	for <bridge@lists.linux-foundation.org>; Fri, 22 Mar 2024 15:41:48 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1e08512cd86so9310135ad.1
        for <bridge@lists.linux-foundation.org>; Fri, 22 Mar 2024 08:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1711122107; x=1711726907; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJh29uvbzp8qLyreE66ADZk3coO9VHHThpMV9LfpmGI=;
        b=Bpu5CIVzJD38iVfRxzLGnvEVN4cJ1/MsiJvZIJp6Aj+MbAhewIgg0B06s32H8BYaV5
         wTEJsfcLqWd94+xiwSnaQZs85dHRx6z1gVsGPcJQyC8bgEAYDIBIsTTRf/vTDsFxQU7M
         +vmyTgfxMxEDcRH6/eoPozJipCgB+xzX1w83a4SSw5aTu2fVcRRSo9nFQnFS/O46SMw8
         6/Q7a+8A/K/i5GaHfSA3E7Yvl1AiM2nmaUBp+ynBvzD+QeQqMzG8tk00UcXz/NUY6ALt
         fTNhMHsJFVXjYas+8Me6S+VZQMHqVCeuxOD8SvRUsfvMZDeergw6mbU2rWbRq/en3unV
         rm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711122107; x=1711726907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJh29uvbzp8qLyreE66ADZk3coO9VHHThpMV9LfpmGI=;
        b=kNPhKOGl5ZbbBD3wC8WJYETXpcKLS1l3zvtfmD58DAjjuQS0Z/5nhnSToD4bDvH4Yp
         DgdLd9q7soQ9Z4kYOrO4pXHQsxwxvbXD2LWE+sdyq8RbjPQ4/VI6jnMiPUa1mJ1u3rMX
         ij9oVIz6qXBS6dMek811YVOL3K8z/Oej8bgUU6xZ0RcubA1Tv2B7DeoqRETBE71j/zf+
         0KxaaAt2xuVCfR9Q/zMEVJW3xsc5xEpZWqOHewzwUWNETVFbNyJG6m2X5ok8EgFG/vJ/
         whXG2rPERYLoRP0/H9J75uuhXaP9JPMoVbk1kA/1Jlh9cZCQQgEVNsTwif9QzzmGwsWD
         Ngxg==
X-Forwarded-Encrypted: i=1; AJvYcCW40NPxlUVVrKwmEO/0XZS5MwFcEe3EWHkmo9In9UpqhJlwoUTmQDx5UwSZUTrbIeBtr/HPjnbY6yaR8PPjY2nNFxUVln4hkt92otj1R0Y5c5k=
X-Gm-Message-State: AOJu0YyD4p5p/Cu5s8HrPNMH3iQCXBSUetykpnsVYgYxFxIkdRyLkFBk
	oNyjtckwtPD0gLFxoo3TL0sf/v5EJggS/UPAHdIXR3zUBjQ5z47j+ymEyQMddoQ=
X-Google-Smtp-Source: AGHT+IGYi1VQSz+fvk1a/BPp0AjYfkPeTAMoiRUqwMq0c6i+v20HMcjlyCMfPn2Jh6oGAPrzWCN/MQ==
X-Received: by 2002:a17:902:ef44:b0:1dd:b45f:4cc9 with SMTP id e4-20020a170902ef4400b001ddb45f4cc9mr122024plx.23.1711122107584;
        Fri, 22 Mar 2024 08:41:47 -0700 (PDT)
Received: from hermes.local (204-195-123-203.wavecable.com. [204.195.123.203])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902d38400b001dc91b4081dsm2056441pld.271.2024.03.22.08.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:41:47 -0700 (PDT)
Date: Fri, 22 Mar 2024 08:41:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Date Huang <tjjh89017@hotmail.com>
Cc: roopa@nvidia.com, razor@blackwall.org, jiri@resnulli.us,
 netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Subject: Re: [PATCH iproute2-next v2 2/2] bridge: vlan: fix compressvlans
 usage
Message-ID: <20240322084145.3e081475@hermes.local>
In-Reply-To: <MAZP287MB0503BB0A5D2584B43A734CB6E4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
References: <20240322123923.16346-1-tjjh89017@hotmail.com>
	<MAZP287MB0503BB0A5D2584B43A734CB6E4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 20:39:23 +0800
Date Huang <tjjh89017@hotmail.com> wrote:

> diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
> index eeea4073..bb02bd27 100644
> --- a/man/man8/bridge.8
> +++ b/man/man8/bridge.8
> @@ -22,6 +22,7 @@ bridge \- show / manipulate bridge addresses and devices
>  \fB\-s\fR[\fItatistics\fR] |
>  \fB\-n\fR[\fIetns\fR] name |
>  \fB\-b\fR[\fIatch\fR] filename |
> +\fB\-com\fR[\fIpressvlans\fR] |
>  \fB\-c\fR[\fIolor\fR] |
>  \fB\-p\fR[\fIretty\fR] |
>  \fB\-j\fR[\fIson\fR] |
> @@ -345,6 +346,11 @@ Don't terminate bridge command on errors in batch mode.
>  If there were any errors during execution of the commands, the application
>  return code will be non zero.
>  
> +.TP
> +.BR "\-com", " \-compressvlans"
> +Show compressed VLAN list. It will show continuous VLANs with the range instead
> +of separated VLANs. Default is off.
> +

Overlapping option strings can cause problems, maybe a better word?
