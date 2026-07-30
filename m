Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5750743F8CB
	for <bridge@lists.linux.dev>; Thu, 30 Jul 2026 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785425269; cv=none; b=SD+PWxEiqXk2pR/oKCu+0JcNrgvjCNeJb/9+6GawH56zx13WMOZCWDF44hzAREEXp3KG2Zsidp8kzMuqwac0p7+kRs9+Ehi6TERbP6NEWjC3GWgReRZBuvbEl6kvMrzneETYqc5YkPHhot4PiGzzoQH0zmL2Z7d1csjw988hUIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785425269; c=relaxed/simple;
	bh=d5RXFfVRX5p3oscQXB9FNGQJzjxxqOI0ZyUQ/yhbbX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufVGwsNf6E+0DhZzsv0WnDDusUUhLiJYl3AMLOEF/PaaXDOOtgyrrzpYoM6dwHa3BtVgcQ2qfmY7+GiVYEGD858EXUL0FcDha0tA0Nf6VtIdVBUrGhNDpVb+F6KQAkf1Zr+9YkSkpb6GZ3I37wPb8eLF4H4wgI1FvvpAyuS3qIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=GRneWVRU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="GRneWVRU"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso11470315e9.3
        for <bridge@lists.linux.dev>; Thu, 30 Jul 2026 08:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1785425264; x=1786030064; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nzJUatZRCgVEofo3LM1zenQhlJFklBY9WtRFTuod4dQ=;
        b=GRneWVRUK0u/l1Tgy60rS7UecUCTEqSuDNXmi+lif1JdXFfLxORaghG/4ZQFsrxgIj
         s8uefrte+LmL3vtHNIBpuHc8YcVZIImb+fE3Lo1Vb7qwvgosGMbj17YM0UQIpm8kf5Uv
         QMSu497K1wuTC7Yyfn281Vhb4r7J8II780B6+TyUqkSov3JX2OGZu4DsnS4+ny5ddUoN
         LsJRtQrx67lo+nt5my5IsIBi5TraG942BkPfsul1+9G9BC35AQF2YX+kT6QspQ0Hcc0i
         jVcHVLZs20o0x9t0/G/SX+S/C7106J1VkkJ0B6yiTpR0OexG6u+bxnfQtyo3JwCxgMSb
         yKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785425264; x=1786030064;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nzJUatZRCgVEofo3LM1zenQhlJFklBY9WtRFTuod4dQ=;
        b=QmKIB2cH9kAYs6PB9+d+MFkl89AsYxSX0MjSq0GcFlpOgQDMXQ/oWVmoC7xYbMwb6W
         YpGcMns/aWObm5sKhevVjrxsVKjBbUwaNs3yvuLnz9oznIZgVFQhCiWhX2Ms5PAxwNMl
         mU6batu0s8A3WNPswPcy0kSEHSH3iQavOw6a/b34MlsHqc01DbOZstg8xOD1kGyGnj/g
         UT8NCmb4ec4VovHmeSJttTaeFKr9zOsV4OhqRtAM3Pljb2AQJD+QSKBnMjYAIl8h9t2Y
         6p++AQXbW08nx1Din7EZMZQw1An5BfoafjGs7UX7H0yOT5vlff0FRYMiTmpfZeRNdwRg
         eJfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrf8o0LsFnyDrP4nFmXeEq9DByBj6D1UxvgdG6cwwdiQuWYTPkm4IYgwUDk+ye/WNmhsNtlvfc=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4CLExyE0m7i3N4FX/ekuhAL7wJkqQETss0VkVc3QLriXUjX3P
	fWv3bSLWh0XMeOIpYMKcwrxR70KH+ec9ySGyTvagGgY7J5m6h+vJmvUwoYZQfP+bprI=
X-Gm-Gg: AR+sD13AOaRf53KQ8p3nHUtJoEL22SJasm9NPluipGtJMkJk8k4qgB+EPV3hwDK01hH
	/A3s3ho+oHr45v2XAzzONzymIN86UEvgd6ZnVm/wnf+IB2NDjIA5GKK8izfb3AI6aSEmakeXixr
	iqBMxYReJXXzGN+yoPopaumWmn/hmtvqvcZ9SKkDW069Zh4sAxfv47Y1SygXD2qYcIeyRA3OhRF
	p0UfLOAeByFm3ymykgQajL07/s6RaFbbNXRBoIcgNErtFN2bHI1xYoJsHT6EZdZ/uBzykHc1nKl
	8ByqZm3Mx75aIEwMJ+g6Fiyp0dStA3hEwQSAMX4+QLdSmv80gdeZVwIzIzKwEQItcb6oronUjQy
	aU/xNaoJiNcz9WSPdDWT/GqvoywSmBMO33DaNQGaN7kDocLCF2kGQ2EG9dPS9jkAmJ1A8ToLAR+
	0P9S4Ueb+8tT4WnFSBW9EyU7Yb7VhIzvYBokXjXD42TAfUYMvLQSOhutw=
X-Received: by 2002:a7b:cc89:0:b0:495:6f6b:fb75 with SMTP id 5b1f17b1804b1-49800ebba08mr29432035e9.38.1785425264161;
        Thu, 30 Jul 2026 08:27:44 -0700 (PDT)
Received: from localhost ([109.160.74.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498011fd5fesm62954505e9.7.2026.07.30.08.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 08:27:43 -0700 (PDT)
Date: Thu, 30 Jul 2026 18:27:41 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Baul Lee <baul.lee@xbow.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: bridge: mrp: fix uninitialised bytes on the
 wire
Message-ID: <amttbcdZkuWVSdLE@penguin>
References: <20260726062518.43774-1-baul.lee@xbow.com>
 <20260729131941.10254-1-baul.lee@xbow.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729131941.10254-1-baul.lee@xbow.com>

On Wed, Jul 29, 2026 at 10:19:41PM +0900, Baul Lee wrote:
> br_mrp_alloc_test_skb() builds MRP test frames on an skb from
> dev_alloc_skb(), which does not clear the linear data area.  On the MRA
> ring-role branch the sub-option TLV header is appended with
> 
> 	sub_tlv = skb_put(skb, sizeof(*sub_tlv));
> 	sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;
> 
> so sub_tlv->length is never written, and the two trailing alignment bytes
> are appended with a bare skb_put() that does not clear them either.  The
> neighbouring oui and sub_opt regions are explicitly zeroed, so three
> uninitialised bytes are left in every MRA MRP_Test frame that goes out.
> 
> Put the sub-option TLV header and the alignment padding in a single
> skb_put_zero(), which clears both.  The AUTO_MGR sub-TLV carries no
> payload, so the zeroed length field is already the value it should have.
> 
> Fixes: f7458934b079 ("net: bridge: mrp: Update the Test frames for MRA")
> Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>
> ---
> v2:
>  - fold the alignment padding into a single skb_put_zero() for the
>    sub-option TLV header, dropping the explicit length assignment and the
>    second skb_put() (Nikolay Aleksandrov)
>  - drop the paragraph about observing the leak, and the Reported-by tags
> 
> Link to v1: https://lore.kernel.org/netdev/20260726062518.43774-1-baul.lee@xbow.com/
> 
>  net/bridge/br_mrp.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
> index 179d2470b..ef16d0703 100644
> --- a/net/bridge/br_mrp.c
> +++ b/net/bridge/br_mrp.c
> @@ -224,11 +224,9 @@ static struct sk_buff *br_mrp_alloc_test_skb(struct br_mrp *mrp,
>  		sub_opt = skb_put(skb, sizeof(*sub_opt));
>  		memset(sub_opt, 0x0, sizeof(*sub_opt));
>  
> -		sub_tlv = skb_put(skb, sizeof(*sub_tlv));
> -		sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;
> -
>  		/* 32 bit alligment shall be ensured therefore add 2 bytes */
> -		skb_put(skb, MRP_OPT_PADDING);
> +		sub_tlv = skb_put_zero(skb, sizeof(*sub_tlv) + MRP_OPT_PADDING);
> +		sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;
>  	}
>  
>  	br_mrp_skb_tlv(skb, BR_MRP_TLV_HEADER_END, 0x0);
> -- 
> 2.53.0
> 

You should not send patches as replies, they should be sent on
their own. Aside from that the patch looks good to me:

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
