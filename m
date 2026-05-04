Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151D1242925
	for <bridge@lists.linux.dev>; Mon,  4 May 2026 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880477; cv=none; b=nEOK9lHxvQQf9MURYBIxb/XvM+A94ntGFh2y4zjnOvSNreYRPK8SK3eRzQXciqHB1KlL+qzEQblDqs3qTMLK3+hnG2ns/H1XmQij09f91uIpQWfBOD/6SD/Rk167RP4hoJXelFkJB/NzUrxta2qlXfy4bteU+kWH8mIFlxZ9UC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880477; c=relaxed/simple;
	bh=2rpPDoGUMbl/OmiwIJkP4efIs256LD8njZZi9FevGN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dClnhBkfTIxQLWy+akas19sHU5MTbieYjfhScx5Gnmi6t5GYlLM/MFw7ATeBodihzQqG9Yf/A6oAjAwA2/T8iz6dKh/hmgpXMu8eJMKQpg3+bkagtE0iEK2qnZUU+wlt/nv2/ux78R6XxK/4cJ1SzRlc+Gmez1/LjNDLNLmNigk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=iUKu8LBe; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="iUKu8LBe"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so55624845e9.0
        for <bridge@lists.linux.dev>; Mon, 04 May 2026 00:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777880474; x=1778485274; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZhDFU6GxZcW7vndx5L08YOJX1khbTM/b3o1EeqP1uk0=;
        b=iUKu8LBeFYp2UyTYv7FvNpOMswD3BJ5pCBjggGpEbmQrK3j4uf80ag/itROw1bEQbT
         3Nv21enRn8Wau9gkEbIuCilFS31nDCiIfKENLgO8qxcbuifPDIFRP9Qcw3LpWx1I++lS
         9eYxHo5QaNbeheUu0g9yS+qXhPjDKm94fjDSrO0sj9r1ASDamIpn98pwsTHZHi5e8piX
         eubHiH4J5FacYQ0xSkTYGobYTSik/c1iJAmebx9lin22n3dySaNaR5uefjUqwFtsL374
         60+8ombqZ/F2/9a0mXVOTqBN738wPSbSUv6P4OvT/dwavnqy5BIotK03HJXZPhXdR1tJ
         Gwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777880474; x=1778485274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZhDFU6GxZcW7vndx5L08YOJX1khbTM/b3o1EeqP1uk0=;
        b=ASHk/DV2ByWa09tBQ11FpJqwjz6Deikpppu+0mUWtceq4Cz41tYOnmvVSicrTiw4Ty
         ENvxRVrDs+MuptBSSauqKJAqcmIqtCQgg9JOVddtysgqUtwpGKUr4Qtd+vAxnkvsYhbU
         qvLKy+O3c0WeftmsaxLLj1iw/SEDChXD9HqV+EPxQRlAYDLuQzwSLtJ8VcV8D+WrMX/E
         0nlddrNSjJEvXLHVU5+Z9gKod6brdRp3yt0bdAMSdAlGh2vwFdyWOF2uTaOQt/GKG6xc
         jGVNX4XukPgXa+ePJRfjUMJie5upSzGmZfGPWVyrdKLBN+IJx8DleHPN3iTyLCT3YlWa
         9JwQ==
X-Forwarded-Encrypted: i=1; AFNElJ/M71GONW95HwHInMT8iYzytaF69K5pQgHXIfMivqkleyPh1YheZN8eswgq3tBOlwqvynaDK9k=@lists.linux.dev
X-Gm-Message-State: AOJu0YyYGVIisVeayknCDWyFWHEDHVMzSDnlY/AV1U/rhTfJL/8tMuCx
	NIFeMyW84EepWPEIQK4hX8N5MJTny5jpUPP4fwnvmKa7wp2I1ROgmjCnwDOQt3spTLo=
X-Gm-Gg: AeBDieuHS5l/x3PvVAjt8N67DSMeeYYb4qTaswFoNa0Tna+kWrC201/PP0RVg4xa0uJ
	OG/Uq+Bmjnw4ezwlUNFzSacV3Ii/puuBdZnXd2bw9kLd7JcHJklpUdQIl0EYd0PJtMjXmegxLch
	uXs6DKXxxg+MeQmAQb9yXnKsJV3Fdgiv7fgXs7bX/FrhlBBtmh7TxuorDkuy6ZZM6CLXkL75Cqs
	eQbV1kBBY93xnuo7Nw2+p6X6cVADD6pVyTDOVHxKJZaiFYe29fD4/eXElpltVFGrKQsp8K97SrB
	XY4xO7i4mHaUJTVvm0JwVRTjO2h84nFRYCLbpb1XO2aNLdh2owQXsVrJ3lXzC1ZjYY/HPSSBgE5
	WwmWbvxA0KwUDOZTY5DviSuRMtPPzuW+AhyXVhFENcy7oB/IomXK16t5UqtMRZHOBOW6O6cLJ/q
	SLVj0PXV6gEHdTqordaQd1zOao7DKCWE3Stgy4FaGYiP5TM/Q7cCQd7v45sJeLZ3HR
X-Received: by 2002:a05:600c:1f11:b0:48a:f18:ece4 with SMTP id 5b1f17b1804b1-48a9866e803mr139507745e9.24.1777880473443;
        Mon, 04 May 2026 00:41:13 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fee4da6sm74095385e9.18.2026.05.04.00.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 00:41:12 -0700 (PDT)
Message-ID: <6803e955-7512-44e4-a0d1-8ad4d62e31e9@blackwall.org>
Date: Mon, 4 May 2026 10:41:10 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] bridge: uapi: Add neigh_forward_grat netlink
 attributes
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
 <20260503073532.2138165-2-danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260503073532.2138165-2-danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/05/2026 10:35, Danielle Ratson wrote:
> Add netlink attributes for controlling gratuitous ARP and unsolicited NA
> forwarding when neighbor suppression is enabled.
> 
> Add IFLA_BRPORT_NEIGH_FORWARD_GRAT for port-level control and
> BRIDGE_VLANDB_ENTRY_NEIGH_FORWARD_GRAT for per-VLAN control.
> 
> The new attributes provide independent control of gratuitous ARP and
> unsolicited NA packets. Operators can enable forwarding for those packets
> for fast mobility across VTEPs while keeping general neighbor suppression
> active.
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>   Documentation/netlink/specs/rt-link.yaml |  3 +++
>   include/uapi/linux/if_bridge.h           |  1 +
>   include/uapi/linux/if_link.h             | 17 +++++++++++++++++
>   net/core/rtnetlink.c                     |  2 +-
>   4 files changed, 22 insertions(+), 1 deletion(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

