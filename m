Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FE33932C7
	for <bridge@lists.linux.dev>; Wed,  4 Mar 2026 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613831; cv=none; b=r7zYMMZtG94MY8ZUOkbv2BQJLFITm4M72JNDWjUqemnJ6T8THb90lu53k0balwJYh7ryN3CaC/pwDYiAl7Jq6ozmhMU2J8e2fGBXTHzZnmhTZWXT7+S0zpnmPwm5TBKzd+mnoUBq+lR455jnrRtvDRa0eAxtGymtqFGueKwR3/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613831; c=relaxed/simple;
	bh=VIJxBhv7XGCFbPbdOeAB7Qdcmzlygb76zrm9jwwzsOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LrD+YMZItpuhI0Ru8XvmpIbRfJMNaO0hqRoLUP7wKRueTQh2GazFxf6xmtn9dpgAN/PooLf6EvEgjv29arDlzhv0APGgqD1HseP26lDU1BkussHBcevSVxYZA0MUdrfMOddlUKX+gReO30GO4zAsiPlDgwDhm0rdYzRr0pTTgoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vwNexQa+; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vwNexQa+"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bce224720d8so3798618a12.1
        for <bridge@lists.linux.dev>; Wed, 04 Mar 2026 00:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772613830; x=1773218630; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E3vMQO/IQoYaKESJWlFHP+qMU8qosPwTVj93SXFE13Y=;
        b=vwNexQa+5mXnZJs5/tnzpT9Dhwh7yozx7jxKaEkx4ztYs1hT2qbkWRvBBPKlv4UF/m
         vrjNvRgOFDuB+aeKU/yCY0vRHr/4pFEXSkwMkMOmuKNyNy0SC1Wm7BWS7SuPJCuqQb14
         IS9e/wWazzYlJEdACk2MX3w6rdMHnye0xHlj1Lw0JaGIeXB/5SpnDwiqZAl8+oQxH8J1
         3s1hi47owSaMoSynMvO7Y9hqnTWO7CAXtboI47nfoXoWj5f/6LLN26SagvTKKEl9bUF2
         sxKYjZ/UNRmTIPhETHFXI8wT/YXQblFJFtid06BsG09BjkE++RX2S1K7Xs1FN/N/89hA
         Dz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772613830; x=1773218630;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3vMQO/IQoYaKESJWlFHP+qMU8qosPwTVj93SXFE13Y=;
        b=j81rno3LTHwjuC9YuJfFgoGCWtTNBCdOa2RHnP34CzDRueVMjvprucHC07DryQYqw8
         0qPWrgwL8KYx+IBxL6x25mSXdhKx0bWCG3xDcKD3SzVkMAC3h7yLZxNvv2BproBY8z74
         RKIpwuwcmX26JW/NL/VhCoRWNdR25tqzTi6GuCwi4+tZEJSv5wQeHrs6T7AISnLMmbbi
         f11PNU1vOss0YXU0bO/gT1l3HUnWixulfv73C9OAjBGvA3IZ1ZabR6BlN6bIUN7d4qxU
         pvw5k9wzyvckONjhCR2Orqs5ZWxQFEejEnPyKo00vdWsuG/azWyAUPUxaiWzMp/7Aq6F
         K30Q==
X-Gm-Message-State: AOJu0Yz48bXVh3FbCq2Q5FsFuFp4/VjAxQ+BlwVGIOOhF4D3svJpS1eP
	oJTVHvIWIxR5HvA/2ACwIFwfodj2sTS91ZpIq0W0lH7af3DWD+V3tqSiRmG0KbIRjeij2ZBTXlS
	DLTgs8A==
X-Received: from pfbbj10.prod.google.com ([2002:a05:6a00:318a:b0:7cf:2dad:ff87])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:438f:b0:827:2ee0:411f
 with SMTP id d2e1a72fcca58-82972b61332mr1138758b3a.4.1772613829535; Wed, 04
 Mar 2026 00:43:49 -0800 (PST)
Date: Wed,  4 Mar 2026 08:42:57 +0000
In-Reply-To: <20260304-br-nd-suppress-ipv6-null-fix-v1-1-084356ba8257@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260304-br-nd-suppress-ipv6-null-fix-v1-1-084356ba8257@gmail.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304084348.1075022-1-kuniyu@google.com>
Subject: Re: [PATCH] net: bridge: fix NULL dereference in br_do_suppress_nd
 when ipv6.disable=1
From: Kuniyuki Iwashima <kuniyu@google.com>
To: devnull+maximilianpezzullo.gmail.com@kernel.org
Cc: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	gurucp2005@bugzilla.kernel.org, horms@kernel.org, idosch@nvidia.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, maximilianpezzullo@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, razor@blackwall.org
Content-Type: text/plain; charset="UTF-8"

From: Maximilian Pezzullo via B4 Relay <devnull+maximilianpezzullo.gmail.com@kernel.org>
Date: Wed, 04 Mar 2026 09:20:23 +0100
> From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
> 
> When the kernel is booted with ipv6.disable=1, the IPv6 module loads
> but skips full initialization, leaving ipv6_stub as NULL. If the bridge
> neigh_suppress feature is enabled on a port and an ICMPv6 Neighbor
> Solicitation arrives, br_do_suppress_nd() calls neigh_lookup() via
> ipv6_stub->nd_tbl without first checking whether ipv6_stub is valid,
> causing a kernel panic.
> 
> Fix this by returning early if ipv6_stub or its nd_tbl pointer is NULL.
> 
> Reported-by: Guruprasad C P <gurucp2005@bugzilla.kernel.org>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221143
> Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
> ---
>  net/bridge/br_arp_nd_proxy.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
> index 1e2b51769eec..0b1b9ba29b7d 100644
> --- a/net/bridge/br_arp_nd_proxy.c
> +++ b/net/bridge/br_arp_nd_proxy.c
> @@ -455,6 +455,9 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
>  		return;
>  	}
>  
> +	if (!ipv6_stub || !ipv6_stub->nd_tbl)
> +		return;

ipv6_stub is never be NULL.

Also, Fernando is already working on the fix.
https://lore.kernel.org/netdev/20260226234059.19402-1-fmancera@suse.de/
https://lore.kernel.org/netdev/20260302140847.5941-1-fmancera@suse.de/


> +
>  	n = neigh_lookup(ipv6_stub->nd_tbl, &msg->target, vlandev);
>  	if (n) {
>  		struct net_bridge_fdb_entry *f;
> 
> ---
> base-commit: af4e9ef3d78420feb8fe58cd9a1ab80c501b3c08
> change-id: 20260304-br-nd-suppress-ipv6-null-fix-0a516fc27f1a
> 
> Best regards,
> -- 
> Maximilian Pezzullo <maximilianpezzullo@gmail.com>
