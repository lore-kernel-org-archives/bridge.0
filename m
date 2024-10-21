Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A926F1E47CC
	for <bridge@lists.linux.dev>; Mon, 21 Oct 2024 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504995; cv=none; b=QlSEXzdMfCD7NZu2lTiEf8N1tAQEAUb3vL5AoSnUdaEUquhRD7SpF0FEMxH91sFpUnfOYSHTznJGL5+9Zadmv5auVPvPO9T6swcv9KTsVmVs7sW+7w8AMcuuISAIftFxaak0to/KrAE2nUExW1vuYCa3w1o4LPhGThz2AaFeoRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504995; c=relaxed/simple;
	bh=I+fgLQYvZA4NHmjabi9mLzQKoBBv8sQ86evUvZ0B3KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmyW663GzL8RfGNyiyprndBTcGUceaY36CSmnCeSEUsV5/GgrjqQYGqK9nWyTH5OOcd4tfJ9WhcU6ZxdfJm/0GWwY8CYucAUkgDpCeaIjOjzwMnhOvpItATYVgd7AQUKT9Xj44wJ1eG3sOHtlYu14REtrudPUywW9SrXY6VVN14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hq52sTMJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hq52sTMJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729504991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xyJEmcQ9WC5ci3BgLXvbHouj36m3b4UCzV4/eAbKmds=;
	b=hq52sTMJ5GyfhAsIQCgqRyU9GgeSbML7nAgnNfLwvb0aPCxzYrCmZ6ymRA+T9jQ0IYFfcq
	gsqKnfGm6nxHPNEXciVd76sT/iVmz4SLBIIFxCgRquGbd1sWRVryy2yJV4nnUY4ExBaf/M
	RlqSCNa9dXqzOg9gyWFaBmbgyJuDcnk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-EUbSr5B5PrWlbW6t026ncQ-1; Mon, 21 Oct 2024 06:03:10 -0400
X-MC-Unique: EUbSr5B5PrWlbW6t026ncQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d45de8bbfso3009310f8f.3
        for <bridge@lists.linux.dev>; Mon, 21 Oct 2024 03:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504989; x=1730109789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xyJEmcQ9WC5ci3BgLXvbHouj36m3b4UCzV4/eAbKmds=;
        b=uvlIbu/qUx6ZBr7KJFNKwgTgjiiF0QVsaT/lgwUkx3mh3iMgOSNcrCeM+jMSvgGL9/
         dnomMtrjGrIEFMl/RhaWLOeei04sHcRidg5QM/2GJun0lkEuuvH1liWk6qKowDldrwsT
         +kDXQuh+oj/ZLqr30hP0G0suWctW4vJf8zaIChUUvIK+9/21fRbBRSWEkB1uE28VPbLI
         ctGKbkHs2FNMlYSf5WSMejEkAkCT111++354Z4/oWoZnr4C4u3cThEodh/H2KmjrYNDG
         fKbhzI2pJF4g0DIKOMkOpdIfq90HMreUObIJHHo6W25Bw+YTnwbvT98XEyjdAraiJP2u
         +sfw==
X-Forwarded-Encrypted: i=1; AJvYcCVQL2B6PX5NbEmwBt5idTfTRNMFYys/R8zrBlQLmDHCpoXUbZxQMwZNFd+C0xuzEdgrVkLMHtE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxh5/ilgtPVMAo8czs7AReaavwbrdK3iIk8qeZ9EGAASY8b/FeX
	CbwjzE+S2tiaCJjQaZ1ObteZsCU1PWQJsOmaIWqbzJY6aFSsVspMPGBJ2AdeXsikXC+0l1aVXmk
	2REz9yGvQ+XEQxS6vGSf9rV4oH7sHJj65n7g2zJyFVM4vcDYO+0uHdA==
X-Received: by 2002:a5d:45cd:0:b0:374:c1c5:43ca with SMTP id ffacd0b85a97d-37eab4d1157mr8503634f8f.32.1729504989293;
        Mon, 21 Oct 2024 03:03:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9g89QrZrvWMTWImI7QH5apSf6nTS4fXvPKvygF4vW9LE+7/wxBk6jbiygE/3PCkrJ2u0ofQ==
X-Received: by 2002:a5d:45cd:0:b0:374:c1c5:43ca with SMTP id ffacd0b85a97d-37eab4d1157mr8503606f8f.32.1729504988968;
        Mon, 21 Oct 2024 03:03:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b944fbsm3940643f8f.72.2024.10.21.03.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 03:03:08 -0700 (PDT)
Message-ID: <86d785cd-41de-484d-ae17-ffdb4aa9393e@redhat.com>
Date: Mon, 21 Oct 2024 12:03:05 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 01/10] net: ip: refactor
 fib_validate_source/__fib_validate_source
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 roopa@nvidia.com, razor@blackwall.org, gnault@redhat.com,
 bigeasy@linutronix.de, idosch@nvidia.com, ast@kernel.org,
 dongml2@chinatelecom.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, bpf@vger.kernel.org
References: <20241015140800.159466-1-dongml2@chinatelecom.cn>
 <20241015140800.159466-2-dongml2@chinatelecom.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241015140800.159466-2-dongml2@chinatelecom.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/24 16:07, Menglong Dong wrote:
> @@ -352,6 +353,28 @@ static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
>  	struct flowi4 fl4;
>  	bool dev_match;
>  
> +	/* Ignore rp_filter for packets protected by IPsec. */
> +	if (!rpf && !fib_num_tclassid_users(net) &&
> +	    (dev->ifindex != oif || !IN_DEV_TX_REDIRECTS(idev))) {
> +		if (IN_DEV_ACCEPT_LOCAL(idev))
> +			goto last_resort;

IMHO the re-usage of the 'last_resort' macro makes the patch a little
hard to read, as this is an 'accept' condition. I think it would be
better to retain the original code. If you really want to avoid the
small duplication, you could instead introduce an 'ok' label towards the
end of this function:

last_resort:
        if (rpf)
                goto e_rpf;

ok:
        *itag = 0;
        return 0;

And jump there.

Thanks,

Paolo

