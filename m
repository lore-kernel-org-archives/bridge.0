Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B453F1C870E
	for <bridge@lists.linux.dev>; Fri,  6 Sep 2024 11:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725622726; cv=none; b=TigLRIZr05/k9wc1dcujtqNvQayWMgVxqkFItwaHPVvbke9AFtikmULyeV3tp8ikNP7K/sBOaIx1fMbUFZhYAVQzVPAf7PRNSeIBnhsZOUBU3j5l2+PCHBPKfSj/IJTR1fc3ACa7g0c7lKk7i9RpQrztf4x31v3dLD7v1SSNnaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725622726; c=relaxed/simple;
	bh=3OSEMPeLSNHVCNVbKv7RAO1iD4GGzvlj38LVpMDyE9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JJ2qZ2VwwUbXQZ1ElxpDlXo5K292pcRIZhWfjp8KImTDinkVO6RoVEHWj9WKcPojtZQw+1cRqOzhkee3fxm0ID9sKUc8IE0F5PmlHIwrHbvZy67h7AtHnGIURrSxZ6CsPHyKyAeGY6mDxlycw8q2Eg0EMGrY18gVM/6rkZIRiiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MUC0LdfC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUC0LdfC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725622723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3OSEMPeLSNHVCNVbKv7RAO1iD4GGzvlj38LVpMDyE9k=;
	b=MUC0LdfCJGegurNSIdIVubx1QqLouozMvJH0++/vPLkhwDzmTYZRDJSFtDZXf1m0Gaogz+
	3XXbwGvrmEwEq497T/FyjjN79+2taZ+wI7nvvqZ4WAlDl56PnI0GJeYdhUKQ8vHOYrRHPb
	QTjZnC8luccKwDAjwYLLWD4Ub8EnwQo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-ObyZN5-COeGDaFLRduxttA-1; Fri, 06 Sep 2024 07:38:40 -0400
X-MC-Unique: ObyZN5-COeGDaFLRduxttA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42bb6d3cd05so15459875e9.0
        for <bridge@lists.linux.dev>; Fri, 06 Sep 2024 04:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725622719; x=1726227519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OSEMPeLSNHVCNVbKv7RAO1iD4GGzvlj38LVpMDyE9k=;
        b=b8MJPRqriNGDHn8Jm2LTBIkb2iYM12a07vodglxaaNsrTF3eSx/oOUke8HTvR/8qyY
         cJf5d+Idv9mWtf95nWR946I1JNZx3o6dWwe8yi7d/MqIuM/OI+Itqar/IaLSscv5Sw9b
         DmJmd9XvZRT2vEMoCJnlcgtN3jmks4XmcJp5jfUagIe4+cFJFXQv8gC7OHNz32nl9qo+
         Ykp/ahm+qfGVO8WYeiWGsk21myhVlCgXBakJGDx3IhOqVnfV4iAcCmP2muDRMK9voe9p
         8xhVtwOEQnq1+90/XKeprRhzrPAjBRQEnA82BOxKNJvxrSVAGdfOWqVY0cno/v3sb0/U
         6XGg==
X-Forwarded-Encrypted: i=1; AJvYcCVOMPEtUcapl27oAU/a8YRlnmq5KNleAnSTq9lQLYhj77Drg7hrnBWIzXlD4Tgp+Q33IZZondY=@lists.linux.dev
X-Gm-Message-State: AOJu0YwKhwWL0aI/wK8ybeqWJrY++HGKY7UvwaYmgIFTSJ3/lhD7kZh1
	2MFxkpUNTfXz44RVfpxuzPqvoWdNI26onAL1k8tkWBjb9FRU6DHZd352AAWNPNpo6xV9SOYSkTa
	gFpg/G8ARhkpDW0+4TSt3ItCIcnWwAiP8CoUo3ythUiBpdhnSZ5vy4g==
X-Received: by 2002:a05:600c:1c1b:b0:426:641f:25e2 with SMTP id 5b1f17b1804b1-42c9f9d7035mr18302825e9.25.1725622719301;
        Fri, 06 Sep 2024 04:38:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuAsg7pwxpDVtdYJ/6+D+Ph/FNa76MdgLyOilEwQ/89LMv1D0nMU3M5+amZnhf14vF76nDJg==
X-Received: by 2002:a05:600c:1c1b:b0:426:641f:25e2 with SMTP id 5b1f17b1804b1-42c9f9d7035mr18302555e9.25.1725622718460;
        Fri, 06 Sep 2024 04:38:38 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05cc3dbsm17708455e9.20.2024.09.06.04.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:38:38 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:38:36 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 08/12] ipv4: netfilter: Unmask upper DSCP bits
 in ip_route_me_harder()
Message-ID: <ZtrpvGliOjZzPkyv@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-9-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240905165140.3105140-9-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 07:51:36PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_key() so that in
> the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>

