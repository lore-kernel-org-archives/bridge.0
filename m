Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23B13BE64D
	for <bridge@lists.linux.dev>; Fri, 27 Mar 2026 06:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774593503; cv=none; b=nLPjjomCYSj3VXnxj2jbOFPRylCABJY/H9obDhHQxlsbxjl4vjio7nRXpLzzlp7xMN1ZIDndS8Af6wkxNZKAdMfArrfy4wdqnunsTqroU7/YWDW3UsUR258+BXHpXuDsPvi/7q5DTOS3RCazoUGXjvw/iVvvqkv3hr3Nz1Vjh6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774593503; c=relaxed/simple;
	bh=0PQ0R9rAwmS9xKjuhJFascJ1dmFx6hqwZe5aHDfzhHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lbw6nlL5boyupDBrBpVcdfJWA+SV5jYVxaR8Y04d+9y9mwMnxa7WBRpi3yvE/lgTmetOSRLOU/nVMQskvOM0b7yR0xI3s3f+9inijuMeyrTQhYC9OyKZ7NouVu6W9v86Iz1FzVi94D0L1blh8S6+/9qzcZY/VACUuu5g441TONQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=iMOM5b8i; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="iMOM5b8i"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so17554575e9.2
        for <bridge@lists.linux.dev>; Thu, 26 Mar 2026 23:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774593492; x=1775198292; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vy83C5FxtN9GPfanScbX328M9aV0PE+NWeES6DorSXA=;
        b=iMOM5b8iWgbQL9E59VijaodGEt5axyRzAFiSaqPPOTl2JXs/I2gJ6ttQ9XUWk84Aug
         gaUPrhRBEgKJsPG9RSmDatBOl+JsNrG54URqpX14ovHLh5fWOgRPwMl+S7g+b0q76i7x
         tU0thUJVAgUH0kFkVgIzbsQu4pTDkgytg7Ppy9Oz2Ho3YwIlXITROvCj5B9LM7QzH+RK
         9A5sVNgHIxzs0NFJXzrXC2n+KS8WFJXVJemYT/f7aGW9xzbH35OlK/n1TUk1cy3YvcFr
         wXPiqcEAzIYW+SEDW2JM403mHAeKYhV3172AY2MzoDdte88Ub0tAQUX5WLWj407q1mib
         uwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774593492; x=1775198292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vy83C5FxtN9GPfanScbX328M9aV0PE+NWeES6DorSXA=;
        b=Ap61cV5Txqew6N2/+Uyvih0k1DF/MzFKnChtbH8+E7jPai4CcD84KGipTs3uBm9qj5
         mOybmViSgtnygNl79U+szyOzro7Z0w3LFAtQUjcyfm/bg9VgHoEvGqqlyR3HnUqE8FyV
         QSB2wx8vTxAHdkJKjCt3EEN3qDgiB2kdLyRUdk9LM90s+4NMSCKnIyMFzq7FdrcpZQbx
         PNSc48U5Ljlyirc9KLXDkUM0EzXbUE1NKHYmoAN0KZkrUjn5VcqlkDHmADyc4ngAYfh7
         hSMtHZzUlyjN9Nyjv/r0F1KrHdGQLHHyG6gQ8JLLpiPQWe0yPGQ5CTe6YoPqki3fQVin
         fwgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYZCI8ZHM+42bSdWwP3o6lxalOt2OImUPjDN1765EqtFH8bBECL8wZV2vL1jEPbSPHLHo7KxA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/RqdtdqNyuTM50Sc23O1quxlsZjm4Ao0l1JIaPmBtYf7gas5X
	sfnmmQNBk2v24dRmbD1Z7Demq1+E9p6c0oGPbnKYpUk6kaIKNaO4s+KWUYCu0POKTJw=
X-Gm-Gg: ATEYQzx3HnzPQAfW0MzLTGUou2tpstkg3dw4/8YjFT1HKuupqf23RDdRZU6sXtHqrxW
	X6wtH0weZijFeCFAlf359+ULNGUt7jIqGy3c3SJWNdHKNx/j2z9gG6pksEzNYrhUZPE+laFBbbw
	qXwCnEm3G+HC0qJIkKR09DiZd4tye6hRurJXaqD/vVHp9u3iVYdfd7UFV0Sro5ikY+qaXx50biw
	Guti8CJv/xSleBw1xHDnsDjSSHKauWHKZv4kBCET6wG9h4/Yf8rvqwMEIJb3u5LnPUU68JT0uIH
	xaXBCIRyN7B7OMucMQDQBz8COyfERnGnzX4SdwZqK0loZu/cpzozX2/KMKzRb1eu6Nj1cTFssLX
	phhgADjtHhX6imsy5xklS0HaIDfiaUjz/Y2zxJErZloPyxxnUEK3EqeM0cKGkCI9X0VZ0GGc1n0
	R5n2gIGet6aAmPclg/HFG05G9z1rbqBpYfHv1C6L3MepESj1MT56x7hg==
X-Received: by 2002:a05:600c:8b77:b0:486:ffa3:584 with SMTP id 5b1f17b1804b1-48727f17035mr17478945e9.15.1774593492578;
        Thu, 26 Mar 2026 23:38:12 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487270fd880sm12607495e9.8.2026.03.26.23.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 23:38:12 -0700 (PDT)
Message-ID: <8414c7c5-5400-46b4-a470-fade0ff4faee@blackwall.org>
Date: Fri, 27 Mar 2026 08:38:10 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] vxlan: validate ND option lengths in
 vxlan_na_create
To: Yang Yang <n05ec@lzu.edu.cn>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com
Cc: andrew+netdev@lunn.ch, horms@kernel.org, florian.fainelli@broadcom.com,
 roopa@cumulusnetworks.com, dlstevens@us.ibm.com, nb@tipi-net.de,
 netdev@vger.kernel.org, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 tanyuan98@outlook.com, bird@lzu.edu.cn
References: <20260326034441.2037420-1-n05ec@lzu.edu.cn>
 <20260326034441.2037420-4-n05ec@lzu.edu.cn>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260326034441.2037420-4-n05ec@lzu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/03/2026 05:44, Yang Yang wrote:
> vxlan_na_create() walks ND options according to option-provided
> lengths. A malformed option can make the parser advance beyond the
> computed option span or use a too-short source LLADDR option payload.
> 
> Validate option lengths against the remaining NS option area before
> advancing, and only read source LLADDR when the option is large enough
> for an Ethernet address.
> 
> Fixes: 4b29dba9c085 ("vxlan: fix nonfunctional neigh_reduce()")
> Cc: stable@vger.kernel.org
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Tested-by: Ao Zhou <n05ec@lzu.edu.cn>
> Co-developed-by: Yuan Tan <tanyuan98@outlook.com>
> Signed-off-by: Yuan Tan <tanyuan98@outlook.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Yang Yang <n05ec@lzu.edu.cn>
> ---
>   drivers/net/vxlan/vxlan_core.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 17c941aac32db..a94ac82a61364 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1965,12 +1965,14 @@ static struct sk_buff *vxlan_na_create(struct sk_buff *request,
>   	ns_olen = request->len - skb_network_offset(request) -
>   		sizeof(struct ipv6hdr) - sizeof(*ns);
>   	for (i = 0; i < ns_olen-1; i += (ns->opt[i+1]<<3)) {
> -		if (!ns->opt[i + 1]) {
> +		if (!ns->opt[i + 1] || i + (ns->opt[i + 1] << 3) > ns_olen) {
>   			kfree_skb(reply);
>   			return NULL;
>   		}
>   		if (ns->opt[i] == ND_OPT_SOURCE_LL_ADDR) {
> -			daddr = ns->opt + i + sizeof(struct nd_opt_hdr);
> +			if ((ns->opt[i + 1] << 3) >=
> +			    sizeof(struct nd_opt_hdr) + ETH_ALEN)
> +				daddr = ns->opt + i + sizeof(struct nd_opt_hdr);
>   			break;
>   		}
>   	}

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

