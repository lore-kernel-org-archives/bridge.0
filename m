Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A4A2C69E
	for <bridge@lists.linux.dev>; Mon, 19 Feb 2024 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343175; cv=none; b=gSuD/Q1220E4EAwQUIaC4X7nFn4Di9fG+QvkzryraEpzFkPpSzzzzZ8DcZ/XLS6VaEkQd8M8edV/kzaqmTkD3vsvwlz3CEo9PPvrsvlS7LMMTCLI+SIZG/pi9+FCGHhOmFH9AH2Lm7fYhugmllspcJA7Ra3QHlwclq0i7wSP654=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343175; c=relaxed/simple;
	bh=4ZD/Ak4Shixqt+hRFej2u9n/4j5VFvBfGQlSNWdsOZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CEFKNqdmPK2XE5qJSdAmM6ul17H0JqD/HkOIb7HeoTbX7+Of95uF0CEG3WFV7cTUecVUCnqv0p2ML9uBbJCt0PqLCOIiIGwrvnVteeNksBVyvtx8F8WDPUew9SOSGXKCg1khS+wZKxdV5s41DoU65+WZuTqJowh1NbY9eYfXfgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QnDjsIP5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnDjsIP5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708343172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZD/Ak4Shixqt+hRFej2u9n/4j5VFvBfGQlSNWdsOZ8=;
	b=QnDjsIP5/Nx0J4Ft7kaySQAC2ZhAezEqVRib/Qi4bG4q3HNSCOOlfXvvcyzF04LF6cLOMn
	awxyFoovIgrAO6wBPaHbtGd1AlktIZu3YXvKtnbZuSztUONRPrZZfeIVN90Kiim+7nD/rY
	8LlMSdMAX/HpHJzsmzbK6kECnfDyg/I=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-avyBzeyLO5qAWsJ221rsLw-1; Mon, 19 Feb 2024 06:46:11 -0500
X-MC-Unique: avyBzeyLO5qAWsJ221rsLw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-42dba675351so51284701cf.1
        for <bridge@lists.linux.dev>; Mon, 19 Feb 2024 03:46:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708343171; x=1708947971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZD/Ak4Shixqt+hRFej2u9n/4j5VFvBfGQlSNWdsOZ8=;
        b=Pzc66AhD0Q9dfO2ytnPv+12F7q5pOnzFVi1/JMMpJgZmrU6jEmGXi1E0OBjBkYrzEQ
         /x9WlbS1Wm0uyOnvyNnAzEXybVLr1M3PP0dzvDBbPtBOqcRsXRfQoYne8v8a4ZQ0HRxX
         o6mY+Dn3KfL0R3jsXekub9kqtzeTrVa7lLW4oxaHiD1Jqvbt42EX1bVb3TKtU8DXN5U8
         ZGdV/nqmkgXQkAPk6GutXK6GkCF74UlJLunoyCRsoEQ4OIfIkdKf8RkfvVOcgRKw9MN1
         FisCuDbSCHfczl1+QgnymFlpnG3jD71eFu86Encb3o5KHxV613ked4TdvWzxHCQI5vLm
         PXHA==
X-Forwarded-Encrypted: i=1; AJvYcCWMe3MUG3c22SR1YSzBTLWkI3tQa+ac5HTeYHb7AVfbPjKxyF3nxqwkVOFf0GKVqwSCblMBbwp+3tMTnQcsynlWV5CcqYEU
X-Gm-Message-State: AOJu0YxA+DB44QKNlkM+7twnq8EhC4zdgLEfY+LlJgx+VClHoDfvFVmM
	zEAFfOpG5dlpv4kXIq1BUoSjV5738Ncq0sZAo7UGul5rIMynjt2iOmn9n/txQAJcZdmgx3nTC9x
	DummMmD9RJdPXn+R4X2r5IEwp/vi+QViQtbAnyvGS+Pb2r2qsECPKsA==
X-Received: by 2002:a05:622a:4f:b0:42c:7bfc:8068 with SMTP id y15-20020a05622a004f00b0042c7bfc8068mr18270858qtw.11.1708343171122;
        Mon, 19 Feb 2024 03:46:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiNw4DCsKkz2RLLVtfw6QNV6TRlA/lysd4gQNMYeIoLrM5/4vWlvVZ/26MqBKbSbHaFvNgsA==
X-Received: by 2002:a05:622a:4f:b0:42c:7bfc:8068 with SMTP id y15-20020a05622a004f00b0042c7bfc8068mr18270830qtw.11.1708343170853;
        Mon, 19 Feb 2024 03:46:10 -0800 (PST)
Received: from debian (2a01cb058d23d600e55283140c56efd3.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:e552:8314:c56:efd3])
        by smtp.gmail.com with ESMTPSA id t13-20020a05622a180d00b0042d0995a040sm2444657qtc.62.2024.02.19.03.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 03:46:10 -0800 (PST)
Date: Mon, 19 Feb 2024 12:46:06 +0100
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
Subject: Re: [PATCH 08/12] net: l2tp: constify the struct device_type usage
Message-ID: <ZdM/fjlngUdegmC7@debian>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
 <20240217-device_cleanup-net-v1-8-1eb31fb689f7@marliere.net>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240217-device_cleanup-net-v1-8-1eb31fb689f7@marliere.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 17, 2024 at 05:13:30PM -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the l2tpeth_type
> variable to be a constant structure as well, placing it into read-only
> memory which can not be modified at runtime.

Reviewed-by: Guillaume Nault <gnault@redhat.com>

