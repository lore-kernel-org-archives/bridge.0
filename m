Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54832EC563
	for <bridge@lists.linux.dev>; Fri, 24 Oct 2025 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291783; cv=none; b=cHO2UYPTeX41wQt5ZZJS9Sar26gHgA6Nm0VMDfMxD36wOXP5rm3SZ7ZsYGOnId1rVQYXi0smznmI/kwzXMI0SXz3ceLvsxBbs+zsygP6jKYsQk9QHrypt/+i3JwdhYae5G7c1710q50vuYnjvn8aRttz1nEPAUjr3B0jha61gEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291783; c=relaxed/simple;
	bh=+Ri+9nDNnz2Ro7JzCcrVpBywjcXVkOfSO4cIXjqKvQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bsjji0rexRC7yc7HEgjdV5D26y2JR0JrkWoZfyVFN91Z8Hn4UpeJKV9WgcQOhDQNh4NU8i5x5+vIkBC69ys9kQHXfUSdgNvs7htUjt8K1S2KO660xUxcN0mfrG4k+SAQdPSLayhAu6TczxSClDClTrvQmtqH19jKds8ne6jMJjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=H/SXnfAo; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="H/SXnfAo"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3e9d633b78so333732066b.1
        for <bridge@lists.linux.dev>; Fri, 24 Oct 2025 00:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761291780; x=1761896580; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jhahQiKxL2l5ZMBK3/b5kydysdy0zRxJIFdQCfDiF8I=;
        b=H/SXnfAo5K6pZKojRdhN/py6JHppD2vCs4rrCpCfqSCHXqKGkPCMqJiRwTOds/JxkY
         SOJOPAoXupdVVHAF8l8JtqyKWqkjY+5ZUg7NAoBM3EbcoeRKGw07dtdAwotMLhZY+Iz4
         H1h2FY/XjIBUgPdQJBC3uJL8GZqA9bGcURHmvntskNt/qe2h6Y42vphxqyFpqkGTf+4a
         kdGnE+N5qMLTgKjJhTV1bA7fTQ5j0myOaM35hn0ua1dlsmprxisrlyhE+p1b82Y4se0J
         Xep3xrtCCdW7Oi4nZg6KN2mPMjScUr0ZYKe8rPoJZUWJ7XSwe5fcLtfO9osRLugYNgw0
         IY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761291780; x=1761896580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhahQiKxL2l5ZMBK3/b5kydysdy0zRxJIFdQCfDiF8I=;
        b=KL5sc3YAs1E764aYpENQqWv00XUrEqnSo9FIwaRRNt6tFhjRCMGYBKISuQsDKUOL44
         zHkRA9anDNZeIBUMX32PDQKIRZbpu07P7KSU2ScsmHD7LAQRdRPNGZ4Br19pX/I/6QQW
         lAWdPm2JEj8t+L9YpjMT2uxMmzwtRg4i+sI21hgYDWqmDStP3ek2dSEA5w0cfxe4Fcns
         XtCWH7rDEEiR/QVk/rEoXU5nK/kscMuVFXSbBRPqatGwhe9xmfFsJDMgvWHT82RFJ7Q6
         545BrFBA+ljaQub9nA0L1PpucnWU0EyN6PXIIhB03seHNqFAApzXoCV/KxCQUEk8vTlz
         KC7w==
X-Forwarded-Encrypted: i=1; AJvYcCVk3y6txOmYyPLoyS3dxnpVzCPyevENe60HZPtSiL/GnrV18G20jvMabDlgJJg7UJ+wtgIB5iQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YwHcvkFbVTdm6DonLke0p//Vp92FVkxgTn0BVvl4skPtpnIbJgq
	kb97RC8oTfvoE3Y2OtFMN4Qcum0s94yYvUbJhhn/cTyE0BKNfWpYE4VnBdK1GVED7Zk=
X-Gm-Gg: ASbGnct6URogJtI7Vf0M8RiU0j3BB2qRmlanXw6EV0rM1qxF3xktzaY/2B5bg3ElPw3
	F6O5t5urF2z8MQAW90yvrk/4+oTM5hyfaZCb/tyPIPv19qGmvCLBprQzPKiWtjEuUR3WLcUxoc0
	JuRkT7cRkG9VaSo4EGLFCqAoZMRrW8Hlx+x+PwolpQX69JcCz2YZBcHfvXZoLZkv0GVxTrNh1My
	8b6t8jkPcKI1cdq05AvpQrE4w+RXEvqVqTCjniwAe0nkcK2cHJm81RnOmFozAV1i77yIzrxx9oF
	Y6AO2wlvOxyTZ3uXpNsvHfH202CrxYGYJqZpCyQKNT6wlgDYShaVckyPWHnots6QP8DZ7YtW71B
	r7kxCSi9KFPnysI8+3Ta5hYhyswlwDMjIz1ZlBU6mUQZPxVorcf8Gk43YjdhMZ17L1hpgUU68ax
	dTLnsuMDoBtVW1MTojmu/K+nsC6DI0Scde
X-Google-Smtp-Source: AGHT+IFvbTrKGBBpoTCaoGS2gvcjtD63K6LWeth4uaR2zH92WeIfEL6ETRbjxcJ7CljSIdIyP7aerw==
X-Received: by 2002:a17:906:ee89:b0:b6d:595b:f54d with SMTP id a640c23a62f3a-b6d6ba8f860mr195451266b.7.1761291779267;
        Fri, 24 Oct 2025 00:42:59 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d5144ece8sm443173966b.68.2025.10.24.00.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 00:42:58 -0700 (PDT)
Message-ID: <aa92bbb5-c64b-4262-a382-ae5609254606@blackwall.org>
Date: Fri, 24 Oct 2025 10:42:57 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: bridge: Flush multicast groups when
 snooping is disabled
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 bridge@lists.linux.dev, mlxsw@nvidia.com
References: <5e992df1bb93b88e19c0ea5819e23b669e3dde5d.1761228273.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <5e992df1bb93b88e19c0ea5819e23b669e3dde5d.1761228273.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/25 17:45, Petr Machata wrote:
> When forwarding multicast packets, the bridge takes MDB into account when
> IGMP / MLD snooping is enabled. Currently, when snooping is disabled, the
> MDB is retained, even though it is not used anymore.
> 
> At the same time, during the time that snooping is disabled, the IGMP / MLD
> control packets are obviously ignored, and after the snooping is reenabled,
> the administrator has to assume it is out of sync. In particular, missed
> join and leave messages would lead to traffic being forwarded to wrong
> interfaces.
> 
> Keeping the MDB entries around thus serves no purpose, and just takes
> memory. Note also that disabling per-VLAN snooping does actually flush the
> relevant MDB entries.
> 
> This patch flushes non-permanent MDB entries as global snooping is
> disabled.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_multicast.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 22d12e545966..d55a4ab87837 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -4649,6 +4649,14 @@ static void br_multicast_start_querier(struct net_bridge_mcast *brmctx,
>  	rcu_read_unlock();
>  }
>  
> +static void br_multicast_del_grps(struct net_bridge *br)
> +{
> +	struct net_bridge_port *port;
> +
> +	list_for_each_entry(port, &br->port_list, list)
> +		__br_multicast_disable_port_ctx(&port->multicast_ctx);
> +}
> +
>  int br_multicast_toggle(struct net_bridge *br, unsigned long val,
>  			struct netlink_ext_ack *extack)
>  {
> @@ -4669,6 +4677,7 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val,
>  	br_opt_toggle(br, BROPT_MULTICAST_ENABLED, !!val);
>  	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED)) {
>  		change_snoopers = true;
> +		br_multicast_del_grps(br);
>  		goto unlock;
>  	}
>  

I've actually thought about this, disabling multicast has always been weird in the
bridge and I think this is an improvement:

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


