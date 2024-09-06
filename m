Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C821CC150
	for <bridge@lists.linux.dev>; Fri,  6 Sep 2024 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725624301; cv=none; b=QCDmpR3+9QYxksPdP2cAxQSU5Gd0EmLW0bTJ0TbptSEf1SboF8BXSEF8YTFkiN7aIZc9ezOxeAd1Q+mLjCSth6nrCi+90UDJGCSvScM3Z5lOsopchLD6+ruJ+wA0rsuqri5gnXbIkDe/XtpxC2J8F+mdBaPPUGtpnhGi9ImMPu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725624301; c=relaxed/simple;
	bh=tc07zvGyCiSLPaYrP+kQC7S675jJOEsGznL3PVrjuoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cSHr0TariqUszEAzQo+KeYsOjFn0hnAk3ezs7nlskM8kH800b3UR7JAMNZFi9PrMBjNhwc+SzL0gCADBjBvndJp3r67Kg41JTcH10RLZ7avn1ZVLGP8CI0AjdZcWyInX2pBH8u5oi/G9d+ydTJVZ53Di4uNOs0buedn4Yz+HVrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xd1/nlyA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xd1/nlyA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725624299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tc07zvGyCiSLPaYrP+kQC7S675jJOEsGznL3PVrjuoA=;
	b=Xd1/nlyAq1njMvSHoNJzifYGB1LHRVvaRYlUEPFakkToHsAU+Q6aXT4AIRJx6SzszoQlZM
	i8DFs3EEd4RCWjkiBxLNmoyJqVVhGJ6vsRijAieQdCT/B+c7BA32KugJJLdTmVJ9NZmNaZ
	lKTSh5VmALT+WaxeCLryAEaYxCgqsX0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-tnoC3BY-O-auAbM7SUIw0w-1; Fri, 06 Sep 2024 08:04:56 -0400
X-MC-Unique: tnoC3BY-O-auAbM7SUIw0w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374c35b8e38so1032281f8f.2
        for <bridge@lists.linux.dev>; Fri, 06 Sep 2024 05:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725624295; x=1726229095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tc07zvGyCiSLPaYrP+kQC7S675jJOEsGznL3PVrjuoA=;
        b=hWCKZpZYQyiV80smvT0GSyjeWV4XILsz+unteELutwKTAE4JwSjnmtsBnfOmXx9SND
         Ch12DhddtK5ut8Hd1H7U/FpVdFoXKa52FCH3ZE83cIqLIdi+sCl8F1Z+vkogP3uIznHB
         mvlh2+G3yc3ThT2JRrv/raLHfIThnyxWoHnVw9JvlF7tb7+HOFrDLC5T8/S8cE4eGlV3
         l0rLTQESs6tTdODbGOhLQPnLQZ1gWnzaRxdJxbqN5XUwgK9n1Wl3ImALQ6cGxKlA+HCf
         EGvtRKEYl5B9B/a+qfIsWsxdnH/nnUMsgg0XV3aGMWb1pGbXaJq1dP1HANaL1EG71DvX
         +FXw==
X-Forwarded-Encrypted: i=1; AJvYcCVTriJpB8pcJtSZP8rwpZjZ7EX3dxaqlbGRQy6XT2pLKczPJYzBGSB516op4/C08D+oCpJnIcQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YyNdUefMVfBpALO5VC8mKWhExfbTKxzwCDktZ/61Tap1i1cepZg
	eR6lqMcXAxxJbpJCCBKiSGbIl7ElJz5tDqnxD7M2GOZj2hlJxlhS19FBBiDZM/E/36hiQxHcHuk
	X6/WTmttrK3rQ4QQLjWjPgXMMY/6ujl1A/LSuwso3yb3HS22H6d0Q0g==
X-Received: by 2002:adf:f488:0:b0:374:bde6:bff5 with SMTP id ffacd0b85a97d-378896a3f30mr1662836f8f.46.1725624294907;
        Fri, 06 Sep 2024 05:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbR87w40KjGE1b97gvsYds4sMcM1bBpW/FoDG702Xq5HctTZU+3n1iB0oeDTTrGblPjEdGcw==
X-Received: by 2002:adf:f488:0:b0:374:bde6:bff5 with SMTP id ffacd0b85a97d-378896a3f30mr1662799f8f.46.1725624294075;
        Fri, 06 Sep 2024 05:04:54 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374bde83ebdsm16914774f8f.48.2024.09.06.05.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 05:04:53 -0700 (PDT)
Date: Fri, 6 Sep 2024 14:04:51 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 12/12] sctp: Unmask upper DSCP bits in
 sctp_v4_get_dst()
Message-ID: <Ztrv43ZxmgQRW+Po@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-13-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240905165140.3105140-13-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 07:51:40PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_key() so that in
> the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>

