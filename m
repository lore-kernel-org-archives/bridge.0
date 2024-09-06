Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B1E1CF5ED
	for <bridge@lists.linux.dev>; Fri,  6 Sep 2024 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631473; cv=none; b=aPoOznR83fQ5B9UYhsmo8OdJy1dNOd27QOrNuJu4S3ghI7ZOB9jlDI6YclG9TrTUK0Ecn8FrxD1lLB2ijFaJ/fQ74NY1F1cbhjUEFYUhHpLKRGqbtLYcTCeJ7Q0RMYuHCR1iNpSDRC8lSV7gFKV+OCEn0lVh63QgStO9PuU6pVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631473; c=relaxed/simple;
	bh=HHFC+pt8F30hf4thaLXM7MllDwsBRp0xvNHzUpudAOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BJYwmRshvnETJOVBt/YYDdH4UZlTAhpMD8DDFYecnWspC3f0lWqaZCXxGyWXdBdcD2H9YKnMc6XZLUi1DknR4S/FTkxJUpZgPALIW2nkV6f/PPEr4ECWpui/ZyNRj4gHeVNRsQG+Y7ZEBSNhoLF2rUY/UN1W9/bMTzQcZaR2jW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vx4YBsIg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vx4YBsIg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725631470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHFC+pt8F30hf4thaLXM7MllDwsBRp0xvNHzUpudAOw=;
	b=Vx4YBsIgzZWwm5LHkZzAsX8POI0wfFGZyMiTYtWnKimj+iNwOovhqNm1Ni5xyJXllpCmjr
	tXDnfL5/luN3xPXFi9GsxdCDbQNgSjcWUHR+3EJWLLFt3X8ta8vIBTJhh7bYSklr9XrDUe
	IJ/TVOXCC+av7OVJqvoyMWjjjBgBjfQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-RPKEdlElOnCkdHIkQCglNw-1; Fri, 06 Sep 2024 10:04:28 -0400
X-MC-Unique: RPKEdlElOnCkdHIkQCglNw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-535681e6f8eso1998784e87.1
        for <bridge@lists.linux.dev>; Fri, 06 Sep 2024 07:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725631467; x=1726236267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHFC+pt8F30hf4thaLXM7MllDwsBRp0xvNHzUpudAOw=;
        b=fPDUuAkArtRlxhsfl63J+ny+hIqw/H4sKiOm4bhz+NUOvmgMWdsqY69djPbrezQG99
         XmlTcE5AwTTrVGa1bNGmDjLR4YW3GB6N+M08RqHwHfnU6K4oXxUW/Q7RK45WOdapwpU+
         L0jQAi5LZIF/riaNvmr+8G48HcWlSkDssDCzwzudouAjcJKnShuybFJB/HkVrkvLyjyl
         d1oMTuuToxkn4l18dtOZa13WcREtioSB39b5My2F0yz49PWDK9x7i5eXkHQmYoGWDdMu
         NV3KBxDoHSHLY2faArHesxR25PqI78C7w0nRVw9IjYTVNVAkaPF+7wGw9fgAk6InuAUI
         SviA==
X-Forwarded-Encrypted: i=1; AJvYcCW4cIYCljhyC/ZnvdhPABF+LZ/TRQAwv0M/OX+vCdB+5vI344uufcz19iyeYImoBlGRmVbi4Es=@lists.linux.dev
X-Gm-Message-State: AOJu0YyQiAimBsiczWe7DoBrBCNuZLIWW5sug6x5R1Ig1hE9piI0RNW5
	3lBmrHAslQyecg1YFSC/TcdnjFLxICq3oe+QPx6QVDTcYzlptJfLYT2TTZzpHbUJhtL0rtYlKaC
	vywa1iGJNJDpC9agYy0+qFA/p/49hGYYev1yprtafHxc65qcwYwawVw==
X-Received: by 2002:a05:6512:224f:b0:533:d3e:16fe with SMTP id 2adb3069b0e04-536587fa8e4mr1676579e87.38.1725631467075;
        Fri, 06 Sep 2024 07:04:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKQ5/38TKV/Y2UqEsgT1myno6QGvAIBzgZWsQu6maWs8a2tVqrqi7GmjJ3p9IQvBhwQGLDzg==
X-Received: by 2002:a05:6512:224f:b0:533:d3e:16fe with SMTP id 2adb3069b0e04-536587fa8e4mr1676511e87.38.1725631466186;
        Fri, 06 Sep 2024 07:04:26 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05cee8csm21366785e9.21.2024.09.06.07.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:04:25 -0700 (PDT)
Date: Fri, 6 Sep 2024 16:04:23 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 07/12] ipv4: ip_tunnel: Unmask upper DSCP bits
 in ip_tunnel_xmit()
Message-ID: <ZtsL5+/aztO2HBuR@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-8-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240905165140.3105140-8-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 07:51:35PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when initializing an IPv4 flow key via
> ip_tunnel_init_flow() before passing it to ip_route_output_key() so that
> in the future we could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>

