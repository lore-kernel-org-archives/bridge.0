Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5296326C385
	for <bridge@lists.linux.dev>; Mon,  4 May 2026 07:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880655; cv=none; b=Z5iwqZRRxv3esDSqBY/GNErMFdSTVW2jfwfl6/MVtD/2O4GhMQf/tlJhwy1WvNeXNpcV1BrS5namW7HeBBQRofRVuiB5XviyjYRsdhgrbXILzdsiC60dgB5eK0zY4v0QfMfJx43S3Mn5jEKNEcTe6LbhOttqBQwmVKV3CrGY7po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880655; c=relaxed/simple;
	bh=WqTgDRyF7thxXL2tFuIlt/14bQOXqqiDNxfbMkQh+l0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5vC6UZFwtdO3yby5WCOHOmzxOsRY8xJiTa8Fsfqr8GrYnX8bZVPLvhH2wN3cCKxm5rE/avtL+4wIG+RGQauWQZFYIo7IdE4U5fEjwVKHPlwLZzqKjYIZtMY9XCPFDHx5iKbxXNJriOpwzkPJO7AYSep17bzxvAJlEQCk36Ckm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=aM9C3LAm; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="aM9C3LAm"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-44ccbd3290aso1135397f8f.2
        for <bridge@lists.linux.dev>; Mon, 04 May 2026 00:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777880653; x=1778485453; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BqVl4u47O1sLc62PW00yH8pyp8rHN1ZyUmrViFkDQUc=;
        b=aM9C3LAmK0Ycjv3DEfGqWUWGqgXqqDT+yrMQ+6fpCSmAiGnTd2GtNgQQxuclZCTphD
         02t4fXhv4l8eJSm2HASKBDkrdEXnCl61hbhvKAnI2bvKKktGsvq+slOhyNPlwfWP80Re
         zZ/qwW95nNBxvJP2hIj6oxcDXyVrAfdOlS5/8Y6IMRk5Q0EFs3LlUrJ/okfkWV90wUJz
         Ua4ZZ82SIYvQqEQ9sJbAfwYw6g3r/pgccVAhpqN5sj+tjq5sCmt6S1c+homgUio41+vl
         r5LZE5wm6oMZC57spkh1qaDFrXJ5QHramh4L4gGZXRWZMlmkevndQlWgmXsca4fzUekd
         +piA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777880653; x=1778485453;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BqVl4u47O1sLc62PW00yH8pyp8rHN1ZyUmrViFkDQUc=;
        b=LhK1FW4zW8GMIkQ35v9Puktb1mXPMcs0D+TYbVP0fK1uAf67+eandagy+Ocj/VNnsz
         aWUXaWAFnWT0H0sydulobnu7IStZFeW06lrXhfkaaAigBPV6+A+t/qWP/jtx8XuOG6BX
         +hVsKC3VMmagpMNx1VPB3606htd6Apmg+CVWsltNaNMBibDejIdrQX1E5d99ZpIh5R6K
         bnbqMCPYDKja7h8+1yYiQK7kAQPmDko2YZzVN3HcxjNyc+BcyB3Wl9wbEz5/xtfqmTdU
         gaouDKWu7rOD4A3kBi9Re1zzyhIXHIskdIOGkiKa7AKOsmABPn1F+yLKWGcTF3bYvNpt
         S0Dg==
X-Forwarded-Encrypted: i=1; AFNElJ9ETImrp/0gwkiy2jx/h9jd9kAGhvnX1i2KNtHbR1nMPwwutk21klJg7bDFscbXWYvLQhNFPVc=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4+s37eDMvXhO/pKmwRVKLmXeWEvGThshJ1EAXM194QiLfBecs
	+5mgHg2DNI54GUHth0U++nMJqkTiR26tW5DQ/7NmSZAvVAIe69DelSLVXjhK/qjya7g=
X-Gm-Gg: AeBDiev30agMZzDot0xXnL222cKh/PJMGYD0n0E/kKg8gLRMzfdkWohV4a3S7A13v8L
	if4VL6x2vwAKtMpln53I6WJemNOeAfjctf1bYNqi0KzbxaYeoXBTxNKHGeJDlbaTzkFlInibUG0
	TDsxgRmRq8Qav6WrLA9hJw2xwG/dmv145AiOp8UA+9edgB87L07jH/+5kCpGajR133Sfj8W4Oji
	lAbdhIM52nyOAieNhwQv6EnrLZZnn4CC5R96o4WQuqud7itGDj9WDlnsTTExFc49lSWvI7AW1IV
	8Ps/Mnk/CvOlo2MehmEyJIPMSd1Tz77n3Yccnh9bxPb2XCrVAc2i81MnjYGI/OZ8x6M9TmnHpbM
	8+kJ5hD1lreTsY1MxIWVAqUfsPFQWt6zmmIKI/yOPOaM1Hdtl83Dz6u/9rMIBEuXeMcipf7r0w4
	lk46tfP07b/nDLul+vKMHpUJvEfS472mSa4uMeLpN3nz78hGBVYAqzECS1C2BCvj4O
X-Received: by 2002:a05:6000:2f83:b0:43f:e22e:e8da with SMTP id ffacd0b85a97d-44bb444393fmr14065131f8f.5.1777880652602;
        Mon, 04 May 2026 00:44:12 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a981ded99sm24332121f8f.18.2026.05.04.00.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 00:44:12 -0700 (PDT)
Message-ID: <fbbc57a7-76c7-434d-af40-4f0e8c314aad@blackwall.org>
Date: Mon, 4 May 2026 10:44:10 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/6] selftests: net: Add tests for
 neigh_forward_grat option
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
 <20260503073532.2138165-7-danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260503073532.2138165-7-danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/05/2026 10:35, Danielle Ratson wrote:
> Add tests to validate the neigh_forward_grat bridge option for selective
> forwarding of gratuitous neighbor announcements.
> 
> The tests verify per-port and per-VLAN control of gratuitous neighbor
> announcement forwarding for both IPv4 (gratuitous ARP) and IPv6
> (unsolicited NA):
> - When neigh_suppress is enabled with neigh_forward_grat off (default),
>    gratuitous announcements are suppressed
> - When neigh_forward_grat is enabled, gratuitous announcements are
>    forwarded while regular neighbor discovery remains suppressed
> 
> For IPv4, use arping to send gratuitous ARP packets. For IPv6, use
> mausezahn to craft unsolicited Neighbor Advertisement packets.
> 
> For the per-port tests, the IPv4 test exercises the ip link interface,
> while the IPv6 test exercises the bridge link interface.
> The per-VLAN tests use the bridge interface throughout, as per-VLAN
> attributes are only accessible via 'bridge vlan'.
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> ---
>   .../net/test_bridge_neigh_suppress.sh         | 298 +++++++++++++++++-
>   1 file changed, 296 insertions(+), 2 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

