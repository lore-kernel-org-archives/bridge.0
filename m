Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295E53277B1
	for <bridge@lists.linux.dev>; Tue, 21 Oct 2025 08:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761036392; cv=none; b=CPd1MFI8QD5wO3R19SDxGGOR3rdXhsby3EOybncIe8tQmo9jjaNNmMWKBOd4mPHXWuWABrMHine4uZmcM7Scj+vCCBQY9IIOlcK0IflBKl6PKBOpyxKQHdP/EuA8zFwUV7s2NmcSOAKvhFKzfnTPpmKkJ1Avo9MOLXvEs3TMtSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761036392; c=relaxed/simple;
	bh=TpzzFfcks+i/8NbAyOtY67RjKecMIpCXc/ht890k5AA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ttn+aBQIv7xjTTr+0EEjo7c8gu3ozKp24QRjWmiRg28DMW5VaSd/vCVqM72trVKCMoInJarpLeoZ49LWisRNEfw1yf/K9LSuBLkMYypDBCm3OsvutfRdGJMpkdbFYSvIWovoLYhb+R2vL73k1kNNPrwNAHTwSxSTTtNm5vuHNNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gb9ruOyV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gb9ruOyV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761036390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00fUrBf0Q4px2FT8LQcfYm3XMw7xBPoyqZCdVsDVhGA=;
	b=gb9ruOyV0jhrImIfJqwy4+ZQ+Nfec1hGWiHAnoxI1xUbDkpicbKtIJtk0GPhu+yT1GYJfV
	VwnuIbbXttOxjq4IuCxAoyMVDaIegWd90UMn9b8PWpdGIM1kZjZSmrhktiAgBWqo/g4npk
	AewCYUlkkov+vDAnHXTrhNY9BHCBhcA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-k6vnWLCHPQ6ZYfVFA5NJbQ-1; Tue, 21 Oct 2025 04:46:27 -0400
X-MC-Unique: k6vnWLCHPQ6ZYfVFA5NJbQ-1
X-Mimecast-MFC-AGG-ID: k6vnWLCHPQ6ZYfVFA5NJbQ_1761036385
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47106a388cfso23672765e9.0
        for <bridge@lists.linux.dev>; Tue, 21 Oct 2025 01:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761036385; x=1761641185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00fUrBf0Q4px2FT8LQcfYm3XMw7xBPoyqZCdVsDVhGA=;
        b=h9VwrtTXJvRU8H0gvx0SatqzsvBSQzJ3itPJZtSFyJ+clZ0mLvBVU9Sdkceh3t83ik
         xtqYAlrNWx+dSApswf+7BI9X6HgCfl+6QsGKDu33AzwpHbE/GFcONFIqoekka3LuFGBE
         u/KV4uTsrwDg7Iv1xNSXfjQrtufiDiIygYTzbiv9tld1Cv2Sc82TBFKw9Qev2rAX51Pd
         2cy5OIa5bKOQoiWFTwWRWWYrZ/I3v7ezsaDw9+YsCGcqLmR8aSd+eApCNiVcWD3oAtwE
         W4NHZ54+SkhamWCbdYkcA6G8HKEPzV+I4jwJBjERnrkMpTIBIpn6cniBqbf5im5kVpMD
         TMtA==
X-Forwarded-Encrypted: i=1; AJvYcCXYkPawEkfog+B/RrB1m3xu0avSsne4ZXb4eixX8b+tSUfYC8iLop0ztUMcGQdq1lcAtidURsc=@lists.linux.dev
X-Gm-Message-State: AOJu0YzFqAahjvu0Sa3YWbKGzp55BBvnAp32EESjZurOHOB6e4xzj3eN
	eHKkSm0q7J1XRcTrIKXmEvRrZG0slJhcsel5qLRz/AVHUO18KBzbv8KSGE+tdPhOovmexuFc8K6
	dsjy+VgaAMO+m2rB+x9LLhYXslnkHBcWaMs3tlBuC0jYXqktbgjCmfcz/Pw==
X-Gm-Gg: ASbGnctVuqs94/OnjnZUe7vq7vvr3xm8IyBdDm2NRmCAHdieC9ZJyzRjnufaA5nUbeg
	KvcEWsvKy+x3TqeQuBKtt9CApj6u4sVXZeREFcyXf5diSGmoa8Bgk4+rqyVN0cj/5jGVI0lSYfh
	8RXPhj8ky1MfbXt7avsJFMLSYOKEjQw8JilugVTKoMGSxNKKdfdVax1PV3NSJKSKNzQ9Imw1iYD
	w2R+rVJjjlVdflhCj3u4Sjmj2mR644fZgQTMzTabMLI9vzh7mQISf/6ygxtT35fDTr0d2B3X8wD
	MUL6aLDxe42+ND03isz9T+PJ6Rs51FfmheF8qmOp+P6eUSAHh4dCL6a0f/260R+HC3xxTTwRCz9
	57CznYTDPHRgaHulIaJvJ78v85nQnFCPJaV8kV+f93e/WUWY=
X-Received: by 2002:a05:600c:870e:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-4711791f94dmr149275765e9.34.1761036385506;
        Tue, 21 Oct 2025 01:46:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER23LbhF/waeMFxIZ3tVMBTzNNjsK3AFz1Qz2WEJLL+1IU3R8oWYr1yCKAHDnzB9vrI2gn0Q==
X-Received: by 2002:a05:600c:870e:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-4711791f94dmr149275465e9.34.1761036385083;
        Tue, 21 Oct 2025 01:46:25 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47154d382d8sm189481805e9.12.2025.10.21.01.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 01:46:24 -0700 (PDT)
Message-ID: <a2e85a2b-58b0-4460-ae7a-b1ea01e4d7e4@redhat.com>
Date: Tue, 21 Oct 2025 10:46:22 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 net-next 1/4] net: add a common function to compute
 features for upper devices
To: Sabrina Dubroca <sd@queasysnail.net>, Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Stanislav Fomichev <stfomichev@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, bridge@lists.linux.dev
References: <20251017034155.61990-1-liuhangbin@gmail.com>
 <20251017034155.61990-2-liuhangbin@gmail.com> <aPX8di8QX96JvIZY@krikkit>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aPX8di8QX96JvIZY@krikkit>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SQ0IXDSWHE3FFVgpH3hm7Dy3F1XUxpIWLb4xfxxvmBM_1761036385
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 11:10 AM, Sabrina Dubroca wrote:
> 2025-10-17, 03:41:52 +0000, Hangbin Liu wrote:
>> Some high level software drivers need to compute features from lower
>> devices. But each has their own implementations and may lost some
>> feature compute. Let's use one common function to compute features
>> for kinds of these devices.
>>
>> The new helper uses the current bond implementation as the reference
>> one, as the latter already handles all the relevant aspects: netdev
>> features, TSO limits and dst retention.
>>
>> Suggested-by: Paolo Abeni <pabeni@redhat.com>
>> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> No objection to this patch/series, just a nit and some discussion below, so:
> 
> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
> 
> 
> [...]
>> +/**
>> + *	netdev_compute_master_upper_features - compute feature from lowers
> 
> nit: I'm slightly annoyed (that's not quite the right word, sorry)
> that we're adding a new function to "compute features" that doesn't
> touch netdev->features, but I can't come up with a better name
> (the best I got was "compute extra features" and it doesn't help).

I'm not the right person to ask a good name, and I'm ok with the current
one, but since the question is pending... what about:

netdev_{compute,update}_offloads_from_lower()

?

As it actually updates (some of) the offloads available to the (upper)
device?

>> + *	@dev: the upper device
>> + *	@update_header: whether to update upper device's header_len/headroom/tailroom
>> + *
>> + *	Recompute the upper device's feature based on all lower devices.
>> + */
>> +void netdev_compute_master_upper_features(struct net_device *dev, bool update_header)
>> +{
> [...]
>> +	netif_set_tso_max_segs(dev, tso_max_segs);
>> +	netif_set_tso_max_size(dev, tso_max_size);
>> +
>> +	netdev_change_features(dev);
> 
> Maybe a dumb idea: I'm wondering if we're doing this from the wrong
> side.
> 
> Right now we have:
> 
> [some device op] -> [this new function] -> netdev_change_features -> __netdev_update_features -> ndo_fix_features
> 
> Would it make more sense to go instead:
> 
> [some device op] -> netdev_change_features -> __netdev_update_features -> ndo_fix_features -> [this new function]
> 
> ?

Uhmmm.... this function touches a few more things beyond dev->*features,
calling it from ndo_fix_features() looks a bit out-of-scope.

/P

