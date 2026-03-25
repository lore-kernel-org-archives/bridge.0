Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AD5356A24
	for <bridge@lists.linux.dev>; Wed, 25 Mar 2026 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774423713; cv=none; b=qCw9jCdesFaSTeBJXIhbRtY2JF/LAQYiERv3vRgwLyps3TSdvdP+VWp7Qtgy/6F0nCNGN+GRnFYEE+nrIG/N2GRyxNpKGVblMtOUwYvQGt8JcHQkqkjdcdwUD3dr5tpsTHHQvI6ZhRN6ZbifV+vtQWeFOEwzGYcg4v33qPiEZns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774423713; c=relaxed/simple;
	bh=S/BaYDdPcQXTkL2SnY6Z59AFoydNh1oEXzUXxXeESmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPcpXT2tOne3+5JF+P9YYtbP/23XVDON2ssv5vYx06QYzNXc6brudZq5AkdTHK3Cq+RtuilAHGhUeBQPfo07W5Ni1EAGDG2VO7tKvY3iPBzkm9xv8PISO8+uBLBkhbEU2QSD4F8Ot9PGJOV5ZAortLpodNRI1MAFS1LP1i0vmjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vk3XXkVB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk3XXkVB"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b97bca3797dso266692466b.0
        for <bridge@lists.linux.dev>; Wed, 25 Mar 2026 00:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774423711; x=1775028511; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xXcLoA3AOm8JsZyBFRvvn/2aLGbl2SRuVxCEIFV1m/A=;
        b=Vk3XXkVBsjF9JB4qdwhiTLgMZ7TCJSRY9tlBif1CcX/xwtyp6OBznCh/+yckIKyT+I
         XkF3eHe+RylxRhHVt7SsI5cZOVItLY4LuAy5Xlms8dMt+a1rpWV++Y8AxvsRRdjzFivt
         56l+UDucroKuKSCdiQLgfBOJ13K8tmaX20NtK+JvNI0E4GYe7ecC+1Tnyn8YBchC2xJe
         ySzehMk6QvWuEpkImO0X5FFa263Oied4Ng83OmlC2OUfXYhyT08vZRzXuG65O4u2HmCk
         a4tEbDhj5BsZsUVn/XNl2Y6tvm4/amLVw2Akw6pQXp6swy5ohjtU93WwYXwCRfR/A7LZ
         ZFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774423711; x=1775028511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXcLoA3AOm8JsZyBFRvvn/2aLGbl2SRuVxCEIFV1m/A=;
        b=rl6iim7SAxgoyk/mUMpWzhmV80rVYJpRW0EEaF3OWMkkzYPw99rGA6d3YO/VpuCBSt
         GcXIaKFt0dbvQmfRQZbg8M4UGwOH1s1kS+IOsI0vaLhgnQvGKB63or/9UBnyKEn7YNIn
         JlDelHA9uj+Rbo/hi7kO0Z7jet/thSeL+kHZpdYUmKbkJJL9PhPy45YGQzmsaz6QHRjH
         6kztOIIAJr1VZLUmgfh9YctRNhgYud477cxtTPfEnwsp10QQ+r4VRoUnqEUoiN5Xw+rS
         2vyb4EIF+5lG0Ke+gt8MXKlD3hh/OnhOeSP2qIMSHIzlSjnZSahPGuqfhlDihMc2jRZl
         sduQ==
X-Gm-Message-State: AOJu0YydBt7t89nJ3AQu/plpHZEgp+SU2n0CBYUtYcUGXQsqksrFFc/9
	D6VfvN6nxXKOlcPLRCs9dDuu3sCEU97I7fUoT9a0P/tKlbGif9UjcsUr
X-Gm-Gg: ATEYQzxs/aakNKSAo/xUVM6PvRRe/2m+HGFIN4cx1TaEExgdXxaC28GPX1sqmDrIIAw
	JIP3KMOc573QKflaBkq7IPN1bV/IXFsvJOdi9kpHgTYBi2XIIyKeROJrGkY2bkpClMG+I/cm3S1
	dbyMSP8Ztp6VjvllZfGMt3e+JLR1ej4vPR2UnLx05IwUTnDku5XQX5Oc8eaxEf9MBBTw12+HQ7c
	72LTJzlBy1u1U6tvuJ8i+0UjQv7lmWjcTgCxZFN4GY3MUBDE2+wP36pF/beJpjKCravz4bLjyv8
	RH3uJdbhOul4+UYq6DlZTSlSJGbwBf3V6NwWEXezDafmsmWNiFd+2OEzE6AQkReQ6B27T8W8Ovi
	2tzGmkpTPvvW8/wY7PDB8IVhDEyYeIHemnKWNaTfFyW/6alRgMdXiRBS8wdZQG3xVVPKwqWLHuU
	9YQWNB2gq30hr0rx1yiDfXPmy6L7bbWHsVddX9q1FIC2omMF5+7tSbeaE7LCfnw5cBt7X/HTtGN
	fVoNqp33B2Z
X-Received: by 2002:a17:907:d1c:b0:b98:6c41:a77f with SMTP id a640c23a62f3a-b9a3f1a815dmr138126866b.20.1774423710456;
        Wed, 25 Mar 2026 00:28:30 -0700 (PDT)
Received: from [192.168.0.2] (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b984b056f3bsm573597266b.26.2026.03.25.00.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 00:28:29 -0700 (PDT)
Message-ID: <abb8a10c-571e-44f2-a15e-1d5da288963d@gmail.com>
Date: Wed, 25 Mar 2026 08:28:28 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] net: bridge: add stp_mode attribute for STP
 mode selection
To: Andy Roulin <aroulin@nvidia.com>, netdev@vger.kernel.org
Cc: bridge@lists.linux.dev, Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 Petr Machata <petrm@nvidia.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260324184942.2828691-1-aroulin@nvidia.com>
Content-Language: en-US
From: Jonas Gorski <jonas.gorski@gmail.com>
In-Reply-To: <20260324184942.2828691-1-aroulin@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/03/2026 19:49, Andy Roulin wrote:
> The bridge-stp usermode helper is currently restricted to the initial
> network namespace, preventing userspace STP daemons like mstpd from
> operating on bridges in other namespaces. Since commit ff62198553e4
> ("bridge: Only call /sbin/bridge-stp for the initial network
> namespace"), bridges in non-init namespaces silently fall back to
> kernel STP with no way to request userspace STP.
> 
> This series adds a new IFLA_BR_STP_MODE bridge attribute that allows
> explicit per-bridge control over STP mode selection. Three modes are
> supported:
> 
>   - auto (default): existing behavior, try /sbin/bridge-stp in
>     init_net, fall back to kernel STP otherwise
>   - user: directly enable BR_USER_STP without invoking the helper,
>     works in any network namespace
>   - kernel: directly enable BR_KERNEL_STP without invoking the helper

I like that very much! This will also allow selftests for
switchdev/dsa drivers for correct (mst) STP state (change) handling.

> The user and kernel modes bypass call_usermodehelper() entirely,
> addressing the security concerns discussed at [1]. The caller is
> responsible for managing the userspace STP daemon directly, rather
> than relying on the kernel to invoke /sbin/bridge-stp.

Should the caller directly manage the STP daemon, or could the STP
daemon also just automatically manage bridges with
IFLA_BR_STP_STATE=BR_STP_MODE_KERNEL (and IFLA_BR_STP_STATE != 0)?

The latter would require less changes for network managers, as they
wouldn't need to be aware of (individual) STP daemon
implementations.

But I guess either is fine, as long as the latter behavior
configurable.

Best regards,
Jonas
