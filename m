Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75B814A9F
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="kGs1mqEH"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AE1E8140E
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:25:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3AE1E8140E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=kGs1mqEH
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5qBaLAR1BLpo for <bridge@lists.linux-foundation.org>;
	Mon, 18 Dec 2023 10:25:51 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 694CE81364
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:25:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 694CE81364
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c48d7a7a7so27077085e9.3
        for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 02:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1702895149; x=1703499949; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HAhY8aDSbSHyfdVv3a4e8tb7OVTCiD6h7HXkcU1kn/k=;
        b=kGs1mqEH5GQtyX20DlzJxM0mAy3sYK3XteyzLBFYPRoUeL+Y54C1F1LpmGWdvWkvJ6
         j5kSEUwGMdml6jFp3OATOEpGZwLeO9XHZVSZfto80MMJx5qrj7/JcQDjEitZMOlsZC8/
         h7Hm3B9IwPq4dssE+qfVFacN8rUryHlHzG/ftQjKZKET7tWjxFM2WxbEs1G4NNHdBYrz
         iT6dOvri/Q4ouX7Z5HrCZ/fEgKoxOqLZERigw/yjdt93nLA57flM4T/8GJC7N6s1jvZH
         4GRoGWTusVpzRm+UABLR2tfGrb2BeD/yG8JLvBz3fg9yPAagE2B1PBe9ICdb6pXUPCpj
         S+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702895149; x=1703499949;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAhY8aDSbSHyfdVv3a4e8tb7OVTCiD6h7HXkcU1kn/k=;
        b=s4zQsZ7hIcXPt3q2RY92bzJZJ51nfMvKnWqgc9AsS62Fwi4/lLWyOAFwyLpWAdp3QL
         JKikhoTh+oEPCQeQsuOQgdwaS0zDaPfhTsRQnP1l/CTTjUMyllfVGtm8UcTYC81kSLAk
         6kE1LZilIsppAWpZbuuLzWY3VgM1CYOuPJdmr/Pmbp3x8IizR1+TAWuouKeI1BJIMFMU
         bq9TKokl/lx5nFu004LoAuCNaJ1Y+W63fJ/HyDj71autqblTwUqPnMBWu0fXTSt/v5Hx
         G+BF+fxW4O7W/hZI0quOTfA2dMD893H3S5bgVEfQb7C6lKqVjEl3H1zXp/SD9rZSAZIa
         utng==
X-Gm-Message-State: AOJu0YxR4FZl479GcOd/C53FamPmG04byefPOGR3rSPllCuC7/rN/peP
	I7mIrjIzwKO/4eH6zRK1wl75/Q==
X-Google-Smtp-Source: AGHT+IGJMxQMX0Eoscu3sLkJq6SNkKBPwM2Ver4NRONwd+C+57if1FUNlfPi8M6NlcM1V6yyiEKZBg==
X-Received: by 2002:a05:600c:44c6:b0:40c:6204:d595 with SMTP id f6-20020a05600c44c600b0040c6204d595mr4532968wmo.99.1702895149603;
        Mon, 18 Dec 2023 02:25:49 -0800 (PST)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c315100b0040d1775dfd6sm5777864wmo.10.2023.12.18.02.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 02:25:48 -0800 (PST)
Message-ID: <f1d6b9bc-da30-4df3-a97c-b5808a8c14aa@blackwall.org>
Date: Mon, 18 Dec 2023 12:25:48 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 9/9] selftests: vxlan_mdb: Add MDB bulk deletion
 test
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, petrm@nvidia.com
References: <20231217083244.4076193-1-idosch@nvidia.com>
 <20231217083244.4076193-10-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231217083244.4076193-10-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/12/2023 10:32, Ido Schimmel wrote:
> Add test cases to verify the behavior of the MDB bulk deletion
> functionality in the VXLAN driver.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Acked-by: Petr Machata <petrm@nvidia.com>
> ---
>   tools/testing/selftests/net/test_vxlan_mdb.sh | 201 +++++++++++++++++-
>   1 file changed, 199 insertions(+), 2 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


