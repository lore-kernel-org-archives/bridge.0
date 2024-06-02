Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425903D0D1
	for <bridge@lists.linux.dev>; Sun,  2 Jun 2024 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717336210; cv=none; b=VBr7DI5x0+Exie9j6NvxO7GcUpahWKiw1s+tZCDn0Xj8dn4k0Dp4nJnFOv77vdqQa0HZ/X0N0XAUoppT7gwo6U3rJIY1jb1N/KuuS2ilE78WocDszlP2r1hPKAcin+KBb54GbECR/oIFOfmZ1+NKUR1w1cD4T+kxH1UYxuWVBj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717336210; c=relaxed/simple;
	bh=RRz9TLvLdNYU9kZYBkqdH96oTN/q+RzbkWenYQGTsXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gEggGomJ+TQ6Bn8T7UJQ/b8GWfnXuCRbtCVvKgou6wWhpuIFhiesTODfxemrL+MmRkT4DjuN6Sn6XGsg+3QEI8Lhq5gtZPr6+GCWyj4rxxIPCD+azM2Xt+B/r9y9YRm666xIDxhiQbFdtXY6lykhRiPIr6o7qzvDiug7Xld5KJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=vWgzE0ds; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="vWgzE0ds"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52b9af7a01bso15437e87.0
        for <bridge@lists.linux.dev>; Sun, 02 Jun 2024 06:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1717336206; x=1717941006; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WgucUj/3Ko+mub3oS+UVl4puHDskyniNFtly+3QQjXA=;
        b=vWgzE0dsSkIXQfBNTXt2qzGFTDQa9clpmdGghZyvfkh+cLiBVaj0/YgbDdybNYRIiH
         Q4EJ9qGPJNhnwIrEXfE31wBfyN2VTh1qeiQRMSWRmKXna8oAj1YI+FqFUxe8XGEuEyUN
         SJTZUf9O7idE3HGcZVUnCokTSsdOAr2Sv1zRliKk8TCnYbKcX2n+lMVF5sZUdUSomVpY
         Z94lqnX2A6E2ivh0VRCSPEDATIK44OhCQZ9c4s5KbQZDY6WHYVGQiVl4FCCFHVBAzJiR
         YiF7SPpj3eL6NMjwOCDeMIBsotTvvSQ5aD83NzMeRklV25FNkD32aRrUYxNMnC/qD2rF
         jVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717336206; x=1717941006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WgucUj/3Ko+mub3oS+UVl4puHDskyniNFtly+3QQjXA=;
        b=NMZM/uyX1arGFa4upeGE++W0a39TH0/9F79BMlg3bUaVEDe0TNZLb8S2YU5HJ91qsj
         Vh7Fpl0Hze+YsRDxxe2yQ9eUzMGqZ5j4eXt0cIaFBJUbDfL7Rk8ANHY6HDogrbZVFGAS
         7525f1d6MevkxOXlZO/JVBlmSCXp2X4LlCbUriuQ1zN65m0/jbdUL6SrPuAZOCdLq9IF
         EqTdRweWMexfqZp9uekvPDNB9vkpBDIO/LhjMRBL92RgO/YAGUINt7zl4muc7ERnxdlf
         8TfiZ41K34pI8+k7bkBhOurVfkXQLQgFGmnY7facnjXCZnGXmywVqL5kHkUSARyOMBEF
         YfUQ==
X-Gm-Message-State: AOJu0YxkDwfkVsp2Rn+6k4ubzSeUlqTfXjsg79WpjqD3CmrOj+j4tpUM
	1kz17TfKymUQcjXtH4RCfbbQRaFGuZYgSdjfih+X61bccDOGWfp7g65y44JEKvM=
X-Google-Smtp-Source: AGHT+IGGAzLz/AvRTfuiPc7HwIKoVr/r+Il2Nn/+u3zi39STxi1U10wu83q4W8KbUmYeBoHmwsP9Dw==
X-Received: by 2002:ac2:4d92:0:b0:52b:3f91:fa62 with SMTP id 2adb3069b0e04-52b8958c003mr4856099e87.30.1717336206067;
        Sun, 02 Jun 2024 06:50:06 -0700 (PDT)
Received: from [192.168.1.128] ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68bc97be38sm194986766b.208.2024.06.02.06.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 06:50:05 -0700 (PDT)
Message-ID: <f12dfc61-2957-479f-9237-58c8374bf42f@blackwall.org>
Date: Sun, 2 Jun 2024 16:50:04 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bridge: fix an inconsistent indentation
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>, Roopa Prabhu <roopa@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org
References: <20240531085402.1838-1-chenhx.fnst@fujitsu.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240531085402.1838-1-chenhx.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/24 11:54, Chen Hanxiao wrote:
> Smatch complains:
> net/bridge/br_netlink_tunnel.c:
>    318 br_process_vlan_tunnel_info() warn: inconsistent indenting
> 
> Fix it with a proper indenting
> 
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> ---
> v2:
>     add net-next tag
>     modify subject
> 
>  net/bridge/br_netlink_tunnel.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
> index 17abf092f7ca..71a12da30004 100644
> --- a/net/bridge/br_netlink_tunnel.c
> +++ b/net/bridge/br_netlink_tunnel.c
> @@ -315,8 +315,8 @@ int br_process_vlan_tunnel_info(const struct net_bridge *br,
>  
>  			if (curr_change)
>  				*changed = curr_change;
> -			 __vlan_tunnel_handle_range(p, &v_start, &v_end, v,
> -						    curr_change);
> +			__vlan_tunnel_handle_range(p, &v_start, &v_end, v,
> +						   curr_change);
>  		}
>  		if (v_start && v_end)
>  			br_vlan_notify(br, p, v_start->vid, v_end->vid,

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

