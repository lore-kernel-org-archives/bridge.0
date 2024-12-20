Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0351204694
	for <bridge@lists.linux.dev>; Fri, 20 Dec 2024 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734697685; cv=none; b=NwUKzV8mr8WK2H9n3zrWrHui+F73nbm0jKmUoWa2jjKRuc+4XysD/esEJ8oXbouYUKqCraoFOJdKJ7whfOQV6r3FTzjvgMLwhr06TVVQuzbfEvjOxBVhFLoqPKNEa0FEmfuXjI7mdb9NIEoNp48GZumylJ6OZNSE7kfrE7/hZ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734697685; c=relaxed/simple;
	bh=crwUz8w4erOpuUncroLz8rVV6rCiCKVlVqP8+2IqluY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FqxNoVZt1Gtkg/7LhQGKNIScLoxcXVIkBXjUUj5YoDEG1GybaOJABPpiqB7RUt5Jf8tA0l5aZhRXlfQXbB4eBPm0aMm2NeDWRr/Hl2L/UwoyGGsh8XHYWppznv9bChqcjk5DfxmwprEY+4QevdQ31mdPaDEZXJd5kv0nvYEVspo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=RHJEQCP/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="RHJEQCP/"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so1070149f8f.2
        for <bridge@lists.linux.dev>; Fri, 20 Dec 2024 04:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734697682; x=1735302482; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XW/eDTIh8MSvBLVk4dolZoBmyg128cNU1krHt3uwMlA=;
        b=RHJEQCP/CvAXtjhQH6GX34z5w47u+o6p6fCTfpry6gmihBBe1GacFeyYlyqsPg74V7
         lyKgEbq0aPFdpA1axsY17qUcBQcy1lIyjquEDYVGVp02hEI/s3JllCePQz/X56k1WeDD
         Bz0g7YlaTenPOAv/nDlKLxVIitG0RHuCCOmhqio+fkSwwG0m+TdTiC+SAQbX5Ze01W3e
         aaYl1Ceg24PH5Bjz7XHzeKLOJ+JnCTjLKQ6uD6pehPKsykFaTcK0I+R5m+4jqMo2mHFX
         MHGFPH08JVRJU0kTNK8oEQdclgL/8HeDfpPPCPQnkL+XPwt0Z53zKkW6hg7cfRjG4VyZ
         P/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734697682; x=1735302482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XW/eDTIh8MSvBLVk4dolZoBmyg128cNU1krHt3uwMlA=;
        b=cJjjO9nBYWbcEzT/zQPQmoy1ERyARbYgMBtJKH8y76vGFnat2iI+WeFY0JzAvBNz8+
         hJzWhWUikIBx4dILi5zuNu9NHfi7aaEWqcZIsRwje3m8catp3iju9ZnYeXAyojWnpxsK
         0sv6CfhRfBDSXh+MX4y409hSo8TVto0TxUen54Jd5FFeidtWGcWyCl5v5D//k/yuk0pC
         t03QKA9porPvFfLJAbJTccsvO10adBydzR9uoyZIWvSe4Fwm6QoJvgIWxzPGUS0lOjYM
         iaTgMrgxvj0YAzQCh5kGxo82W9cjQXuJO1GqJA9PlohQAMEV8KOG66qbGi9ptRbF2ao4
         nYDA==
X-Forwarded-Encrypted: i=1; AJvYcCU/xxQ+ZrMMyKz9Y0hQm7e7P1gvgr/kMCKbaWOxmUKiTJjqFNK+fhcIJqjADvhypK1/1Y27aOY=@lists.linux.dev
X-Gm-Message-State: AOJu0YxE1CnEFIPybJfY9CUUkLAtLh0fmBfz/AkomGwwaiU4VOsE4my2
	Jy1sEJR3gOgdsi/xJ2kx7ONT3n1T0+ht6BDemfpHtDRR29oFxoLCSnrIB06TLZc=
X-Gm-Gg: ASbGnctRwH+ayCI4NFDNGb2apkMIMYPhMF9adf3QFOp8hLeqYJckUZqlaOg1tOoFfDJ
	0mJBCQ91ubcoQk7++L9gDczgP2DJIOXV+vWLKE0mnznhTAyQ50AZxgNqOM40BMtJx6naxobAqdt
	jHtEb5q6O5WJRhinczLMGIcLY325jhcsPUbpoI2Y9Kx8vl7kia5ec1cDtpLdSwR3Clf2HqBHP5J
	svtezvbFDnf6YpN9ibAY1oPUZEtsxKgzVINqKWec+i3WgK4G7nepl2cn5tT1oO+jVDUn8AsYHfl
	R3ke6LW0LIHA
X-Google-Smtp-Source: AGHT+IFIskpEmOR+YWcUP2jYS4Ck9DjO4dUxfusvUv9OGLXmeydXNRW2PPdKQ1wOV9XNaCqV5iGhzg==
X-Received: by 2002:a5d:47cc:0:b0:385:fa2e:a354 with SMTP id ffacd0b85a97d-38a223fd65emr2840355f8f.47.1734697682184;
        Fri, 20 Dec 2024 04:28:02 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c84840asm3944688f8f.61.2024.12.20.04.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 04:28:01 -0800 (PST)
Message-ID: <5012d081-eae1-4424-9588-3dd8fc7d933e@blackwall.org>
Date: Fri, 20 Dec 2024 14:28:00 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] selftests: net: lib: Add a couple autodefer
 helpers
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Roopa Prabhu <roopa@nvidia.com>,
 bridge@lists.linux.dev, Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <cover.1734540770.git.petrm@nvidia.com>
 <856d9e01725fdba21b7f6716358f645b19131af2.1734540770.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <856d9e01725fdba21b7f6716358f645b19131af2.1734540770.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/24 19:15, Petr Machata wrote:
> Alongside the helper ip_link_set_up(), one to set the link down will be
> useful as well. Add a helper to determine the link state as well,
> ip_link_is_up(), and use it to short-circuit any changes if the state is
> already the desired one.
> 
> Furthermore, add a helper bridge_vlan_add().
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> CC: Shuah Khan <shuah@kernel.org>
> CC: linux-kselftest@vger.kernel.org
> 
> ---
>  tools/testing/selftests/net/lib.sh | 31 ++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> index 2cd5c743b2d9..0bd9a038a1f0 100644
> --- a/tools/testing/selftests/net/lib.sh
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -477,12 +477,33 @@ ip_link_set_addr()
>  	defer ip link set dev "$name" address "$old_addr"
>  }
>  
> +ip_link_is_up()
> +{
> +	local name=$1; shift
> +
> +	local state=$(ip -j link show "$name" |
> +		      jq -r '(.[].flags[] | select(. == "UP")) // "DOWN"')
> +	[[ $state == "UP" ]]
> +}
> +
>  ip_link_set_up()
>  {
>  	local name=$1; shift
>  
> -	ip link set dev "$name" up
> -	defer ip link set dev "$name" down
> +	if ! ip_link_is_up "$name"; then
> +		ip link set dev "$name" up
> +		defer ip link set dev "$name" down
> +	fi
> +}
> +
> +ip_link_set_down()
> +{
> +	local name=$1; shift
> +
> +	if ip_link_is_up "$name"; then
> +		ip link set dev "$name" down
> +		defer ip link set dev "$name" up
> +	fi
>  }
>  
>  ip_addr_add()
> @@ -498,3 +519,9 @@ ip_route_add()
>  	ip route add "$@"
>  	defer ip route del "$@"
>  }
> +
> +bridge_vlan_add()
> +{
> +	bridge vlan add "$@"
> +	defer bridge vlan del "$@"
> +}

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

