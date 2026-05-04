Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E862E06EA
	for <bridge@lists.linux.dev>; Mon,  4 May 2026 07:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880637; cv=none; b=QTicUs2ndUqvxFcuA5NRl0ybuFWVB17jNbGaXelvf3ixo6Oh3kb6NlVm2ndKaF0y/xLKVOFsr4TuSsSqKO+nqjHma1elp8KHjTv86F5TNYK5RPtIzFXS9avARPp5VF1IycwswiKD6cV+1ChDqkFf7xyefiHF0jDJ7uRBtSkYgnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880637; c=relaxed/simple;
	bh=boGwKw02j+YN2/NIEQgBpXs69EV5KI3+mVKmW0Vhc30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3x4vmmM/jqzmVAiKXS0oiqxwX98PGzxtbUmrbwBwv2+Y1JzVG1QbnL1Vcgd6P44OZ8LcZaNAqBAt4ZWaNWcRfI7Chi4chd+e1GECKj+Vw4vkfY7KTTIUpwgQKtyNmCmMz5hyQ3mw1Du3Sm60gYy4ghHEAwqBCa7BHKlPfyfVt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=FuP+iZnb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="FuP+iZnb"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48896199cbaso33352935e9.1
        for <bridge@lists.linux.dev>; Mon, 04 May 2026 00:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777880633; x=1778485433; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VyNdEo2zQTUk85Np/ZYvwEJkoha6O3/ZtIdB/pJF5MU=;
        b=FuP+iZnbZd6ziIARK165CYwDi9UwSNZDDFKhHBpMq6YbN31zmUP8Gge7etaHvKJdJJ
         iSgGT7ruZqsuWNsIvpznSNcBoGGV2fz7t1qn/1T2A+JtTf31s0ZI5dxVDRdhAkhW3zNr
         Bic9LCq7jI9em+qJHjphej2sJbaGUZD6lW3tVgfDwpcqqRrXC8QeMu+f13zHvIon4MxO
         Jl9tlqVo0MP9agiMTup1FWlmYKux17V81LNmMigj8nV54EbBmRZqWoZB+WAPl9/3h/bE
         phHhQRApAilu/MyE9NT7lGEvGgYV8XjoJf6YQmq14/Be+h0USo90myteZr+XuZirO6kl
         wmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777880633; x=1778485433;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VyNdEo2zQTUk85Np/ZYvwEJkoha6O3/ZtIdB/pJF5MU=;
        b=EF86Pjpg3Zpv+/uVKtl0Ihouv0C5Q7dHBvDxmFkL6cjcNu6sf6/ppzh+YU31ibFIef
         MyQ4SrXgcae8KCZXrcsvMPSfyRVTCkjX0B5e5wV9ne0dC2aoFWb0qBOTqFPO39vb3tBd
         OBASdDhGuUFHcWmuhIQmDYMgh05nSXrV4hAV+2ZV+2yCO2NJHzxA1FYl+8j9JH9NmAMx
         mGDClRYyHQuFVomPhTrYzfRrDXvM+cap9OsNalkanIUt+I6WKN09mZWtEohLXApwjwgV
         wZD9kLBsAiUTLLviqC1n1KlRvdcVP+8M88AfhOVdc0n89at40KTkUcicHo+zGiC1pyIX
         2r7g==
X-Forwarded-Encrypted: i=1; AFNElJ+DpoVxTTrHdlDyWjIicaw5I/Smd3ZVOFrtstQyb4KWPs/fqqIaQifJLnxgV7QYq6spTAVEyk4=@lists.linux.dev
X-Gm-Message-State: AOJu0YzuVNJuCtHIHxgXyfa4aYsDphvfE/QKwiZamR/5hyytuHlUP64T
	QyY8+HtG/NvLT/E10K3GEc52C5Tyrj8asPx4uHiYk/j6PaiU3BwOxO90WHX8/RfA9wU=
X-Gm-Gg: AeBDieth2gHcny+0u1mJI0mAfVODz54nuxQHcAtnF2oOYyAYPDHGLHU9RZTRdzbCf09
	rFVLU/K4jQAYP/IjEd86zrB8g/Bt5z4iKjWrE55PCO7GqTBDPtLdwnuf3qw1IDTTONZ+t6bOF+c
	J7XgfMoQNyLarPsk59iKvgpkHFNhi/ZEe56vOty/BxmfOnDMHkQ18kAxsKz5O4LnaEYSSPvLILK
	Fg8MnYeXYHGY6tLs/+whbaFjP/weLn3SdkrqE17JhS+yPzONTBAldN31N5BP+zrjaCW0FgdeXNy
	OeYZtJlglR4oDhtyNZ/WoHPJKdBHUAo3+gyjNjwtVA8eGwJoNJiZG+sf+XOwdbrFYSlbXju/sXG
	F3Ln6k7TYj9bS1hqrrDdmDNPvefles81PoW+fYHmt7HS68DPI1PdydAd0/f6tjy5Ld7yjtN4T2r
	jQz5JgR4dj/32N0kgI1AFVNVWRg8xaFkyddWOBu9pjpJTRRaQDCBaK8ryHYOWzdUnU
X-Received: by 2002:a05:600c:1604:b0:48a:66a8:9981 with SMTP id 5b1f17b1804b1-48d0562f7efmr35523185e9.27.1777880632919;
        Mon, 04 May 2026 00:43:52 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed6b89sm306862325e9.1.2026.05.04.00.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 00:43:52 -0700 (PDT)
Message-ID: <f3a36ed5-52b2-481b-aee6-c2080cf5f14e@blackwall.org>
Date: Mon, 4 May 2026 10:43:49 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/6] bridge: Add per-VLAN netlink handling for
 neigh_forward_grat
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com,
 andrew+netdev@lunn.ch, shuah@kernel.org, ast@fiberby.net,
 liuhangbin@gmail.com, daniel@iogearbox.net, aroulin@nvidia.com,
 fmaurer@redhat.com, sdf.kernel@gmail.com, sd@queasysnail.net,
 kees@kernel.org, nickgarlis@gmail.com, amorenoz@redhat.com,
 alasdair@mcwilliam.dev, johannes.wiesboeck@aisec.fraunhofer.de,
 petrm@nvidia.com, linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
 linux-kselftest@vger.kernel.org
References: <20260503073532.2138165-1-danieller@nvidia.com>
 <20260503073532.2138165-6-danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260503073532.2138165-6-danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/05/2026 10:35, Danielle Ratson wrote:
> Add netlink handlers for the per-VLAN neigh_forward_grat option via
> BRIDGE_VLANDB_ENTRY_NEIGH_FORWARD_GRAT attribute.
> 
> The per-VLAN option provides fine-grained control, allowing different
> VLANs on the same port to have different gratuitous ARP/unsolicited NA
> forwarding behavior.
> 
> This enables control via 'bridge' commands:
>   # bridge vlan set dev eth0 vid 10 neigh_suppress on
>   # bridge vlan set dev eth0 vid 10 neigh_forward_grat on
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>   net/bridge/br_vlan.c         |  1 +
>   net/bridge/br_vlan_options.c | 24 ++++++++++++++++++++++--
>   2 files changed, 23 insertions(+), 2 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



