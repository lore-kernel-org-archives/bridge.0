Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458991CB15C
	for <bridge@lists.linux.dev>; Fri,  6 Sep 2024 11:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621799; cv=none; b=GoeTrtPD2nUr+k6VaYtgyMAeiCE2oxuHMyqxXn1MuGdDdcr60o1f/Z9FFZ48/O6FDzviGs8VzpvZOZbZKD4mbq+GrMM6BrLkY6RIhNaKC1+ePeB2YExGaQficYPnkGBvTPBgalYLXhp2+4KbM+OUmC5XWb88EbcNjxmt+vzbdx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621799; c=relaxed/simple;
	bh=ppjXtJ7gs7W9QUgkDi7uSrA4aZ6/Z9GMvpuugQHfWxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EMKBN2KzCDiPcGBYFMK3NZ9KpSKXkg0aaYoUpAgoZDgeWxwEdVWfUzger0fQLArB5XbRU5b1/iPDry6t9ah+X0LVeU6FV49EG+RNEBoL04VKQ3Xz0FLWiNY1RfdWwFfQAL7TIpXmz9mE11wQRLDUMeYf7bPWGV40JWa6LtmZXTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZ1MUDLb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZ1MUDLb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725621797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ppjXtJ7gs7W9QUgkDi7uSrA4aZ6/Z9GMvpuugQHfWxc=;
	b=BZ1MUDLb5f+CKw6+G0w40+dAR+p2e5DyUKhKlMpKA4gtGVOJl2K3hjnAevTsN4M5Eyjiat
	Ohl/ftk7ZU3TVcDCjHkcyaEtjsWiM+MTadTm6W7m4zWm0vlq0nzXwfFww1K9np24KHGGqQ
	uW1NJaW2tc7yw80/anOrUtAY+Lr7258=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-H_TjP8iQMvmYgHSPcmPmNw-1; Fri, 06 Sep 2024 07:23:15 -0400
X-MC-Unique: H_TjP8iQMvmYgHSPcmPmNw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42bac946976so15484025e9.2
        for <bridge@lists.linux.dev>; Fri, 06 Sep 2024 04:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725621795; x=1726226595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppjXtJ7gs7W9QUgkDi7uSrA4aZ6/Z9GMvpuugQHfWxc=;
        b=aAqMNXyEj4e1Dx8CTVBwW7Pz+HMkXnCiR4k6cPWmGAnACa68M4rqfkW/wafApmbRV6
         luseQHRGjPCL2SoY/RWeCyy6GXLnlflU52L8rQXmVq+ssCii4ReRtzGMxuOh6hCxPbn+
         0zbigI73jdGbmoWHagR52ASd4RL4vblbSkdyYxCZ4wmZggkl5i9gIFxvkSmbKifyIJcs
         itsror7/3aWB+P8ftMKqd/S9SSIhUWcm0aMOUZHV1wQXfd0O9fzgG4eUP2DOn1czHQh+
         4FH085GW0kQ7s6LQRkHx2bdTosetoRrv2j4ZrkJYRqAORAZYbsCPqVPXa2HIBHnm9lXn
         U4/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgWsbB8vhezVDdj/uPjKlCNJO7lGvbG3bs0w0Hhnx1FelsfCo3/6k9zB2HvHkpZkm/ZiKeboc=@lists.linux.dev
X-Gm-Message-State: AOJu0YwKxhjS39TNVkRdDITjIz7Ee5XpQYG5HFSo59Ru7qzL88QjOIG7
	ceVmcAGj2V9qtjWK5b8tGFuVOtl5dG5mRp4O/YDUwtB1OLRMB1t+Y3L4ihVu3HuV2YtGz4inohC
	zGanWbes5Wk4gJbJum++cUycFg89moDjTJ18YiViy6It2lxyZ+XICcg==
X-Received: by 2002:a05:600c:1914:b0:426:5e91:3920 with SMTP id 5b1f17b1804b1-42bb27a9eedmr205061745e9.29.1725621794779;
        Fri, 06 Sep 2024 04:23:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDWt5S+yLwjHr+CBf53VWDHiFksVfZtQBazKOXS3AJWWvyxr4Lz9xJ3DkOyXs6TcqBtg77Kw==
X-Received: by 2002:a05:600c:1914:b0:426:5e91:3920 with SMTP id 5b1f17b1804b1-42bb27a9eedmr205061375e9.29.1725621794156;
        Fri, 06 Sep 2024 04:23:14 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05f847fsm17687305e9.41.2024.09.06.04.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:23:12 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:23:10 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 04/12] ipv4: icmp: Unmask upper DSCP bits in
 icmp_reply()
Message-ID: <ZtrmHrAC40k4hpxe@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-5-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240905165140.3105140-5-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 07:51:32PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_key() so that in
> the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>

