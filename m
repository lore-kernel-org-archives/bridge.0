Received: from mail-wr2-f33.google.com (mail-wr2-f33.google.com [74.125.225.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF0D4078D3
	for <bridge@lists.linux.dev>; Thu, 24 Sep 2026 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245559; cv=none; b=msNX3SKBwObCklc9TVWzUkSEIdfpJk7YeYkfgsjqkxwmYk+GMLQh6C1/Pi8mSU4HPvoy+KI7DsmAv4cj8An2agFiQH0MWoAkuAQ0wVGGQDXmkRPOpPz6Vk0GJggMDz/z+yyUoivScSMgPpM+APVLrqWbgEKP0HYAoVneCRkcQgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245559; c=relaxed/simple;
	bh=vNOz10Y52SylWqLAxXpDtRKVnu0yA6ICaPesQyqWfok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqUehxz74jdGA2ti3XsRYHTp9GiuZBuDRUnDLeQ6peECVfbCId8fveX0YIz+nM4zpGrZbEI/D7sj23TBAR9gXAZAWqWvUGSczW9hpoSlwA3aGYiaM9eDjZ9NBahScTaRU5bm10PM7G1bTidhK7z9UaGYZnrXjOcN851vR+SP2H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=dwYpMcC2; arc=none smtp.client-ip=74.125.225.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="dwYpMcC2"
Received: by mail-wr2-f33.google.com with SMTP id ffacd0b85a97d-482f6351831so1185755f8f.1
        for <bridge@lists.linux.dev>; Thu, 24 Sep 2026 03:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790245556; x=1790850356; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aH8cj72YzC0YBKtfZhE3DhN84f2mpL6hc+PS7300/kI=;
        b=dwYpMcC2fKb0QuCGsgVDSCwl8DPX5pTQUJbpbRer7ZCcKrVZu8UEVYmxeg60NTcaZQ
         5nK5hJBxDtKwelpl0u7qUGNMUMae7THwdKXWG9FFVVryPijC3N2lV+lu0RvyO45IpHsn
         mB+okQvuCGZPM1rfCqm49MNjQgQP4/oeYu4XsfOCBtOe4hyzvaaHtK3djfIEVVes1SZK
         8+0vyyDhRwi0Mx1IJmfLYIjVZaegY5PxdjfyrbaGCNNdNsmdjDk0sjz7mQxiL7M9uUEu
         u8wrq2t2O3gOPJUfNAjV7DkXIojbcXs3DPIHobX8rm0R2eWbGVifPycUsvkgKfBvPTui
         028w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790245556; x=1790850356;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aH8cj72YzC0YBKtfZhE3DhN84f2mpL6hc+PS7300/kI=;
        b=2Nkh+qNaHJn2Km7UFqQJpB64/z1y3dkK3D8+xmyIzwFiH06HfCK2k9mEqR2kc8zlsZ
         X72dpcosu/rMa8d083SGR/e3sNJVI0EhLr0tFseUiHf0ZAg2izI9hTsbCPRNqBapimUr
         j0nx0UFCrv0L03WXeli5iQfEH9crlvoA+tAlaTLkeRQ8G7uDr+lF1BGuBDX8lEq+Aggy
         c5HMtN6qExDDYWBFzvOcQY028jzhSHPbCl9ehffjrbVgOg16k198xfzTW4Tgjd316Scn
         oA9JW8sGeGsUqfo4BrWsfnJ182aJuatxlziSUFAP2oZci4hdKv/dbhZC6m3kiYmbsnPL
         rbIg==
X-Forwarded-Encrypted: i=1; AKwUvBwTG2H1/LZgcHcBqlMfKtQr6ntiYuC0FX2cP0VaLHHjMQoLdWHLEAe/M2WbrCXJZVUs4nAtOlE=@lists.linux.dev
X-Gm-Message-State: AFuF++lpHPbseqJMCB10N5Pg5AY2o7xZ14iZQ83LEb4McCPdr/wXaxLE
	c9kMQYnE+9JhJ7QmCxNXiTkBFJOEhIAj8hdVU0ps0J8zkwwNxjuYBJ0CKVtbX1AfgD0=
X-Gm-Gg: AYBFou0GUjPMfn7kBEJCIS8zny8YEsP0u6HOC4EB7Bi4CEHodf8XEPM5pGZ1KeUwB/g
	+jhKT2rQk7y3hMJnptbs5+osZR4N8On8IE//JcD7eACJilFzXZwBvyf1BmdGEioHMpAk+h2CUWp
	CqY9iTMjXYnm5FCGErmsO8/4TLfk3pyyCTjIgeUPUpix5oDkVegMTGYUff9Zfv0sAHraietZSMT
	JlEfW0VFo+N3XArpYZoSz/exPfecoQQlciO5HHD+UeBXqko+7v8xneLp2Fy5ff8UPCW/6BoLt53
	rbZ9la61a34qvaEj3VdYaorzsQomfpxhfIuJXQnKSbypKFyWkB3i7hmecjjBh2IYc8+L15xhQt9
	E3bJD6BcMwPdBqwudNo1RGj2fMAS1TS806t/6FAfDg4/GRRQk22DCc3+FNZspB2p988QcrtkTr1
	P4kye5xOHBvbWVDEzdEgJUpUJhMOoJWDMuT6Tbp0vFDzeB+h/0yon4VGkag2Wv5eRtQuoMAZVis
	Ha5JADQpbqqQDBpD3n2FmvhbXzr
X-Received: by 2002:a05:6000:4282:b0:486:e9ab:2b86 with SMTP id ffacd0b85a97d-48871759fd6mr3288299f8f.39.1790245555726;
        Thu, 24 Sep 2026 03:25:55 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488682673bdsm13504490f8f.2.2026.09.24.03.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 03:25:55 -0700 (PDT)
Message-ID: <392eb8c9-6254-4ae6-ad44-e38af8bb2956@blackwall.org>
Date: Thu, 24 Sep 2026 13:25:54 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 2/4] bridge: check llc_mac_hdr_init() return value
 in br_send_bpdu()
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 edumazet@kernel.org, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev
References: <20260924082951.1599377-1-edumazet@google.com>
 <20260924082951.1599377-3-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260924082951.1599377-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/09/2026 11:29, Eric Dumazet wrote:
> If llc_mac_hdr_init() fails (for instance if the port device type does
> not support LLC or dev_hard_header() fails), br_send_bpdu() should drop
> the skb instead of resetting the mac header to the LLC payload and
> transmitting a malformed frame.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Closes: https://lore.kernel.org/netdev/179022851638.2160803.1808206741379444999@kernel.org/
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Ido Schimmel <idosch@nvidia.com>
> Cc: bridge@lists.linux.dev
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   net/bridge/br_stp_bpdu.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_stp_bpdu.c b/net/bridge/br_stp_bpdu.c
> index 74ec42ba1e7d086cbfde608c93f5fa24d6b4ed7b..21d092f5acbb81f1d0ccd80200cebdbda722f4bf 100644
> --- a/net/bridge/br_stp_bpdu.c
> +++ b/net/bridge/br_stp_bpdu.c
> @@ -52,7 +52,10 @@ static void br_send_bpdu(struct net_bridge_port *p,
>   			    LLC_SAP_BSPAN, LLC_PDU_CMD);
>   	llc_pdu_init_as_ui_cmd(skb);
>   
> -	llc_mac_hdr_init(skb, p->dev->dev_addr, p->br->group_addr);
> +	if (llc_mac_hdr_init(skb, p->dev->dev_addr, p->br->group_addr)) {
> +		kfree_skb(skb);
> +		return;
> +	}
>   
>   	skb_reset_mac_header(skb);
>   

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

