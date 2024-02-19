Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD9A2C877
	for <bridge@lists.linux.dev>; Mon, 19 Feb 2024 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343112; cv=none; b=XyELghhpQtxBcwzAwQ0oPdwDE3XGJdWhZ8dsJk2AuG8kM/6kCgRlIvXNB5Vmc44mkg82m7tj7ps0s70LMmUtoWuizl+WHMineVK2aVpuXj7hrduIR6ODfR9HISqLtk124Iix3F6CQ35aK7BOtbyYt+ICGmrhyaB15RX04n1CTxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343112; c=relaxed/simple;
	bh=D9hRGYviTBgrT9JL4bYsDb4sJ3nlGtiMKNkQ8M8d4Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YUlbljVUxCth5+CBRYM+6Idf9UaenRocIlrLXS9rbH8ZfslZ5DaS3eW8uvudMfc9waZs3ljYWIAXGb9ttHE5gThYHwLVCT1XTfmZ3w6VuIswajmSuYZ/l0QbTI/tiq/5UdexLykZw5BGf/15oXTyMhgoRRZRL1Yx+puW8sMZ6DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iQRZVzAd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQRZVzAd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708343110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9hRGYviTBgrT9JL4bYsDb4sJ3nlGtiMKNkQ8M8d4Mo=;
	b=iQRZVzAdpFAKN4FVIBb1+D5kaMdbKsmHqHnpLJje+Ci4rpv8x1ojD5m08sGM1eT5QL9bbW
	y0aPkkfKQcL7bBxOqzkieo4VyQnzgwvEo2x3us3HFAsw0dHKgD1Ve9PRcqA0CqnlFNcmB/
	BcXm9HQDQz7dxEOMH2fabY8L40SNalY=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-5FxJ4CZGPKmZBdBLMN-lxg-1; Mon, 19 Feb 2024 06:45:06 -0500
X-MC-Unique: 5FxJ4CZGPKmZBdBLMN-lxg-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6e43bd130b9so1885400a34.0
        for <bridge@lists.linux.dev>; Mon, 19 Feb 2024 03:45:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708343106; x=1708947906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9hRGYviTBgrT9JL4bYsDb4sJ3nlGtiMKNkQ8M8d4Mo=;
        b=ioKSwH+tjInh1lELSa6wYvjTBRsyzPy6SFPU6ZADimU+ZDNXySAXbUAvgGv2qaXInO
         1vKtR/HqRkHnYWXVjUluSYhJ7MwpzQgWrgkLZsVz3IWtiIxUb3fXWKutcb1GzNi3UHpE
         zx4sKxNq3KMyFTA9Mm5Bj4ueeghyYPMvQx55Uzt/V2T5Zh44y8dm+2bKeeUDutPxWl4X
         iZsG9TBGC2GNcxchzJrqYAudDzAUU3vDD+qN0m/0tQY1Ic/NYqZ0r/uGVKeOUn1dEiWG
         IQbVgxsPiMQm3hAp+x1X48cD3pwFUHb679kByMscv/gTGXQJWtdxdKr9TnzFDaWbKxK6
         k0cQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+9FzO3nLM8NcN+ibMKU/HyK8vkfkUmI7wEhpcQpGBlBiBWl0yRR7i53UoWTEwho5HauWlPOJSSN7VpVtcAYe2Dx4GaTCj
X-Gm-Message-State: AOJu0YzfYdvX4m/9WIqFxeNkLcNYFy7UA79OjSAzwmbA/qCnUFCDpOjG
	iLXL4utOkpKfRGFX9HV9ecRqk34fpvQg8zRnpxCze+LltP7mUn2AAhBjHpHyhs40tH/8LeKr8/x
	TIwh9dPKt3ZwVCOFNbjfVA7hgV5sU3jvw+01YiYcSGbNNq2Dw8Et/KQ==
X-Received: by 2002:a9d:784d:0:b0:6e2:b28f:6179 with SMTP id c13-20020a9d784d000000b006e2b28f6179mr10941352otm.1.1708343105910;
        Mon, 19 Feb 2024 03:45:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsN2n5yYaiYxn4J72WsxzOtRLf/NgiPHoctu4Eq36TIpHVzuwMVBn8xyf/HnupptrjA+lZvA==
X-Received: by 2002:a9d:784d:0:b0:6e2:b28f:6179 with SMTP id c13-20020a9d784d000000b006e2b28f6179mr10941343otm.1.1708343105678;
        Mon, 19 Feb 2024 03:45:05 -0800 (PST)
Received: from debian (2a01cb058d23d600e55283140c56efd3.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:e552:8314:c56:efd3])
        by smtp.gmail.com with ESMTPSA id r10-20020ac85e8a000000b0042c6ae89193sm2447426qtx.93.2024.02.19.03.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 03:45:05 -0800 (PST)
Date: Mon, 19 Feb 2024 12:45:00 +0100
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
Subject: Re: [PATCH 06/12] net: geneve: constify the struct device_type usage
Message-ID: <ZdM/PD+asF91uwTZ@debian>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
 <20240217-device_cleanup-net-v1-6-1eb31fb689f7@marliere.net>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240217-device_cleanup-net-v1-6-1eb31fb689f7@marliere.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 17, 2024 at 05:13:28PM -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the geneve_type
> variable to be a constant structure as well, placing it into read-only
> memory which can not be modified at runtime.

Reviewed-by: Guillaume Nault <gnault@redhat.com>

