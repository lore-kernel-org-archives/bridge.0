Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792774128;
	b=j5AGbbOoTBsIU+6PcnAwTVi9/4TcSMjgdw9NSWDLR21a96/u6+8fGAy1NGajDMesmct/
	 vkuPrBjoroi/6BwVf1CkUsFAP5KZzxZUOW9rkKW2bNWauFFx/PAVAlO7qpuOQJzXkGi89
	 fSp2ZgYMdME1hEKIAC4HVbPQRy0q2LtsoopjJ7gHXefJIyhsYSlXoXyVwDKEobOQ6aeNc
	 lfeERnMnFkE5x4ZagifBqVPLE6H7M2dzmsr8OWSkhqtoMJ1/TGU920tg9ln6pSlefPj4W
	 QBGbIZDdWkIK5lECz2J+jMUioQSkC9aXuFzBY/bCYD9fRPSkP/mGcBVry+bUin5f8Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792774128;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=l4yjbuyU9tYNCrKIyPpIJSh4fdlXELraeddszflbbg8=;
	b=nlgfYCEz7dHipBVIfM8XboWsgYx5mYr+pRRBuuX/irehwAHaj3nDLnRXdEdiIrxu/EaI
	 jQGW0p7BmMCUa9HdCLi9G+K0F/Ri+4FJlNf/IORPOOn3HjnasYBr26ngMr5vDYxivyiLx
	 fCRvD2kAeWT+Kx/52NsuIAAHYqrxWRc28Mz78e/Ktrf/RgbMQA+ClVesAjD78Qsn0s/JC
	 CJhrE2Y4L3XZ0RSgL3Y0mUhpLgIaZaiva+WPmXVLz92ASEzQyv/2gejepnQZr6W1choIa
	 xvSZRrHOs7M9iW5H1V7TZ3G4NwC650GG+B08X7XtcYgJXNezd9tCAZZWzIAFKMGgPvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gU82Iq7X;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAEC606A329
	for <bridge@lists.linux.dev>; Fri, 23 Oct 2026 16:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FAEC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gU82Iq7X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792774126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l4yjbuyU9tYNCrKIyPpIJSh4fdlXELraeddszflbbg8=;
	b=gU82Iq7Xsy1bpWiIWtNPit9g5SQIShMVBOyJwx+nwb+BjP3l+EB4PoCljAmCX4l/1T7dUD
	+6tTkweWJ8evAupHVvRN6kSm2boS84zitk73UcCxFYaXggpoiJzkpIUtJC6FUrJtrqd0rN
	IVMs4Kh2OrhM3PI9LV69RzWvXdes1A0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-rF-3dyIePnqoPSvD1FhsHQ-1; Fri, 23 Oct 2026 12:48:45 -0400
X-MC-Unique: rF-3dyIePnqoPSvD1FhsHQ-1
X-Mimecast-MFC-AGG-ID: rF-3dyIePnqoPSvD1FhsHQ_1792774124
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48b027578a4so1007186f8f.3
        for <bridge@lists.linux.dev>; Fri, 23 Oct 2026 09:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792774124; x=1793378924;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l4yjbuyU9tYNCrKIyPpIJSh4fdlXELraeddszflbbg8=;
        b=X2qz3Y1S/aZXu/7x2qHOjfehnSUDKlL0kqNFMTrRcQY5wSNzcopOKazZgXKcWXhTzv
         doSZWpkc4Ct8lnuXU8HkJFxQI6mIgjgZS51thDjEJ9GY48yxPQPasNqCqFCCGAkz4bOA
         +3BoorC02F11Ij637VPtfADbglSub4B8AaqH3b/7ri4Zk51wOKLDjAFjAxyHX3sRcNY3
         cZnBmNBXUp20tuxFqABO/M45XyfFgYyS0IFoxWWXG242Uh5QCYousryw7Wah1aw+j2JP
         hEnMLe9lFkHuiS9BaYWPru/kzfXpr9vnTfGlms+CcQS3uQ7Ym/pU7SZcMvGI6UBuvAvx
         Qa7w==
X-Forwarded-Encrypted: i=1; AKwUvBwrSY+BpdCiYbU+ZS1y73c2gJh1OOFc1OOf00swfSuR1ztOvMWysp2u8rwfEfM5X4lJaxJvzyk=@lists.linux.dev
X-Gm-Message-State: AFq9FYIfRhfatE7X/YIXeB52c4nbJihZ5wFtpq6W/3mBE7PRZ+5Hfy5N
	B3NIFSOfI6M9pcO4pZTeQuy3790IiR7pX4ktWkYhN1k/y2tevFU1S9qYm8zqK0lKLbhgbd5JcEV
	EoNW5OSW3aGgwBimKROid81bDntQPwspiuHeG78hrFHb0HC1BheqGiUNx0w==
X-Gm-Gg: AYBFou072W4zBkxASs4MFYvBcoI6JnAk6nZGiEZ75BT0hggbT8QrU7YGQvxrUiP7tRM
	xaWEGfj1NSWV6Cz2OeCS3VqEQN0xnzDsxZCI4ANAKAGnzGmhhwTc9dsCKTW1vZ+NfSypR9ijT7u
	aGYrHY0qk4nW4DCFVtShR3eplYV3qAv8nc7jGg+T0nPVlARdDZavm3KNKj4DgLbCtE6pvVn4vyS
	FSOwaqlTWqjhXLq2EL28zXe9mp5tKutRxrg6emewzC7x/wHAXt0YLSbuCTfLsf0PECXnP34pRby
	c60E8lvxHjrPmSohAbGKsYc4oaTNjfnRdOOXCXW/31zhNC/qXfH1BnheVMWpB6GuuJ0zhAQ=
X-Received: by 2002:a05:6000:4026:b0:48d:eb6b:9d0f with SMTP id ffacd0b85a97d-48e385ac430mr4702387f8f.11.1792774124020;
        Fri, 23 Oct 2026 09:48:44 -0700 (PDT)
X-Received: by 2002:a05:6000:4026:b0:48d:eb6b:9d0f with SMTP id ffacd0b85a97d-48e385ac430mr4702351f8f.11.1792774123549;
        Fri, 23 Oct 2026 09:48:43 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d37c4b7sm1157431f8f.2.2026.10.23.09.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:48:42 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:48:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Chris Arges <carges@cloudflare.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, bridge@lists.linux.dev
Subject: Re: [PATCH net v6 6/6] net: add ip4_parse()
Message-ID: <20261023124740-mutt-send-email-mst@kernel.org>
References: <cover.v6.git.mst@redhat.com>
 <970e2341834eadcf265fa7dd61a05ee305fdc1e4.1792687500.git.mst@redhat.com>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <970e2341834eadcf265fa7dd61a05ee305fdc1e4.1792687500.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xTKOFGrKmww3TwdiMoO-WsQikuE6zNm_EmAIQyeZpuY_1792774124
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


This one was sent by mistake. Pls ignore.

