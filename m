Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AC31ADC97
	for <bridge@lists.linux.dev>; Sat,  5 Sep 2026 21:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788643061; cv=none; b=E30MWfg2RqgK7ylIkM1g3uiyw/vx5O9EXLmP9CE0OzvC0R3t6RksuPJ6FTIqVQFel+xTrRzRnjb7V9Tvd3H/iy9nI8tNOrp1CcxLrZfjkT/hc5w9Oom/uQV33zQmuDjpz1/oFiIuvNSn0APlbFekNPNhrPMWyeZ1iLhXRg/ZQ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788643061; c=relaxed/simple;
	bh=zZL53EEjw9D1RZgfinpAjxAnatcoOrPLnw/a2JQ7lgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pizhpKZHXbVrG2z1fcKG10xUMJKO+eBGhl7MRRebemHYzF1dW9wzbgMdjJ2AZ2nZFS/bu4xBfEk/kHyD6T6ofj/qMfqhZrv0dY/kAUYhBzx0JGnP1GHvjQL23S0rTI8btiM0hwZQnRtbVtvkiEsDI5tQz1QsmM6mtvVAUHZ1ngM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=PimzKgKW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="PimzKgKW"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48436216a98so1440566f8f.0
        for <bridge@lists.linux.dev>; Sat, 05 Sep 2026 14:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788643057; x=1789247857; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AY+HihG4agfNBeK2I6zqAOhhokWdRfXRGsAmqq96xZI=;
        b=PimzKgKW84vxBQ6VpKTXDNQH9hUvL/sWale3FbUaTreMAYfPWSgB33+sanBFNKNHzP
         pjb2AlQYqV8R6Ycnl+MtML2jmHfkYwTgz23JTnETDY5dGSe6m8adesHW4jDa3y8DVtBx
         KYDKnq3CEVGrWT75eJd93Uk8OmzB0Bz58caWoKb4XoYVEQT3qzW+MUs60LvfoQRZ+XkQ
         uRNsc0AWKE5YyFvw9+9vaqn0YUPtDVDTpW51VrvyaDkqlw2Ypvkg629VnVzuEQXiLS4r
         wgsXq5b7rZnJ/0MbkA6WEJ/ppl+3eQHbdQl5pH1j6ZK9Cx06igkxMA8WB36GmfCHsm5j
         OUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788643057; x=1789247857;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AY+HihG4agfNBeK2I6zqAOhhokWdRfXRGsAmqq96xZI=;
        b=Ew+z8ncdrOttk0raDZGSFLrxsbvr8DGZXXNtqKPssSnLdfxiUWwMf/w8My4LCulX/n
         kOdahC6OFW53mBkkbuigIHXjZE3dZK6/IxxkEPdn7Iudzhx/uIaS22FWRPGxulXYbSUY
         9pWuFMllqqq3tigseUcioXrp12nPot4tuxCCsSjI7cmigjvmiFXX3KejrbOIIq//nFH3
         Bmy0SySGgC+GjhjKzZ5WkgTGfyQOzoSl1q64sae94HccNg4DqIB+D8p49/Iot8CpDPcM
         0R8bDQoTuqJv91jmdX2vjF+d9JHRJWVMjMhWkcQJsXv2O0RywfjQLp6W0rD//uYDb7KL
         maKQ==
X-Forwarded-Encrypted: i=1; AKwUvBznPTPVXsHqLB3ksyfuY90SBQ1y25h8qhOs2GskaBQhuDHhYbTSOqK+35AL+Dx1BklhV4zCkTQ=@lists.linux.dev
X-Gm-Message-State: AFuF++m1P2JngFpB7+Jd1DqOAdbz/Iou9zop2KNs+ZsMzniCZJ7JWDbN
	m9jZyBiysMFB2r2i1qn72wKj4jZLX/tp4LZuYCy1lBbl9E9aqPIh98QSih6/KKqWN74=
X-Gm-Gg: AYBFou1dBmVtFVxt3t4p14pPoTJDnY94bVrvVssfjh28EfRuj9PJPAz/T+w4GvrB0fA
	mpt9jwk4xr3am0jsYmIk4T9M6ztH81qCsXYDevP6RhafPnSN/UQOpgchhlrE7PEp69NZTHPjWm8
	nbT1LlxmuMWkeds7ke7aGkRn3XCXHQ/EIvsDdpEg+JrhESKXULCEF95LylLgm7XFLeiBEd6N8Jz
	pSgQdMEuHJnNfu/C4RTEI7d7v9UQTezIuEOHVTvalllWBFQxKRlo+tGvC/v2naOQ02AqUu3C6w5
	svvdZWUzyuyvshtDF0aIRc8Gq9oX7h14wWdxH1ri80p4IB/AIhB7Co6L6euQUeJGEWR82xyS8f7
	cLlL4ACKznHzxCUfiFjasxc/F0ZdyPlM/sps0vFmUyRosaVe1M4xW900fgnyiM3iceh6b2LSb07
	XL6JsaX09Llb706/Im9kWB8ltzd0o0ELaLjro8x6Le3YUXfWtMQNvYbWqxXpZVu7fcZGV0/K9Zq
	ssYSAfUo4Hjcy/zLms=
X-Received: by 2002:a05:6000:26d3:b0:482:a8b1:aa6d with SMTP id ffacd0b85a97d-48587091389mr16889952f8f.10.1788643056177;
        Sat, 05 Sep 2026 14:17:36 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bf3f0sm17665272f8f.33.2026.09.05.14.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 14:17:35 -0700 (PDT)
Message-ID: <ac7e3f4e-7a0f-410f-afb2-9bf65549cbdf@blackwall.org>
Date: Sun, 6 Sep 2026 00:17:34 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/9] net: bridge: vlan: drop legacy memory
 barriers
Content-Language: en-US, bg
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev
References: <20260903143138.1574598-2-razor@blackwall.org>
 <178864007675.219967.6069320085194764242@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <178864007675.219967.6069320085194764242@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/09/2026 23:27, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)
> 
> - [Medium] Writer-side publish ordering removed: in `__vlan_add()`
>    (net/bridge/br_vlan.c) a new VLAN is made visible to RCU readers…
> 
> Pre-existing issues:
> - [Low] Concern (retained for policy combination, but validated as
>    resolved within this series): after this patch `vg->pvid` is read and…
> 

I don't think there's anything wrong with the patch, I've answered below.

> --
> 
> net: bridge: vlan: drop legacy memory barriers
> 
> This removes the smp_wmb() calls from __vlan_add_pvid() and
> __vlan_delete_pvid() and the smp_rmb() from br_get_pvid(), on the grounds
> that the pvid is written under lock and read under rcu in the fast-path.
> A couple of questions about the write side below.
> 
>> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
>> index d337b1cfb980..5b2c22ad669e 100644
>> --- a/net/bridge/br_private.h
>> +++ b/net/bridge/br_private.h
>> @@ -1687,7 +1687,6 @@ static inline u16 br_get_pvid(const struct net_bridge_vlan_group *vg)
>>   	if (!vg)
>>   		return 0;
>>   
>> -	smp_rmb();
>>   	return vg->pvid;
>>   }
> 
> [Severity: Low]
> This isn't a bug introduced by this patch, but with the barriers gone
> vg->pvid is left as a plain C access on both sides: br_get_pvid() does
> "return vg->pvid;", and the writers in br_vlan.c do "vg->pvid = v->vid;"
> and "vg->pvid = 0;". There is also a direct read outside the helper in
> br_mst_vlan_set_state():
> 
> net/bridge/br_mst.c:br_mst_vlan_set_state() {
> 	...
> 	if (v->vid == vg->pvid)
> 	...
> }
> 
> The sibling field in the same struct is only touched through accessors
> that mark the access:
> 
> net/bridge/br_private.h {
> 	static inline void br_vlan_set_pvid_state(struct net_bridge_vlan_group *vg,
> 						  u8 state)
> 	{
> 		WRITE_ONCE(vg->pvid_state, state);
> 	}
> }
> 
> The follow-up patches in this series do address this - "net: bridge: vlan:
> annotate lockless pvid use" converts br_get_pvid() to READ_ONCE() and both
> writers to WRITE_ONCE(), and "net: bridge: mst: use br_get_pvid helper"
> converts the br_mst.c read - so this only applies to the intermediate tree
> state at this commit. Would it be simpler to fold the annotation into this
> patch so no intermediate state has an unmarked pvid access?
> 

This is not the point of the change here and it isn't relevant at all.

>> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
>> index 1e0e436629ec..2ae6ffb23399 100644
>> --- a/net/bridge/br_vlan.c
>> +++ b/net/bridge/br_vlan.c
>> @@ -40,7 +40,6 @@ static void __vlan_add_pvid(struct net_bridge_vlan_group *vg,
>>   	if (vg->pvid == v->vid)
>>   		return;
>>   
>> -	smp_wmb();
>>   	br_vlan_set_pvid_state(vg, v->state);
>>   	vg->pvid = v->vid;
>>   }
> 
> [Severity: Medium]
> The commit message says "nothing to commit prior to changing it".  Is that
> accurate for the add path?  In __vlan_add() the vlan is published to rcu
> readers first, and the pvid store happens after that:
> 
> net/bridge/br_vlan.c:__vlan_add() {
> 	...
> 	/* set the state before publishing */
> 	br_vlan_init_state(v);
> 
> 	err = rhashtable_lookup_insert_fast(&vg->vlan_hash, &v->vnode,
> 					    br_vlan_rht_params);
> 	if (err)
> 		goto out_fdb_insert;
> 
> 	__vlan_add_list(v);
> 	__vlan_flags_commit(v, flags);	/* -> __vlan_add_pvid() */
> 	...
> }
> 
> So the removed smp_wmb() sat between the rhashtable insert / list add and
> the vg->pvid store.  On a weakly ordered architecture, can a fast-path
> reader observe the new vg->pvid before the matching net_bridge_vlan is
> visible in vg->vlan_hash?  The rhashtable bucket store has release
> semantics for the insert itself, but nothing orders the later plain pvid
> store after it, and the WRITE_ONCE() added by the next patch in the series
> does not provide store-store ordering either.
> 
> If that can happen, the reader in __allowed_ingress() picks up the new pvid
> and then fails the lookup:
> 
> net/bridge/br_vlan.c:__allowed_ingress() {
> 	...
> 	v = br_vlan_find(vg, *vid);
> 	if (!v || !br_vlan_should_use(v))
> 		goto drop;
> 	...
> }
> 
> which would drop untagged/priority-tagged frames for the length of the
> window (this lookup is reached when BROPT_MCAST_VLAN_SNOOPING_ENABLED or
> BROPT_VLAN_STATS_ENABLED is set), triggered by something like
> "bridge vlan add dev <port> vid N pvid untagged" for a new vlan while
> untagged traffic is received on that port.
> 
> For the read side the analysis looks fine: the smp_rmb() in br_get_pvid()
> preceded the pvid load, so it never ordered the pvid load against the
> following hash lookup - that direction comes from the address dependency
> into the bucket computation.
> 
> If the write-side ordering is still wanted without a fence in the
> fast-path, would smp_store_release(&vg->pvid, v->vid) here be the right
> replacement?
> 

This synchronization window is acceptable, we might drop a few packets. The write barrier
here keeping it shorter was really an accident, the barriers predate my conversion of
the vlan code to rhashtable when bitmaps were used and needed the sync.

