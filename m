Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565DC13FF0
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="gCSA6NkZ"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBD0D418B1
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:25:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BBD0D418B1
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=gCSA6NkZ
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m5mndqunXxth for <bridge@lists.linux-foundation.org>;
	Mon, 18 Dec 2023 10:25:27 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9B134416BE
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:25:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9B134416BE
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c3ca9472dso32133225e9.2
        for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 02:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1702895126; x=1703499926; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+KPm0OJmVIXFG+d21U5Ot2/HuESUtNJS9snp3+0hCn8=;
        b=gCSA6NkZUFdeYbjCUA58tiLks+y6oDj18uIwUY7WvEiy6oHGnjbZavthAl99xX7MxN
         5KybM5yKwh6uWIdkVBh62b8nCbbJJNeKhVx1HYCUlaIlxLaFzEHVgMii2BMrp6Cesbhw
         hHr/4sT4nu1wULb6FiNA0Cw+uWIHZA0iQp9LKa5WgZ5OhLYm8JzFD+cDyskLdq3h8sGi
         9qSpyOna8PjsgFgzfdWIjo7FQwT4qkw9i3g1rWrxJjHGynoQgP2G2tdx3qcnV8iJ9ZXg
         e+R0QyroyfA27AlIhLAXqI4DeLu91Hdl0bWtntqRBepxJ9+lGSYOFAfyurOZ6SrXxJUF
         On7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702895126; x=1703499926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+KPm0OJmVIXFG+d21U5Ot2/HuESUtNJS9snp3+0hCn8=;
        b=PsrsCv+6mKS0m8E9aRRkLYvl/wkszOLSm+5U/qo9TaTk28pvq+/jnRCVz/fNOmkhfK
         lu7eVVrm/qTAOIWY6QArdLqmjBxbaAZtxECltrkqVPJrKedtyfjLXkSt++9asdZfYnGe
         MRcoglDJ97Q04ahX+tWjLxueRFJ/6wQIbIFGn1Q3i9BQWv/Jg7AQAuiDYgoeenKVO/KK
         J1g8hIE6hpKSb31lZaTqaRyDEjjXs0CLESCkBRHNCquAgC5gYQDhwGp9obwTfk/LqBXQ
         xjMB2MQooGFwadKFvg1RobmTK4rEDybP9RHuIY0ZfIgP/wnMZErwZMNzPupL1eUMv3oe
         MQVw==
X-Gm-Message-State: AOJu0YxIKYXGZDpzlNcZaFGHJY4aH3gVdMXgM9PKXsDFHFjwFoodMmuC
	Iir2wuEhMV4MbYP2urtliCzsRA==
X-Google-Smtp-Source: AGHT+IFlQE2Om1rufO3da32bBnZQM2d0oM2pEA0LNHroS62tTs5iEyRAZMUYhyD5SO3L09KiGqgeLg==
X-Received: by 2002:a7b:c8c8:0:b0:40b:5e59:99b7 with SMTP id f8-20020a7bc8c8000000b0040b5e5999b7mr5779742wml.215.1702895125824;
        Mon, 18 Dec 2023 02:25:25 -0800 (PST)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c315100b0040d1775dfd6sm5777864wmo.10.2023.12.18.02.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 02:25:25 -0800 (PST)
Message-ID: <50158735-e367-4dee-8515-12886ee810fe@blackwall.org>
Date: Mon, 18 Dec 2023 12:25:24 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 8/9] selftests: bridge_mdb: Add MDB bulk deletion
 test
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, petrm@nvidia.com
References: <20231217083244.4076193-1-idosch@nvidia.com>
 <20231217083244.4076193-9-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231217083244.4076193-9-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/12/2023 10:32, Ido Schimmel wrote:
> Add test cases to verify the behavior of the MDB bulk deletion
> functionality in the bridge driver.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Acked-by: Petr Machata <petrm@nvidia.com>
> ---
>   .../selftests/net/forwarding/bridge_mdb.sh    | 191 +++++++++++++++++-
>   1 file changed, 189 insertions(+), 2 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


