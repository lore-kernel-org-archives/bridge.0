Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06A01D4607
	for <bridge@lists.linux.dev>; Tue,  5 Nov 2024 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805955; cv=none; b=qPuL7bv795B2EDd/yAzE9zvplH/GvAO1Qone830eoKfst3h+X1SDxnj3/bXK1eQx4wMhCUu7KWfvGa0iOn5sZuXHnF4rXRri5Jyy2PDq+/Vl5qhVo23Oy2rVnzKplBQoC2sME7aU8xWgr/HlNent5ZoBCIOUcJQeIaxDQhLz8qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805955; c=relaxed/simple;
	bh=8AFVGRwtaJeSF+KSoKYzsx4Byj0svgLauYfW+TOaTno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhq5UEJ5FLdmH2B8yzAt7OP1GWaGe7NFcSimpIMoqY0WTGeqWh2LYzJ3+Ws+JDtTK5D4MACB4IUyhwYPRIBDMortfohA+AjE/8N5h+n3frGiDs3F38U/OOGUSSEd6QimzIgxCM0DhC8dA1AsDFg1UBAK385wtJeXrgdkKvxKERo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LwISbJSW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LwISbJSW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730805953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AsybYOao8j0qbOJ+5wLogVpuC2sFzLXUAO410jIN/GU=;
	b=LwISbJSWt4++gRUA8KOJfm53IMVcvuzSoNqdRMiARnWWeEj3U6prHgwuc5iTjJ88iiLJBL
	+Q5yl6x7UlQ5Hm0z7gJKFhDkBFBlXWlTj7VkuNCG6BV6yY7RC8D+8CHymkmm3vvQz8Ldmm
	/fldtCyVD/OwQINff4nc0hRs7uLlir0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-VRsHDRc3ObWnO64lm70czg-1; Tue, 05 Nov 2024 06:25:51 -0500
X-MC-Unique: VRsHDRc3ObWnO64lm70czg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-381d07c377cso2127082f8f.1
        for <bridge@lists.linux.dev>; Tue, 05 Nov 2024 03:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730805951; x=1731410751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AsybYOao8j0qbOJ+5wLogVpuC2sFzLXUAO410jIN/GU=;
        b=tEtkoGqmtz/4VZOjX5d9OKOgz35+UL4CS/xPQqJxaZA9l7Qcj/0unw3xDbqpnYe/yt
         EQefFEXbkhvAKSNakhBsclyvcnsEe5gZ04tbr3QJOKrOsmrj5t2IrWmOsOIWCMjQRl04
         EEdIojUHINIW/WwtB3xjIQKe0cCA/c3yhhOnkdePpGbpnI/swm1jJivys4/IwSPXawYY
         x2vVPU4U8PmWBus+z716vEwC4+qpP+U41TwX/KJLySRKGURiF8mObgom6N97y7kkZyAc
         0dma5XxqWCTUbDheHU4o8qCeHBSsbnEycX+VbgbnwOztEl4h5yGJITq2GB88AI5dXY+l
         slcA==
X-Forwarded-Encrypted: i=1; AJvYcCWKBkkZESHuZhzPx2ITVgTDhUauqR7QaEoE4FRQ5UTKQXSOvgiVzGT3nm2Blr/l1dNHzWNNJWI=@lists.linux.dev
X-Gm-Message-State: AOJu0YwaAqrF8LnrMdoaOpQvfiz5JXDLl+oqyUs668HkDeXpDhYMmS1V
	OjAKWB4BPNsmayjO+maoKAORHxkWYQwEyMJr3p3/sRC/JJgHyhE2ezZZ4UHrmt6GorbJWjvoYPY
	roj0rtDqeHv2/4ZHbpfcIGclCru9dpxFT+wHSK0jiHeatPIwAHYueTA==
X-Received: by 2002:a5d:5e87:0:b0:37d:39d8:b54b with SMTP id ffacd0b85a97d-381c7ae1552mr13768273f8f.58.1730805950645;
        Tue, 05 Nov 2024 03:25:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjLB5E+ROQ7F6DRPhVbGIzb5at4ILUKJu3X2OrRGqPJDFCPvEe/hdkUEhFiHeOv+TQOCR9oA==
X-Received: by 2002:a5d:5e87:0:b0:37d:39d8:b54b with SMTP id ffacd0b85a97d-381c7ae1552mr13768245f8f.58.1730805950234;
        Tue, 05 Nov 2024 03:25:50 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e7449sm15923971f8f.49.2024.11.05.03.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 03:25:49 -0800 (PST)
Message-ID: <7b8b83b4-f745-4f3b-8cac-2f190937667a@redhat.com>
Date: Tue, 5 Nov 2024 12:25:48 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v4 8/9] net: ip: make
 ip_mkroute_input/__mkroute_input return drop reasons
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, dsahern@kernel.org, pablo@netfilter.org,
 kadlec@netfilter.org, roopa@nvidia.com, razor@blackwall.org,
 gnault@redhat.com, bigeasy@linutronix.de, hawk@kernel.org,
 idosch@nvidia.com, dongml2@chinatelecom.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, bpf@vger.kernel.org
References: <20241030014145.1409628-1-dongml2@chinatelecom.cn>
 <20241030014145.1409628-9-dongml2@chinatelecom.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241030014145.1409628-9-dongml2@chinatelecom.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/24 02:41, Menglong Dong wrote:
> @@ -1820,7 +1822,8 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
>  		 */
>  		if (out_dev == in_dev &&
>  		    IN_DEV_PROXY_ARP_PVLAN(in_dev) == 0) {
> -			err = -EINVAL;
> +			/* what do we name this situation? */
> +			reason = SKB_DROP_REASON_ARP_PVLAN_DISABLE;

I don't have a better suggestion :(

Please drop the comment and re-iterate the question in the commit
message after a '---' separator, so we can merge the patch unmodified if
nobody suggests a better one.

Thanks,

Paolo

