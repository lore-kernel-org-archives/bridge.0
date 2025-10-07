Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4583B2DF3E7
	for <bridge@lists.linux.dev>; Tue,  7 Oct 2025 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841382; cv=none; b=ag8/+TqsbQ/DWKIRI6Atcp92TcbajwcKdr2CbQ2Fq+X7Ejr81p8a685v2//lorDYKjwmHvoLBWWSCdPkoFpn4Pxtt0SR1K6T+83oCkMdFXVpFiFsC4Z3OhHB3cSofCg4+Jywn3nYpVtUzmO64I+mB+c3XoX5S3TPLY0ODUjeDFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841382; c=relaxed/simple;
	bh=c/WLFYIFjnh2k/ZgBeBCvK2ZBmSP55ivwUxj5/6hNpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o2s67OS8Qj7VM4bHzQabzjauLEZSjYTVcewcqgvuAZJhR6MM/r03FGBXkrE+gLbLwB5f82S3tlMecC3vGNnLXZUXvOZFiwMK3Hj83gLP+plOJXZzcLM05Pxj0TS6pSAMEw8Bre/qz9Poiogrz2Bu85iFGDEKAf36c8Te2KxP7w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BcxSSoxn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BcxSSoxn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759841376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WJ2c6ZhPNn3NTb/ZXUe3uUgmdMJ2RmrHeu2BLMk0710=;
	b=BcxSSoxncTvd1rIQqWUp8PmAYceFuweXd6PJvxqOoMOMN+2Zm5dgPa2BxQ6QHxP6Fp/8Ue
	4vjn4Ywk4JDR0dZ3gQTlAi1A2ASpriUVOQynmrx5MsbD6tW6kyxMU+E6G0RnP3gBEFP++h
	GRJC1WhKfSvBhwlaVnrp+DkuGdrpuzk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-8PmI8pE2OzeY17ceOSxQFA-1; Tue, 07 Oct 2025 08:49:34 -0400
X-MC-Unique: 8PmI8pE2OzeY17ceOSxQFA-1
X-Mimecast-MFC-AGG-ID: 8PmI8pE2OzeY17ceOSxQFA_1759841373
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e3d43bbc7so24153465e9.2
        for <bridge@lists.linux.dev>; Tue, 07 Oct 2025 05:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759841373; x=1760446173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WJ2c6ZhPNn3NTb/ZXUe3uUgmdMJ2RmrHeu2BLMk0710=;
        b=WxUgiMAKbaYpjS3AcWB/zfqBiSS2yrrnALN6HuTrg+s7b8533iqq7/OZ0L+co49R6S
         P2Lj4Cw+XN8fmjFrl0GUdGJf2sK0SAl31kCmnSAikRKU/QyIVq8F6xuYzIJKzGCIJqRV
         g2qOt0ErYS/LXZI2KTsUqQheD/0sQDBzqveBveTsszr6ktFRxeZS8ojBhm6HjV/g7WjO
         AUbqqTB1mp+fgpx4hS/52PuH0lcVjMzHkKkBwzox/GZsQiRXezzQ7u+0VwEff8GLyp4A
         +ZU2iRykYIUcdt1wzLwpomBjQk6bEmGy0AIWcwVEO4OSfA0COX4jdUOsTD9JnGwEV786
         ZW7g==
X-Forwarded-Encrypted: i=1; AJvYcCUMW/O/hQxhcQIgTBtqlBRAc87QPwGG9CDbG8TqE9LeYsfI0jJwfbJGmLeYcA2Nqn4bNHtAYss=@lists.linux.dev
X-Gm-Message-State: AOJu0YxGGEaQP6hZw3ppORuldOHimCmJe/a2l1yi2vZh9RXMmPneZNSe
	+/f4Hol40ZXQobNGOF/K5GpyTTfV2Dqfy82MFaxie3BOE7xjFWTkUZdb9f88I7juTSuLitkCvY3
	7bZSELmufqMYxjAorUd6G5PbMCwX7bx5CGG7Mzi3W9O2HEDP/4TEuUFnV5Q==
X-Gm-Gg: ASbGncuAYvAdXxYGDXfLix5zGFgz0X6RLEb1V+59glthIKQRbqmpGU4UPc8A1MrQVj8
	TlxNizQhNSBH6L/kxHMWPbVhDy2WnCMOQOjZMWEIDS9dj5r/BS3CxPW2lixPMWlbRnPBDU5jG4h
	lN8WLrzyX0E5Zz7BKSmr8hCOe3n0lhtkeFRbIXdMKSvOUEkxuWDFZkdXcXpfSdqwVCRwnbT48Oy
	nedJMKoOVntUvO/9LcxNhdFEV5fRLqt3rnMXJ8F2AqYIIf+QdN+b/zPTVXuWwBj022u4rZtmZvy
	5R32PcbLEbvWuSkfvnSa5JaS4D2snzPOeDRFZnZxGYVTa/FfLGJ4neT1+sXrDkEytoKKS1I71X3
	02KeDrQeul3BxdLTrXQ==
X-Received: by 2002:a05:600c:680a:b0:46e:42cb:d93f with SMTP id 5b1f17b1804b1-46fa26df6f0mr24052665e9.15.1759841372956;
        Tue, 07 Oct 2025 05:49:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmEdkYp9kyJChoEBmC1Wayd07hjE4hNEA+dlV58UpIwkkn9LSiHaGwwKX8eGfaTODnJZOzSA==
X-Received: by 2002:a05:600c:680a:b0:46e:42cb:d93f with SMTP id 5b1f17b1804b1-46fa26df6f0mr24052335e9.15.1759841372567;
        Tue, 07 Oct 2025 05:49:32 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723432c9sm204340025e9.1.2025.10.07.05.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 05:49:32 -0700 (PDT)
Message-ID: <2bca842a-0a94-4798-b215-128809956018@redhat.com>
Date: Tue, 7 Oct 2025 14:49:30 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 nf] bridge: br_vlan_fill_forward_path_pvid: use
 br_vlan_group_rcu()
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: Eric Woudstra <ericwouds@gmail.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Felix Fietkau <nbd@nbd.name>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
References: <20251007081501.6358-1-ericwouds@gmail.com>
 <aOTm6AUL8qeOw0Sp@strlen.de> <aOT0jTumQq39V7p2@calendula>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aOT0jTumQq39V7p2@calendula>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WSX-z-0N_JiVNLePKMmDW8lCfp827aHF3d6-VPigTwQ_1759841373
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/25 1:07 PM, Pablo Neira Ayuso wrote:
> On Tue, Oct 07, 2025 at 12:09:51PM +0200, Florian Westphal wrote:
>> Eric Woudstra <ericwouds@gmail.com> wrote:
>>> Bug: br_vlan_fill_forward_path_pvid uses br_vlan_group() instead of
>>> br_vlan_group_rcu(). Correct this bug.
>>
>> @netdev maintainers:
>>
>> In case you wish to take this via net tree:
>>
>> Reviewed-by: Florian Westphal <fw@strlen.de>
>>
>> Else I will apply this to nf.git and will pass it to -net
>> in next PR.
> 
> There are more fixes cooking, probably we can prepare a batch.

FWIW, I think it makes sense to wait for a NF PR.

Thanks,

Paolo

