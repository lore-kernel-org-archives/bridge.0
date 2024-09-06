Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C891CBE81
	for <bridge@lists.linux.dev>; Fri,  6 Sep 2024 12:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725624184; cv=none; b=harg4c4nNXRalN6CMReyoD9f1PGPATjwaubEDBrrhSR+PT+6TX5Pto/+Nnkg0P8b93W6c3Bg8q3UJELVMeygx6iNmaTwvRbAdA8npcunvK1HtZC7GueqsGyBAI+j9zrj4QkDLxROc+EwbJYHsQznnlN04C2U8WI8coT5rcWtRMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725624184; c=relaxed/simple;
	bh=SzxUx97+S6KIAnLwmxguKmEFLZ9yAdCsp/nWhUUS7FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qU6qYdVCo0eqIGqDVL+lc3OiY/jUWCfs7n2QvsFlwYrDWNTdKDZPmP6zPkvFaZHU6Jz4DKETnVzQMyOlwAiBBeYBpgM/S/dZdRSYrLNO/3K6G3uOV6ZE0D5el/zzJ7E7KjrzHwinaLOelJKnzHxEj3wMaZqknT8un937dh862ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCbbTZ4Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCbbTZ4Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725624180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SzxUx97+S6KIAnLwmxguKmEFLZ9yAdCsp/nWhUUS7FE=;
	b=cCbbTZ4Ypxqo5mGp+SjgEHdXAov3on4FYCa67PLCOq8NNDQLZYEPWrYjWOrtaIiP4VvtZy
	CXyRurLUNibPRU8z7erevNXQ1MdGNo9cX/JwF15MpqGtSRxWSEmhvfQGRJaG+riUmx/+D6
	FBKhjmRp7LU/XMAhYd5qn+9uP2VNqVI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641--X34vPufNvOXXBHArBUufQ-1; Fri, 06 Sep 2024 08:02:59 -0400
X-MC-Unique: -X34vPufNvOXXBHArBUufQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42c7936e4ebso15848865e9.3
        for <bridge@lists.linux.dev>; Fri, 06 Sep 2024 05:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725624178; x=1726228978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzxUx97+S6KIAnLwmxguKmEFLZ9yAdCsp/nWhUUS7FE=;
        b=QACjx4bPnE4XmgPyOfLphdBpQV7wy1rv3GlPmJDq1wZU85TCM4T0X3xS4Uadw8Z1jH
         BgbSumHsdLfGIS0qluKq16Un649lRK48GW16OPt8aovy+37pm/bGGjxaGa9Q1bvaqGKu
         C8TkS5tGl3d/8Rck1eMtcBwvkwNlzdqjL0edJJ+4T7/066bQyyMbN33Va4tU2hxrUoVo
         ofczyN86sIBlNfaXSBOnHgevBYhoEcepfnwgh8M6hT7994acQo/NsPjahQ8b8BC6fU8K
         rCs2/R7OZ1jL9WypgVBfFUjLOP8zRQXDZpr92PbSrki60rMXGgxAYq24qVtU5YxvzC+O
         Ym3g==
X-Forwarded-Encrypted: i=1; AJvYcCUZipazJHu2LkJmqN94BcIkVs2jC0cs3GE3466A1NSrfapNYZ0slc0b8+PYdK4lLSpGRc9aXZM=@lists.linux.dev
X-Gm-Message-State: AOJu0YzOaknl9Yz2q+mogwKccCdVwXjyrTn1yBs2dZic7e7V1ACJbBax
	zf8O/RQC25Qo172VI37e6S0gb+VBoJPHul56sQuMlNj/49Qn3+4o7EYAeQAREEZY6WsFbEBuCzp
	gtS3CizDkclJEtmA6PjO5lsqL3EIVHWqyunkeSbGD4dQ1C3Bf5VoHjw==
X-Received: by 2002:a05:600c:4e8c:b0:426:6921:e3e5 with SMTP id 5b1f17b1804b1-42c9f9d6a97mr14855405e9.24.1725624177993;
        Fri, 06 Sep 2024 05:02:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoI0DxPX/u6R3aYPAJ18qh/X+91B4iTbd+r7c0r2GHaqUyL4q8mSemuf8LpPqF1l3DBpiAhg==
X-Received: by 2002:a05:600c:4e8c:b0:426:6921:e3e5 with SMTP id 5b1f17b1804b1-42c9f9d6a97mr14855095e9.24.1725624177430;
        Fri, 06 Sep 2024 05:02:57 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3788dea8eabsm1004604f8f.114.2024.09.06.05.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 05:02:57 -0700 (PDT)
Date: Fri, 6 Sep 2024 14:02:55 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 11/12] ipv4: udp_tunnel: Unmask upper DSCP bits
 in udp_tunnel_dst_lookup()
Message-ID: <Ztrvbx3qzXI2VCN8@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-12-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240905165140.3105140-12-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 07:51:39PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_key() so that in
> the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>

