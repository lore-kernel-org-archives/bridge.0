Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8D020468D
	for <bridge@lists.linux.dev>; Fri, 20 Dec 2024 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734697698; cv=none; b=CaLzpOTBz/YuOKVGrRKvHPNIMOy2EcR+l4BB6e78BOapFBAdZFcqMBmdnMUhfdmznNnWyeAesgy+WTaRvth3pnyjYKwSG0ccQJMJv2OyiB63jJ1ZbCnC7IrAoSEHv/0k3pjJ/cDeQjtRmSN0Ml35VZne7YvWTaeyd1H/RmgLTYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734697698; c=relaxed/simple;
	bh=Ddb6v77SHWQ01yjg5zQWJJWLi+Qk+6+wE6upKt6anmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E19opWAMRpnEEeVUzR/dpWYnA29Q8ecLiV01wU7VtY0wfxV6xdZUrobI4EgBDieUDI91iFftFR628uwEI0g4JE1ZljeF5CMQ+JjfGVl3T7xS69CyUaKwn3GHpvCJ4x6oTAS9A3cMiFEg4By/vGXlJW4mLBt91mPWBmeFCMxvw1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=K0kAWkqJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="K0kAWkqJ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso12700045e9.0
        for <bridge@lists.linux.dev>; Fri, 20 Dec 2024 04:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734697695; x=1735302495; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PK3ngqbeNw4BOnOakPdfhW4DY28wx9y6ctKhCJu1Yn8=;
        b=K0kAWkqJK7tVySfg1kctUSrgJbjN6zjjtsFo1N1RfuVJXJQIVaxcbrxg1mnIchPv9i
         J2w9BK9xAEml7WxQgGSDPJ7UkIPXl1wi77VXgVLmQYSUW5oPPR7xmI3wbKvC63dhn1GG
         +1DKK6n+5O3TRiSyuP+gSyGihzXzsCeiJ7SSdTMPPZKaMTL42ctJPE5ICL8+32hwtOiH
         KQzKTtfjEQpi1vlXsdWjbtQw2vxHM8SVdKSwF8M3K50kS7e+jkngKYs2YwW9zsCcRyS+
         qcOzfd3DemDrjKdmVCqabAM/my3faPwTAjqVa8fwCYh5Vzl2lqriTxcBMNAmWagXYdCj
         tAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734697695; x=1735302495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PK3ngqbeNw4BOnOakPdfhW4DY28wx9y6ctKhCJu1Yn8=;
        b=X9D9f0j6YaCjXma6N2LPJ2+JNsJ4kDZ0LabpmmzhD6hiklxhV7gUB3U5TlHO/hgOIl
         ZjAiccMNb6piG25IZcwsY4kO6jc003ckhXTdXWEE6GupKSOSxXWTTidy+iko2hb+ONMl
         CQlMUlGu9WeKgo++IgZol7e6c8L6ET/2yVRrM4octQNMQHyD/aGCx4RIs1fqKGqVdGGm
         8nYNyJYH2PVh6cJCrbxHkG+a0fdctvrkQBGtDWFNHCAgZFxjVGXOjVNaBZX6DWaSBRyX
         N08a8syzmEY5HPWn9esmFRPDQIQN7LoCQidBD3Lel2ytw3Lfe5fUd7mVn9EMy2boaRx4
         rhAg==
X-Forwarded-Encrypted: i=1; AJvYcCWl1YjNGeK2NE7WLwBHIV1p1qql+T/gsMR38BuIPTBxJkCAGZtFe4yvw/2snGm1j4J8ansFnW8=@lists.linux.dev
X-Gm-Message-State: AOJu0YzBtKhxmV+3z5ngVleXCeKs2GS/ow3aspcLMHm4Q7/0WBP8ldF/
	RDQMW/ZtB0rS+MA/7dutb8pzJUhQ4iROYOc1/7turo9CK9QmXtHNFonlKQo52t0=
X-Gm-Gg: ASbGncvf97xlC6pzRQ6WGcm/VXpOeh9wa4EBE6l42QETSvWVbi+qaOcd0tpjXrphj9r
	0rWXnslJDA3LboO0Rt0QxphL7KUwcnAxk+X+JilV2xGe1D9vfIr2+2kMuI/BncFdi03E1p9tvRa
	gjFvn0CZjwMfCtHQxv84GEF5xuN6257zf3ocRb+YLVNUP4y4gdwBVHD7E1EAASPAl6aQG4lb+x8
	ZLwa0LRRXIXSJ8ksNgEPX7GcKxQPUKiRFiJumfLGgfmfYNAaXi3dQVvuZ5X7/jswO+AEobHTmBH
	qVc7X2/ZC9H6
X-Google-Smtp-Source: AGHT+IERzTmIuZ5ShE2OixsRQokWqLCp5nlaW4wpXU7HE4OP8i/8gpF9Ee/IWg29uVu7gnnL3BEArQ==
X-Received: by 2002:a05:6000:1fa7:b0:385:f7a3:fed1 with SMTP id ffacd0b85a97d-38a223f5cf6mr2525361f8f.44.1734697695631;
        Fri, 20 Dec 2024 04:28:15 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e528sm3994788f8f.83.2024.12.20.04.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 04:28:15 -0800 (PST)
Message-ID: <50b37747-6820-4849-a578-a168e62dda6f@blackwall.org>
Date: Fri, 20 Dec 2024 14:28:14 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] selftests: net: Add a VLAN bridge binding
 selftest
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Roopa Prabhu <roopa@nvidia.com>,
 bridge@lists.linux.dev, Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <cover.1734540770.git.petrm@nvidia.com>
 <baf7244fd1fe223a6d93e027584fa9f99dee982c.1734540770.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <baf7244fd1fe223a6d93e027584fa9f99dee982c.1734540770.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/24 19:15, Petr Machata wrote:
> Add a test that exercises bridge binding.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> CC: Shuah Khan <shuah@kernel.org>
> CC: linux-kselftest@vger.kernel.org
> 
> ---
>  tools/testing/selftests/net/Makefile          |   1 +
>  .../selftests/net/vlan_bridge_binding.sh      | 256 ++++++++++++++++++
>  2 files changed, 257 insertions(+)
>  create mode 100755 tools/testing/selftests/net/vlan_bridge_binding.sh
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

