Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B936306768
	for <bridge@lists.linux.dev>; Mon, 20 Jul 2026 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537906; cv=none; b=D16caSYV3zmterKjHkYqWHcyvjot2PKfyeoTko9VrRldRrQ6aOf3cXbgluG6xG4wnFgWTS7wxm3xu1AcNn+Z10g32L+WKU/Fq8Hvo3q94JAk0KGEanGb3SfPbQNfKcs7RP8JLNY3A6Ys1MJ0IZFr2p6XoONDMuGk3OEqDCGLAmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537906; c=relaxed/simple;
	bh=M/FeSkUlN2iqLgZl/QwQ1vDPTww3FqT+IV1psC7BNho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXCUvsuQlVvBwVTnsk3LchgaZR/Aj2sPk4diKviCcxRy4SDUycoSGp/HTD+wWHUKozxeDGBUEMbr8KMfnCocs6ZcpvGjw/QcRstzTJ0s2mryq7pw5ymXMANeKkjF06iexQ/MMw0W2332sKgfhTJPLsunWICT8HZV4YltbtiTnxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=WOlxkWC/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="WOlxkWC/"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49548aebcd8so17489805e9.3
        for <bridge@lists.linux.dev>; Mon, 20 Jul 2026 01:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1784537900; x=1785142700; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=THIFmBumm1t3Qj7dX1twvX3kH9ShW1vcRhMAUJ6LjVo=;
        b=WOlxkWC/oCU8xwsEMwTR3evan4EWm3TEiiJAaYUW52CyyLfvp6NYFQFfaMWWI3IABq
         oF2SmLuXcVt7y5MKx0ekmn/TotJDqcvYhyg53WdnUQ6MYM6Efhg2enTv5iBUYSNiKiWW
         XhCaSgnF0mv4Jd4q9ispSt4FP5BF2xPHseiBd3jLOEsR17tcHUwsCTO79Tc00pkbFPLK
         55kFswYSJKliahgkhEHEqjCoEWcZFAs+gp/o25NP2HUrlXl/GlUv6invstEf+rcs2r38
         ymrSAuVhC/2wMJ1l7f6OlRAkfD0BJpW91N4fiRTT1p8cvQB7xsijgH8fsnxgcFR9ndZ7
         Dzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784537900; x=1785142700;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=THIFmBumm1t3Qj7dX1twvX3kH9ShW1vcRhMAUJ6LjVo=;
        b=WDmjPnUle2Gj23VsyYQN1EkThpBP/q0QXxCLRdb8rjS8G/yx/rFz1xWglsZ0VNmkmc
         a0W8+Lkkl7qXX7mynW0CkHicYF0A5E4hMqqSHS5eTbAGm7GAbbYM6uJVDGEGWDigDnp8
         yeJhkzC8UgEzQmPs+0LHe5pUfg+x76Z3I1Q7cUi1/VmvoWDOYEzvh2WPPzHdEnoLtzKh
         58aUe6D3r/rxnhwv49mhWBx8oAKGs7h6ypXoyVI5LvLtJiWIwK3dpYlEobtNSgAcNiAh
         wRmWV5zNsWGhoGcpoOzR9W1nEa1rEd/5zkT/jgTtuClZH+6lZeLSqOmGcvUYKzUrOTIt
         B1Gg==
X-Forwarded-Encrypted: i=1; AHgh+RqdzbFiUvKvAvzhh+3PExz6hRMiwwZh4+JBTd9Bzr95VUCbxjLqwIrqDT8KeHY1bfljyTFjcpQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzn8I4ZGU3XSJgQE2SzlHx5WSj2VU1OBQ1VHH1+KD3hI0P1bmhw
	Aa3exSX7Dgz+ytpb2Mv7KKrOu6sEL7hxrCc4gT5w6vbXxu9Ygq8h5H25xybZRZu+TUw=
X-Gm-Gg: AfdE7cnS5qLn04CjMlzBdHg/suuzg80pDY/BEjQjeRjA3QDVLX6XUoDqkf9wZweGAKq
	1nEHe0txQa+b5U0Wzy/KMiUolebIJurZhWoCa2UjftYHq8B993fzGMd1D5wxcfIanqxoLcS/0ob
	Tq77ZvmAey2EYmMcXHAaUshVRo6w8UddtS10DF7BzCsaKqmM+HhuYCtjfG/fyW2RUC/piLbqWRL
	scnL4QGErH6BxqMLDiT6IFZhFGvicARlRmI7LkPRI0Tdq/dXs1q4nQCpgy42Sd9xCpBP/90PhHN
	28v/TvQx6FJ1autICo8I670XUHFOS/1QNolLysi1BIduBvur88lbzd46B/eQvLFs5asWQahs8oG
	2w4jKktnfH0fbY/seP4X7+Zupr+rgDkIWtyQm6Nr5dIXD0FS1EXFgnwLM8Ju3QMONO45HQapCW9
	8RGo6+QdCGimv1XBNkFXN11oDSswBHYVW1
X-Received: by 2002:a05:600c:4f44:b0:495:5b02:23a5 with SMTP id 5b1f17b1804b1-4955b02253amr51695905e9.30.1784537899449;
        Mon, 20 Jul 2026 01:58:19 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49563eee22esm1870305e9.1.2026.07.20.01.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 01:58:18 -0700 (PDT)
Message-ID: <2797c0ca-07f3-4815-9233-f0f27375162f@blackwall.org>
Date: Mon, 20 Jul 2026 11:58:17 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] bridge: Use direct pointer in
 br_is_nd_neigh_msg()
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ja@ssi.bg, petrm@nvidia.com, fw@strlen.de, kuniyu@google.com,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1784463131.git.danieller@nvidia.com>
 <c710e4a236e69868a59c969bab31e5f29cfc0e86.1784463131.git.danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <c710e4a236e69868a59c969bab31e5f29cfc0e86.1784463131.git.danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2026 16:34, Danielle Ratson wrote:
> Both callers of br_is_nd_neigh_msg() already call pskb_may_pull() to
> ensure sizeof(struct ipv6hdr) + sizeof(struct nd_msg) bytes are in the
> linear area before invoking this function. The skb_header_pointer()
> call and its fallback buffer are therefore unnecessary.
> 
> Replace skb_header_pointer() with a direct cast to ipv6_hdr(skb) + 1
> and drop the now-unused 'msg' parameter and its corresponding stack
> buffer from all callers.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> ---
>   net/bridge/br_arp_nd_proxy.c | 9 ++-------
>   net/bridge/br_device.c       | 4 ++--
>   net/bridge/br_input.c        | 4 ++--
>   net/bridge/br_private.h      | 2 +-
>   4 files changed, 7 insertions(+), 12 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


