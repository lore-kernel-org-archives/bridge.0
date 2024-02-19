Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E783610A
	for <bridge@lists.linux.dev>; Mon, 19 Feb 2024 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343347; cv=none; b=TcTKccrzlSBHp4efFBULoUqcLJjSNa3tOdlv+0+iVkq5XLrKZiYaOJbCqV4H3Rfu1BEbXTLY0Akq+DK6WNsJ1XIhoJcBkmE2INs1M+kfJlD9ideG99atLYqlc7wDw6rZqkXJyJ7Q1yA+gZHEBo0T4eJMA203bdOnEcvlr5qBqgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343347; c=relaxed/simple;
	bh=GVjvAPYbMIuKLzqak2azvCdxXlpubEruAFBoyFzUHMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTqyIksWxFJsKf0N4++LZfYoNEEEV8NIO8S7refxc68GSUruNzg+SIZDlqMhUWE1RWge5SiPhIfhuRX8Qe3vaJhGShkgxggkiVAyK8uOv1xxJEZIvSkNF5n4o4V8X/U88zlTh+Od79P4/MfBnCW4nkdwWX2vUSiopsNSPj5tsOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=aF3EPXsT; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="aF3EPXsT"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-299a2456948so561948a91.1
        for <bridge@lists.linux.dev>; Mon, 19 Feb 2024 03:49:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708343345; x=1708948145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CW0WXcyNYkXvrmiNrVym9t+J2nK+JeRu5kNrSxRLDH4=;
        b=JFxeELUlZcUMxqCOuWOJafBy3EbDOcOonn0yXSvRmK9UKWpdmUF8QB0XhIcC6bIu+k
         Rn47IatrVLW2dyCF5SUWEAo8P+w6Xi12q/vwJUMR0ov4ZOgdo29UiLv6naFa8VgSlj5r
         KygMA7SX5GYOT+YCOmxdC5fGf3hoTR13dnjUcOmvZMVNroL/B13yGRSd5xGpuW/FV0OG
         FcOGAkGjpGBH45ZpxNPwZLwnKfcRlclspvZBgZm1KcXP7zcN/AeEdVPL7rIWOa2p0mVj
         Xh2WMzzW5K5Q3WnL4pWvt0sQVpf1ib1cGGTIhBvxfec92M+ebPmWYItLmn5dL1H6c/3e
         irBg==
X-Forwarded-Encrypted: i=1; AJvYcCVh+slL2z7gYfGRJYqFuw/zwpHRgWCezXGT/ddPratjdGsFtNQMGe0ZwM7PkjvKZ69xWnnsaHiaPUlYScCry76UeugLx3U2
X-Gm-Message-State: AOJu0Yw2qY0oZBWd0HvcLrDgkvsVLAvPppF3h74DP9RCknr2rI/TDep0
	3W6IetePUmk3NiVRZSvjuFsNzvTcl8OiFhXBS6hLiwbIr/l2W7Sg
X-Google-Smtp-Source: AGHT+IF68FoElOobhjt+UxMIgmYvkJ7kfurkN7xNBIeED5I12PhyFHotNODXFufCcCdAiwQOshri3A==
X-Received: by 2002:a17:90b:1990:b0:299:48de:9c7a with SMTP id mv16-20020a17090b199000b0029948de9c7amr5910376pjb.0.1708343344080;
        Mon, 19 Feb 2024 03:49:04 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id gw15-20020a17090b0a4f00b002961a383303sm5006491pjb.14.2024.02.19.03.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 03:49:03 -0800 (PST)
Date: Mon, 19 Feb 2024 08:49:47 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708343342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CW0WXcyNYkXvrmiNrVym9t+J2nK+JeRu5kNrSxRLDH4=;
	b=aF3EPXsTFrB1x5H2n2pIS3IyVuCY7etIJQKZUeoPOEOz8WhjXdUyktGbvKmLJR3UA1ouEk
	PSRfYIKrFGmJBKr+kbNx1ECIPVxnT03aYAJ1XZ0XDSVSBlzJwCnPRGc4n2NAFBQGJU1K/x
	GjmkZIegzD8zf3Y0+awRerHn0ayq/hJd10q6cq2MesXbGgG5EnZfWK/XIprFIcsvZ0nc1B
	rNb1dqWxo5r72F9tRyqvBRc6xQySlul7mKOQaTKwTPifwGnBE06nZYnMANsEob+HbYix7E
	3Xuws4H+hBs1e0J2mcIcpU4XuOgahkF1kfIDygPln7C3NtN5eUEHaHXfINbT1Q==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Guillaume Nault <gnault@redhat.com>
Cc: Oliver Neukum <oneukum@suse.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Loic Poulain <loic.poulain@linaro.org>, Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev, linux-ppp@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 04/12] net: vxlan: constify the struct device_type usage
Message-ID: <wcvz4nnmhiz5ktrr6mww5sjaxmr6fewjay3hjrlurlkeg3fcor@ntspq2qi2bfz>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
 <20240217-device_cleanup-net-v1-4-1eb31fb689f7@marliere.net>
 <ZdM+4uKE83V2j4o8@debian>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdM+4uKE83V2j4o8@debian>

Hi Guillaume,

On 19 Feb 12:43, Guillaume Nault wrote:
> On Sat, Feb 17, 2024 at 05:13:26PM -0300, Ricardo B. Marliere wrote:
> > Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> > core can properly handle constant struct device_type. Move the vxlan_type
> > variable to be a constant structure as well, placing it into read-only
> > memory which can not be modified at runtime.
> 
> Reviewed-by: Guillaume Nault <gnault@redhat.com>
> 
> Note: To help maintainers (and potentially reviewers) work please
> write in the subject prefix which tree you're targetting. For this
> series, it should be "[PATCH net-next xx/yy]".

Makes sense, will keep this in mind next time!

Thanks for reviewing,
-	Ricardo.


