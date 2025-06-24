Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398FE2797BA
	for <bridge@lists.linux-foundation.org>; Tue, 24 Jun 2025 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750768914; cv=none; b=EgRsxSBtoNYnRTn2RB1DjW28ZtV9ktKrbKs4kVWjJQsi2pAe1sTwdGTytbFfrJJwsPnjsvklfIYTS++SgMJlSQuokTAB3sxPRyyrFWH5PyKv+CPn7RyVm0W2u6scYcarSBI2tYpaao6WOKJZ7wtVIxEUa78IptEtZctF2fe4c3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750768914; c=relaxed/simple;
	bh=cXGzktznsPaCd9niYVc++U800pwYs32DegeREu5MQF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Is9v7RPDOM+TdCtZCCc5mUJhhdJ6Cz/97DStOfR0jaBwWOy4WwJ4yyspspL7XbjClREb+ntKt07d4ALbxR0c/zJ4p9wklgaiezbYmGg9p4wSOGBHAuMGmZhWygECubcwZ7A62Boqt7a9kx9Muxhlsggvou11QRS6jgQZNl9ihuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=a1j8dOBJ; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="a1j8dOBJ"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C030340089
	for <bridge@lists.linux-foundation.org>; Tue, 24 Jun 2025 12:41:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gEwPxVpObjX6 for <bridge@lists.linux-foundation.org>;
 Tue, 24 Jun 2025 12:41:52 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1F7A3402BC
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F7A3402BC
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=a1j8dOBJ
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1F7A3402BC
	for <bridge@lists.linux-foundation.org>; Tue, 24 Jun 2025 12:41:52 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-ae0b6532345so43825766b.1
        for <bridge@lists.linux-foundation.org>; Tue, 24 Jun 2025 05:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1750768910; x=1751373710; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4iJYQvGe8WCzmQmQubLMat5jwWy7Evztun3tUQTNGJQ=;
        b=a1j8dOBJylxkwbfFzTroZFZXi4NOr6aExAm2QUlTDPvx8o56gfxi5pWhgf3KpVrJts
         Qgdi6g67dqtJvDfauvVZI8kD3mZ6fCHF8l/Z6X/Pt/y57LBEGR9xVshSAVmgmfICmq3K
         fY609cV2vPfO25SiwRRQvrz0GYR8an8UInMS9g2zBz2af2IADUT1zVlD13R+z9kCW8Wj
         q1FmRtN8Bx6pWqGR2VM2sHXmeqef6k1wZPVn/cV1FmWAckp9bMoWR5F+5XABwVI/8JRL
         mS0L8WjQFzlNZjdK70PbkLOe6x/tbSEGt800iMsYPHKFLTk8FGcbdYFF5NpidvhCghSr
         w5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750768910; x=1751373710;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4iJYQvGe8WCzmQmQubLMat5jwWy7Evztun3tUQTNGJQ=;
        b=PY3Lq6dnI/eddoxX32RnaGncDTzZa5VBLEN1H34RJTZR6iefSA/Bu6/cwiBIlRyxZg
         xX85+yF3tRN9fL53GGEu+MArHm9GonYEI+viff4K7HjLLyfRtYNOGbWBXr+Vp3KJggaO
         6786qUkaA803HM53cvMpJU3Y2b8oR49+0Zqo2Z1tGdg0wR48G6s3IpN2U+ZUNIEGYhaN
         WKQwGYDvovIzEe3WoyokQ9SLAimUr+bliXRz72PwsEvsDj5kFdti29dvlfrv3kcNEwBC
         4zBB1qmu16Xx+nT/OefTFrykQzHM2ugZ720wLm91/PsYMw+sSOEbiBhXIxP8Vb1PLfr9
         fhrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYhE00vZolPO2Vng/5IACcvA+jjczXIuOC+/nOszH9CGr/S+8jW6Aw4bZ5nVw/DBjgVWGtzo0=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxCKwRDv8Et3DY8urCsfDOgLF+M55P8HcbNC7t9fML/Ws1ylOwW
	iZwmK2alXdehw+1vMkagPYLrfUUXB8WIReWB9SZnpl8h6ZmAgsKyQ6eCQW3+ZCJr2Ms=
X-Gm-Gg: ASbGncuobTyCez5KkRffE0FnF3f6XJlT7OcPlvBgg5IrkLelAI1zzyzeg+Oo4YbZ3n+
	e59HWWXIFYrX9mEFouhO2rJi8Xe/2qV1ulcetsXrwIGh3Ic1RsRq+Gs8hSmAEnjcN7xFeKzRQ4e
	ku2RwVqK2UXoUCER/FLXjXhA1C/uIXKu++z2vFA8OpDLaE6lM0vdpLSyvPD605nE796+GS8IeAK
	40WffEKZNUFYz/N14xW59qLD+jnCPQ8bMHybn1M+oqJuxt568lHQhwZt+jtZ6sE0fi83zKiaGJ9
	Thp8gYq8TbI+KjU9eluLc3e1zziq62PRlDXYnhrI7AJMlM6Vc4KheMe26E6gZXikqj7Ofo9RU/K
	7VcZTgfeledBfBVi5LA==
X-Google-Smtp-Source: AGHT+IGXmUe4yUvnAnWDcICMoNz7pR9dQh11kqyZfBlXN8ECSr1NR39mxMd3RQDLoTWSrCl/S1IVzA==
X-Received: by 2002:a17:907:7f2a:b0:ae0:a351:6208 with SMTP id a640c23a62f3a-ae0a715cf32mr298541266b.1.1750768910090;
        Tue, 24 Jun 2025 05:41:50 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053e7fbd9sm869476366b.33.2025.06.24.05.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 05:41:49 -0700 (PDT)
Message-ID: <efd218b8-df7d-4d22-a22d-8c8a59c171b0@blackwall.org>
Date: Tue, 24 Jun 2025 15:41:48 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v5 3/3] bridge: refactor bridge mcast
 querier function
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, idosch@nvidia.com, bridge@lists.linux-foundation.org,
 entwicklung@pengutronix.de
References: <20250623093316.1215970-1-f.pfitzner@pengutronix.de>
 <20250623093316.1215970-4-f.pfitzner@pengutronix.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250623093316.1215970-4-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/25 12:33, Fabian Pfitzner wrote:
> Make code more readable and consistent with other functions.
> 
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
> ---
>  lib/bridge.c | 72 +++++++++++++++++++++++++---------------------------
>  1 file changed, 34 insertions(+), 38 deletions(-)
> 

+1 for Ido's suggestion to remove the blank line, checkpatch isn't always
right :) but it's a minor nit, looks good to me overall:

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

