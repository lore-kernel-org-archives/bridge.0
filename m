Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D874D1CEAD2
	for <bridge@lists.linux.dev>; Fri,  6 Sep 2024 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630757; cv=none; b=erHFsnQ5d1DVZgWQsdR2j+v25veb/g8oeiNNCm84IfZWW8lPm770Wf0RzgW2djKZS2V785YTOzWvPboMGeoecPndktvnIJowoMDHRzA404nk+vsdvQ4XOkuhzoinjvv17dHNaVI7VcW/LyH2QrHFGtwkTSRDjUPC3vN2CGKhBqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630757; c=relaxed/simple;
	bh=q9aU6MLxmooh2pjhdIX2la9jDmWUIouSae2ZL0rKgsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uCbCkg+aUfyyQyuO4SAucMhfwf59W4NGmWCo3LX//OpdMD2+fWdN9dwFzMs24jBtxJ+XrIdl4seysdBP8kZR/M24NjjT8A81mY9VgElaMiMlNE2u2njPn69rBFvAsDhxYYiS46JxWMBf/Kcn2Go7NrU72qV8XWgamkpy5UHSAWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RCgYqfj+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCgYqfj+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725630754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q9aU6MLxmooh2pjhdIX2la9jDmWUIouSae2ZL0rKgsM=;
	b=RCgYqfj+I+QXX+EXx27VpAdT/9KMML50JfD0XPVF+ro8toaDgDZ6McQdOeTR+OvvGGLPyw
	7Whu31OuU4jVSefWoSIqz3axl5c2moP0Ow0F5nev5P1jzB9WRvSnsEY+QxNRHUTWB//KFt
	9SIArbnZYvKuuFNXSZfMV5lEVHPn234=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-K6_TYu2pPeirfYpFta47LA-1; Fri, 06 Sep 2024 09:52:31 -0400
X-MC-Unique: K6_TYu2pPeirfYpFta47LA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3771b6da3ceso1247496f8f.3
        for <bridge@lists.linux.dev>; Fri, 06 Sep 2024 06:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725630750; x=1726235550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9aU6MLxmooh2pjhdIX2la9jDmWUIouSae2ZL0rKgsM=;
        b=IHCEunGoO6XTl2l9f1E9uiK/HxiiglpRcUqvIymaarE8Yz7MQqXwQ1VNIVTSIIm2tg
         GYqR1pWKXxazTTGnBNzRLxeYmocIJQKYCfxe1MsSMGfApNOHOjmSU+EvvU+gZI+8T1q3
         mCmmyyVHYVzKVBKp1ZlCJExIet124A72hOCqbxPxqSMrPww3aLazsKNTmauonWmVQiHu
         yvw9bPjVYwfSly7hR3u7WNURNaSBxI7C/VDXgqiHETIt1GLHgOk0GL3cj6A2pGrNCpvs
         QAYs0Vu7u9uY+vYxMy9xqEFpzs0xLshqAQsav8Dt0stHNIkP9K7ifNWIMGOh1dXxFuQ+
         wY+g==
X-Forwarded-Encrypted: i=1; AJvYcCUHBkFp3ww1VOmso2JzbQULxPQoZfnhePks3UngQic4rQSb2Dd7LEv4da1eXp0fuEi1Nt31VgE=@lists.linux.dev
X-Gm-Message-State: AOJu0YxVhGx9CNlbk3HOtdY9+PXQJhtSdBqxayKiO1M3wAKi3WXHd5wM
	Z35dHdIp/ctj9TYLR+mCsARVg0AHHJQkM2/RIQ/IqWgzFht9/rttp9sr4MnyAMFhcXRTvKXxPJh
	Aq8bUa2sT3szALaWXJ9fOOFXQhrcF47D2TR2oKpKKtuZnqSt6TfiQoA==
X-Received: by 2002:a5d:5e04:0:b0:374:b5af:710c with SMTP id ffacd0b85a97d-374b5af7510mr12649959f8f.26.1725630750359;
        Fri, 06 Sep 2024 06:52:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7rIucSxMSJNCM9P3fVpLg+fca1j3lilFUPuCE9KWtPYnhwY3r2Fu3rHNI/1QZKG6cYsZRkg==
X-Received: by 2002:a5d:5e04:0:b0:374:b5af:710c with SMTP id ffacd0b85a97d-374b5af7510mr12649933f8f.26.1725630749848;
        Fri, 06 Sep 2024 06:52:29 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3788773ea3csm2131461f8f.54.2024.09.06.06.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 06:52:29 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:52:27 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 05/12] ipv4: ip_tunnel: Unmask upper DSCP bits
 in ip_tunnel_bind_dev()
Message-ID: <ZtsJG3/3syyoQOCH@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-6-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240905165140.3105140-6-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 07:51:33PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when initializing an IPv4 flow key via
> ip_tunnel_init_flow() before passing it to ip_route_output_key() so that
> in the future we could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>

