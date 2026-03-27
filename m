Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6D43B8BB0
	for <bridge@lists.linux.dev>; Fri, 27 Mar 2026 06:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774593492; cv=none; b=AU8WkVct4lEwMNTj7vUvl86N0Nr6R2ivqd1zjNKh679STcXQ8rXVht5IUhCdBNz/uFczlHrHlHeCDgAXtMBjj4iI4st/1psnrKkOG9bExt30geA0YH+p8r5v1uiwxenMWalgqFYhnaaT2XyXxVzM81QAzn3oMnX3+hpf6Skxq6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774593492; c=relaxed/simple;
	bh=OalUvNka4rSqIza6cXGQTTpYwwa3mB6/6RhFkMnDUhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MDrh/sZx35rWnivsepI0NdAmZYHsPlDp27Lbr2PVhACfjeBPy6k3CNeRuiBKzK3itp2ixcjMmPRemOy3+M5fuRxW4vNwXv81crYsFmUv7iKT1EE1+aR/PADKXo2rklDpN5x42kWwFEQDYci3ME4DIQR9+zgsjQSw2p97F4XR/R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=JONk1kws; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="JONk1kws"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-486507134e4so20344105e9.0
        for <bridge@lists.linux.dev>; Thu, 26 Mar 2026 23:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774593482; x=1775198282; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ufslfVKbYiC1gJ1SBX0ye+COWeE+LMG8L5cvsaYvZjY=;
        b=JONk1kwswtWz6ekJw7F/v7+j4QQupjt9v7k1s6ToGkoeZ5eL3L2OH7zPEHTQ7qQ/Rg
         /Ad4bClXDXzIN70kSO4xu+jinoNQMDt+Q1JDqKgGtUYVjgszz/feskZSBehfg8jHHgeU
         HJtANFESbzYMYKofCMmLQTg2Jl+nhQ4EhyUeSIpf1qKS2AbhAJwfhCvCPRKW6ABlSXy2
         oX0LKHeza1TA7TPfH0jWxeEVu+TdH5NHDvd/8m1CMEHv+rQW6+17jMrqXHSvZnXX1NpB
         AvcVWAlAYbnAiRw9iMO2whLxG9YLQKf8I2j0Xg0PRwvzoHqkIMADBAXiGKaxOq6AcyhZ
         venw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774593482; x=1775198282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufslfVKbYiC1gJ1SBX0ye+COWeE+LMG8L5cvsaYvZjY=;
        b=bz1sF/+rJLNsND6Xfxo8cJEl6MCTeB/5hrH6gOrfwNlmi2/CNTHAQixjlFnEUHDPIO
         GbYAjJJl0GakLev0g1a8Gpd5SEsxkDRuvhWsd7yzJxK7Ln39Nqyes7Mgt4qI0hA5BwcB
         Qvn9VH2uKZ3W5TO5wL3d1SPZChWfZvhPr3a/rZKTs6UyPgx9Y/iQRUmVMEpMWLVzdhez
         h72UVBD8xbJMSKkkDzk1bSlJaQSykDh0EnLEIHz5iHAVMKk+mjYr+c0Rc7wyNdpnYT6O
         G6gtpN6cIEhaDKS0JA4YSN6EndUISBLjp3miDxLrwlsAl4P0HrgagBshY/UmoVnB19+j
         vPhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPfisY9q+5ziDCZY4YIH1w/PwM+CAjmmVRgea7wS8/50PrnQpfn7CwHG3OKz9KKd3j9Pg0MF4=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzy11pwO7It5UhmLtP7cJtv+n1t1CNt76C7JZfWv2x9Ql4XbvJi
	4DOcywE4geb59jNlNFutBMi05bSGAIrTPzowHoUZJHTRQQEksSePtOkBzUZ05L7SVzc=
X-Gm-Gg: ATEYQzyGuBpZS9bThO200DGdR/980VXv2m1T3N8r/WPju/xSOGwoMQgYa+uqWj1v9E1
	eR28OuPv6JXPGShl6G26axkgips5s1KM0VoRDlvfsW/krAH4Aerraxqr8ieyll9bC2jdOCih7b2
	9GItL+9v1d/QmhLXLyxxztAEOYVqH7y2u8TLaxVX55fVRot4okZkSAOe29oHqckHByUM8EC7SM/
	2Y81mzVwrJHBrlKjbF2mvmPY8KwTetOVbp7Xy6V0/gfC6lHs2MccmeOj25ucgdzpx9QAGtGL3uw
	BSOnPUQHlXp7/6a6f4cx4zAmGh5E7W8pDLE9r7crBsBBItshaQ4Ge0y344dP+fFw2sXisPehUqg
	6PDcBQdjPXWP4rzsGYxe6wZOaOITtsLpmuyHljd1ug2L46ouefF1lem4uYeWwGoY9nvIAvxL/sT
	XrltcM2eZsA6I8cPFFl69jlgK3ZMH/iutj8qN122Fmff94DJkyuwD/OA==
X-Received: by 2002:a05:600c:4685:b0:480:20f1:7aa6 with SMTP id 5b1f17b1804b1-48727ef67f8mr19564215e9.21.1774593481383;
        Thu, 26 Mar 2026 23:38:01 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c9f58fsm121003165e9.11.2026.03.26.23.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 23:38:00 -0700 (PDT)
Message-ID: <4b0ce6be-1f9e-4f2d-b2db-16d39c8b133e@blackwall.org>
Date: Fri, 27 Mar 2026 08:37:59 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] bridge: br_nd_send: validate ND option lengths
To: Yang Yang <n05ec@lzu.edu.cn>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com
Cc: andrew+netdev@lunn.ch, horms@kernel.org, florian.fainelli@broadcom.com,
 roopa@cumulusnetworks.com, dlstevens@us.ibm.com, nb@tipi-net.de,
 netdev@vger.kernel.org, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 tanyuan98@outlook.com, bird@lzu.edu.cn
References: <20260326034441.2037420-1-n05ec@lzu.edu.cn>
 <20260326034441.2037420-3-n05ec@lzu.edu.cn>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260326034441.2037420-3-n05ec@lzu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/03/2026 05:44, Yang Yang wrote:
> br_nd_send() walks ND options according to option-provided lengths.
> A malformed option can make the parser advance beyond the computed
> option span or use a too-short source LLADDR option payload.
> 
> Validate option lengths against the remaining NS option area before
> advancing, and only read source LLADDR when the option is large enough
> for an Ethernet address.
> 
> Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
> Cc: stable@vger.kernel.org
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Tested-by: Ao Zhou <n05ec@lzu.edu.cn>
> Co-developed-by: Yuan Tan <tanyuan98@outlook.com>
> Signed-off-by: Yuan Tan <tanyuan98@outlook.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Yang Yang <n05ec@lzu.edu.cn>
> ---
>   net/bridge/br_arp_nd_proxy.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
> index af3d1e33f50b8..6b5595868a39c 100644
> --- a/net/bridge/br_arp_nd_proxy.c
> +++ b/net/bridge/br_arp_nd_proxy.c
> @@ -288,12 +288,14 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
>   	ns_olen = request->len - (skb_network_offset(request) +
>   				  sizeof(struct ipv6hdr)) - sizeof(*ns);
>   	for (i = 0; i < ns_olen - 1; i += (ns->opt[i + 1] << 3)) {
> -		if (!ns->opt[i + 1]) {
> +		if (!ns->opt[i + 1] || i + (ns->opt[i + 1] << 3) > ns_olen) {
>   			kfree_skb(reply);
>   			return;
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

