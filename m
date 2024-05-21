Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EE9149019
	for <bridge@lists.linux-foundation.org>; Tue, 21 May 2024 19:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716319639; cv=none; b=A5blksW/YtCCS5iO/KHpNWX/KrPpdA1/RJ93uLRw/BhTWYBBq3sj5+I0p4Pov98H5baS31lVltfXuxSRefEf/zOFw7TvYN6YMXZjZzs6OTf5ZKLD/+13qP5soKd8HfsgXNbiH2jRiSyX/VhwwFx6gold+jJ8D3n3TdSubQ2h+d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716319639; c=relaxed/simple;
	bh=/5LJJk96zOYAd1s3zbgIV8x3/5mg3XuUvE6Gz54Fo9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwAXFLwizrGGT94P9cLHyuxBoav5UY5ouA91PWoXnPUveml2YZ7WP86V6dGLABdn/+FH7V63c1XuBGkL2jomB6BdMKp+vcJshO3+Llpfp9gyAcIiXi1G6d5OyYM+ZSymKWcBRc9sZD4gN7BJKXGvjtUPk25YmeWdcJBQJx/7CFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Hyx5W0WH; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Hyx5W0WH"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E50E840702
	for <bridge@lists.linux-foundation.org>; Tue, 21 May 2024 19:27:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J1TFhF8gDgRD for <bridge@lists.linux-foundation.org>;
 Tue, 21 May 2024 19:27:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=stephen@networkplumber.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 930BE40701
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 930BE40701
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Hyx5W0WH
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 930BE40701
	for <bridge@lists.linux-foundation.org>; Tue, 21 May 2024 19:27:16 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2bd73b12872so578160a91.2
        for <bridge@lists.linux-foundation.org>; Tue, 21 May 2024 12:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1716319636; x=1716924436; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uD54di9/3KSU1csIqNnGenHNf0jpGZ/KT+RBkitwoy0=;
        b=Hyx5W0WHv1hnJz1D67e/Px4GVL+wUE+5xF5TJhEWEGd2QO4tmFZoFhsy/pyF70JXWq
         NYSiqlOFIoC21rSX3cbY3uYtMxL6veM7VMPTMU2B/eNmZxpCnF25MbXRobwunFBAbGcs
         XjHP8y47VQq3Fmhg/1ZMghMR+nt/zJZZ/T84l6FpZ3Z+tOEZ++nADkKK4R232YEgbI02
         gZVcNZ+cQ6FzHP00V5Xx3pBbOETAhLU21KpN6Du5SkcrFdH8m/gMLRRjDXECh1Y6Yeta
         kYccJXQ/EiCLe3gKeYm4eZ3Qk+O2ZOphay0ux3kWAk87LfuN5H9kq6Hoq+aDUTDcU4Gu
         OVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716319636; x=1716924436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uD54di9/3KSU1csIqNnGenHNf0jpGZ/KT+RBkitwoy0=;
        b=wrr6qK+3AfDTxIv/PODuW5R0bw2y+5sEDYwZ4rZMw1tQdDl5/5cBC1UqTgWXy9T/JQ
         aP6NpRhz2QprtAvymi3ET1PCGJhN+l2j16MMWxFlLtZSqZBaBG5GY8Jq1/eV2ktp0wDO
         DkV4s1C0jG74Vp69IVuMOeVfs+niGIrVN945QT7T/Ej3I2b+HmDWQvX33bhNkuX7+wjl
         sCbMI2ATgy5iWpRfGfShfwDj7CKRLajjvXRM37e7Fn1h9wTiPD+Acp3rmTSlB7X1aM4L
         uoAgedY1cceS1OYSFzHboLlU1RiLNIZERgeoYhn12KXg0rJIzvKRIBFC88TKhpbtfO6r
         m3aA==
X-Forwarded-Encrypted: i=1; AJvYcCVUSnXAY02SSiM1jz58uS+5QQcvRwcSDhwa4jRXrj8ghIhOTeAL5qVE//WBj42l9NtWZpCxtpTo2z3d32EAcubGcIPAc3ChpTOTWViN8GTPoTs=
X-Gm-Message-State: AOJu0Yza3BP/MNwOA3T9BulQz4Q/kHl90oM6hVAyyJmSMiV4+m/uKh0g
	hJWKdvdU3dKP4uEnMCkayAMsZHDB+Oa5jpNIuv+NekWhRsxdGSUbWfBEZSpeAd8=
X-Google-Smtp-Source: AGHT+IF7ocvNRXtIXYpalAtaN0Dh0bbHXRi/WE9QPHxj0DWnjICpXcIVasXK6+CaNoVHhEww2YEOfg==
X-Received: by 2002:a17:90a:dc0a:b0:2b2:4c3f:cf08 with SMTP id 98e67ed59e1d1-2bd9efdc164mr153109a91.0.1716319635697;
        Tue, 21 May 2024 12:27:15 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bd92b3d2b0sm1760535a91.3.2024.05.21.12.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:27:15 -0700 (PDT)
Date: Tue, 21 May 2024 12:27:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hans Schultz <schultz.hans@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, Hans
 Schultz <schultz.hans+netdev@gmail.com>, Roopa Prabhu <roopa@nvidia.com>,
 Nikolay Aleksandrov <nikolay@nvidia.com>, linux-kernel@vger.kernel.org,
 bridge@lists.linux-foundation.org
Subject: Re: [PATCH net-next 1/4] net: bridge: Add support for bridge port
 in locked mode
Message-ID: <20240521122712.3d09b03c@hermes.local>
In-Reply-To: <20220207100742.15087-2-schultz.hans+netdev@gmail.com>
References: <20220207100742.15087-1-schultz.hans+netdev@gmail.com>
	<20220207100742.15087-2-schultz.hans+netdev@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Feb 2022 11:07:39 +0100
Hans Schultz <schultz.hans@gmail.com> wrote:

> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 6218f93f5c1a..8fa2648fbc83 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -532,6 +532,7 @@ enum {
>  	IFLA_BRPORT_GROUP_FWD_MASK,
>  	IFLA_BRPORT_NEIGH_SUPPRESS,
>  	IFLA_BRPORT_ISOLATED,
> +	IFLA_BRPORT_LOCKED,
>  	IFLA_BRPORT_BACKUP_PORT,
>  	IFLA_BRPORT_MRP_RING_OPEN,
>  	IFLA_BRPORT_MRP_IN_OPEN,

NAK
This is userspace API, adding a new value in enum in the middle
will reorder the numbers and break ABI.
