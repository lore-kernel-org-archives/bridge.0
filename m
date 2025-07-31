Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B872A15533F
	for <bridge@lists.linux.dev>; Thu, 31 Jul 2025 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753991919; cv=none; b=HtvoIN+Ls1zVcHolt4tNfjES72aB+D4oTzbJ6DDYqPedHO9SWxpzxVk2A8XcjTd0wIU0HewhX5VQ2leeOiUkHODWXjD7EvI2zVmBTkc/yRgmyP0BZUbuBCKWQVj4JGZRPXlIv8EfrgW22b+I1e8rDthSKnmXM4ODGUxjlgttp4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753991919; c=relaxed/simple;
	bh=VE3joiXSw99qAb6jVz6lsKUWuKipwIyRAFo8ArBr8qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXHcfEhCJEw3yXKmimYit7mQRm18Rz9/uPKo8XjluzvLBipDhDFeM7b/9Bp7mfssDFYAj3jKC+OiKINF+zeDGTpP2G091U5wls2v2yxFXSzoqocnG6YQKX2awfjfUMwZvTeEpV8Sh698OXy7Xnuk18Hn+PF2eN9M4gFTIXt0m2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-615756b1e99so248741a12.0
        for <bridge@lists.linux.dev>; Thu, 31 Jul 2025 12:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753991915; x=1754596715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOub6JEULz4NRTq/hirUiArEKHDk37KcHlXQ+q2/ZHc=;
        b=IKyOyD9NA3HWIwal2y3Bg5Dv7CW7M4R/fGIqOxHGkOX+3Ep2pFzPeO2GKwDGJcgGy2
         mJ+vpgnyRLaTKgGBa3salMzmpNoaqQzWGiUPHV3JQovovapgccxNW1xq1sfNojItLmWQ
         H1OKh4WtCp4Ea+bKt470vDsMg6HWYIOT3IZkngrwifWdUV+aJUqcO8i+we5iyaeyzZHm
         LrxUwZBIJLJVRqgGBzpEjGd3x8pI8f+PcR47VxLLI/EGW+0oYn+K+dRj6FpifBV5Lh8B
         4dHhcDikRbxu55c+3WbFGc1sG0uVjI3+te5DXdsua2B2LxxyWoFVoiS8d0UgfhqqQQ/Y
         4Itg==
X-Forwarded-Encrypted: i=1; AJvYcCWER7fC5UHkEUEBK++tXBSjSX0pKcOOUcHKXfz1zIfDOZmPplMCAdiF8k/ST4TfjToxePfnWAo=@lists.linux.dev
X-Gm-Message-State: AOJu0YxIQjBCuirpoiz3m9UsZylLh3Mya9OzHOEGHaw6/53IBAPG+lXZ
	CiuUcDrkVWBcuNQIdgVKSoEYdvVrB4ZVgJBb/fOldXwwv0jm7fFV1F1T
X-Gm-Gg: ASbGnctWlouoWKDhjDuqz/gCtB8L9G/KB9GEjNx4fRIomfW2NEGk9XjVk4B/QjI5GJj
	BVyDa4rKlOOS46hQxgUNct2XWmwHAhti53Mk/UNZxyrtlHYA07kwZL5DJKKkiSmHsSHMlF1yeo7
	6GrnxeBZEh1JaFmP7IuF2koFxhwYtbqXbhcSBsCd+YPON+iHNZk3+WMF4fDEZoPmIvOS9tMLHow
	2eJsE8R9yxETAL7psoYJlMXzJqZSTtKBRsPwvzciUwKkfnDGb8EcOyIwud9C7ztYs09IChMOfCr
	GxbmtEWjq5MF2JwCnR81dcVzrSUs2dY6VQk2omVd+NvXeAphv54a/JM7SxfvciA9OOCq9oasTFc
	gqjflVYqmgKbEIQ/R0YNZ
X-Google-Smtp-Source: AGHT+IHi5E7zdxk5Xx1zNsFA7iW/9W+ly6JoYYOQpr1wOvbx3PwGi79d4r5orR4ephm9fAhIPcGSfQ==
X-Received: by 2002:a17:906:7951:b0:ae0:c355:2140 with SMTP id a640c23a62f3a-af8fd9f7520mr1057608066b.45.1753991914859;
        Thu, 31 Jul 2025 12:58:34 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0766f9sm163674566b.24.2025.07.31.12.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 12:58:34 -0700 (PDT)
Date: Thu, 31 Jul 2025 12:58:31 -0700
From: Breno Leitao <leitao@debian.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@kernel.org>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: add back NETFILTER_XTABLES dependencies
Message-ID: <uadem53d2ymvjweqjdvilrpr2vwsfxu2gbwyaopacyl3x2zmhl@raeakspbvdiw>
References: <20250730214538.466973-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730214538.466973-1-arnd@kernel.org>

On Wed, Jul 30, 2025 at 11:45:32PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Some Kconfig symbols were changed to depend on the 'bool' symbol
> NETFILTER_XTABLES_LEGACY, which means they can now be set to built-in
> when the xtables code itself is in a loadable module:
> 
> x86_64-linux-ld: vmlinux.o: in function `arpt_unregister_table_pre_exit':
> (.text+0x1831987): undefined reference to `xt_find_table'
> x86_64-linux-ld: vmlinux.o: in function `get_info.constprop.0':
> arp_tables.c:(.text+0x1831aab): undefined reference to `xt_request_find_table_lock'
> x86_64-linux-ld: arp_tables.c:(.text+0x1831bea): undefined reference to `xt_table_unlock'
> x86_64-linux-ld: vmlinux.o: in function `do_arpt_get_ctl':
> arp_tables.c:(.text+0x183205d): undefined reference to `xt_find_table_lock'
> x86_64-linux-ld: arp_tables.c:(.text+0x18320c1): undefined reference to `xt_table_unlock'
> x86_64-linux-ld: arp_tables.c:(.text+0x183219a): undefined reference to `xt_recseq'
> 
> Change these to depend on both NETFILTER_XTABLES and
> NETFILTER_XTABLES_LEGACY.
> 
> Fixes: 9fce66583f06 ("netfilter: Exclude LEGACY TABLES on PREEMPT_RT.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Tested-by: Breno Leitao <leitao@debian.org>
