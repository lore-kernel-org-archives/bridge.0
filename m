Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FE138DC62
	for <bridge@lists.linux.dev>; Thu,  1 Oct 2026 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856189; cv=none; b=Y+EYdVmQfV5ywvpSFsKn0RDV1hghYzxPOMmkhZNen73beOr7UYxeyprMRRkk5IAlbPmygIjh8kcnLGcoZGehPzhJdCY0q6FBs7W8YKOmWuZ4ur+hhdNS2EBDFduvrxpkM9bp3IFKE5NvIzlBqZNn2F0LkhjOVroPAtCljqIAzw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856189; c=relaxed/simple;
	bh=xiogtjMtB6wCIIbyGGo4QNiF7Ji8CL/sbE8HNl4iyjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4nh/IIkRZNyg5M9dBfSrfzEjAxGSdzZebFwfre0By0qkku/YL3JQIogHW9xdtE3VRie3kjkHgUORLAJihjLDtoRzob5WUqc02paSBEgU1HsPv0NCv4Rw7//GHpvaIfIC/B1UrdH5EsZQHkNRc/kkOrKk0LUyOnMwr4ap9Iw9FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=D2PrqL7z; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="D2PrqL7z"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48affb828f1so1782325f8f.0
        for <bridge@lists.linux.dev>; Thu, 01 Oct 2026 05:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790856186; x=1791460986; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QAee4xNfaxXZxk12pcan/SMbXVDN86ECylJmXyJsoN4=;
        b=D2PrqL7zHcWCzlG5NkbQcj8jJ7cJJX8rJ5CxLC1QT5v0AsZA/+HgLCF+DTvPgFz/Ln
         v9Y75VJvDAqO2fqGloFNU/RbDQxj2GOket0KNGW88UuVUiDC8AofTFbNbqdt5UFv1QpA
         W8JR9qYvNAY06GWItiLk/pbi2bjvIZq7iVgsAbUtf58cUFPl5iWjKkbnGRUVlQjpByAb
         uzCMSlJtK0wdg495Py+5erfY6IOdWfoTPYgoj/RjQZJjUA7pz4jKTiIldtvWKOPyTd/L
         8fONtGfZvcE7KyeRk2VkhKAORBC1nS4t4XKcwtM1sqAu8XUmws8wKHKqBLyW3umIF8ik
         angg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790856186; x=1791460986;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QAee4xNfaxXZxk12pcan/SMbXVDN86ECylJmXyJsoN4=;
        b=hwn45ZsiNM2HOxPq2fICXfzy+KUjfD5kUYdqdcIz3C2YX3A4jIs88wR5N9nazfdDzh
         Rvj7Itrg5UciE461Hv8oNJ+AokLhRJyoxkpkLQ93tDfSdq62H14SHL4NiLi3uKi7AK6o
         99ErWFs3LlWOHdBRJ0Ua1lhvTS4OibN7JH4hngyvXV404PaO8q6ntI5dDxh+PbCgD3Db
         g6u3ME2Rqg+co/wc4TnzOr+bMqiNoeDaG+B8lsH6+51Z2zjOoNhlIMChVlv0g6OvVoS1
         p73egO/BtFd5Ibsy5c2NvY837GxnJlt0FVeZki4MquS/VC5x54v5qMk8N4f8SOOlJsIX
         RiSg==
X-Forwarded-Encrypted: i=1; AKwUvBx0579U7jql0gMINv18jxKt8TdoTTxDnrD7NaHVE8KwyWBJzouvwaL07b7BzSBfc+sF3yr//U0=@lists.linux.dev
X-Gm-Message-State: AFq9FYJRViMBmmXK2qxc7Z2ZtDQKAesX9aNcq23zqA7xqTkmpRFasbfi
	gbRL4Bqq2PDgbbJxVSMzWZCbjoaTOBoTKHaG4XJJwt8h8sK60OoEfjgTq+WdSF25Ook=
X-Gm-Gg: AYBFou3HaguGhRIeMrAelwlMp530b20Jk/DTPwVp35jyiGc1leEF9x/MLff3kM6p6+y
	P+zvBS/lpzVjf97gLP5zOW4kdggGfENlcJB06c1iqTEX1O2klh0GKNjOM+3sYLzB341zCw2X3Um
	BVe16UAStc5xAck07gauVBzsgt+CynFCZw6UecE1kvT49kgKS7dwy0H1RbgAWVN+I3iGjVkHTod
	vZCp3GC7qkhU8nOuTlAoJF+pFXZzxrLphCo7KxkxDwZAzM16V7EZ+dXkST5kEvJ14U2GIbOwBYo
	cpBcFx5OW2RNhAfvCwc6V+L1Z5Pns5mwkcXbfMRc2G7degL1/cN1PWv0E/6bfD2iO3GfvEEuG7s
	DNmdaSKf2gXfAjxpeznK+A/1Yo+56Bkrd1dFDsyaVGZExd3Ew32UwN20daDI0A6N+/gmBNu7ivi
	9ayumfA1S+ckK864lc3EWWn37sniy2gSRZA+UCIy2ZjO5B2W9jsJtUYWDRk7qCOO6Nq0VhWI5am
	aP9pm7/CPvixU6NdhRK9YCm0mSh
X-Received: by 2002:a5d:5d83:0:b0:488:8384:c382 with SMTP id ffacd0b85a97d-48b025325e5mr8036844f8f.49.1790856185689;
        Thu, 01 Oct 2026 05:03:05 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b0690e19asm5870743f8f.18.2026.10.01.05.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 05:03:05 -0700 (PDT)
Message-ID: <679483c3-5fba-4208-b05b-aa4dfba28f46@blackwall.org>
Date: Thu, 1 Oct 2026 15:03:04 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/12] net: bridge: add VLAN support to bridge
 destinations
Content-Language: en-US, bg
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev
References: <20260930071411.2786201-4-razor@blackwall.org>
 <179085594902.434549.16785666588384507596@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <179085594902.434549.16785666588384507596@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/10/2026 14:59, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] Baseline decision: false positive.
> 
> --
> 
> net: bridge: add VLAN support to bridge destinations
> 
> This commit sets bit 0 of struct net_bridge_dst to mark a port-VLAN
> pointer, so it can be told apart from a bridge port pointer. It adds
> helpers that build VLAN destinations and decode them back into a port and
> a VLAN. Nothing creates a VLAN destination yet.
> 
>> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
>> index bbb59b53e7452..2bf7f4429a3b2 100644
>> --- a/net/bridge/br_private.h
>> +++ b/net/bridge/br_private.h
> 
> [ ... ]
> 
>> @@ -702,10 +704,56 @@ br_port_to_dst(const struct net_bridge_port *p)
>>   	return dst;
>>   }
>>   
>> +static inline struct net_bridge_dst
>> +br_vlan_to_dst(const struct net_bridge_vlan *v)
>> +{
>> +	struct net_bridge_dst dst;
>> +
>> +	ACCESS_PRIVATE(&dst, value) = (unsigned long)v | BR_DST_VLAN_TAG;
>> +
>> +	return dst;
>> +}
>> +
>> +static inline void br_dst_decode(struct net_bridge_dst dst,
>> +				 struct net_bridge_port **port,
>> +				 struct net_bridge_vlan **vlan)
>> +{
>> +	struct net_bridge_vlan *v;
>> +	unsigned long value;
>> +
>> +	value = ACCESS_PRIVATE(&dst, value);
>> +	if (!(value & BR_DST_VLAN_TAG)) {
>> +		*port = (struct net_bridge_port *)value;
>> +		*vlan = NULL;
>> +		return;
>> +	}
>> +
>> +	v = (struct net_bridge_vlan *)(value & ~BR_DST_VLAN_TAG);
>> +	*port = v->port;
> 
> [Severity: Low]
> This isn't a bug, but br_vlan_to_dst() takes any struct net_bridge_vlan
> pointer, and br_dst_decode() reads v->port without checking which kind of
> VLAN entry it has.
> 
> In struct net_bridge_vlan, port is in a union with br:
> 
> 	union {
> 		struct net_bridge	*br;
> 		struct net_bridge_port	*port;
> 	};
> 
> For a bridge master VLAN, br is the active member. Decoding one would hand
> back a struct net_bridge pointer typed as a struct net_bridge_port.
> Passing NULL would encode to 0x1, and decoding that would dereference a
> near-NULL address.
> 
> As far as I can tell, no caller can hit this. Later in the series, all of
> br_fdb_update(), __br_fdb_add(), br_fdb_resolve_dst() and
> nbp_vlan_delete() pass a non-NULL VLAN taken from a port VLAN group.
> __br_fdb_add() also excludes the bridge master case on purpose:
> 
> 	dst = p && vlan ? br_vlan_to_dst(vlan) : br_port_to_dst(p);
> 
> Would a comment on br_vlan_to_dst() be worth adding, stating that it only
> takes non-NULL port VLANs? Something like
> WARN_ON_ONCE(br_vlan_is_master(v)) would also enforce that.
> 

- No, that is clear from the code and its usage. It would be redundant.

>> +	*vlan = v;
>> +}
>> +
> 
> [ ... ]
> 

