Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4EA33970F
	for <bridge@lists.linux.dev>; Wed, 26 Aug 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735645; cv=none; b=EN07/vxuhCadx07GlUX+Oaxm09u2GLcJ8TIeuJWuIgdX0uJtg92Qj23Etj3ERPbTRSdwKST8klwiXae/QzerdTJ7BxJWv0M2kPsNojIYxuYaidj3sp+cdUO1qwT3aCOhvV8jHBiUSiL2G+Sc20MzsOHexywwAZbcQNprzL9cgdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735645; c=relaxed/simple;
	bh=8cNcQmSBEQa/bqsTILDfnq+twu8/JgZiX/XoG+xyzZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxWEOj/yKQMJU8Uegw0FC3H3pvN1WBgJg+94xC9UwO+o+Ud1yE5kGVWB1Kj/yc4H/nLZPJCdpUc4E4ZSWgN2b7LXEUe0gytajZe5yq//17IcDkPiJCKEleKFF/AgyYpAb/XOzYmn4ofo3mhtOGOfQpENXpRnYLGx5P4SL75U0Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=DYQvit2J; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="DYQvit2J"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so1331566a12.2
        for <bridge@lists.linux.dev>; Wed, 26 Aug 2026 02:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787735642; x=1788340442; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6kHnb1LiNoLhJZjgOJ2+mjeSBKbJsOHUehEEF4uHAow=;
        b=DYQvit2JbfmdODZdUbxLYScJPEA7jHKHnIYxGB6ZHNdWAI/pzE4kTNQhcC0OiPy2nZ
         FBwiK50YJytctF2G7cIsAq/gLPnFp/Y3KrJtQU9oGr5GCDDluU+hcp+EmfoTtkb9a18P
         TH6ctgah8RudD7wWHPAodTlUSkA0e1dbAKX3FhmguyijSwWFRhm+56QBTeZIa7dfJTq/
         SQhDmvxQ1iDmehIzeEjzq+sNtDVp1nC2XGWKp7iigMFZAqVHFdwac/8r4YsW6z0H6acG
         AVGG2cSSkXVi8xbERt7ZdqmiHMzE4sGOvihb0tyh1P/uhtXTknqgwbU26JDOAaPJ85yt
         hfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735642; x=1788340442;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6kHnb1LiNoLhJZjgOJ2+mjeSBKbJsOHUehEEF4uHAow=;
        b=M7MwOnJ7FjQi/7roaQAO+zX2TiBEPspnNmnHi+rB53wCZPn+k5NSpPPcS5hhwrEd35
         KPk1/Gn3yYEKWf39y4aFj7CZor1zMh0Ib33kZKmVLudIY3BGOiPDDlOrzgMy1oTSZ2vT
         vDMrXI5HgI0uz7wFbAtQalA17gOZiCeHnjzGkIk0/6y1TDEwjyQOca2W0nRfV40mganu
         xwDajPN3hW6P2Rf/cFQvdzmU2lnrrBFvfktCrhvcwqno9LOJ6B5oosCaO8uakfQnVxBK
         R5WkB0T54108mOdBFdNGFnIgFJxMleYuM/nDDlhFLw86AdmBhhdfN0Lmvp5HM5qlcDB7
         d/ow==
X-Forwarded-Encrypted: i=1; AHgh+RrDSCbh1kW52mhR5sFxxpZSzIeEKGSzKGX1smy9Oayeb/g20GpMaEvzsn5MpXt/oU2q/Nhx0pc=@lists.linux.dev
X-Gm-Message-State: AFuF++kC1C8fqfUjivBZoFblFNFHSudh4lpl7gXU0mXBtLEsOzQb8Z4B
	xnGY+0O3bT0cRVlM3Eg/1nTZZhsahQ0tK1JF2pHZ24EAeoWyyNav+8+y3+Zx3dQaWqM=
X-Gm-Gg: AR+sD12hEtCD4uYpGAzKmo6eqJaTHZ0RCgqfTXXOAhzUo7+u2+I5HLBQLuoX01K7WT+
	VkzsrhoIax/lapXomL/X1g/3AkgywzlMkOL52EOuvb1CIZ1EXxsiCD3rFxn8swUj+G6pbYyGX57
	LjXrfy0uwfsnwT3lnUR3g24C3FVdNGKQhqEGuJFc9UrO6I/a/oc0jva5qhJBRuYBN0IopJRuxcN
	HfdX97fWFypmQ/AWpyRN/ERHcfjE7OzacORabj7P2qAV6I9OlgCWZwUd3wgHUFllgcUPJywz553
	9mKshk4MJDyj1Z1J31ilqYNfz1iLD9CZmiJPW2dSRTTboJLkQATv/5GpK0106MdlCIp5309v4UH
	tCGyQTzQwbvse0xFiVUE1ulFhvp5lhaQjO3ej+oGbnc73NOamqDtEKWi3DeeTkSQQ5hbngfUNr2
	wu0gl+4MbxaiuWv0Pg51i3K7PX8meZdSP04YvCUMAzWYGQjuz9OQbqzPkoWv7KjxxA75oOmWi27
	as7J3j1Uw/HfNdaosY=
X-Received: by 2002:a05:6402:a0c4:b0:6a5:d7cd:fb9b with SMTP id 4fb4d7f45d1cf-6a5df327ce6mr6566059a12.0.1787735641083;
        Wed, 26 Aug 2026 02:14:01 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5de8ea6d0sm4038428a12.13.2026.08.26.02.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 02:14:00 -0700 (PDT)
Message-ID: <4e6fcd1a-779d-4777-ba39-d8cacda0862b@blackwall.org>
Date: Wed, 26 Aug 2026 12:13:59 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: bridge: mcast: fix use-after-free of a master
 VLAN's multicast context
Content-Language: en-US, bg
To: Norbert Szetei <norbert@doyensec.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <D400F6C7-543A-4B79-9E5B-D1D8974DE5C9@doyensec.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <D400F6C7-543A-4B79-9E5B-D1D8974DE5C9@doyensec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/08/2026 12:12, Norbert Szetei wrote:
> br_multicast_toggle_one_vlan() clears BR_VLFLAG_MCAST_ENABLED under
> br->multicast_lock before stopping a VLAN's multicast context.  That is
> the teardown handshake: lockless readers gate on the flag through
> br_multicast_ctx_should_use() -> br_multicast_ctx_vlan_disabled(), so
> once it is cleared under the lock no reader can arm the context again.
> 
> For a master VLAN the handshake never runs.  __vlan_del() clears
> BRIDGE_VLAN_INFO_BRENTRY before calling br_vlan_put_master(), so
> br_multicast_toggle_one_vlan(masterv, false) returns early on
> !br_vlan_is_brentry(vlan): the flag stays set and br->multicast_lock is
> never taken.  br_vlan_put_master() then drains the context in
> br_multicast_ctx_deinit() and frees the VLAN through call_rcu(), while a
> reader still inside rcu_read_lock() sees the context as enabled and
> re-arms it.  The port and port-VLAN branch of the function has no
> br_vlan_is_brentry() test and flips the flag under br->multicast_lock,
> so it is not affected.
> 
> The reader is the bridge transmit path.  For a master VLAN
> br_multicast_rcv() selects brmctx = &vlan->br_mcast_ctx with
> pmctx = NULL, so IGMP sent to the bridge device re-arms the context's
> timers after br_multicast_ctx_deinit() has already stopped them.
> 
>    BUG: KASAN: slab-use-after-free in detach_if_pending+0x412/0x4a0
>    Write of size 8 at addr ffff88810ac39918 by task brmc/601
>     __mod_timer+0x51a/0xc50
>     br_multicast_host_join+0x25b/0x390
>     __br_multicast_add_group+0x468/0x530
>     br_ip4_multicast_add_group+0x1a0/0x260
>     br_multicast_rcv+0x2cda/0x61e0
>     br_dev_xmit+0x6c4/0x1540
>    Allocated by task 610:
>     br_vlan_add+0x111/0xb40
>     br_vlan_info+0x370/0x3e0
>    Freed by task 0:
>     kfree+0x1a7/0x4f0
>     rcu_core+0x7dc/0x10a0
> 
> Only test br_vlan_is_brentry() when enabling, like the
> br_multicast_ctx_vlan_global_disabled() test next to it.  Disabling then
> always clears BR_VLFLAG_MCAST_ENABLED under br->multicast_lock before
> br_multicast_ctx_deinit() drains the context.
> 
> Fixes: 7b54aaaf53cb ("net: bridge: multicast: add vlan state initialization and control")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
> ---
> Changes in v2:
> - drop the paragraph above the splat, per review
> - no functional change
> 
> Reproducer available on request.
> 
> v1: https://lore.kernel.org/netdev/B41EB55B-E5FC-431D-956C-503CA7B95C30@doyensec.com/
>   net/bridge/br_multicast.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 75e1e2a8fc83..3ef5d8bbf552 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -4377,8 +4377,8 @@ void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
>   	if (br_vlan_is_master(vlan)) {
>   		br = vlan->br;
>   
> -		if (!br_vlan_is_brentry(vlan) ||
> -		    (on &&
> +		if (on &&
> +		    (!br_vlan_is_brentry(vlan) ||
>   		     br_multicast_ctx_vlan_global_disabled(&vlan->br_mcast_ctx)))
>   			return;
>   

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

