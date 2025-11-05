Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD2F2FCC01
	for <bridge@lists.linux.dev>; Wed,  5 Nov 2025 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334766; cv=none; b=BYr149lYWWmJgaPrshKD2GAOe+8m5Tns0FRkTZ+Zn3Cg1GKsWMz3ZEfQlRDb8JizliC4ISVjSvrcx/Igp4iuI+wEvh06blwo4801vEkd+NzUeUAOXetQSbMiuxrcHeXDFbAz5oyWh/dL377FzOR32N+t3fKJ2ShHxq+YrLEDQ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334766; c=relaxed/simple;
	bh=GqMkXKsGqN0+Gqq4C/IHZLpfl50dHLp5chkEPgO7Rxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHAtSFMaJoBJ2TS2nuZJ1sRz6hanxfgwlcjjw+cQjKXhjvhqA/VpSySSAXZOyOF9A+n3pgF0HNBPVzuPfNcfBi5XMNBDpqfvq6BmlWGzGbDdTEnkOlAchhJxINmMOngmCmBxxihwFYO1M+vEClS1s/xOsdf3ozBUFt9u1ZpDQ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=nXgICtR8; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="nXgICtR8"
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-640b2a51750so6344325a12.0
        for <bridge@lists.linux.dev>; Wed, 05 Nov 2025 01:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1762334761; x=1762939561; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kIcShUHghIbttH+Fiw9oOghCKixyC+FkGCQ9kttXoaU=;
        b=nXgICtR8oNI/dTfqWDb1yB6qtfZVq8vLXu3VFpgKOO7e4y8/GV92NxOIg8TR0712Rr
         ziVhd67WPwObj7KYi/6R+RBWl89uMlddXdMXGdOz02kuwzS3+ple10Dzln5qfZ/F5qdo
         n8YL1NyuwRe0Dm1+tfyb67sME7BZhso6nvtwZaa0P1gD1XOZT+PydMcLm7HVUnw8Z0lu
         BMjcqQmmKNkq4IC40mEzbn4HV8FrLlkTC+kYenbGDjzZwt7HDtT+5jPwcFpTkf9n9KlB
         onXXT74INGSQ23FJc5fO1N6qlU5ECdhriXO1rLnDYYUhejHEbiulus2CDgeP2v8oFiaT
         ocug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762334761; x=1762939561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kIcShUHghIbttH+Fiw9oOghCKixyC+FkGCQ9kttXoaU=;
        b=k4yZMK5cVkQX43FZ4w/pWFBMfJOmSNruEbOAxZOk/JjChNzJ61B9BQ8/8ZIuMbH6Qg
         rK+jPNaLtNYLKL+L3yY7d6dzkOJfv/Vck19vW+vfFp0gALXMgf2QZr/oiRsW0wJmrsvk
         4KEQo3n5a0odGJKkTKGQV08QxK2e0AsJ0fTXSvtFg1esonwhaYKDBPLWkptgCFQ5GAW7
         MbbM3wNoP5ASpc4UQdsbyV38WMBXGLy+fjLtP0OpzzDFKN8CNXh+qCGQFIDXfkXyplf7
         cZwLCzh3DY8Jx/aZ473AnhJYJi/B8QKsZsLxT/BKz291yrTDBjEEar7cRKw5ALd6aItT
         y7yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl2Niuig3l8KhCGhKS2ANiAy6Unhz6UWWxyOf9JT06xWYZoQfmYUSgdpY7wHuyE5ZUIluyoSg=@lists.linux.dev
X-Gm-Message-State: AOJu0YyFQDSEDkU2Ql/DKlKlq9Hlvwx2TnibTYPXje8r+7T1RkQUvylg
	xGfpC3KIFe2Wi0RB78FYO5400rmaG58RoLyw4yMIShu5rG04poykt9AeumPVjx3s7Gs=
X-Gm-Gg: ASbGncvn71RxrRcuQxAoecONx2hX1ZHuzPb0qv/9Kv13bpo61b110YjQnRHPSIFNwyh
	leZdnAhqwY2cX/ml8EqZoypw5gqcMU21k/T+FIf7qxmcG6fdIccH2VOcJPYkYX7XluJgOY9fi74
	q/TVslz4UCvtNA2U0OR8THAcCh2hojc2aPzF8T5m1IBwzfeITiLkhhWwOblRwhLac9v+YYwIckU
	kug4rRMT6hTcF1CEtNGTxK9c+jGZoiW06IWr5zqT1YJGZmNwYjSoSr7gHbgvhziGGccKe6vI/gS
	I06A8hh21pDSsPiyqjAVgaG5FNSexflYvxRvMe0YbX5e6MhkEBbysbdUV0KbPUinZVkXcc01XT0
	j9FyQWhOJdTQspSxQdd4gQ0jaqUHMgnYYUQttsO1bhsS8I7xIomkG6Op3zgBlfdLoI5GKyUflOv
	jbVLMDBMx2EGb02lcXLtwoOSzX42r4pwJo
X-Google-Smtp-Source: AGHT+IEwYWQoAgzR7tSa/a29/LZCHC7aXdNluYiG6IxOdndYNsK3NBgggmlX+oT+UtRAQmQ7/BkElw==
X-Received: by 2002:a17:907:72c6:b0:b70:b4db:ae83 with SMTP id a640c23a62f3a-b7265605335mr232961466b.60.1762334760889;
        Wed, 05 Nov 2025 01:26:00 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d3a3d4asm438406266b.2.2025.11.05.01.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 01:26:00 -0800 (PST)
Message-ID: <db8450b0-35bb-485d-af33-3ed32a9e0845@blackwall.org>
Date: Wed, 5 Nov 2025 11:25:59 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: bridge: fix use-after-free due to MST port
 state bypass
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, tobias@waldekranz.com, kuba@kernel.org,
 davem@davemloft.net, bridge@lists.linux.dev, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org,
 syzbot+dd280197f0f7ab3917be@syzkaller.appspotmail.com
References: <20251104120313.1306566-1-razor@blackwall.org>
 <20251104120313.1306566-2-razor@blackwall.org> <aQsOUyVTGCD4Tpkb@shredder>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <aQsOUyVTGCD4Tpkb@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/25 10:44, Ido Schimmel wrote:
> On Tue, Nov 04, 2025 at 02:03:12PM +0200, Nikolay Aleksandrov wrote:
>> syzbot reported[1] a use-after-free when deleting an expired fdb. It is
>> due to a race condition between learning still happening and a port being
>> deleted, after all its fdbs have been flushed. The port's state has been
>> toggled to disabled so no learning should happen at that time, but if we
>> have MST enabled, it will bypass the port's state, that together with VLAN
>> filtering disabled can lead to fdb learning at a time when it shouldn't
>> happen while the port is being deleted. VLAN filtering must be disabled
>> because we flush the port VLANs when it's being deleted which will stop
>> learning. This fix avoids adding more checks in the fast-path and instead
>> toggles the MST static branch when changing VLAN filtering which
>> effectively disables MST when VLAN filtering gets disabled, and re-enables
>> it when VLAN filtering is enabled && MST is enabled as well.
>>
>> [1] https://syzkaller.appspot.com/bug?extid=dd280197f0f7ab3917be
> 
> Nice analysis!
> 
>>
>> Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
>> Reported-by: syzbot+dd280197f0f7ab3917be@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/netdev/69088ffa.050a0220.29fc44.003d.GAE@google.com/
>> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
>> ---
>> Initially I did look into moving the rx handler
>> registration/unregistration but that is much more difficult and
>> error-prone. This solution seems like the cleanest approach that doesn't
>> affect the fast-path.
>>
>>  net/bridge/br_mst.c     | 18 +++++++++++++-----
>>  net/bridge/br_private.h |  5 +++++
>>  net/bridge/br_vlan.c    |  1 +
>>  3 files changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
>> index 3f24b4ee49c2..4abf8551290f 100644
>> --- a/net/bridge/br_mst.c
>> +++ b/net/bridge/br_mst.c
>> @@ -194,6 +194,18 @@ void br_mst_vlan_init_state(struct net_bridge_vlan *v)
>>  		v->state = v->port->state;
>>  }
>>  
>> +void br_mst_static_branch_toggle(struct net_bridge *br)
>> +{
>> +	/* enable the branch only if both VLAN filtering and MST are enabled
>> +	 * otherwise port state bypass can lead to learning race conditions
>> +	 */
>> +	if (br_opt_get(br, BROPT_VLAN_ENABLED) &&
>> +	    br_opt_get(br, BROPT_MST_ENABLED))
>> +		static_branch_enable(&br_mst_used);
>> +	else
>> +		static_branch_disable(&br_mst_used);
> 
> I believe the current code is buggy and these
> static_branch_{enable,disable}() should be converted to
> static_branch_{inc,dec}(). The static key is global and MST can be
> enabled / disabled on multiple bridges, which makes this fix
> problematic.
> 

Indeed, multiple bridges could re-enable it. That code is buggy..

> Can we instead clear BR_LEARNING from a port that is being deleted?
> 

Yeah, if done before the vlan flush (i.e. before synchronize_rcu), it should
work for this case, but I'd like to avoid bypassing port state altogether
because it could lead to other bugs in the future. I am tempted to make
MST enabled dependent on VLAN filtering enabled (as it should have been),
running with vlan filtering 0 and mst enabled 1 is nonsense anyway.

I think we should add one check when MST is enabled for port's vlan group,
if it is NULL then don't bypass its state since that means it is getting
deleted, that would prevent state bypass altogether.

>> +}
>> +
>>  int br_mst_set_enabled(struct net_bridge *br, bool on,
>>  		       struct netlink_ext_ack *extack)
>>  {
>> @@ -224,11 +236,7 @@ int br_mst_set_enabled(struct net_bridge *br, bool on,
>>  	if (err && err != -EOPNOTSUPP)
>>  		return err;
>>  
>> -	if (on)
>> -		static_branch_enable(&br_mst_used);
>> -	else
>> -		static_branch_disable(&br_mst_used);
>> -
>> +	br_mst_static_branch_toggle(br);
>>  	br_opt_toggle(br, BROPT_MST_ENABLED, on);
>>  	return 0;
>>  }
>> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
>> index 16be5d250402..052bea4b3c06 100644
>> --- a/net/bridge/br_private.h
>> +++ b/net/bridge/br_private.h
>> @@ -1952,6 +1952,7 @@ int br_mst_fill_info(struct sk_buff *skb,
>>  		     const struct net_bridge_vlan_group *vg);
>>  int br_mst_process(struct net_bridge_port *p, const struct nlattr *mst_attr,
>>  		   struct netlink_ext_ack *extack);
>> +void br_mst_static_branch_toggle(struct net_bridge *br);
>>  #else
>>  static inline bool br_mst_is_enabled(struct net_bridge *br)
>>  {
>> @@ -1987,6 +1988,10 @@ static inline int br_mst_process(struct net_bridge_port *p,
>>  {
>>  	return -EOPNOTSUPP;
>>  }
>> +
>> +static inline void br_mst_static_branch_toggle(struct net_bridge *br)
>> +{
>> +}
>>  #endif
>>  
>>  struct nf_br_ops {
>> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
>> index ce72b837ff8e..636d11f932eb 100644
>> --- a/net/bridge/br_vlan.c
>> +++ b/net/bridge/br_vlan.c
>> @@ -911,6 +911,7 @@ int br_vlan_filter_toggle(struct net_bridge *br, unsigned long val,
>>  	br_manage_promisc(br);
>>  	recalculate_group_addr(br);
>>  	br_recalculate_fwd_mask(br);
>> +	br_mst_static_branch_toggle(br);
>>  	if (!val && br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED)) {
>>  		br_info(br, "vlan filtering disabled, automatically disabling multicast vlan snooping\n");
>>  		br_multicast_toggle_vlan_snooping(br, false, NULL);
>> -- 
>> 2.51.0
>>

