Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8732C19C
	for <bridge@lists.linux.dev>; Mon, 19 Feb 2024 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343067; cv=none; b=YhUGPP1jKl+hyhNL+D+xDBfkZlpxzET2Q/8Ez77Xob5gyQnQspNn+eQ0loYf/l0tZwOaNvBXLIMrXoczneI6vz0AISr8vXD7recLJ6c3vKEpxGLBBLw2nQuyuaJSEGi0WOdgvRFTbyo5UkzGpzGsWYjiZHMkx6KM2dt0SMT9m40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343067; c=relaxed/simple;
	bh=gUntlLLADUk9fOwIp7/2ak+sHS72oT6rdDnXj0smozo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=o6QEHUBlfy5NlIQ8VghV0dw6dtCs+MHdSLPEK6xlSqEqAt1YPzfTV6KigjyCSaAv3XLRbi5fKr7dqc0zb7g2CzXa79SKBYnkbXezRhh9ZWNdfS5JARxQc5Gy0JjYTEkxocfF/L62hIGYLtqqxUm90wQJaDLDMCVVzvuaLLRl25M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dry4wvDx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dry4wvDx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708343065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gUntlLLADUk9fOwIp7/2ak+sHS72oT6rdDnXj0smozo=;
	b=dry4wvDxtXI7dP3ln4nyKSpqlLi+nqPlKWqM8TJtqpcEcJ6hmtb0zODLGl7HhsqIbbMOe8
	h7joAXnrW2IhE9J6ePfGp07lUWlVQdPDC1GfUK2HUZHJt6pTKNE/RgRwiduXUNPYzibSB7
	xPYmgvaf34zWd4X82zEo3bOnnljLHOo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-cWi-0jPiNjaHhpPzH-4pPA-1; Mon, 19 Feb 2024 06:44:23 -0500
X-MC-Unique: cWi-0jPiNjaHhpPzH-4pPA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-68c50d32297so60981236d6.0
        for <bridge@lists.linux.dev>; Mon, 19 Feb 2024 03:44:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708343063; x=1708947863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUntlLLADUk9fOwIp7/2ak+sHS72oT6rdDnXj0smozo=;
        b=hMFzm1EfvMkgqlDogB07BfHH/80JWUZYYD5xxYll8Kw0ggny6Ry80T+mXKKy8Arysp
         ZpNld/EBFcsteIr84cL/EC0EHzwAt/4XggoLOFTbELriycTOMWVLUcKfSroXMRFb2ZSF
         4JTS/stglnWwVE/AFu2Af7YqF2DYzy3Mg3S0LuxZUnbhY7DbEEgq7VsQOkBB/AxV02Mh
         Lwyr8Y+U/8anKHFD35WJop0Uj3vfkmibQD+kDI7g3JiSlz7IkoqWMKQEzqYkm39K2//w
         T37Trc+xgOGi4WRzso+MDNBO0rbDbezAkP9ZlxBNvJrEBno389vrOAyFwM8PhwjfxUq6
         pALg==
X-Forwarded-Encrypted: i=1; AJvYcCXZF4ccMw0mD4Q0hqGzlM+F9b4WqpEjQKgDOjkTx1tb1SDCQZRvjLrzo3rBxeUJNQB12NkOcE0kTBBTGmyUussjGhlgKWFP
X-Gm-Message-State: AOJu0YypX+5q7/eFn3VN6X5ET29gNTyiDkOvdMKqRohx8Af5KFX32R4Y
	km/kZ+9BvNM2lPXjXxB0Z5Ahfg7ZeZ6kPLipO846TdIkUSXi1oekePuF3tNInomyMWaptm7K/it
	DSFffaibi1XaKUUEI9AR/MAecA8XY5ywT9GvDnsIeHuFyiYN0zAhVvA==
X-Received: by 2002:ad4:5d69:0:b0:68f:4645:8cad with SMTP id fn9-20020ad45d69000000b0068f46458cadmr2351909qvb.57.1708343063351;
        Mon, 19 Feb 2024 03:44:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLbhd1hRBa1Vi4h+/NrkLkws+Hyd7ejD07jtvzpsrfiTatFhwS2ruE/0PimVLy9ybIJlmUWQ==
X-Received: by 2002:ad4:5d69:0:b0:68f:4645:8cad with SMTP id fn9-20020ad45d69000000b0068f46458cadmr2351886qvb.57.1708343063103;
        Mon, 19 Feb 2024 03:44:23 -0800 (PST)
Received: from debian (2a01cb058d23d600e55283140c56efd3.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:e552:8314:c56:efd3])
        by smtp.gmail.com with ESMTPSA id d11-20020a05621416cb00b0068d11cf887bsm3121135qvz.55.2024.02.19.03.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 03:44:22 -0800 (PST)
Date: Mon, 19 Feb 2024 12:44:18 +0100
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
Subject: Re: [PATCH 05/12] net: ppp: constify the struct device_type usage
Message-ID: <ZdM/EjzGrmdGIpvg@debian>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
 <20240217-device_cleanup-net-v1-5-1eb31fb689f7@marliere.net>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240217-device_cleanup-net-v1-5-1eb31fb689f7@marliere.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 17, 2024 at 05:13:27PM -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the ppp_type
> variable to be a constant structure as well, placing it into read-only
> memory which can not be modified at runtime.

Reviewed-by: Guillaume Nault <gnault@redhat.com>

