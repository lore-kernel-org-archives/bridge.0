Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C175B2C693
	for <bridge@lists.linux.dev>; Mon, 19 Feb 2024 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343020; cv=none; b=NxwExd7h1s7iPEO48hcI/1yAIc69OdJ/0Wo1YZRLmSLGwmnJpELZ7h+/2/nLBFYKnJHKM+pzilnka0DA/olwe5EmFvvmliJdzwFWZ//Q/rXV0kOrgv0ZePF5b2kg6PBCd3Mh7HVNn9M0B8Nk/K+W8Fb2vYBmSY1scWxrG4sEIVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343020; c=relaxed/simple;
	bh=UT1lPa/2yb85M5r4o3D5dus2HraX5x5mzr0FhmB6TGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=exKPD/m5vNOK8GbuMEp0rjrB2xSieRxsfjwlclGiLMEeQLzJDb3y4Qoe6F2pPiTqy0qfMjiIcGFamtB5plnOYon1mr9DRH4yQwFR1ygxGhwgvp8DNu+4fJkXTEKQ7bzMcKwm0jfw4swSenUMNt0ZpIEQ5wu0keqhK/nHMp5vsus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BzddOlzg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzddOlzg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708343017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UT1lPa/2yb85M5r4o3D5dus2HraX5x5mzr0FhmB6TGc=;
	b=BzddOlzg6j9TlmdTRLejMmv7U9U21i9uGd98fsVZd3pFR0a/jMlD1BI6TNZ8rkCYbKZUsN
	kIp8EpbJY6VlcuMQUC/YMu7TgCO9oGP+fugQ5ckXVXuNdf7B0Mxp/mKCu+kxry2hYW12lO
	8qeWVsgvtvJb0j84Og3yHmz3QsfrmWM=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-PbwE7N-gMH6BtJZvw73WsA-1; Mon, 19 Feb 2024 06:43:36 -0500
X-MC-Unique: PbwE7N-gMH6BtJZvw73WsA-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-7d2d72f7965so1952014241.2
        for <bridge@lists.linux.dev>; Mon, 19 Feb 2024 03:43:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708343016; x=1708947816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UT1lPa/2yb85M5r4o3D5dus2HraX5x5mzr0FhmB6TGc=;
        b=gGHtJJYABOxz8+SLPy1I3XdkTT+VUbuptLuwTesGA8sD4tOL4+9SEV7DkUD0pZnNtO
         f6YUqETr0S29yN+S7KcI5rzYsBsJxMKJ7poUeLv376hIUMWzTkHnz9JKRb79m+1rzciT
         ii0HbF9nklcdSpo4yPckOKkkyD5475ua0736td/cwQPQQ/ukY3ifbex3DI71wpoUZWkv
         CJfNN0U65MblXXMgaEgIx8A/hDH3xm3hXEsQ0JoxvJ6dmBxoirUAstXkHcV7HP9KOxv2
         RnyGr/xyX8XMFMal2e510i+Je2X8QtbEUQQfqPtyiunZKKo6PmO+XACWfVgvKPJpCA6k
         MLsg==
X-Forwarded-Encrypted: i=1; AJvYcCXepqUehVpbqA5UnDyqj538C0LQJlGXoSz2fkumlJ++Car5yBDwYoIGrY3pcoOWRJa/g6wOhPmMmQMw8yqGFdAInH1Kwee6
X-Gm-Message-State: AOJu0Yxkvzt5Owr0i9dWDG8cs3dBnA0LyPmh75GcMvdzlOWexBKPOXpj
	29XzOMX/AGn/FQ8lsbPXrxWcTMTkLEFaAEq14wFCb78fwIuR5AZf1YPM/Gthpme0RH9QHnQ8+88
	dfZKkBBdAcnDlKpBk9O60P2jOrSfFONxIc/kUqcUTzlTaI+0Aa0OLRg==
X-Received: by 2002:a05:6102:c4f:b0:470:5d2b:d3af with SMTP id y15-20020a0561020c4f00b004705d2bd3afmr1232154vss.32.1708343015884;
        Mon, 19 Feb 2024 03:43:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcM4hsvYF0Fkc6wNPR39b7BLYIzpcoNtkCS5Zhj9FBZ5j1bMr2hWobtFDKi/HpuXRX7eZKug==
X-Received: by 2002:a05:6102:c4f:b0:470:5d2b:d3af with SMTP id y15-20020a0561020c4f00b004705d2bd3afmr1232149vss.32.1708343015592;
        Mon, 19 Feb 2024 03:43:35 -0800 (PST)
Received: from debian (2a01cb058d23d600e55283140c56efd3.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:e552:8314:c56:efd3])
        by smtp.gmail.com with ESMTPSA id kk12-20020a05622a2c0c00b0042c7145fd19sm2473479qtb.12.2024.02.19.03.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 03:43:35 -0800 (PST)
Date: Mon, 19 Feb 2024 12:43:30 +0100
From: Guillaume Nault <gnault@redhat.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Oliver Neukum <oneukum@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev, linux-ppp@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 04/12] net: vxlan: constify the struct device_type usage
Message-ID: <ZdM+4uKE83V2j4o8@debian>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
 <20240217-device_cleanup-net-v1-4-1eb31fb689f7@marliere.net>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240217-device_cleanup-net-v1-4-1eb31fb689f7@marliere.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 17, 2024 at 05:13:26PM -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the vxlan_type
> variable to be a constant structure as well, placing it into read-only
> memory which can not be modified at runtime.

Reviewed-by: Guillaume Nault <gnault@redhat.com>

Note: To help maintainers (and potentially reviewers) work please
write in the subject prefix which tree you're targetting. For this
series, it should be "[PATCH net-next xx/yy]".

