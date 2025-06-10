Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE7A28FFD6
	for <bridge@lists.linux-foundation.org>; Tue, 10 Jun 2025 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558068; cv=none; b=WR5yChnPKaOEnO8oxZzVu3Y4ZfciWUCdgTLdgkx2RdArixNhcqM6KT7JnmWaqte0zBRf1LrkqgEvC2kEM5ueZP8IOCcQlT/4hL4ajlKExzBNxUzFkiRvECD8u5eOXDxwJLKFp6Bh80hhxYBBIshbnvo7XqY0eIw0j7Mj0myWe/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558068; c=relaxed/simple;
	bh=u0j01G9fvtcien2pLULX5dEIhNEOfJHSJYRvt2F1akk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDL93YF+TWKbmdgIiY4etugNufuPp8dEPqfjEobLAjEk6j49GVFlhFRLvZjUm7Kxh6xvkMtolvg0/mwIYbOe75vH9LOME9NoSrR4Pu60K4MQUsM1M8kr9ddbUcQdR2RLVsCKWty9IOYvnzdo4FcxmhukrYeHTzvIKlCrzSo7J1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=eEIh3Vng; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="eEIh3Vng"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82A20833A7
	for <bridge@lists.linux-foundation.org>; Tue, 10 Jun 2025 12:21:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H1ByHfRVto-z for <bridge@lists.linux-foundation.org>;
 Tue, 10 Jun 2025 12:21:06 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::129; helo=mail-lf1-x129.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C4893832D1
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4893832D1
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=eEIh3Vng
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C4893832D1
	for <bridge@lists.linux-foundation.org>; Tue, 10 Jun 2025 12:21:05 +0000 (UTC)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-54e98f73850so5754773e87.1
        for <bridge@lists.linux-foundation.org>; Tue, 10 Jun 2025 05:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749558063; x=1750162863; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wwioawj3LoM8t1kN/tzjpsLzY0VIcc0CS1zTnNXsK2E=;
        b=eEIh3Vngdb8uthWnE5SALFBgEsE0/gIkeGs9GdiKWndd/GKcLs/c3AnGItkP4lavfj
         P4uskiHP8ZD5JIk0IFg6Qc8fBt2jicr1olJ3BD9qr8e+luFiAoMTBfrfcg2/4RmK0Cga
         wvdwrmg1pK8/qWTCVkH9KAmRErgKkGXJo9w1PDM5sucJcFhStkJ45/9IxGkGmUEg+YrS
         O7CX3yCeuPfKiEteQgYYjNkphYm65oh1dCl7oqMshnO/J4DLz6a0ShcpOpgDTJPSt2q6
         JkfAEekTQmWa8PlLPnOyZ9o78EBNQ5PVNujZK9LmBIS9rSRT2aKXjqraK/mVRbUs9OAm
         FGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749558063; x=1750162863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwioawj3LoM8t1kN/tzjpsLzY0VIcc0CS1zTnNXsK2E=;
        b=HMUzgN2tVLzkv73G5GomdajNDM2zxlRAXemBb2wopf/tGm0JSE2PDTd5rztx3H5HR0
         VkPw/JZjQ2IRJQ/3+nXhSDqrxWonOAneOkgDL0o8lm2vv8XH7y/+iPo816ALEXz6TLUr
         K1Vm1HypfP+8fmcYY2RVkIVs/fIxWQj/Oh9A4kFMQrbGxbVU0Gt4aJsTm7+Pr1y+CVYC
         4ICbQMIwVr3iY5xzfJHKpFz1N8/m+Psjidm1DKBnvqWhXBNAZ2Qek17kG8d3bo3GKwfk
         BfMsSuERue7Gmxr8qv5osZfUCwc8iizv514Q0Tw73YNUi59OqNRKo3aSShKo0zmnok15
         csbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL95Qs4/pb2ceQI1Ldv8IsAW+L8POB5ftDVpRWDFOpnDahDiWqrlEqjzzzJzCtnuk1Pq1W/yY=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzxifqiozGOUH2mO5fRtXiqa6chSLHfk94+yCgju6cIoFfaNDlr
	k35vb5obGAMIRMO1h35xtfonBL0LBJg/piv9sJ+Tyqa6p0J7OxpLIXrVE10Eubu/06o=
X-Gm-Gg: ASbGncusVQ3f6O5m/LCgxXZ5TtZNOOa6XG61uUBnAEbOLeWIK7LMx/OFGRO1lA1vavp
	u13oTc8WELH6sFULN9ufRerGwQOjMwVvqb25HM7y3Y4Ju6Tn7L6nFaopm/Cgl4xfdKuB4Dl0SSQ
	RRehVojEffbieXY0ifAq0hoIJiqVfrTsvOROmIYutU9CZIDQWKDGEL+1siytvZTRJ5JH5sT+a0b
	yNNDvIPEMaoAfer6tzFlWpV3GSzYJv5g/cgqcneIMdYq3yEONr3WB4U6oUrtonKyCqxgmYK/0TW
	8QSGXpcqHlyWn/S1XNQl8IHgNjaOlgWS+vfLTy8eBN3EbImjKvqX4jnictUUY7IeM7rq4WjzYJF
	bWMaQEUENtVJnbmu160bOnGDX335iP3c=
X-Google-Smtp-Source: AGHT+IEspqSQo2l6BoJsMZshtR+Z6E87KKc2jCvflDBVZfWYLnYP+yI6/3Yx/J8lMpyaxw9s1GFUHw==
X-Received: by 2002:a05:6512:1248:b0:553:32f3:7ec0 with SMTP id 2adb3069b0e04-55366bd0d03mr4190897e87.9.1749558063127;
        Tue, 10 Jun 2025 05:21:03 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553677330c8sm1527573e87.238.2025.06.10.05.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 05:21:02 -0700 (PDT)
Message-ID: <2b1350f3-ac60-42d6-b647-251d040a36a6@blackwall.org>
Date: Tue, 10 Jun 2025 15:21:01 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 2/4] ip: ip_common: Drop
 ipstats_stat_desc_xstats::inner_max
To: Petr Machata <petrm@nvidia.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org
References: <cover.1749484902.git.petrm@nvidia.com>
 <b1514e637ec85b85fb76360c29573a4d9dc15dbf.1749484902.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <b1514e637ec85b85fb76360c29573a4d9dc15dbf.1749484902.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 19:05, Petr Machata wrote:
> After the previous patch, this field is not read anymore. Drop it.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   ip/ip_common.h     | 1 -
>   ip/iplink_bond.c   | 2 --
>   ip/iplink_bridge.c | 4 ----
>   3 files changed, 7 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
