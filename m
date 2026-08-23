Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05475306B08
	for <bridge@lists.linux.dev>; Sun, 23 Aug 2026 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787491974; cv=none; b=UHoBNxpV6yi3EAHo4a+8wW8O89hVGm+HPk6bz+cAhB3yIWn6Zo6d9unTQShsVK+DaqskBzJFdxutytEsZEDXmkVDjvgnp69HQtAX9OKnySVARu5TcrLlzCZoTZItf0uJFW1NKT37bkuk2R9fbIP+igaU42ISLXxz8xwqBFLHo9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787491974; c=relaxed/simple;
	bh=QnsqlWV2+HTY6HhUI51xQCDZ22CyVTT5ZguwayhWJac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hy6pEREw/pkZnHL6Q+1qZSkQr0uaPF/hYrHa5P8Iy/go0G6cQg5uTdNJlKkc9znnryOPW3W2rV3Th3+tzon1Og136aOtUjuKfBPi9FYd77LL5lvR/yGMo90Zz7lxVhEDHwuqE00VZOkzFNKK/qowelzIKn750mhVL2BM6bGfv4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=UL+eesOr; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="UL+eesOr"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c247f6687dcso277291966b.2
        for <bridge@lists.linux.dev>; Sun, 23 Aug 2026 06:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787491971; x=1788096771; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oKNZxXkQOBpNNoBVz2Q1UXI7fB4yjnJyzapqPLmW9AA=;
        b=UL+eesOrBl9Ayp8F85uTUmZb5Ul3b0ynQ2jJFQbuU/Py+eD2OoK/VD5MR1dzqzwhOd
         dkjOHpDWNVTOGtWnkkX01qrUrXMj1l0jzQXaOZ2SFHXTSY2ATgIZVBinO1jwo9omxD/J
         O+0YnZf8DKueyUWg7YoHjIpbe7ANom14Y1RR77A9gksOCzUiI/fYVHIomnkLeKjdIY96
         zRqtUku1C/zA0b/HE/5EWFLifWSGq056DAvYpxF5uhAiijU4Efu88ddN5Z8UNO9oKlYq
         HUyqcG8nhFCfNL5EVDNeD2S9618raozG52GtaqDx1fiBWFgPunaj4pHIs/eofzo0Y0Qv
         bcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787491971; x=1788096771;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oKNZxXkQOBpNNoBVz2Q1UXI7fB4yjnJyzapqPLmW9AA=;
        b=szt94AT1WV9tSzyAZpJHY3izvcCYC1deTiT6EwUEuTqoORZ26ah0PFspYn8rL57rau
         vTb8tlDyx1BIxHy4Fw9cHeaDJoolYpBu7yPfqmatrhb9ed0iMOS+ruSHLPHhRslZkuF6
         EGazXqvOSkY2BrI/XNd3rZY3auL/uApufgzxNfqD+VxTlbMGxg4TXnUcyLFs4Swk29IH
         7S44R+9tLhvYqivqCifkxf8qs6jl59FzgAu+r7cB+Hw5nB+71oRtZjmD3GORyHOC69EC
         Pi5Euur2KI7paJYUVhmYIcpv2psIgpXUTMlTxlV2E9yKAlba1RNrkDtNJuKU+yZhS8a0
         jJuA==
X-Forwarded-Encrypted: i=1; AHgh+RpaUEnTNHb7hTmSy2uGAd/O5ndSqcnoCBnji3tLrcCCwJBa7HwSAvviMGnxcbI5obksmhnt65M=@lists.linux.dev
X-Gm-Message-State: AFuF++l3SWyBBxdc2IRe++PrZ4q4p2FWp9b9SR/A+ARhW100FN18AiQr
	HL6WGxiOLiy3U0hZdRd7epJFMO8Bqzsm+VSKRg2Ub75jfHiLRkv7sKQzB3tuO22nrsU=
X-Gm-Gg: AR+sD10uZLdhw2SlDPrtgYmv4dANUSPH8EMdvGFA60Z5/kwrdIVt3c4j5voz7ZFlsft
	c4pe1qomwHRAqC7UzFCGoXeb8RUEmP6E7i6j0e6L3Iy/2aDR8l1KMTuyRbfZaGy1/pMI4DqNzYj
	zKp2TS7fnBqrOOlDlMNH/uy8tzGgRMoDOhoX0tGb4Z2FAMTTHA7j14sIdHTFz4XiUbrs35XDlQG
	smasEmavy5ill0jTraLk9FmfAuAezRPg8222PjzRJ6H13QyebgZPchNbsuFc1NifTJfnKjV/Y1Q
	2HBT1H8Wp8ad1CvyiRon+uSLGwOiDLX7NXwdny8rI0y4VK6M8mN0E04SAbsJFWVy/m33PnBpbuE
	m2cLeWJgDaG/zhmePRtXw6SZpXhC/4j4D0YVH9UWNEFNM/awhffAmxr7pZrNyDAsN0dtEDbebh1
	ub5B715zOdHL8uqZiyTAD9ZSwBvg+t5qqs7zgJAQRWFeaZN+QlOR8xbdXsCpvblaIsuORdrzbY7
	n5/Ttzr8YN2asZbP1k=
X-Received: by 2002:a17:907:6094:b0:c1f:9c3b:96a7 with SMTP id a640c23a62f3a-c246a6269d2mr2107478766b.17.1787491971003;
        Sun, 23 Aug 2026 06:32:51 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249629563dsm794720866b.17.2026.08.23.06.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 06:32:50 -0700 (PDT)
Message-ID: <a7cc297b-ae54-40b6-92fc-2d1311f2e76f@blackwall.org>
Date: Sun, 23 Aug 2026 16:32:48 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: mcast: fix use-after-free of a master
 VLAN's multicast context
Content-Language: en-US, bg
To: Norbert Szetei <norbert@doyensec.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <B41EB55B-E5FC-431D-956C-503CA7B95C30@doyensec.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <B41EB55B-E5FC-431D-956C-503CA7B95C30@doyensec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/08/2026 14:58, Norbert Szetei wrote:
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
> Any user able to create a bridge can trigger this, which includes an
> unprivileged user in a user namespace, by deleting and re-adding the
> master VLAN while sending IGMP to the bridge device:
> 

So much AI slop... at least drop this paragraph which is completely useless.

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

