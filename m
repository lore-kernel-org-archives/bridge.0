Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792745274;
	b=jMqscQ05Dr57ltFl/1UsOYbYE0+8G0dCb5TAollH010kvSB5qvUxePaOzqDqUcP51Ysp
	 7PjrBCqahIlSpB0OQ1moPVggHzY2IoM/4zr3+WG6/ChVVzWXOvo9ScbVgqVk/I5USSqfn
	 56casJ65gIz9XgP2TcEBLSE1OAob4E44aBLjrKzjAmHAe95qKXauextxtnub4GpLRiwwR
	 /wB54+7kWqghPsYt/OXFDuuL3B9w8/3367H4ajdCpD8dMJFL1ofFyNb0kMPfeq2Luif9u
	 2ftQWMWcaFJQUFzG08BtHDWRHime78xdxztujhPGEJHhCcKGqbJPinah9kIUH8s4vpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792745274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type;
	bh=mcXosW2OV7Dzgaxf9eJAPNhpQPkL1o5sHEtJNdoFfAE=;
	b=amxg9VTtz9j9ro7qIFaC8uQwS8uFJc90Nt4kvq/o9Xcn9um3d9GvedTeWmtJltOo/IZU
	 w8x3yT0g3d6Ui2myjGuMB0wneGoD432tcfyLfL7ZIsKComUcvDV7tDcTJ92XN0sXehe6f
	 8H/eUlCO6pgaiDcrz+073vHE8nStzPC7XxqSOdatXYezyXY9zqAg7Aa/z+3LWHo6TK0Ym
	 OA5ZBFixqvo1GTPC8ZdjE2KZUxRfpiDNAfoR+8US/cX+jaZ84KIn42d3XmRzQmSf1xrTu
	 CU4hyvexTXmYe6Rrf7oFFU+SwhX07LDHUdB4paed5k/8IFHLh+2qvOdy1ghHATGtnaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=waldekranz.com;
	spf=pass smtp.mailfrom=waldekranz.com;
	dkim=pass header.d=waldekranz-com.20251104.gappssmtp.com header.i=@waldekranz-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=vRoFovUL;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1D4606A31A
	for <bridge@lists.linux.dev>; Fri, 23 Oct 2026 08:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB1D4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=waldekranz-com.20251104.gappssmtp.com header.i=@waldekranz-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=vRoFovUL
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b2232d8ef5so948098a12.3
        for <bridge@lists.linux.dev>; Fri, 23 Oct 2026 01:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20251104.gappssmtp.com; s=20251104; t=1792745272; x=1793350072; darn=lists.linux.dev;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mcXosW2OV7Dzgaxf9eJAPNhpQPkL1o5sHEtJNdoFfAE=;
        b=vRoFovULeYLCqEXSywixN+mTSCOzuZrWsjS9eGD8xW/FtU3QwhTt0Yk/WrOqIfpcjH
         6yEz0kt7C4LNTd1S2CzrUxd1ly/xE6hMfGcUVYPToinD0jINeVB+P9Y5AuhJwsj4hTMO
         9TkquJ5YByYz5LRPgtX6kVf50H0hFUbsKZ66doiiNbGEIH71Sg0iWggvqao1c4kAe+We
         YI0k1MQFfpjorXY2K+3qohRUMgPHsK2XvyhnuvEMDEoDT9KxAhtuNPF+okPCyEhP8Kfi
         6NZC5caPz3DHX6cRv69qIIdmwWRkNN5DWFcxR3UkrQ+bi43r/ciVf6CgPf0iRlKiK87C
         sJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792745272; x=1793350072;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mcXosW2OV7Dzgaxf9eJAPNhpQPkL1o5sHEtJNdoFfAE=;
        b=Y9ery0u7f4ga0nL11Qg6xIQIK5MubQOV9aji0v4snu1agmCX/oExG4e3lix5kKlhMw
         ywW8LXPyhIjybhIGEGRyiDTs7rsw41CrQV23aKYGJtCE4HSekwUPttnWnjjzURjJomOD
         15keiDxMxzaNUpVjmyFFDYKYuRcGN2FKxzd6kQqw9NLgvs+1ZhPrvpxhJnwGk5ybJEMW
         VmT/H95OC8mIQQdqw+p7IHkT4hfmIqfl3oVxli6ax5jqWTT7yXYOKtpJqYXqZWCJKChN
         C22QsRb9Abqx+SGYD8uf5p9Ww2ZHU53j0eqUA136tTOyxy+zq0FkdZ92Q4gx8z7rIgVU
         mgOQ==
X-Forwarded-Encrypted: i=1; AKwUvBxL5HYs8PuFjPZRE3475FiuM6eonaW81j7J7zJFwq0twJEyWu2tqg9hZLPUqs1ncaE9HvYrJKY=@lists.linux.dev
X-Gm-Message-State: AFq9FYJNSRspzjDc/T7tHiCW4CnbctHOVIm5dIGdU7muRXlN/7JFJdyg
	NDEokGn3CnX5WyioBpqSnrzGZJa7bV9dhDxSNtW55B6htUxCU+eJV2/QITrFVEmeL6A=
X-Gm-Gg: AYBFou2Y9XXkwYt9rJf9IJxcaW1TyjbK3LWmwWtBCgiKMDvFSQ2OoOaFWG3wLzgQGeS
	fiozGYt2J49lm7UhBpt9kV5dXLKMNkt0mzLCUZ6EXUBhF1lIptDqngSJcYZMI9D2DvArPZPC3ci
	wfCs3eshyz3+iJatQh4DMPejsBVlywFKE0LF6Bmb1+0VZpOoBVmynuJ5FSp1KwOelc8IfXsX8ND
	iXhj/b+DcBRhBwKWl1zKxycM1KMLvUhh4XILt+VpWQrIR3wcmDE2GX6dvnX+T0OXK8Omte1JdzR
	2w4adJ8+zexmEyMM9bEVoPqr10UrOPmpAjumHJpSllKLbBKjNOeE/MHnOi06C1SXfnOWkFBlsbL
	LbxyjIgfZsa9IZdwxVIIoANi8XiA2gHvFpQTadKJ081O4hR4v7gTVHTUekqJ7q3aHRg7kD/XWcn
	lY9FIdkQv29O7O8bZMC3uDIdryCxi7+gr3wX2Scy6hOR7ZGYONnyW3GIRln9HYbwba0ZcMzspk8
	NeQ9FEd6E2/X5HaT9XzIBSMJ6TXzSL7hR2pHtycP/+HOwoGzICl/vvOXvG9VOOzjsR01JO24oeK
	ecFYf8d7TrS0j9WzwqWSW9g5ilR4l8uRG4Yga4TFWxfPczuqx+Otj5CbH4+UMS8mccvIyNamXje
	adfTChs3qGdfVZTY=
X-Received: by 2002:a05:6402:5004:b0:6aa:9284:9a99 with SMTP id 4fb4d7f45d1cf-6b432b14825mr2549227a12.6.1792745271895;
        Fri, 23 Oct 2026 01:47:51 -0700 (PDT)
Received: from wkz-x13 (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b432cc9775sm840508a12.28.2026.10.23.01.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:47:51 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Cheng Yongkang <teel4res@gmail.com>, Nikolay Aleksandrov
 <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: do not bypass port state for MST
 without VLAN filtering
In-Reply-To: <179268538303.70821.3493915601694605045@gmail.com>
References: <179268538303.70821.3493915601694605045@gmail.com>
Date: Fri, 23 Oct 2026 10:47:50 +0200
Message-ID: <877bj8iz0p.fsf@waldekranz.com>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain


Hi Cheng,

On tor, okt 22, 2026 at 08:26, Cheng Yongkang <teel4res@gmail.com> wrote:
> br_mst_is_enabled() is true when the bridge MST option is set and the
> port has a VLAN group, and nbp_vlan_init() installs a VLAN group on
> every port even when VLAN filtering is disabled.  While it is true,
> ingress treats the port as forwarding and egress skips the
> BR_STATE_FORWARDING check, so that the per-VLAN MST state is enforced
> instead.  That state is only checked when VLAN filtering is enabled,
> though: br_allowed_ingress() returns early otherwise, and
> br_allowed_egress() only checks frames that were VLAN-filtered on
> ingress.
>
> With MST enabled and VLAN filtering disabled, no port state is enforced
> at all, and a port in BR_STATE_BLOCKING or BR_STATE_DISABLED still
> forwards traffic, defeating STP and MRP loop protection.  MST can be
> enabled in this configuration, since br_mst_set_enabled() only requires
> that no port has a VLAN, for example with default_pvid 0.  In that setup
> a BLOCKING port kept forwarding broadcast frames while MST was enabled,
> and stopped when MST was disabled.
>
> Commit 8dca36978aa8 ("net: bridge: fix use-after-free due to MST port
> state bypass") stopped this bypass during port deletion by also
> requiring the port VLAN group; the bypass itself remained.
>
> Also require VLAN filtering in br_mst_is_enabled(), so the normal port
> state checks apply until VLAN filtering is enabled.
>
> Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
> Assisted-by: LLM
> Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
> ---
>  net/bridge/br_private.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index ff746f036f54..85065304597e 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -1953,6 +1953,7 @@ static inline bool br_mst_is_enabled(const struct net_bridge_port *p)
>  	/* check the port's vlan group to avoid racing with port deletion */
>  	return static_branch_unlikely(&br_mst_used) &&
>  	       br_opt_get(p->br, BROPT_MST_ENABLED) &&
> +	       br_opt_get(p->br, BROPT_VLAN_ENABLED) &&
>  	       rcu_access_pointer(p->vlgrp);
>  }
>  
>
> base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
> -- 
> 2.34.1

I suppose the other way to fix this issue would be to require VLAN
filtering being enabled in order to enable MST filtering.

From a user perspective, that seems natural since you need to associate
packets with VLANs (i.e., have VLAN filtering enabled) in order to make
any use of MST filtering.

From the bridge's perspective it might be less desirable since it would
mean that the two options would become entangled - the bridge would have
to refuse VLAN filtering disablement while MST is enabled.
