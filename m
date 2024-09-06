Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BA61C9EDA
	for <bridge@lists.linux.dev>; Fri,  6 Sep 2024 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621309; cv=none; b=rYCmLKldyrPcMMpdl7qZYhLRNrmeihYp2kyXq5qcOwCUMbNs4EkrVWSjZ/ESKpEplb8AMlAQBN8n0d9plK5ZOyLc41G1KxtCXsrxrBeP44xmHOW1oEpgV25DQ+1gN+qmkMQjgfHW1IEBxrsKDCJ+83FZUCJm0zGkpYzUbxmzr1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621309; c=relaxed/simple;
	bh=0NGiB9JCDYS9eHATqhHJptO0ZudgwqWhSFOBgZQcJOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ng5NDZPEHFGhna9AM3nSUUlu9QN3aO16meMTH9sg0vRAajggHrF4OSxFtca8qNWfUbhVqqGUMHjx35nao3CxCTxXsr1Pwyw3KIYRETMLeANw+OPRoNfU7EizDkjcd0rGJp1dGuMgrqnqf/OLfergqi+7GYA27cExrwT4NXzNrxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=COUiHW8E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COUiHW8E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725621307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0NGiB9JCDYS9eHATqhHJptO0ZudgwqWhSFOBgZQcJOI=;
	b=COUiHW8EvBM6PoV4HjoARUgXVCG8XhghMBYGkt0r0nkt/WuKC5Q3CTlQyr+RCtHgcbjBgY
	ZtfR4o1fq1mzsM8cOEusxr2Hnb07KxNSGoM/kMZ5zzcNRa8JSwMVvYdMWJKfNyAC/fDtDm
	i0MaVoPHx7tkih33Xod+z8+RYIglaDc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-FOZTuZB_MMWOpLUo_hLOjw-1; Fri, 06 Sep 2024 07:15:06 -0400
X-MC-Unique: FOZTuZB_MMWOpLUo_hLOjw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42bb68e16b0so19310205e9.1
        for <bridge@lists.linux.dev>; Fri, 06 Sep 2024 04:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725621305; x=1726226105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NGiB9JCDYS9eHATqhHJptO0ZudgwqWhSFOBgZQcJOI=;
        b=giE7IJONqYsOUZnXvA6PUgEsth1b5s/HaCp+uZdd9GTl9iM51OxlY1o/klSPPb6rjq
         JFSgsrXOz0HiixnneZM4CK0RoHReAOaOsoTOI0ooZo9PwxLa6rGA8nu2rfxMlE6Tv0va
         URpsJl4Zk6vHw1ulL7QYVdpZU+MbJtQWUcOIUkf6mKs41PJr+gMup/ZzpYYeThpt5HZc
         j2xyMxqz4WiP0uX2OGNDEHINvMxXZWIgOu/i1ZnUcQrShQwfAFHCLtWsNFBU7FrKFWGP
         qSjHwz8wdf03uiSKQ/Pau4QPIhY1EHIQFylSdesSalQb59g49QwI1tIhBDTN2hNTGrv2
         O4hw==
X-Forwarded-Encrypted: i=1; AJvYcCVCuuk64vwWfAwcC0K4rnnJQmFOv4NcnpRirLMei0tHqNSJIOzypuBI21RXzA5MK36nejdzsTk=@lists.linux.dev
X-Gm-Message-State: AOJu0YyqZLRBU40vtXM0TqpSLzi7o7Xewegj5XXACvXq+huaTMD/pDWj
	Osiu3nFV90pf2yLgBNX2ej6GsSl3TMQkFrventwkAYTS/+nki0ryi/71ZxOEtaJQLmwznmiS+sw
	Q9Htk/CtzP/QGRV32FSnih81FhXPwQ9sAIMWrvGl972fM5LWWiABXPg==
X-Received: by 2002:a05:600c:310a:b0:42a:a6aa:4118 with SMTP id 5b1f17b1804b1-42c9f98b4aamr16076015e9.18.1725621304842;
        Fri, 06 Sep 2024 04:15:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7vCxT8H4VqHEs2N44xCaNM+DluDvFbOAReI6BECcPwvJ8SnS7DtqOd/aYseydN9zLNtq3KA==
X-Received: by 2002:a05:600c:310a:b0:42a:a6aa:4118 with SMTP id 5b1f17b1804b1-42c9f98b4aamr16075695e9.18.1725621304232;
        Fri, 06 Sep 2024 04:15:04 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca8cebd35sm660405e9.0.2024.09.06.04.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:15:03 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:15:01 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 01/12] netfilter: br_netfilter: Unmask upper
 DSCP bits in br_nf_pre_routing_finish()
Message-ID: <ZtrkNbZcjQrUmdcC@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-2-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240905165140.3105140-2-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 07:51:29PM +0300, Ido Schimmel wrote:
> Unmask upper DSCP bits when calling ip_route_output() so that in the
> future it could perform the FIB lookup according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>

