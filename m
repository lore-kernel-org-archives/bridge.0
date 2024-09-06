Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483901C8FCE
	for <bridge@lists.linux.dev>; Fri,  6 Sep 2024 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631299; cv=none; b=FG4l1wMdBXd7vvF8rY4xpNIQQbr9/PbNtR718ZsHYlm+Gu/a5gj6olssCWj5ECJ3AaJH6pDPVkegtz1G5bnuikPCX2C9pe8r1C6tXO7zYpkG9e2ixeASN1nzNp3biSkLn20qFBnEHTUlejKByCDI8cngz6W+RqYprc/iDjnKhOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631299; c=relaxed/simple;
	bh=H9Qvvrts7066PRTQiTdtz7Ndcp7RKGYi8p8LT9X2boA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QeSRg1C0BKf67MrI9fCEhzTZl5eNFAtc2Mx0K5dvxRb3QgCP9l3Ial4epgFk13WgIAxRBgOVdyJDTV1R+DT5w4IhbfNQ9zselVc/caYYMomD4boRx0eWDexqIwa040+wsS6KuvqJYuUltYWhoDHnQGDVPfUk4aJGxrMuhyphzgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MMv/IHBp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMv/IHBp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725631297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H9Qvvrts7066PRTQiTdtz7Ndcp7RKGYi8p8LT9X2boA=;
	b=MMv/IHBp0+sgtSayIpCeaSYj22+gNT2RidcllNXg9f80LxaJaOhCwHomwR8AxHvhEK2//O
	ebD89rpgS/D8FlbGoEEuO1QQb3RNRqwRuU9zqoySOD10WT1v9TH06K1tYhl8yfc3ORVw7Y
	ShVBdtlPVJdEyjUzMJzFCrTZa5z2CoU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-sPwnW9sQOIegrtSS8bAeAA-1; Fri, 06 Sep 2024 10:01:36 -0400
X-MC-Unique: sPwnW9sQOIegrtSS8bAeAA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-53654420f0cso1945891e87.0
        for <bridge@lists.linux.dev>; Fri, 06 Sep 2024 07:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725631294; x=1726236094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9Qvvrts7066PRTQiTdtz7Ndcp7RKGYi8p8LT9X2boA=;
        b=vPE+NidSLc5MGmOo2jBiDmHT8LUQcgh0WX/+kWQFDsHcYsd1ignTZ9RBvN+haSD/AX
         he6yXF9jkSi5iX55PMLak2OTRZ9MY7+pFdR796CPqj/jpKR2/sfxrCAmC3qbJLCXBnaq
         Ev7m4/hfRp1eTfgVkkUBLLbLH24VgqGp3O0/X8YGKSSsm57rTyHOB/l9wBcCeM5pYIIx
         UqqxE29qgZ71UHHSnYc7PzPay9MPYqJ0nXCwlX9kalUHt78GKA+5eyzmrC9rIYWtL6A7
         mW7Sw4AMa8EJcVeHdLITCN4czgfhrJMD4FGkYRm78Nd/LZeDMxrxqcjK1rAAjnkpJguo
         0+bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTKafAx3wMcgMdW4UesaE5lXCN15UBT8MfsXHSp20CHxTcmRIQNkLqEqogRTcL4enSOZ73/Uo=@lists.linux.dev
X-Gm-Message-State: AOJu0YyfajpCVRfA42UCipCD0YqShalbM8I+n9BwtpmKxknZhg0drqqI
	oFRtUOM4vseHnYnXu+7VAXIzCRPBLmStvf+nfZ1Ed69px4n6p5OwZSOhm1nqyBUrQrXANIx6B6X
	reMRfG0rDRPYwlEXPyyJmBGwjEMmvTT62uH+av+Zr3hBygO3fU4EcNA==
X-Received: by 2002:a05:6512:b24:b0:535:3d15:e718 with SMTP id 2adb3069b0e04-536587fcf0fmr1730162e87.50.1725631294283;
        Fri, 06 Sep 2024 07:01:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESh5ryxYIDRtv0PMqngwp2r/5lvvEI+2l0OS3wHQLQGUs23BzE3eAyNjglC8gFpKq8yS+EfQ==
X-Received: by 2002:a05:6512:b24:b0:535:3d15:e718 with SMTP id 2adb3069b0e04-536587fcf0fmr1730009e87.50.1725631291471;
        Fri, 06 Sep 2024 07:01:31 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05ccc27sm21647655e9.13.2024.09.06.07.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:01:30 -0700 (PDT)
Date: Fri, 6 Sep 2024 16:01:28 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 06/12] ipv4: ip_tunnel: Unmask upper DSCP bits
 in ip_md_tunnel_xmit()
Message-ID: <ZtsLOBY/jZi7rrvT@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-7-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240905165140.3105140-7-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 07:51:34PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when initializing an IPv4 flow key via
> ip_tunnel_init_flow() before passing it to ip_route_output_key() so that
> in the future we could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>

