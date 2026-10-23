Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792749432;
	b=r8nACFAXwnPAt+P6Qb61sWukKkSJZf7aWOS7EfF1T0wMxyvtiWsROpUEWmH4UlHPR9Yu
	 pvcIpe1wHraCgIQ5aaTcWEVTbYU3upAx83bTAbyO+crdyGMKQwHIIzsZUJHsq22h7Z7vb
	 sAjcezh1D/av4NZyQMh7kxzxiUOFMFsCBJqtbNsMqrpBNChfi3M0KtQ3VFODhObmY5F1Y
	 gtBthz/i2USpVVl+ZklxjZjy11FtB/IC4IpQzFcdh3y1pcTH5TgG/BQ6Q7OyDCeHL9dPp
	 XF0qzAeNfwFMY6ol7Mjc53jtBC03GyqRKKkTWS/qZwZlH2UYIUWL6j6B7nbbkc/bKRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792749432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=5zYKXoFoRrW/rjS0dALsJeII0OIOKVqHguJNCNYo2aI=;
	b=pYTPVOtRPNWMQ+L8hpO3gXm9chro2lHt9vTTsKXMF3BJ/fwqd/e9pAUmACEZf7c70pJw
	 KX3JAom8E5bCABLBRdmGIobSKbYvmBLL7hGLMq+75cB4Zkdkswz5nkW/ciwMwkocLStPK
	 LKwHYryY6YNiFFp+REjXNIJDzV+1EW7HIrWVmEbAXygNMC1HK0KxxbEiBU10YwBqrvO5r
	 6IEpO2zlmJU0fEjX8C/RzLrk+2r4B3JhrynviblJa4aAJ0ueKlQwE3bBG7CWHzj1BGi95
	 BPq4Kvnc4yvhuut5OoRemBkHO4nBjBy6GFC9faNK/ugjVo/N1MIM7wGrq3cpRpVHU7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=VaLrBAFL;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16A4606A31A
	for <bridge@lists.linux.dev>; Fri, 23 Oct 2026 09:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F16A4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=VaLrBAFL
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso459050f8f.1
        for <bridge@lists.linux.dev>; Fri, 23 Oct 2026 02:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1792749430; x=1793354230; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5zYKXoFoRrW/rjS0dALsJeII0OIOKVqHguJNCNYo2aI=;
        b=VaLrBAFLzynvibuskxMER9askp7pSlZ/7GUMJauFQ6FMBn4YkLYBURm4BJq2u0hDCq
         Ml9eGl9QEZgZJbOsGVloIFit7IY3FL6n9Mta8H6u1gS+AiTGDZX07EVxU27FttE5Ye3V
         p3vgtcpTFt64tXRbqHft2KCtePJYB/6fFPD9PsUVVGH97VL2EA9Hv3ITcZ3/c+4rwzeU
         KxbEyOm7UWBjo7wHWsaab3ewyRbQcYB3p6Hc86+hORSvcD/gDgtPvBAZGuboCSpJiZut
         xYBBmu/en3MOG3GXf4FAaJVj7V4X2hrNxaDOGPUYYqAHlc46bnzMzV8wHBY1b90ZVKuU
         YQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792749430; x=1793354230;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5zYKXoFoRrW/rjS0dALsJeII0OIOKVqHguJNCNYo2aI=;
        b=HKfgr7Ozoaep9rpRRBkeXKs8Z5jgM5vY8GSANjjVGEWaUUzbsEz5zxdXSrhxUrKbdH
         dvI8z+7mBkIzYG/kXrVxpgh9qYwghZd0VO0F6h0VsOb6faAza85d+PsNrhPia9zI1Nqy
         qJNwukJlBUpyF1zQVIRmyt1Z2H3xWSPrtKQDP/H7Fa55wsxWP7k9i0ICUoj9IILv1Qt8
         x6F98vQo5wedhCzrfiWQUC3rvGnvHfp2eWqMQLyy4Pjxh7DhOYvatr67iJjEmmQe7QXa
         Hm0n8tJLnq4mFela45Kgql1z+QdicC1B30PsMVAFbsGQmGr6mk9x3o6XO1ffd43qweOE
         xgaQ==
X-Forwarded-Encrypted: i=1; AKwUvBwm7Gg03/eN/iUowKyMPFVb6qhFn0Y6Rr7aSNE9DM15S+gIahuUMPZUahQJLu7wiWWntDTDQm4=@lists.linux.dev
X-Gm-Message-State: AFq9FYLSfXGG8U8HXOQif0Nn24Tb/s9a2qzTkYY5tK2f4DwFusioS9zJ
	uTHDJEhhU6tr1w3JCNbTeErVQGdVSfpEP7L51fFByweyNG86aCyOV4QN2uUzEARNEb4=
X-Gm-Gg: AYBFou2K38rjko7iyk5ZvM9uaQQe6q6Hbckat83wrctAeKe4Ji1OyDVSV3oRmeIcVx/
	DJC+YihwAdIezurfjvk7mZXuvgObvjwm+Rmu9NaIHRcDWeT5fYCYSEJf2SGg/NGnbXLYxScXdWk
	YD2WYAgIjAWcrg2MlDaYCO7e7oFkZxP1ulSYw/YrIyo7U8d0eArtkqj1WGgp50DaBQ0fYXy5Tx9
	vWyP0cKb9c2dFSilSClWCSx3O5TxQEm3J8984cdD99BZOPFDksXukle3IPOEPNEpWbNLAVM+cfl
	cBv/H8c+oA9jqcfGkykzUI85LBVBdiAFfiLY1sP8GD2D1amYXDgo16Q0GK2BlVt02zEVNHHh9SA
	udEH74LlX69GANwu6PJZGitgrTDrTly62FczpuAZUFnTSZA1ufVnfnozyzsfy7Y4Gm41xpaT7iz
	xA8Zn2H8cf8iSMXXZZgnO79r26kgMuvM9Bog5Ch2/moQ5h/EYLLoPVCd8MI2AzKQWUds/D6GjdN
	h0PHwcmUOlrY0x7V6F0DJW3leGu+JA16TkAahi4rZ3XjJBMGzlfkC9HpJ58DzTCbxTeLFvRlu/4
	LGAYN2fdbQ==
X-Received: by 2002:a5d:4c4a:0:b0:487:27f9:842 with SMTP id ffacd0b85a97d-48e385b0220mr2207570f8f.55.1792749430068;
        Fri, 23 Oct 2026 02:57:10 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3804872csm3994786f8f.34.2026.10.23.02.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 02:57:09 -0700 (PDT)
Message-ID: <cbcff85c-49f5-4920-94ee-53dc10c9ad96@blackwall.org>
Date: Fri, 23 Oct 2026 12:57:08 +0300
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: do not bypass port state for MST without
 VLAN filtering
To: Tobias Waldekranz <tobias@waldekranz.com>,
 Cheng Yongkang <teel4res@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <179268538303.70821.3493915601694605045@gmail.com>
 <877bj8iz0p.fsf@waldekranz.com>
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <877bj8iz0p.fsf@waldekranz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/10/2026 11:47, Tobias Waldekranz wrote:
> 
> Hi Cheng,
> 
> On tor, okt 22, 2026 at 08:26, Cheng Yongkang <teel4res@gmail.com> wrote:
>> br_mst_is_enabled() is true when the bridge MST option is set and the
>> port has a VLAN group, and nbp_vlan_init() installs a VLAN group on
>> every port even when VLAN filtering is disabled.  While it is true,
>> ingress treats the port as forwarding and egress skips the
>> BR_STATE_FORWARDING check, so that the per-VLAN MST state is enforced
>> instead.  That state is only checked when VLAN filtering is enabled,
>> though: br_allowed_ingress() returns early otherwise, and
>> br_allowed_egress() only checks frames that were VLAN-filtered on
>> ingress.
>>
>> With MST enabled and VLAN filtering disabled, no port state is enforced
>> at all, and a port in BR_STATE_BLOCKING or BR_STATE_DISABLED still
>> forwards traffic, defeating STP and MRP loop protection.  MST can be
>> enabled in this configuration, since br_mst_set_enabled() only requires
>> that no port has a VLAN, for example with default_pvid 0.  In that setup
>> a BLOCKING port kept forwarding broadcast frames while MST was enabled,
>> and stopped when MST was disabled.
>>
>> Commit 8dca36978aa8 ("net: bridge: fix use-after-free due to MST port
>> state bypass") stopped this bypass during port deletion by also
>> requiring the port VLAN group; the bypass itself remained.
>>
>> Also require VLAN filtering in br_mst_is_enabled(), so the normal port
>> state checks apply until VLAN filtering is enabled.
>>
>> Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
>> Assisted-by: LLM
>> Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
>> ---
>>   net/bridge/br_private.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
>> index ff746f036f54..85065304597e 100644
>> --- a/net/bridge/br_private.h
>> +++ b/net/bridge/br_private.h
>> @@ -1953,6 +1953,7 @@ static inline bool br_mst_is_enabled(const struct net_bridge_port *p)
>>   	/* check the port's vlan group to avoid racing with port deletion */
>>   	return static_branch_unlikely(&br_mst_used) &&
>>   	       br_opt_get(p->br, BROPT_MST_ENABLED) &&
>> +	       br_opt_get(p->br, BROPT_VLAN_ENABLED) &&
>>   	       rcu_access_pointer(p->vlgrp);
>>   }
>>   
>>
>> base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
>> -- 
>> 2.34.1
> 
> I suppose the other way to fix this issue would be to require VLAN
> filtering being enabled in order to enable MST filtering.
> 
>  From a user perspective, that seems natural since you need to associate
> packets with VLANs (i.e., have VLAN filtering enabled) in order to make
> any use of MST filtering.
> 
>  From the bridge's perspective it might be less desirable since it would
> mean that the two options would become entangled - the bridge would have
> to refuse VLAN filtering disablement while MST is enabled.

Indeed, that can break users because of new option ordering.
I'm sorry but this is a no-go.

Cheers,
  Nik

