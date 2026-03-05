Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33E4217F24
	for <bridge@lists.linux.dev>; Thu,  5 Mar 2026 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772717389; cv=none; b=SV6QNviWR0FniVTPs5fTW9qYORQTsVsbTQd21JF3xcOnOUcDT8+ex1v2yUHejYFO88KfaT6JCZMfCIEkU4MoAoDtXRMce7XjwSeRS+Dri+U/dlnc2RSqFLaEmhxGe9lB+PM5iW2ibnGIlHSNJq/6tEoA9mpqhzJEPQ3J58tahsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772717389; c=relaxed/simple;
	bh=2O9r9LDXDJj803X3puSuwhl3cSUwWHVBg3YhINrdJqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMJuOl45CLLdstnWNkeh4qrlwFzZmkkycnUaaiFwZPit2fUQMtRptfYoqKsb8QoNGuHGnoDAAtZmiEGN4Wh8O+8Hwwwi7MqkT3yZ0X7FrogUHk6Nrt2oaTmy7ZOEdpV3XdPOkM/7kGM4S13N5ZOA3jETqjNmpZLe+rTA3grXnnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=JQVszcjV; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="JQVszcjV"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b4520f6b32so9193138eec.0
        for <bridge@lists.linux.dev>; Thu, 05 Mar 2026 05:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1772717388; x=1773322188; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W2UUm8R+QueyEkOcuCPbcorlCWNYx0VuCk3zns3tCYI=;
        b=JQVszcjV5zc4Oijkv9K/ueX5WCz9/0fdwGNQTkMtuyph8k/o0TYoSzcuCWFdQZmcTC
         R6vUHywhCLnkisg62FKtvLVhTmi28/tu//GduifbB3I7ENTnovnpNE9mfMoP+9e8DRTq
         Zohz1jrPA395JI/8WpnKYp+T+yfqTkg9z5GW96qUoQeSq/f6tNjNsNPOKjQtDOklQVRc
         8quNEYD488XVtjC7CDxUAfgAd0v061t+kYa5NrNB0wy+m+SbieUsCzMZBGF0gjsblBVe
         psYkFjCEDhM7U2IHaU8aPn0K+eEX13Q8x9y+OrXtV24bGg9Vfe1sGWNNj/jaH10WqcdI
         E/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772717388; x=1773322188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2UUm8R+QueyEkOcuCPbcorlCWNYx0VuCk3zns3tCYI=;
        b=oc9oT2cYf81pfQbtnprSEe+e8Rtqex4W53jMOvKpvAUOh7KDhao7UCqfNV5mljBHuS
         cTJuYadoCMX4uYF9KYx8ewqit/E7pJlYgdkS8dWGs6ux0F+GMypi9TMLmDOsyBe+EEFz
         f/Zvc/6dh5QZe/MZdwfORU5tg2jAJPVnqmicKRxFmAEXMFWOIFwzQF8qAojyJh720Aod
         tfQD3PCkOH3CLFn8Xcp7UjPGFI1e8jEi0PwDY52kPv7h+ornQX7NDUFRTUNXeiVCcTok
         oOfCKBh3xdKbth78SbbqK6hka/IqMnV/6hNggeXflffGCIwo0gCdnmcmSTsxdoBMCbJQ
         Nkuw==
X-Forwarded-Encrypted: i=1; AJvYcCWV0WfxV9OZtuf/Ls9ojIk16LBnJ4VIFl8Z/I1BLO8Lm8qbCX6yU8BMy0v++GVeh43jb0y2R6s=@lists.linux.dev
X-Gm-Message-State: AOJu0YzXYHCZR25X5z0e6ySwhc74ix4zbP0SfKXjY9AY8EOeZ/VfgFq4
	0rJAoQZJ4QJNWz81zFztbuveU2JG3DBNNiXwDMrOoOZT7ifYQc7mZXP+XO62t2/vxlw=
X-Gm-Gg: ATEYQzwr+S0k0zXGo30zergpHnvxGtavmBODxIBOScSJaw9E7fri664JPphK5pEWgQt
	oJEcNEPX7n8fBSnIpoHNkNFGKBRVuJVk4U+uL861FrUQOTAY3VLNe9zQ2QhG9hwlwbZ6nm0NV8I
	D41kHJ5Fhsvc4hJZsrNaXcYJEqISaBbHbbeLB2ogYstVCqKYWzq/dC+WIymXnNA/luExtjUqN+t
	PBQrcixyn3Vf3Lq/wFQZ2UqKp9C49iSAm1wDg1NEKCiqEKMR0CgCgvkPG1nQ0/tDiQSClqyXgw3
	JxRJ6lUIcW8nCmrYu0aywMmRj0yUx6gFK1dXv5xoaRiYM+xSMu0ssC5hbVHX6nsiKHOmlne8rPm
	V/BH8jJVVhuQjzvoyW7s052GO3Y/h3b3bfvU9OmroapqAGsZaMzRtlWqpEXPX4/VWtmlI9fdkAj
	28XvZ+ggsxxGFa0l7HS86S
X-Received: by 2002:a05:7300:e12a:b0:2ba:9835:1113 with SMTP id 5a478bee46e88-2be311c7211mr2339685eec.36.1772717387580;
        Thu, 05 Mar 2026 05:29:47 -0800 (PST)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be1281ff70sm10108869eec.14.2026.03.05.05.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 05:29:46 -0800 (PST)
Date: Thu, 5 Mar 2026 15:29:41 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
	roopa@cumulusnetworks.com, sdf@fomichev.me, petrm@nvidia.com,
	horms@kernel.org, idosch@nvidia.com, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, Guruprasad C P <gurucp2005@gmail.com>
Subject: Re: [PATCH 1/2 net v3] net: bridge: fix nd_tbl NULL dereference when
 IPv6 is disabled
Message-ID: <aamFRR3rfa1TlHEF@penguin>
References: <20260304120357.9778-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304120357.9778-1-fmancera@suse.de>

On Wed, Mar 04, 2026 at 01:03:56PM +0100, Fernando Fernandez Mancera wrote:
> When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
> initialized because inet6_init() exits before ndisc_init() is called
> which initializes it. Then, if neigh_suppress is enabled and an ICMPv6
> Neighbor Discovery packet reaches the bridge, br_do_suppress_nd() will
> dereference ipv6_stub->nd_tbl which is NULL, passing it to
> neigh_lookup(). This causes a kernel NULL pointer dereference.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000268
>  Oops: 0000 [#1] PREEMPT SMP NOPTI
>  [...]
>  RIP: 0010:neigh_lookup+0x16/0xe0
>  [...]
>  Call Trace:
>   <IRQ>
>   ? neigh_lookup+0x16/0xe0
>   br_do_suppress_nd+0x160/0x290 [bridge]
>   br_handle_frame_finish+0x500/0x620 [bridge]
>   br_handle_frame+0x353/0x440 [bridge]
>   __netif_receive_skb_core.constprop.0+0x298/0x1110
>   __netif_receive_skb_one_core+0x3d/0xa0
>   process_backlog+0xa0/0x140
>   __napi_poll+0x2c/0x170
>   net_rx_action+0x2c4/0x3a0
>   handle_softirqs+0xd0/0x270
>   do_softirq+0x3f/0x60
> 
> Fix this by replacing IS_ENABLED(IPV6) call with ipv6_mod_enabled() in
> the callers. This is in essence disabling NS/NA suppression when IPv6 is
> disabled.
> 
> Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
> Reported-by: Guruprasad C P <gurucp2005@gmail.com>
> Closes: https://lore.kernel.org/netdev/CAHXs0ORzd62QOG-Fttqa2Cx_A_VFp=utE2H2VTX5nqfgs7LDxQ@mail.gmail.com/
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
> v2: use ipv6_mod_enabled() instead of a null check and replace the check
> on the caller
> v3: no changes
> ---

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
