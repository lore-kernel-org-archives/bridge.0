Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C96517C21E
	for <bridge@lists.linux.dev>; Sun, 22 Dec 2024 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734860799; cv=none; b=uaBLD6M5N8QSOnbgAum/Rs54Kw7FWZwC2qXmpuMkshU4CYqvr0fXxa1a5rqLcR+nWNKkqeESusMfComCgo3zLiyvlDXbALUAcMFgrk8bDIihpkPMxohqky0wHODIlQ1OE22M8zbVb8A1i2e7IRRDh8yiY0LhaXiOfO8Vs8obOyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734860799; c=relaxed/simple;
	bh=QWAl/PSCX1/7bs2eWj1O5Ous7TH+5LjUcrtPjfqJolE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5iQ+8WQEytAio/WkqXy8Uz7CU+haZr2C1jwcY2gF/CJe8P3OK8gu8gdbdcXsnIr5JBPrB8QDSVZmgZ1ltmXMZO+MOaHHsq2s4u8oJeq+8MHNnFLiqSK78dQQ5LAaEiur0h5vjJK9LkG0NpTctMkRduSvKHTPztzUvQSu8c7ctE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=1dMvjBHV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="1dMvjBHV"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3862df95f92so1550991f8f.2
        for <bridge@lists.linux.dev>; Sun, 22 Dec 2024 01:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734860796; x=1735465596; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r01Rf7AD6Pn5yErJlGrv2YF9sGspDReRgMmzJT8V6OU=;
        b=1dMvjBHVLlelAs0ZErzWEA9ofDAjmvem02vR6x+fqTi4/q4EWQ+4Mqj5SSIM64ki+7
         GRqGgFdROIx1mYKtxnhEWidu0rZxesVI18ThZMbBtob0D9fGsEcFkPCScnA2y87ftIaE
         2aYoNPPux4o+5IkYN9Q7566ht6kLaXxLeuZjS1Xu1OMwkZy6GQFCFHO3w6c7Nsjsjv7V
         JN/oVYN2/WfcVx3sjW4I9nopHSBK0hIhbSwl7ateCvVOGmuSuEsnWJ/PRfPRRaO8rE1v
         QGoE3dFUtCS5NJ+V5GslNc2+XCXvZRZWSshV0miUMdOgJlw8xNft4PWEzu4HMPPT2MOt
         0TRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734860796; x=1735465596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r01Rf7AD6Pn5yErJlGrv2YF9sGspDReRgMmzJT8V6OU=;
        b=p1CZUL7NfZG3JNDXGfnGkFskoQwHo0NBEWt/dDyCf/JXw3ACyMHNwExKbcpJABcusD
         c8Y4GcRCytaF43pE98Gl38+hmfS4i03/wad5zkSG3N54kCpM5oGdkmZapqeSPSP/ZlSE
         m0Tbd/c495i+DoCnlAXsaXO1ulO4kXh53YYiRAsByjVOLxwYiUr+Q2g/mPO7Tk/fXMwK
         dUDV201D/WM953exqnIHvfbvAwcFzJiFI2qu31BWLK8Ki47XVARhMkl5PBRaTqf8ZWlt
         GJmgOfj1eE6d2XLBg8ZifCLvuOjcQdGAEoVsdMJbFUVJXeBub/yq68DaY75LZ4wdpK78
         pC8g==
X-Gm-Message-State: AOJu0YwzmXvlg3/JlS9mfozCIdMsrrrH6XPQdWfmtLgbjA29QVxjJOC3
	XOvmm2RFe5fjtVzBKYn2i6VkLdTiGDsk/BEEekXzIxgx6hdoKICjGVSYizNM52c=
X-Gm-Gg: ASbGncvtuPfrwuxWtkQ/PkQ8WjCLu8o2EdGq0ugES8d4Up3i7lqC1fCP33xM2b/sNFz
	RSX2YzGkYsQubWRBfrQBhGnzgn6M9AWbjYjFnR+I0ES2pGyFTWN3btw3TGsWCNkKGR2XesUW6JB
	1hED4R1yflcK5dCk6A7EOnxY9w9ZFUEr/XXcUAbILB58sFnEa2CUgQi6SH8ngQ/qIXZjksFxiyG
	EzkGHKc1rpoQ8rT4sL+c5U71Z4isLR9Tq7y0rh6c4RClv1AVDfUqL7F9TgCMQ==
X-Google-Smtp-Source: AGHT+IGmgUPUPDdF82PD4GL38Dn/wmNBTo6smgxNBXy3wwBvd7zwwc/UKBn2jlcLMMIzLiNArbxJxg==
X-Received: by 2002:a5d:5e09:0:b0:385:faec:d94d with SMTP id ffacd0b85a97d-38a223fd75amr8805141f8f.51.1734860795847;
        Sun, 22 Dec 2024 01:46:35 -0800 (PST)
Received: from [192.168.0.105] ([109.160.72.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611ea3e0sm100043945e9.7.2024.12.22.01.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2024 01:46:35 -0800 (PST)
Message-ID: <f42d495f-abd3-4f8a-b647-ddebe2e6249d@blackwall.org>
Date: Sun, 22 Dec 2024 11:46:34 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: bridge: add skb drop reasons to the
 most common drop points
To: Radu Rendec <rrendec@redhat.com>, Ido Schimmel <idosch@idosch.org>,
 Roopa Prabhu <roopa@nvidia.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20241219163606.717758-1-rrendec@redhat.com>
 <20241219163606.717758-3-rrendec@redhat.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241219163606.717758-3-rrendec@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/24 18:36, Radu Rendec wrote:
> The bridge input code may drop frames for various reasons and at various
> points in the ingress handling logic. Currently kfree_skb() is used
> everywhere, and therefore no drop reason is specified. Add drop reasons
> to the most common drop points.
> 
> Drop reasons are not added exhaustively to the entire bridge code. The
> intention is to incrementally add drop reasons to the rest of the bridge
> code in follow up patches.
> 
> Signed-off-by: Radu Rendec <rrendec@redhat.com>
> ---
>  include/net/dropreason-core.h | 12 ++++++++++++
>  net/bridge/br_forward.c       | 16 ++++++++++++----
>  net/bridge/br_input.c         | 20 +++++++++++++++-----
>  3 files changed, 39 insertions(+), 9 deletions(-)
> 


Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
