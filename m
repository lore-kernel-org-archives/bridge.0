Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B66D189BB6
	for <bridge@lists.linux.dev>; Sun, 22 Dec 2024 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734860714; cv=none; b=cc79Dzp2ElabljQ0Yfsfb9t7RIPiPHurZRbzaGFIreYgPil1tcLpJ2P8ZbecdRMUM4tZpB9oXBgjW8HjVqi8dZhGLT0Yw2QDLVIBoy+8Sx2I40LG7UVYHgJMy4ofTmEl7FTatLEnNpaUX87tqfEFTB8u6U0KynE0tLC1R2gGd0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734860714; c=relaxed/simple;
	bh=OUXsu3SsIQEIs/KvbrddT+mv/XrsjETOldACl/PfCqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWTjm2LRyheKguQ9bK8fJJbfXb83p80PG0/i6o3IEtOi1t2gLbb/XHm03MFlsfz000TxSWpUeIxq86/qHEzQlRmSM8XkW8DGUHqtpyx5gvknIT+hEqUCRbi/W1WvDUJM8jNDvV8wUDIqQKK0vtO7VvCa1jYvclaTVuVfH0Djw2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=0yv60Hdm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="0yv60Hdm"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43622267b2eso34089975e9.0
        for <bridge@lists.linux.dev>; Sun, 22 Dec 2024 01:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734860710; x=1735465510; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y7UylIxX/vO/9Hcmkt6Up44Ia9UxkJvcsUx2VBfUKlI=;
        b=0yv60HdmPkvxIx0Yvh9EYp+flN4PUfPSOhs95PqU2qZGuq9Ea7o3KlGDkqKkuXmgji
         GcCUskjHCoVz3N5QU9qA4MHB2xzEqhgd0WuZFmJTYEgDH6ACTnfoY407xIrEMzIlxTPf
         YD+biKneLHEXxMra4RXk/03o5WZliu3kqfB9MFQHkQYuMLALQoimV70prTgmIbdVkPof
         J4I1DP5rxcAk+V1QO2CEI8gKCIWKho1TRgYSHaRjKcuXrzKUqiy4x3PIIVOKMmawnGwe
         jZHkMH+5WzI4IcGRsm+J6iEY6q4xwd4lutQuX1Aorz3Iawn9/GJk5Ia+fiy78WaSWimD
         PORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734860710; x=1735465510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7UylIxX/vO/9Hcmkt6Up44Ia9UxkJvcsUx2VBfUKlI=;
        b=nNV97wjAc3SEWTAlLZVg8c3EvyDGvXkMvR5RYxNPQ9fxvDcual3KEterk+V4kVvJVk
         8rPUi4OtEESqDFPgqWlAw/5mA4l/7PTTeER82bK6cYmLp1MnRU11JWzYijTVsbybOrHr
         X5nN25Xtm0UZYo9Uq+eU5h8neQg5uTylyJt6/QJ0G3tlnXDWvDLAdOakZnWWwu04Kqhg
         44AH/KyNyulTt/7UCOFqozRkUa9OBNGSdOhTxgEs6+SN0nOqJn1370qmeXgQ48vqxu2t
         55fwk3mfWZwuxeRQn20AoIhUIBb48zsjQLkwbrv4RaVGH5aq4xWVJAhjFfpDfGV8aHVs
         2ZWg==
X-Gm-Message-State: AOJu0Yyj/PcbNUYa6VGR4oH+rYUjshmeYhNEJaycj6c1Vgu3TEpfqdv9
	WTazXbJasvgrYehDB2R+Rg6Oj1H+dFyvPTWo5kkoLDysZGoEjYrnW8PC2czNJ3E=
X-Gm-Gg: ASbGnctVYREcWvu5WbuOszA26IMakNRmG9AMmombv2EjRoQmkfZ1GyqAxaIsQs4Pftd
	ufT/ajIvSRwY/DtBe0diCRPseknE+K5gDDbzEjAu53VVdcz4R+bTCdy+BOgFP1ggG/9spFqdMx3
	Evbgt3ETQUcsbrerA5Cm1R7zMrrOpOTJVSNtFIgKoKnh6qigIJkybFQIzmnAmhXmOLYMs1kLsw+
	reVbo2TICH2aH/zQSCLlmPBYJngZjI2OlQlsQYV6frQAAKXARXSp3b8HDm6sQ==
X-Google-Smtp-Source: AGHT+IFz6DFvEGYC1jixUKT369V5V2dPgCc9bnnP6QVvHtzTXLaTgll2cK+dV9FnlMJlWd6TXwcbzw==
X-Received: by 2002:a5d:64cc:0:b0:385:eb85:f111 with SMTP id ffacd0b85a97d-38a221eab40mr7017731f8f.14.1734860710400;
        Sun, 22 Dec 2024 01:45:10 -0800 (PST)
Received: from [192.168.0.105] ([109.160.72.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e1acsm8473677f8f.68.2024.12.22.01.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2024 01:45:09 -0800 (PST)
Message-ID: <e1384459-4923-4e02-9051-404c5291da95@blackwall.org>
Date: Sun, 22 Dec 2024 11:45:07 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net: vxlan: rename
 SKB_DROP_REASON_VXLAN_NO_REMOTE
To: Radu Rendec <rrendec@redhat.com>, Ido Schimmel <idosch@idosch.org>,
 Roopa Prabhu <roopa@nvidia.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20241219163606.717758-1-rrendec@redhat.com>
 <20241219163606.717758-2-rrendec@redhat.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241219163606.717758-2-rrendec@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/24 18:36, Radu Rendec wrote:
> The SKB_DROP_REASON_VXLAN_NO_REMOTE skb drop reason was introduced in
> the specific context of vxlan. As it turns out, there are similar cases
> when a packet needs to be dropped in other parts of the network stack,
> such as the bridge module.
> 
> Rename SKB_DROP_REASON_VXLAN_NO_REMOTE and give it a more generic name,
> so that it can be used in other parts of the network stack. This is not
> a functional change, and the numeric value of the drop reason even
> remains unchanged.
> 
> Signed-off-by: Radu Rendec <rrendec@redhat.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 4 ++--
>  drivers/net/vxlan/vxlan_mdb.c  | 2 +-
>  include/net/dropreason-core.h  | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

