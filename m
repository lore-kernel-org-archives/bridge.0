Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839B03D1CAA
	for <bridge@lists.linux.dev>; Mon, 20 Jul 2026 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538823; cv=none; b=Nrpm60bWILTss7N6Qdsn4MemGlZM5L5IsHxCH0h+BjW5JB3AybZXDVmnQMyGZhGrfM/huGgg1bgIeBamF9rHwh9xYC4Tsr/5/oR7bO03uZnWb/N2FtVkTHdapGS8Q+L1/3CwYXIeK9ElnHqPOockTbTvPUwWsvITkWkRkr+O73w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538823; c=relaxed/simple;
	bh=85noVtvBLi1tBODpLf1x2bVLhJvsuksgsZFmoemNzgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rjBKXnZmMMPDglgLhrWYazKhhZ4J8zdP0mXGCga8D4lEvr6rWVIoJc092+nuPmf6IhD0b1efxTAeov+NG1WSYi7AcF+gXn17SeSy5Z5uQPYpOxcUj5bA2tewK3ixc9pYucGliRZjCwUI9uCwdMkFmH0N1cOmqiZntsNY4m8XVS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=AVejmQxo; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="AVejmQxo"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f64ca1c2dso437891f8f.2
        for <bridge@lists.linux.dev>; Mon, 20 Jul 2026 02:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1784538820; x=1785143620; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9T/2cKnEZcfqKCJj5/x/Dfy01VrGSKU7EgzZYtP93MU=;
        b=AVejmQxo5LaImcVsdsw9Ec9k5YjipXS0rCrXSoiK9aBFQF8NdCpgLCsO7bXCtmLhK6
         ZKkbKdJqSFPFBjmosrvCUXIJ9ydtvEeOHpCCoBA8+i1jVyg/40dUBDyaJiHfsxYols+m
         ACp3kHug6fUbSE9BIw9qLUVgCyxm26SgD8M52YScNm2TGTG1jhaxtreBO08hS61mjA0S
         f8P1KHsgH/Y+9JfrbunD9IfAn6wcXRTKALWtuccxwm4rNPQ24jeGEkgBF7kSQqpuEUot
         nxzgWImSUXvvX41/IskaZtR4t+bvNLvX7WZ0Wkz1mmh5TIgT9Ux02jJZh+ZuBTsrHnat
         m9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784538820; x=1785143620;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9T/2cKnEZcfqKCJj5/x/Dfy01VrGSKU7EgzZYtP93MU=;
        b=Ba2fjhDoZr2cBv4w20Y1XTlGvw6IyT39u+wAVWO0hrnoaRt0ANHk6RngcfeeInKUNp
         nYDhao+b2cm/Lg3BRr6pMTjfjjLnfWJIZwERrmZKDEWMXsx3pf3sW6COdRyogkhir6jZ
         XGnC+8cTTojbDjnMA1D5RVjJ/n1EVHryqByBJBj46u7oWHHFzGywght0PJKS6N32LDQ0
         bAkMuoYFAXx4eavYZ3kOO5Y+5GBm46QKNjXHvqGW2deCNbfezXL2gqJnt9KskU4BnA9R
         V2Ioxunj9+szppZqvZRidNafwvaptO4wHGpzz3oyF58/gCPCnCN0Q3b39klziphNnDBx
         Fd7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrli/L3nZp4MqxGZom2I3EqwuH3O6UpZWiY0Ni2hE61rpbiVbkFt9WJquesZGFVXeHlcnhEvII=@lists.linux.dev
X-Gm-Message-State: AOJu0YxTEubbiaZDYBMEosFdmG74UKvw4MKhzmclrgvNMWQDj7BEk4TO
	WUnDN+tm2bmda4v3Ahm9C3dq9l2FrpSngd0iMAHchoQtWyD/FL9MueChaY+Ht97Dkns=
X-Gm-Gg: AfdE7cmidEVDAzc17UA2v6kyK00Qn9w4Z/hVCyB9A2Nr7/fqXqyRSoikLwwcWeIIkLT
	pAhPraosnYxKOPFe99AWqvF+l3JEuE1JdTEPcmdnrLlzWHDysIMUJSs2sahJRvwoeL+vrxTV7kv
	EU+jXMriBcCTNYQdprIUAjGCt6x/AQuQyjEW+MwdcqkT6nKe5eZX7PMPO466KhNUSnXYhxHLEqt
	cjGLitaM8BdCi58Do7zA4dVwoF7MQ5lk3iWuHhNZ+Eg9P4JyrwX+uWrVNrYe5w98gzdIt4IWAHL
	+HBY8Zh/RF0CLP2nrkBoHc/MMe+nRKn+hgdxYXxvmO/EZ1qyNaTJ5xSa8zhlTbBS12ojhdpG9SH
	0Fc+8zC48ZdWZMI+ibw14WV9uRhZsHjzH39ModWNyxwS/vzz8J0ELRQNhHPDTVyr0LrVX9mocQT
	4SaU+z8DyxXtBRqD06UoYHUuXEPyAnz63E
X-Received: by 2002:a05:6000:188f:b0:475:f0c2:5afe with SMTP id ffacd0b85a97d-47f6233b1c9mr16250659f8f.52.1784538819747;
        Mon, 20 Jul 2026 02:13:39 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ee926dsm26438160f8f.35.2026.07.20.02.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 02:13:39 -0700 (PDT)
Message-ID: <2b923c1c-8c00-4375-9ec2-0fa9b073fa91@blackwall.org>
Date: Mon, 20 Jul 2026 12:13:38 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] ipv6: ndisc: Add ndisc_check_ns_na()
 validation helper
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ja@ssi.bg, petrm@nvidia.com, fw@strlen.de, kuniyu@google.com,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1784463131.git.danieller@nvidia.com>
 <c7f894446494462bd72f717021aa4b6373f31131.1784463131.git.danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <c7f894446494462bd72f717021aa4b6373f31131.1784463131.git.danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2026 16:34, Danielle Ratson wrote:
> Add ndisc_check_ns_na(), a standalone NS/NA packet validator modeled
> after ipv6_mc_check_mld(). It performs the RFC 4861 section 7.1.1
> (Neighbor Solicitation) and 7.1.2 (Neighbor Advertisement) mandatory
> checks that are relevant for software operating at the bridge level,
> where packets bypass the normal IPv6 stack path:
> 
>   - Hop Limit must be 255 (packet was not forwarded by a router)
>   - ICMPv6 checksum is valid
>   - ICMP Code is 0
>   - ICMP length is at least 24 octets (sizeof(struct nd_msg))
>   - Target Address must not be a multicast address
>   - All included options have a length that is greater than zero
>   - NS/DAD: destination must be a solicited-node multicast address
>   - NS/DAD: no Source Link-Layer Address option when source is unspecified
>   - NA: Solicited flag must be 0 when IP Destination is multicast
> 
> On success the function sets the skb transport header and returns 0,
> matching the convention of ipv6_mc_check_mld().
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> ---
>   include/net/ndisc.h    |   2 +
>   net/ipv6/Makefile      |   2 +-
>   net/ipv6/ndisc_snoop.c | 190 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 193 insertions(+), 1 deletion(-)
>   create mode 100644 net/ipv6/ndisc_snoop.c
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


