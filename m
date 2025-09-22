Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABEB2F0C75
	for <bridge@lists.linux-foundation.org>; Mon, 22 Sep 2025 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556284; cv=none; b=mNALnqPExxXn6iQFyaeThJEaJ5Np1RbkC2Uopmifz6pDUpL0PgUmF1q/SkaqwfT0SLoaW/lY2Lt5S4dDL4IWmNIfTJIFHPb2zp/9zd8Pgm8WNeucnjBeO/j0QudafDZIUVUWoJdaCsiqNkVWo02/aSJCESRp3Y7FnwHXe9gNjIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556284; c=relaxed/simple;
	bh=z7rS/yxJoUim+mzpgAuctY4+g4cEAbyz7OeFTKQCvw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQJFlESO9bshnom+bIkORrxb3Mt9Us8974qGSojQbSPkFyNPIXKqBoIkimwornIURb3ZKOb8k8QcfY/bvfbZB2I2Jv/asxqdQel2sgoSPHwHyHvuxYZ1VmUcCPtAqAyN80rBxhXo2rJejbmlZUg27aRvvM3QwQ5WPJPVBuPj1Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=UUtth9cS; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="UUtth9cS"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6B76440606
	for <bridge@lists.linux-foundation.org>; Mon, 22 Sep 2025 15:51:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6U4lrYi0189Y for <bridge@lists.linux-foundation.org>;
 Mon, 22 Sep 2025 15:51:21 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::130; helo=mail-lf1-x130.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 34AA8405D9
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 34AA8405D9
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=UUtth9cS
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 34AA8405D9
	for <bridge@lists.linux-foundation.org>; Mon, 22 Sep 2025 15:51:21 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-57e03279bfeso1814183e87.0
        for <bridge@lists.linux-foundation.org>; Mon, 22 Sep 2025 08:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1758556279; x=1759161079; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KI0wiNUU9HxQFHxRzFr4Ntsm60rPJwqbW3BoojwKVFg=;
        b=UUtth9cSUO8L64nPGEvwNbVcENb3wPumMIyUF8EoncWeDGnIaMTz9vrqUpLUptQXmu
         tbrXKhZreEip023oaZ80+Ca3FIl2FtVWJd5eKWzZxaxEvDs3vOPqaNFh5E6DHDxv80j2
         /1rtp+ndCadlAXzCbO1185ME6OaR/d52g+LqGHjEzbqeinPKmTSO0SqEA6Mz85JArHU3
         ASBJEzwUG5DaX2Lxrtecn6Px1IxMGQjGw6v7R3EZUBVM+dOFdnrIUbgTUBo2o2F7kNBU
         f6pmg4/SbSTMQ9qSXwZNzoAs7b48LhJghM6sy1cNh0twcpbolPr9jq3QHhx0xgEZ44Ua
         gsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758556279; x=1759161079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KI0wiNUU9HxQFHxRzFr4Ntsm60rPJwqbW3BoojwKVFg=;
        b=Nnj/qNqP/9VRTLYfFVKWcv9ZbserT3xpuG3CxFjAXo9njrqrKRVvp6x55z5Ev5obzY
         40XO9XIlF5NOUjyH4KTa8S98uiGDGgofpwMw5XAqJ29nJnnM4EuxdUi5bkGyKyG9bVfr
         j494KUpLVGcx6xU3AXli4j4GYkEI67SWkvsaQ+QQ6AzjR3jLgxdDKcn1Jf4wvRA5lMiU
         87B6FpOkUDobpfS7Th/lVLKxliMy1IRFkfzu20Jz4DQAo92GdeK+80gAF78JWb9XWYs+
         fZjYqIn3Vv5iQw3jgzOFMUqkqlme/wKZsiPgSPwIBWKhCK6AW6h8OxyXi/sX0zDpDtc8
         btRw==
X-Forwarded-Encrypted: i=1; AJvYcCVBuLENH3TuV24s+6FlLtqUZw8Ttp2Dl12ZqrsbobfzlkFvClTlDmsuEX/sgnRErnCscFR15Bw=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyUWyhzkrWTFH77TKBvWeqcfICXr+siAyp6mjGJtewJRaxCt0B+
	jPiOb+tvqM7I7SIfxJSrtxqCl/S8cCM2J0umemuw9cXMG4Wrg6GJfJr6SZoD2ScC604=
X-Gm-Gg: ASbGncv9MjbWSbXMzMZZodVfFm+lzcxjMMVd9j83Tb+vBjTYp7JqzKECY/4nU63DWbh
	vPiYxv5YDEp8JzrBpGwKeo/OittS07xae4oLysV3tH31BRRYo8bi2Ucn+1Md3h2ARZeaCggszS2
	DuzUDPHGLWQkmwYeMceCVs8JwldDJED1ODe0o6SUShMVYS9mjPOARE14M8ov3uOg/z4KxiOguqu
	qgvHdB9C0r2j6EXE4nKQrbrAQ8UupdpS30x03BLS5sGB7uB4YwmEfsbV9rPRft6Z1PSzOCLScUS
	nS8zTDC8tpeVTnE6bqSJ0/gHKMW5DNrllWDx+Ap71iUCzRunq/BPfH0lh9nw0FXR9y+ERomGFVR
	iGv4B5pO1N9VcvHDJ/5DgWuGVMCI4z8v+WImVCnReSfdi7ODS05nzfIfDUZ4Z1LuAKNI=
X-Google-Smtp-Source: AGHT+IFbn6UAGD/yYipR4ScnqHgSY4Xy5Snk4YVDAIMeIpi4wrTyL2u+7jItUvxJiL3bukK5bqgVQg==
X-Received: by 2002:a05:6512:3a84:b0:55f:5c1d:6cd8 with SMTP id 2adb3069b0e04-579e1b690a2mr4729095e87.2.1758556278396;
        Mon, 22 Sep 2025 08:51:18 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a5f44a8bsm3412268e87.18.2025.09.22.08.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 08:51:17 -0700 (PDT)
Message-ID: <2e27010e-5a7b-4dc2-a7dd-703a94d2c4b1@blackwall.org>
Date: Mon, 22 Sep 2025 18:50:36 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: bridge: Install FDB for bridge MAC on
 VLAN 0
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, bridge@lists.linux-foundation.org,
 mlxsw@nvidia.com
References: <415202b2d1b9b0899479a502bbe2ba188678f192.1758550408.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <415202b2d1b9b0899479a502bbe2ba188678f192.1758550408.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 17:14, Petr Machata wrote:
> Currently, after the bridge is created, the FDB does not hold an FDB entry
> for the bridge MAC on VLAN 0:
> 
>   # ip link add name br up type bridge
>   # ip -br link show dev br
>   br               UNKNOWN        92:19:8c:4e:01:ed <BROADCAST,MULTICAST,UP,LOWER_UP>
>   # bridge fdb show | grep 92:19:8c:4e:01:ed
>   92:19:8c:4e:01:ed dev br vlan 1 master br permanent
> 
> Later when the bridge MAC is changed, or in fact when the address is given
> during netdevice creation, the entry appears:
> 
>   # ip link add name br up address 00:11:22:33:44:55 type bridge
>   # bridge fdb show | grep 00:11:22:33:44:55
>   00:11:22:33:44:55 dev br vlan 1 master br permanent
>   00:11:22:33:44:55 dev br master br permanent
> 
> However when the bridge address is set by the user to the current bridge
> address before the first port is enslaved, none of the address handlers
> gets invoked, because the address is not actually changed. The address is
> however marked as NET_ADDR_SET. Then when a port is enslaved, the address
> is not changed, because it is NET_ADDR_SET. Thus the VLAN 0 entry is not
> added, and it has not been added previously either:
> 
>   # ip link add name br up type bridge
>   # ip -br link show dev br
>   br               UNKNOWN        7e:f0:a8:1a:be:c2 <BROADCAST,MULTICAST,UP,LOWER_UP>
>   # ip link set dev br addr 7e:f0:a8:1a:be:c2
>   # ip link add name v up type veth
>   # ip link set dev v master br
>   # ip -br link show dev br
>   br               UNKNOWN        7e:f0:a8:1a:be:c2 <BROADCAST,MULTICAST,UP,LOWER_UP>
>   # bridge fdb | grep 7e:f0:a8:1a:be:c2
>   7e:f0:a8:1a:be:c2 dev br vlan 1 master br permanent
> 
> Then when the bridge MAC is used as DMAC, and br_handle_frame_finish()
> looks up an FDB entry with VLAN=0, it doesn't find any, and floods the
> traffic instead of passing it up.
> 
> Fix this by simply adding the VLAN 0 FDB entry for the bridge itself always
> on netdevice creation. This also makes the behavior consistent with how
> ports are treated: ports always have an FDB entry for each member VLAN as
> well as VLAN 0.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/net/bridge/br.c b/net/bridge/br.c
> index 512872a2ef81..c37e52e2f29a 100644
> --- a/net/bridge/br.c
> +++ b/net/bridge/br.c
> @@ -37,6 +37,11 @@ static int br_device_event(struct notifier_block *unused, unsigned long event, v
>   	int err;
>   
>   	if (netif_is_bridge_master(dev)) {
> +		struct net_bridge *br = netdev_priv(dev);
> +
> +		if (event == NETDEV_REGISTER)
> +			br_fdb_change_mac_address(br, dev->dev_addr);
> +
>   		err = br_vlan_bridge_event(dev, event, ptr);
>   		if (err)
>   			return notifier_from_errno(err);

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

