Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0061CBE8D
	for <bridge@lists.linux.dev>; Fri,  6 Sep 2024 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623962; cv=none; b=hCclqJxzptbSs/Bl9iiw1F0HPA0WtsVqbl1Ddn1cylg1YmsIbwFz8pbHCCqq36q7MmmPuNsHTVBVm7wWPyUxHxVw4yVpFERIWbDvScFEntt3bQVHW+BCPOlCyaUJWGc3gUqhy+P55xKVBwfLOVWrcoY95qjw+WuwuzXO6w/HORI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623962; c=relaxed/simple;
	bh=0G0nIhs1bi5zMGUov/GDdwukKR4YYpCSt5fRVl7zUl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=L9ywFS5iZzLUJa53bGvugQumKTkHlYzrhae05Zsp0gT+ckQsXmws20bR64Y5Z7scHO3JbfvJSc99+QGRtya7pwubeLET3zqnvqqBo3R9CjNhAbFRrDJFjiaLHoM4DmqUG/E+d4pv9YerIE0PzCi8xlcWonyFbzJYGh4oMR7J250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBsrkHWs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBsrkHWs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725623959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0G0nIhs1bi5zMGUov/GDdwukKR4YYpCSt5fRVl7zUl8=;
	b=SBsrkHWsCOGQlxVhPyMHDXDGZ8kiTK+eG9zgYRAZXXz0bCx4IrEeFsvhKczPqYMgucRjZ2
	EhX8ElLzOdBVo81C/+uHUHtwe7I0gEiSZ2gxA1vLeopYlvKOtX2Wnpdv/hQWlNV1fl3bIu
	r2THp5EqKARhUDSNvqMFJURm1cr1E9k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-p38aw-_jNMeoQ-vcHgdvPQ-1; Fri, 06 Sep 2024 07:59:18 -0400
X-MC-Unique: p38aw-_jNMeoQ-vcHgdvPQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42bb2899d57so15594055e9.3
        for <bridge@lists.linux.dev>; Fri, 06 Sep 2024 04:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725623957; x=1726228757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0G0nIhs1bi5zMGUov/GDdwukKR4YYpCSt5fRVl7zUl8=;
        b=EV7/5y86CivW7gPGLFfAd0wSWI9l5slsKFNK7R+yhKNmz4uwzi9WvUswIeeig2DOqw
         oIROKpaegZy5JWkVg+eiToruM85YsqdnHp/jlK/25n8nT6DTWVHlFlaEWQhdGJuwJg7g
         oesah8PDlXyt1lG7dk/LUBYG+DVQvzmt7qoYTl19KI/JoqyjslV/PECXhMV87Gl3MlqY
         SoQaVvAzKzfX1kQdTggiZzLTkl644M2TLVoBpR8M7wXim8dYmDK14WnSVMfY3ZPVwbnq
         9PyZjvLsHVR0mR5JmMd2dBB5wx8e+L4h3byWfX0TWzrCz89GWPv+Cp4USmcwwAFVK00t
         7SwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+HOZoyBtqwexPuTytl7W9H0gIQXSmE26KMvWcO2E4/TJ5FozAe4o0Lkb7sisiZqpYT2zOT70=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywg+zKva0fqaa5GUKzAdBdKUkBUSxoK1wSt0BefB3m5P/IjMGcj
	tTBx3ZOCdx2ajsGFJs0bi9iNcJEWEcPMjjUIw+PQ0o7I0tJ34vq3VQ3ufi+R1NQyw8cBQtuxiPB
	hQG3YPqkz9cFOuwGlaM/o3Rf5sPLsxKiZidvaF5zALCIAj+GpgjROtw==
X-Received: by 2002:a05:600c:3c88:b0:428:eb6:2e73 with SMTP id 5b1f17b1804b1-42c9f9e0d14mr18589765e9.29.1725623957340;
        Fri, 06 Sep 2024 04:59:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYA3WJyXIhIIDEVufGNxXIOM6KJ1IZ7nsonG5drAh9teOtbcCOcgYplQPKS/qfufalrdR4OA==
X-Received: by 2002:a05:600c:3c88:b0:428:eb6:2e73 with SMTP id 5b1f17b1804b1-42c9f9e0d14mr18589465e9.29.1725623956763;
        Fri, 06 Sep 2024 04:59:16 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05d351bsm18481815e9.30.2024.09.06.04.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:59:16 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:59:14 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 10/12] netfilter: nf_dup4: Unmask upper DSCP
 bits in nf_dup_ipv4_route()
Message-ID: <ZtruknlefVpreVRQ@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-11-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240905165140.3105140-11-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 07:51:38PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_key() so that in
> the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>

