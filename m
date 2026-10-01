Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EBE3F86FE
	for <bridge@lists.linux.dev>; Thu,  1 Oct 2026 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856318; cv=none; b=BCG7JI2XZS7ERnQia582T4W1YNVaM/wi2iWbfxCLYBAOzmsPRYLbfQEn2TB7zODDYjaNDX2wwg9A8cDsOCDkCE2P7RsMqbnvpgyaAvCdG1ORuIXlvmT0d0q8ByJ5inIMuDx9P11aG7esawRUDEcbyo7mxH2tTMp4d43uofJP/rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856318; c=relaxed/simple;
	bh=T8dzVeHIzAA0O84LgNjofXhcQq9IO4xmtqYc5GVGHXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PhAV8tNsNSSQbL2gOuPrmoWHypliqMJwzRmE/VOSPVMFnPDWBgQh/VhaIL+MK6gXyN+nR8PGz5AQuHNque4R0/wQNmoXVfFrz9sr3sQEiFvnVSwT3NneLVOO0bUw7yrwNNV2P0hL7NbS428kdwWeS0nYdsjZax4tN6enEjfM2Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=OnD29U30; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="OnD29U30"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b01c41135so1208070f8f.0
        for <bridge@lists.linux.dev>; Thu, 01 Oct 2026 05:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790856313; x=1791461113; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KnsYoCtXPP1/HI5phCRlP3AUYjFusJ8JvjYJTN9SY58=;
        b=OnD29U30LyRnXvcu2CXBsz7WmBTTTis1nX9XOoKRwes0fECBQjR/SOIOYjeU6Htw80
         rcWb+d7ApRwCK91i0AiEJxwEcYw+sD41H8GBpPfbp+NMA3+dF2AYCartGpbiuuj080az
         WnXefeg6RtL73W00KCjXEKAvySY5jVRRMOgTSGip/fe4TV9+yLaQ8Km14LXdxvgt3xgt
         Sh+85iC9KQuUNyjKNoclAdeCMIkR3r+iyUamnVgI6qmUfgJnQ14arLhdsYqXBYsta/8d
         WG0tiXtKHLT6M92STxzXSZYz2QOitlGM1ZaDzR19GwoTWfGxUkhRKKv4irf/3wvSRAMh
         S/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790856313; x=1791461113;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KnsYoCtXPP1/HI5phCRlP3AUYjFusJ8JvjYJTN9SY58=;
        b=mwN37GudI7MP8pTtVDhP2GX8qF2cKk0uircnfgyHLLE8mN7+qJOfo0MVdFxvLDlEXL
         PIzMg+WXqKFS5kYM02YmxYU7Ndl/UTxiBhw37UQEqjc9KmvpPDLGGUVtFDoBeTSIJBpu
         ht6T/YlWUP0LHx9S8U7kVs5GH81eqDXMC5rGX+vT+J493jYgAsJiBoIF+vu0elfph84s
         EYWIKY+SgLE7Yr0TTAEG7+IHd+tQ0vU41bWhkc/QewBfV2j/GRvbJmb9eF8W7bkLe6AY
         45lVu3z4///tUjxzfbMlGlrgAGmQ8epCfIFe+NDOGeSzO95bHCcfEaprjcArgxyu7TMI
         CDvA==
X-Forwarded-Encrypted: i=1; AKwUvBxksArkSIYcGXWgroroVIpo2o2gyEeodo8snbRSVMqyPzQfv5CHnhlHgZhQoL9/rOX6C25Rtx4=@lists.linux.dev
X-Gm-Message-State: AFq9FYIj3CpsboZ3H1HiEEDfQlOJ5RNRYccoNQ1JgjORVCY+c1qv0j+3
	kCcyi6vGQLLisqnyeWoWICMOjyvZwQyG0KSVzProTOTSkVAyk8HPA0DTWb/UqMfdwmM=
X-Gm-Gg: AYBFou0H6SKTeisRLIumVqoL4ol3VnFSqOrsLFvnYh5EJGHE2pQ7KAPeeaga4z++0tW
	XjpCkjQ+NoDdnWsPTLbFZqTboKNi0EYOZ52spDGATvZn8KGG0CyzfNPLZwJFubH6/meAfbJ+uhP
	ejizWLkWs0IJmYYYVtMnA5E8e1ryqSzudG/+mf6nJJ1jBRZgsW+WIiJJhcGR3KUHPlqlt2u2ExR
	JEEV/wJoVrOF4sPx75ZOivIB0RyqExNo0kb5L2PTLLXks1EWR8xT6dU7Bq3thxNGAoxSeXNzjWH
	IODPXTJjKKNEth+nPh3oXAD376qh9qCek4SEz+2RunP+oixGhp9RIaCo2DNJ3+1alUemJSo9jhQ
	faJJ8nWNVI1G7bBouW4UeQI+Is/QRwzxuAsrrpdFSLBM9VJIwC7NTm3gRyp645SugfSJhmnGg31
	hiT0EGV9wz21TfcauciLsRAE7Nigks4NSsq3Y+eQdJ2EzgIEcrnLch/xdafNgt3W4lCpBO3wwEn
	hS7Zomcq9hsqFBd9Y7sdulCVEeF
X-Received: by 2002:a05:6000:2003:b0:48b:e25:21e6 with SMTP id ffacd0b85a97d-48b0e25238bmr2956261f8f.15.1790856312097;
        Thu, 01 Oct 2026 05:05:12 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b0db6de18sm2540025f8f.44.2026.10.01.05.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 05:05:11 -0700 (PDT)
Message-ID: <2add34b9-2e3b-4ae2-be56-aa10177a8158@blackwall.org>
Date: Thu, 1 Oct 2026 15:05:10 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/12] net: bridge: fdb: consolidate port-VLAN
 cleanup
Content-Language: en-US, bg
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev
References: <20260930071411.2786201-7-razor@blackwall.org>
 <179085595018.434549.16034696945314071975@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <179085595018.434549.16034696945314071975@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/10/2026 14:59, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The patch rewrote the header comment of br_fdb_cleanup_by_dst()
>    in net/bridge/br_fdb.c, but the comment does not describe what the…
> 
> --
> 
> net: bridge: fdb: consolidate port-VLAN cleanup
> 
> This renames br_fdb_delete_by_port() to br_fdb_cleanup_by_dst() and passes
> a bridge dst, so the function can tell a port-VLAN from a raw port. For a
> port-VLAN dst, the port's automatically generated local entry for that VLAN
> is now removed in the same locked fdb walk that flushes dynamic entries.
> As a result, nbp_vlan_delete() no longer calls br_fdb_find_delete_local()
> separately.
> 
>> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
>> index 9cd6deae86359..7c68b540b3580 100644
>> --- a/net/bridge/br_fdb.c
>> +++ b/net/bridge/br_fdb.c
>> @@ -868,15 +868,16 @@ int br_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
>>   	return 0;
>>   }
>>   
>> -/* Flush all entries referring to a specific port.
>> +/* Clean up all entries referring to a specific destination.
>>    * if do_all is set also flush static entries
>>    * if vid is set delete all entries that match the vlan_id
>>    */
>> -void br_fdb_delete_by_port(struct net_bridge *br,
>> -			   const struct net_bridge_port *p,
>> -			   u16 vid,
>> +void br_fdb_cleanup_by_dst(struct net_bridge *br,
>> +			   struct net_bridge_dst cleanup_dst, u16 vid,
>>   			   int do_all)
>>   {
>> +	const struct net_bridge_vlan *vlan = br_dst_vlan(cleanup_dst);
>> +	const struct net_bridge_port *p = br_dst_port(cleanup_dst);
>>   	struct net_bridge_fdb_entry *f;
>>   	struct hlist_node *tmp;
>>   
>> @@ -885,6 +886,14 @@ void br_fdb_delete_by_port(struct net_bridge *br,
>>   		if (br_fdb_dst_port(f) != p)
>>   			continue;
>>   
>> +		if (vlan && f->key.vlan_id == vlan->vid &&
>> +		    test_bit(BR_FDB_LOCAL, &f->flags) &&
>> +		    !test_bit(BR_FDB_ADDED_BY_USER, &f->flags) &&
>> +		    ether_addr_equal(f->key.addr.addr, p->dev->dev_addr)) {
>> +			fdb_delete_local(br, p, f);
>> +			continue;
>> +		}
>> +
>>   		if (!do_all)
>>   			if (test_bit(BR_FDB_STATIC, &f->flags) ||
>>   			    (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &f->flags) &&
> 
> [Severity: Low]
> This isn't a bug, but does the rewritten header comment above
> br_fdb_cleanup_by_dst() still describe what the function does?
> 
> The comment says static entries are only flushed when do_all is set. With a
> port-VLAN dst, the new branch runs before the do_all check. It removes the
> port's auto-generated local entry even when do_all == 0. fdb_add_local()
> creates that entry as static:
> 
> net/bridge/br_fdb.c:fdb_add_local() {
>      ...
> 	fdb = fdb_create(br, source, addr, vid,
> 			 BIT(BR_FDB_LOCAL) | BIT(BR_FDB_STATIC));
>      ...
> }
> 
> The comment also says the function cleans up "all entries referring to a
> specific destination". The walk only compares the port part of the dst:
> 
> 	if (br_fdb_dst_port(f) != p)
> 		continue;
> 
> The VLAN part is used only for the local-entry case.
> 
> The local-entry match uses vlan->vid, but the dynamic-entry filter uses the
> separate vid argument, and nothing ties the two together. nbp_vlan_delete()
> is fine today because it gets v from br_vlan_find(vg, vid).
> 
> A later caller might pass br_vlan_to_dst(v) with vid == 0 or with a
> different vid. That call would remove v's local entry. It would then flush
> dynamic entries across all of the port's VLANs, or in a different VLAN.
> 
> Could the comment say that vid is expected to match the VLAN's vid when a
> VLAN dst is passed?
> 
> The line "if vid is set delete all entries that match the vlan_id" was
> already inaccurate before this patch, because vid is ignored under do_all
> and static or ext-learned entries are kept. That part is pre-existing, but
> the patch kept the line when it rewrote the comment.
> 
> Later in the series, in "net: bridge: fdb: avoid VLAN lookups in unicast
> forwarding", the comment is still the same. By then the function does more
> VLAN-specific work, including falling back from the VLAN dst to the port
> dst.
> 

Hmm ok, I'd prefer to take care of the comment in a follow up as I have a few
minor cleanups gathered from the previous set review and can add this on top.
I'll take care of the pre-existing inaccuracy as well.


