Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9169D286881
	for <bridge@lists.linux.dev>; Tue,  7 Apr 2026 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570948; cv=none; b=RJb+/loFFs+inwb6gnI9hIbLcUudTMQz9vo4NKqFwf07FXS1fRAZuAmeVkyUKRX5SRqg3Z8uVMXqtiPXy2CMzOxMgVrPVLCKDyxOZstN3pZevrSqLLStDAc3dSpS11d29C1vlOgEDowGNcHi0JyVrpwnTA+cvAhKNS9W2FRukPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570948; c=relaxed/simple;
	bh=Qmf5Akm/+PIKJUxp5O0m5hND0XiK/nwoPMyX6/BX/ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDiAge9nzYvR7gGs8ORC8Ugx4q3ez4+mPt/XSWQUdXaKY/ngQeLbqQBSxZqk7h1ejatsXHgkC9fmdI/yiILZsIhX1P7Oo6PDx6RvAAVY6vKLzIL+MDsYp8j6TClcf7BKpE4S2Jr0w7C7Rw1AoihXA/5LtFpiPWjKMktA4w7KF1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=bCTSZzMV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="bCTSZzMV"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso39096445e9.3
        for <bridge@lists.linux.dev>; Tue, 07 Apr 2026 07:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1775570945; x=1776175745; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MmAj4YJ//rsMhkWTLV/KvMBbE03h9w2Yg3fkPov2U0c=;
        b=bCTSZzMVGIzG7ut7zm/RdTzk2SYn9lXaMuLPx9YFeCpa/CcGBV/cY4C9C5g6rdmAgA
         o1Myivnu+QZEmqTOKv5VLaNcoCohG1wJhCgD0bI+aORSR/ZzAowK5Er7qB0mBqw+Sae9
         RWVABUfs9zA4iKwhTKN7zCQmVgXprxhjdqUuk7Z2LT0HYTFGgUmRj/rWngYZh2zUk/xa
         hqo5mUkcGFhHPLF1n1nnEyaQjjGwvjCz2na/Aw4baWlUQb5ogafdp1Bp3g6EFR7DrWOL
         QcSsXyfAUXsJNHpTuXxpsgN4SzHgaivpoFejyAHpWHmHAz9jitsGheKogvGuyKlvQ9+b
         m5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775570945; x=1776175745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MmAj4YJ//rsMhkWTLV/KvMBbE03h9w2Yg3fkPov2U0c=;
        b=OuUainuTq2dW2RL5Nh5njq4AqN6+K+7Ea6yxv/IjiKjiaQ5H+fyNmoib7Wu0ThkZgA
         Gwe4bEhBdnams5oF7/gaVLKaFpY0/ch32JGpuy/IcStorV8ip6JvlfNbgKhi7lyOaFes
         tf9op58f7jZGn0qnK/RAMmV0+zHe8xkFJqqdxH+wdX6/AqnW6phP1Irm99N1lEdOCZCd
         P9GDfETcgxHx6C8Vc1ubtNMGBZNOYyjLoXG8ceTMJ28DMoadznNSZjlBsy6bHqUcvGOb
         5FzavV28dYPGtdvVJktQEecia8hhakQFXgB5sjPc+S8Bhy6nAExXXEkrXduDxiXy3mX1
         Rxgg==
X-Forwarded-Encrypted: i=1; AJvYcCVMipjf1DTyFj82o66jlF1LtfKRQoFyUdWnDa0tOUYDqs/ZYfXRgLad0sXXSMzf7MWf0RadhfM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1BEKHX5CtccJkHA0Gs7QssyVnLirzjGp9vSgKC43zDZ1tMFY4
	r0YJLtBcmW3vq+dwSOIk2jjdsPH1oW4vqObSwgIM47EcvXW9lriXM79Bgb4YGeCHpXo=
X-Gm-Gg: AeBDieuFQbx9d57k1rbZlLVsoQB6ZM+7gRkhET7Xc2IEJXD+3wDD4ruCyDktkiTgAxr
	pXIy5E3uzejuGH3QvqGHrSULo9OwE0uiRmu9lAwxJe50FPES1f+7LCCgrqMd7XPcjxDXJWfIWIJ
	Bfzkc4lRawAyVh5tv+1KDyrdCq+82I5dC1ebu1fEnbmaH8JVW7QQ4qzstXb0CcYgEukU4KgARDf
	vk20IAuBQZLOf9FWw7FEtoAAHfbKYC7q4uDADtjMPHMiPlJuj2Nc4PQxAR9c7gdgpKsXpBPHss1
	7gfmIc4oJXvrgyzTuN8C4hLQuglLlQzzNVot9BQnqMMgmK0NqcoeCDk/cAu2L8birjnSEorh3MN
	ChvC571R7cw6wG31X6sExCoJjgOy5u4uPlrbWBXe8tWtKj/SoTnJE3e67Hz6vWVQlz3dFRuXj+Y
	i6aM+18uJAP+Fwp5ewov6PNh5H2X9o8urVgFpP0UZYG8UMayUFhUPyKg==
X-Received: by 2002:a05:600c:628e:b0:485:4bd1:4c64 with SMTP id 5b1f17b1804b1-488997d94e0mr228019135e9.31.1775570944594;
        Tue, 07 Apr 2026 07:09:04 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e9630ddsm567249205e9.13.2026.04.07.07.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 07:09:03 -0700 (PDT)
Message-ID: <b10f5928-ebec-4313-b04b-22ff7ab76c96@blackwall.org>
Date: Tue, 7 Apr 2026 17:09:01 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/5] ipv6: mld: encode multicast exponential
 fields
To: Ujjal Roy <royujjal@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>,
 Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>
Cc: Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260403150050.1235-1-royujjal@gmail.com>
 <20260403150050.1235-5-royujjal@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260403150050.1235-5-royujjal@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/04/2026 18:00, Ujjal Roy wrote:
> In MLD, QQIC and MRC fields are not correctly encoded when
> generating query packets. Since the receiver of the query
> interprets these fields using the MLDv2 floating-point
> decoding logic, any value that exceeds the linear threshold
> is incorrectly parsed as an exponential value, leading to
> an incorrect interval calculation.
> 
> Encode and assign the corresponding protocol fields during
> query generation. Introduce the logic to dynamically
> calculate the exponent and mantissa using bit-scan (fls).
> This ensures QQIC (8-bit) and MRC (16-bit) fields are
> properly encoded when transmitting query packets with
> intervals that exceed their respective linear thresholds
> (128 for QQI; 32768 for MRD).
> 
> RFC3810: If QQIC >= 128, the QQIC field represents a
> floating-point value as follows:
>       0 1 2 3 4 5 6 7
>      +-+-+-+-+-+-+-+-+
>      |1| exp | mant  |
>      +-+-+-+-+-+-+-+-+
> 
> RFC3810: If Maximum Response Code >= 32768, the Maximum
> Response Code field represents a floating-point value as
> follows:
>       0 1 2 3 4 5 6 7 8 9 A B C D E F
>      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>      |1| exp |          mant         |
>      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> 
> Signed-off-by: Ujjal Roy <royujjal@gmail.com>
> ---
>   include/net/mld.h         | 122 ++++++++++++++++++++++++++++++++++++++
>   net/bridge/br_multicast.c |   4 +-
>   2 files changed, 124 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/mld.h b/include/net/mld.h
> index da3299545ebd..147e8c44eb28 100644
> --- a/include/net/mld.h
> +++ b/include/net/mld.h
> @@ -90,12 +90,134 @@ struct mld2_query {
>   #define MLDV2_QQIC_MAN(value)	((value) & 0x0f)
>   
>   #define MLD_QQIC_MIN_THRESHOLD	128
> +/* Max representable (mant = 0xF, exp = 7) -> 31744 */
> +#define MLD_QQIC_MAX_THRESHOLD	31744
>   #define MLD_MRC_MIN_THRESHOLD	32768UL
> +/* Max representable (mant = 0xFFF, exp = 7) -> 8387584 */
> +#define MLD_MRC_MAX_THRESHOLD	8387584
>   #define MLDV1_MRD_MAX_COMPAT	(MLD_MRC_MIN_THRESHOLD - 1)
>   
>   #define MLD_MAX_QUEUE		8
>   #define MLD_MAX_SKBS		32
>   
> +/* V2 exponential field encoding */
> +
> +/*
> + * Calculate Maximum Response Code from Maximum Response Delay
> + *
> + * MRC represents the 16-bit encoded form of Maximum Response
> + * Delay (MRD); once decoded, the resulting value is in
> + * milliseconds.
> + *
> + * RFC3810 defines only the decoding formula:
> + * Maximum Response Delay = (mant | 0x1000) << (exp + 3)
> + *
> + * but does NOT define the encoding procedure. To derive exponent:
> + *
> + * For the 16-bit MRC, the "hidden bit" (0x1000) is left shifted by 12
> + * to sit above the 12-bit mantissa. The RFC then shifts this entire
> + * block left by (exp + 3) to reconstruct the value.
> + * So, 'hidden bit' is the MSB which is shifted by (12 + exp + 3).
> + *
> + * Total left shift of the hidden bit = 12 + (exp + 3) = exp + 15.
> + * This is the MSB at the 0-based bit position: (exp + 15).
> + * Since fls() is 1-based, fls(value) - 1 = exp + 15.
> + *
> + * Therefore:
> + *     exp  = fls(value) - 16
> + *     mant = (value >> (exp + 3)) & 0x0FFF
> + *
> + * Final encoding formula:
> + *     0x8000 | (exp << 12) | mant
> + *
> + * Example (value = 1311744):
> + *  0               1               2               3
> + *  0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7
> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> + * |0 0 0 0 0 0 0 0 0 0 0 1 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0| 1311744
> + * |                      ^-^--------mant---------^ ^...(exp+3)...^| exp=5
> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> + *
> + * Encoded:
> + *   0x8000 | (5 << 12) | 0x404 = 0xD404
> + */
> +static inline u16 mldv2_mrc(unsigned long mrd)
> +{
> +	u16 mc_man, mc_exp;
> +
> +	/* RFC3810: MRC < 32768 is literal */
> +	if (mrd < MLD_MRC_MIN_THRESHOLD)
> +		return mrd;
> +
> +	/* Saturate at max representable (mant = 0xFFF, exp = 7) -> 8387584 */
> +	if (mrd >= MLD_MRC_MAX_THRESHOLD)
> +		return 0xFFFF;
> +
> +	mc_exp = fls(mrd) - 16;
> +	mc_man = (mrd >> (mc_exp + 3)) & 0x0FFF;
> +
> +	return 0x8000 | (mc_exp << 12) | mc_man;
> +}
> +
> +/*
> + * Calculate Querier's Query Interval Code from Query Interval
> + *
> + * QQIC represents the 8-bit encoded form of Query Interval (QQI);
> + * once decoded, the resulting value is in seconds.
> + *
> + * MLDv2 QQIC 8-bit floating-point encoding (RFC3810).
> + *
> + * RFC3810 defines only the decoding formula:
> + * QQI = (mant | 0x10) << (exp + 3)
> + *
> + * but does NOT define the encoding procedure. To derive exponent:
> + *
> + * For any value of mantissa and exponent, the decoding formula
> + * indicates that the "hidden bit" (0x10) is shifted 4 bits left
> + * to sit above the 4-bit mantissa. The RFC again shifts this
> + * entire block left by (exp + 3) to reconstruct the value.
> + * So, 'hidden bit' is the MSB which is shifted by (4 + exp + 3).
> + *
> + * Total left shift of the 'hidden bit' = 4 + (exp + 3) = exp + 7.
> + * This is the MSB at the 0-based bit position: (exp + 7).
> + * Since fls() is 1-based, fls(value) - 1 = exp + 7.
> + *
> + * Therefore:
> + *     exp  = fls(value) - 8
> + *     mant = (value >> (exp + 3)) & 0x0F
> + *
> + * Final encoding formula:
> + *     0x80 | (exp << 4) | mant
> + *
> + * Example (value = 3200):
> + *  0               1
> + *  0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7
> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> + * |0 0 0 0 1 1 0 0 1 0 0 0 0 0 0 0| (value = 3200)
> + * |        ^-^-mant^ ^..(exp+3)..^| exp = 4, mant = 9
> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> + *
> + * Encoded:
> + *   0x80 | (4 << 4) | 9 = 0xC9
> + */
> +static inline u8 mldv2_qqic(unsigned long value)
> +{
> +	u8 mc_man, mc_exp;
> +
> +	/* RFC3810: QQIC < 128 is literal */
> +	if (value < MLD_QQIC_MIN_THRESHOLD)
> +		return value;
> +
> +	/* Saturate at max representable (mant = 0xF, exp = 7) -> 31744 */
> +	if (value >= MLD_QQIC_MAX_THRESHOLD)
> +		return 0xFF;
> +
> +	mc_exp  = fls(value) - 8;
> +	mc_man = (value >> (mc_exp + 3)) & 0x0F;
> +
> +	return 0x80 | (mc_exp << 4) | mc_man;
> +}
> +
>   /* V2 exponential field decoding */
>   
>   /* Calculate Maximum Response Delay from Maximum Response Code
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 27010744d7ae..a22e44c4fa48 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1181,7 +1181,7 @@ static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brm
>   		break;
>   	case 2:
>   		mld2q = (struct mld2_query *)icmp6_hdr(skb);
> -		mld2q->mld2q_mrc = htons((u16)jiffies_to_msecs(interval));
> +		mld2q->mld2q_mrc = htons((u16)mldv2_mrc(jiffies_to_msecs(interval)));

you've defined mldv2_mrc as u16, no need to cast it again here

>   		mld2q->mld2q_type = ICMPV6_MGM_QUERY;
>   		mld2q->mld2q_code = 0;
>   		mld2q->mld2q_cksum = 0;
> @@ -1190,7 +1190,7 @@ static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brm
>   		mld2q->mld2q_suppress = sflag;
>   		mld2q->mld2q_qrv = 2;
>   		mld2q->mld2q_nsrcs = htons(llqt_srcs);
> -		mld2q->mld2q_qqic = brmctx->multicast_query_interval / HZ;
> +		mld2q->mld2q_qqic = mldv2_qqic(brmctx->multicast_query_interval / HZ);
>   		mld2q->mld2q_mca = *group;
>   		csum = &mld2q->mld2q_cksum;
>   		csum_start = (void *)mld2q;

