Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0732D2E62A0
	for <bridge@lists.linux.dev>; Fri,  4 Apr 2025 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743762634; cv=none; b=AAlEcMKXa1rt7xJauq35nLCThU+HN/ZKrPw4LX6Cw7nxBoQ8f5gQTSLCjCdzmwZeed8eCZZjE/qVLr/ngNlKgehWPMLMAs91xU0t20o8DeqiimhHE+Ll+qn722VdXb851ukWi3jM4/mM9YnGoRpdjqsP3y8Kh8M4rXy/h6I+qJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743762634; c=relaxed/simple;
	bh=tuR8ogLN+102A8mr0se4sJNMwYt11xopo3TwsfwUfn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYM5ke1N/VBRi8C8N1hhtRhOTyouQS18pw4uWolscqi3dfkAluROq9MB0lZ8RPuNvV4s/goOUcL95l6ERAu6j8V7JOnYlxRFrlMXUfuFMbxTzQIdjP3NAZvd4qpquWW41wjbGTeD2SGPz7FslY0rgcyGj6QekkKm4cwrX1adP04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=f8ZyP0X5; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="f8ZyP0X5"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso19466385e9.3
        for <bridge@lists.linux.dev>; Fri, 04 Apr 2025 03:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743762630; x=1744367430; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fCa0h1WYmNfXaxL3CdCkJZxEN7JBqurAiMu0YdgPsPE=;
        b=f8ZyP0X5oqntdACNFf11IUUinnglP8lNGbU0ckr6J6QVCVXZDDfz1ibrtbWoFUFvHK
         V54iOwT3/UGj0sOuEFTruGqDYTTxokbrmdeESVs28kC5jDv8Tu2mKtPKQcpHc7s2LDNS
         zr6gmCKOyG881r5SoRvaB+qdUDcDZ9omzLjDjI/aYxIlJz9Qo/gdC3nrW4Wr/c1QOL2u
         7AVH5LBYdIQvgqhQN1V2QG0avoxqRC0WHazeuPClFWxJ76waSICIW0v4TH4zd/BQM4Ma
         N8Vv5697X+5D5yza2W+CwnvXYQfGvn+rXckiRk854k1RrwlVCnf0SGdqCb1QwBAp1gVn
         E0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743762630; x=1744367430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fCa0h1WYmNfXaxL3CdCkJZxEN7JBqurAiMu0YdgPsPE=;
        b=dglYGN+67ZrS5X+vNX4GF0Z8gHwUzLEzNXSn8zT6AXTJ30tcywjEm3hgYkX6pMjtQp
         tH6cU4rosUzM25p7RNOEMXztZViIA84oPsLEc3nHhUaS+RPqpdTLf/JGDvZLiw1zNDTD
         S5fGUaBsSOmapLFVZ4hS+8vHwkjNPpsbDVgK/X5JDK9mxc8C6WdO8+XT47eiM50wquh/
         Aseut/ijoqftM03adTzjJsMtAl83FaGB/+RzZlks+en8RYIQrpBquiw/7z2lOgGvllxS
         GrZjvgOWFxzrgz4FH5YOmTWegnhYeNexZUw1MkO0HDLfm7S0NwegF3i2ySExH7xz57q0
         Rufg==
X-Forwarded-Encrypted: i=1; AJvYcCX2Lm6eHt9IMbg/e9xYJVFo1tQLFWtgF46waNv+opfMIl72IagJApeO5bO9e++rkkabRWuc9V8=@lists.linux.dev
X-Gm-Message-State: AOJu0YxCHvjhSknnHuVEyHTJiM51hNVZFplmeMw/TuaA5BGFZlWw44nD
	XzHuNLciPm4y20beFLzbpl8hYTbiIeJLhm0uhQd34o4Eo2pxu/wNKHuTmh0XTHA=
X-Gm-Gg: ASbGncsF/Es9UsiqhM3+9pdTB9U4gGfG9/q/RoJe16TozkbGKLzIsiktWmeYMcyDwgU
	baRvfy7QO0aaO2OjcwNh+VtTpn3ubmIQ433DedGhibZIumaaHDt9jqNUotD1IekDE67KwqUuJps
	tsdVCaWjNNXTjv5CKQjIRBqvjL82ofU6GDrvEgjmG1eZ+QG4n5QmjCu4EiPHQJEaN6gobxDv+5W
	2xCKlpSg6q3Awxy6NTYOENXF5WyVj7emGjtfhUB5YllskfOXLggVk7DMjCgzSmUyjP584LxaWR3
	SbWGoZrwfQ4ttiFvBlw7KjgIMD3R+hdJHGE77oyaW739ogqlQbNA4GEFbpYUiedu63rOYa8jK4s
	j
X-Google-Smtp-Source: AGHT+IEj/9kwyzS+lDrHuF1aDtd7ZnFRYoi1f0ub48TiwcmQog45MqDKf6yHGPbubxz8L3SJeZRakw==
X-Received: by 2002:a05:600c:198d:b0:43c:fe15:41c9 with SMTP id 5b1f17b1804b1-43ed0bf6378mr20646095e9.9.1743762630130;
        Fri, 04 Apr 2025 03:30:30 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1663046sm46400095e9.13.2025.04.04.03.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 03:30:29 -0700 (PDT)
Message-ID: <804b495b-eb2a-46a6-a42f-bee87fd45abe@blackwall.org>
Date: Fri, 4 Apr 2025 13:30:28 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 net-next 2/3] net: bridge: Add
 offload_fail_notification bopt
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <joseph.huang.2024@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250403234412.1531714-1-Joseph.Huang@garmin.com>
 <20250403234412.1531714-3-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250403234412.1531714-3-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/4/25 02:44, Joseph Huang wrote:
> Add BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION bool option.
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  include/uapi/linux/if_bridge.h | 1 +
>  net/bridge/br.c                | 5 +++++
>  net/bridge/br_private.h        | 1 +
>  3 files changed, 7 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

