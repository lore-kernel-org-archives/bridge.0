Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2654B15EFA5
	for <bridge@lists.linux.dev>; Thu, 11 Jul 2024 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720705417; cv=none; b=BXiYmVMFdoBIFPdQXiiYmp3VWfzL13PHwkECPYHC2hETQ1714t4edpgajyycL9d3mENfgtYfnF4ahdzhc3wIk57NDJ3BQ5/67Zu/a6pM/DwJKse5HyOLA2WDQf/ktC3GTXW6TOjcxltfqLDzBGiKbcPyOE+UJMVHxS1RfVMPIVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720705417; c=relaxed/simple;
	bh=o+5i6mIUvBPggu9iNkNKAi/8MWHTFoDc6KXMfC+8lJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lm0IVMmuKLuzkVzSDjAiHmbqDB2edpfR+xt71dqU9JlJh/rvogYU84F7pqVX4Vn43yaRRPApInexavOc2MS9MKW+hS8DFmRygot/nD6254u24eTzYPmIjwFhgt4kWWlyHgDhsg0QoS2bErxiR6xv1QVkV3nwpEp1OGpcPne25wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=JWgxc4lj; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="JWgxc4lj"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ee77db6f97so15165781fa.2
        for <bridge@lists.linux.dev>; Thu, 11 Jul 2024 06:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1720705413; x=1721310213; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HCWEdgZVnaQia4hZ7qxBHy95vphFcyt4VAOelkNx1OI=;
        b=JWgxc4ljOMJZkX/2JGnqeVFQnqPMWl0IrqmLbRdvEMBhJtmWs6bhTDH/2Hc19rrX/p
         Go+N5FQvT9YOVn+tCDCDy3RlWyE/wYpi3a8dBFmsEApJF2ZbbyVE6pEBt2IMZfWWj4R/
         Uxi0xtIbT3YymIzYpXWPy4YFq7YhiHQ0wRxDX7vtgOI3kXS8CbiHWdlxAAqNIDOhK9wU
         5GgjNzDFSxMRLaKQxFHxNojbL4vclasWEIqbwoxdmyC+AvTs96as9eRnzvReDx6WtqDd
         LATcJXUjCyR+nOq6sOBJWfiUQqosSxYdO1YKy1tXmtazdfhMvxmvELYbGXRoqImAcR4d
         u33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720705413; x=1721310213;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HCWEdgZVnaQia4hZ7qxBHy95vphFcyt4VAOelkNx1OI=;
        b=EVkaHvX7Jr0WBBFFv7emhwObuoDTr1lWSNUFuQ0T/xVAKYaWWvoTbIq2H/AoJfcqD6
         kB+hm+qGyjaV/2Upx2IKFSGgIXzSUCUI/wYZ4Bce1mp0rTuPORsEFzJDJhzUc5ATAeFA
         Y4mY91pkmQhHvaW1EsuRgQeS1Gb6n/upiiIX31wyE+Edi6nMI4leLgriiPHyIKLGEBN4
         D/D4vqUFbkt+q0Bm3Y73bc6LPfV3isl1H55ZSSixV0Qic9FlSTgHmFtmCG/Wl5fDj9WK
         FsvWI6yZNFr1jEhk7okK1ASzDuylROjv8VF29v17yYmvUjH4SMrr41lO7NiTNMQpxiNB
         ycKw==
X-Forwarded-Encrypted: i=1; AJvYcCV4qPdvhC22EmEeYjSRQRs4M47S/4bjWaRbkoelLYFi2TLsakxuiGzS1gSiyvQkchPEYUEk9WJaqpQjl9HAMSIeN7A/KUdk
X-Gm-Message-State: AOJu0YwrHGVjvS3MYiWwqrcdyk/bUYyYEBNVU7kaNXJbQ3zAnoaVTO0v
	qSmIicQr5h9lZrJDLU+LrcA2+djDBgF8OOf5ZkjSRr7sNQmIocH4OjrNML/wfkw=
X-Google-Smtp-Source: AGHT+IGfnQgKlm4o3yV4UYgOt7VmCFn3e45AwDwu2f73YOZ7FLTEGLaYTVtXWW7/jc+di92fNHXDpg==
X-Received: by 2002:a05:6512:3d21:b0:52c:d76f:4604 with SMTP id 2adb3069b0e04-52eb99d27ccmr8224974e87.46.1720705412985;
        Thu, 11 Jul 2024 06:43:32 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a8542dfsm254772366b.150.2024.07.11.06.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 06:43:32 -0700 (PDT)
Message-ID: <9aff7e76-0799-4439-afff-a5ca4880bc72@blackwall.org>
Date: Thu, 11 Jul 2024 16:43:30 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: bridge: mst: Check vlan state for egress
 decision
To: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>, davem@davemloft.net
Cc: Roopa Prabhu <roopa@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240711045926.756958-1-elliot.ayrey@alliedtelesis.co.nz>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240711045926.756958-1-elliot.ayrey@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/07/2024 07:59, Elliot Ayrey wrote:
> If a port is blocking in the common instance but forwarding in an MST
> instance, traffic egressing the bridge will be dropped because the
> state of the common instance is overriding that of the MST instance.
> 
> Fix this by skipping the port state check in MST mode to allow
> checking the vlan state via br_allowed_egress(). This is similar to
> what happens in br_handle_frame_finish() when checking ingress
> traffic, which was introduced in the change below.
> 
> Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
> Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
> ---
> 
> v2:
>   - Restructure the MST mode check to make it read better
> v1: https://lore.kernel.org/all/20240705030041.1248472-1-elliot.ayrey@alliedtelesis.co.nz/
> 
>  net/bridge/br_forward.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index d97064d460dc..e63d6f6308f8 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -25,8 +25,8 @@ static inline int should_deliver(const struct net_bridge_port *p,
>  
>  	vg = nbp_vlan_group_rcu(p);
>  	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev != p->dev) &&
> -		p->state == BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&
> -		nbp_switchdev_allowed_egress(p, skb) &&
> +		(br_mst_is_enabled(p->br) || state == BR_STATE_FORWARDING) &&

Does this compile at all? How exactly did you test this change?
There is no "state" variable in that context.
