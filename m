Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DB53FF88D
	for <bridge@lists.linux.dev>; Mon, 31 Aug 2026 12:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179486; cv=none; b=qtjnbA2n1qLgXzkW3HSZLO310MiVsZYP+j0McEQhhQshqbiNM50R4Wcg8xRiH06Drd3IGxR/xmEUmOvnhlUfoZVxr+u4L2hyD3EqiVyABaNLP7M0Qngv8WlzoRArZ7zdkGXzEy7H2Hvou9+qFzH5QyCFRP/np44qsOu/jo3rwhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179486; c=relaxed/simple;
	bh=Y0V/3uw6Dclec70rKLWcztfNr2TyqhPTDR3WmwbMJ+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=noCnbQspJHp1zFEwQ5U7zKEtlT0eJdHW/GyruGpEVFoD7X0MBGdg/nK7jvy0bMOUMC3ngMWmE0dricnPb81IlAPG56XCW/lLYH4c55v1oT6lRFyDsZb8vbtaHxAA29gybz1ESSlIIOTan0D64S9R57ytrTAvc6GMwSgqyHACimA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=hSbkLE+o; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="hSbkLE+o"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so39754675e9.1
        for <bridge@lists.linux.dev>; Mon, 31 Aug 2026 05:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788179483; x=1788784283; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hMHSz/yOqpOw4BUuWyRgv2r2RwaD0GDIsQCXrSNiv3U=;
        b=hSbkLE+olRNBA01H0ps8VkkvVQHftsL91L054PajSCIa/Wl6xqVIeX92LQucsmHaWc
         47rKtAQbGzs3YZGcQc2EKvu5ZSVFHVRkbjFzyqCaKA8ElW5ofC63F3B+7w04mGpF5P9K
         tRigNBy3KW2fC+jsVB0NrJkrvaJoWHI/j8NZFMb0ahoCFtRYCA12C2NR9dpt569rAg+F
         6V118sYN5ZMdNKwtgdwOEafixpFLyqTUwPWqnGsDrE+mJYnsqBR3jnjgSIUmOQonHb7L
         XGisiyWj1zvJX+Ie3R6mj9nhmdrYCYXUoFtF1q/Nid50YLQHku3X9gxeSb+P2vcrkE/3
         7HeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788179483; x=1788784283;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hMHSz/yOqpOw4BUuWyRgv2r2RwaD0GDIsQCXrSNiv3U=;
        b=oGUOeGC8ggxvL9r3UkdhDqwZv+fkUKMkT4GGfXeO9E1evhR5kNyVXuN5GK3ouLiK4G
         ruBz64zn/2mL1cqRMEaxA3ZdKU+nVO2NUtOIw2RUvBM1QX9rxDFHhzfdi7yLlpiu8sEi
         KXgWqCE7/z/bPtIDoMLjsoTBbimmO+BcmhEW3ZiIzqC8wOusqB1wMNl3vYSetZoi4kHv
         5KHRcFbCoW8HKqE5gn/UP1SRhDk0Mp/7TaabuP9BuFlsDO1CNL2Ac/W6fB/R7p6uLfBA
         fTit3Z+hTFMOSRAksw7HvzM/EiXTJBxvZTuWvgSHNbKmWlWqZ7fsRkm7LFiNjcNq1Bwg
         6uyg==
X-Forwarded-Encrypted: i=1; AHgh+RrNyINF/61cMwpL5d8kak53hH4RTxRnT+larJmIdTc/CZq6Bdrc1HYTZVBJ97lZHLPXbOeoQio=@lists.linux.dev
X-Gm-Message-State: AFuF++njm88hYdAiq6735kacYm8pvBkGcwP6d3oGTg58UFVCvDoxSwVR
	PbSiOs92irNI8WE+Ls9NpNgajon4EMEFWgFTK7voVoVdeAk+7opgMQneUEbjQE9A1Z0=
X-Gm-Gg: AR+sD10fw86+8iZlh1iqCDuEtWmJnrXU3TAWp98jcNvUGWooONM8nmm3g3VdUce82zQ
	mIu/QEHyx5hn8DBpmVWs5wpSJJU1KEnbmRaUMENQNdenUurBXu4gZJq8S5KfLq5NkPNh6bn39Gr
	U1MAPytkpfQHxSOWw9Y45Y7sQXzI6d73XSmwhLmlcVCvnT6RIYZukxRKUnjIB8Y27xgCfZRANvD
	plV6a1mlVRbbSOKaCaLgJcxu6sYAqNgwdwZepHOly0gnFPwsOtKze2loW8AhMHqom6USkSOEWZQ
	N+zAnECRTXKMYsXj7glHs4ab7Nggw9eaBGcE4P3TOVbJ8PNjbW36WgIzsbJ9WFyxPfMaSLgl6e0
	ONO8Gueuhmveh6KRWwmzhSaSUlY3uYB9zfM5gB/kqF9/JVmFQgHBwgSxr8qsCuCIHfAevswCsP2
	LDpQ1ELT4WRzyotapbZa1i4iF8X4GhGvzjeDnCasSFKLN9A+gRuTsVPdmdClcohxKp0ch5YgrDL
	qiQ+i1pL8rQx8iWUd8=
X-Received: by 2002:a05:600d:8498:20b0:499:dbae:86be with SMTP id 5b1f17b1804b1-49b91c4de9bmr308024275e9.14.1788179482535;
        Mon, 31 Aug 2026 05:31:22 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ccae954f9sm216243985e9.13.2026.08.31.05.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 05:31:20 -0700 (PDT)
Message-ID: <b30a2594-b154-4f52-9afd-2db0f9d78bb3@blackwall.org>
Date: Mon, 31 Aug 2026 15:31:19 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bridge: skip generic XDP on locally re-injected
 packets
Content-Language: en-US, bg
To: Zhao ShiRong <shxzhaosr@163.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 bridge@lists.linux.dev, syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
References: <20260831113051.13072-1-shxzhaosr@163.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260831113051.13072-1-shxzhaosr@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/08/2026 14:30, Zhao ShiRong wrote:
> Packets locally delivered by the bridge are re-injected into the
> receive path via br_pass_frame_up() -> br_netif_receive_skb() ->
> netif_receive_skb() with skb->dev set to the bridge device.  If the
> bridge device has an XDP program attached, __netif_receive_skb_core()
> runs do_xdp_generic() a second time on such packets.
> 
> A locally-delivered packet that was allocated on the TX path (e.g. an
> MLD packet built by mld_newpack()) does not carry the
> XDP_PACKET_HEADROOM that generic XDP requires, so
> netif_skb_check_for_xdp() calls pskb_expand_head() and reallocates the
> skb head buffer.  This frees the head that the bridge rx path
> (br_handle_frame() / br_handle_frame_finish()) is still using, leading
> to a use-after-free read in br_handle_frame():
> 
>    BUG: KASAN: slab-use-after-free in is_multicast_ether_addr [inline]
>    BUG: KASAN: slab-use-after-free in is_valid_ether_addr [inline]
>    BUG: KASAN: slab-use-after-free in br_handle_frame+0xcfb/0x1510 net/bridge/br_input.c:349
> 
> netif_receive_generic_xdp() already refuses to run generic XDP on
> reinjected packets by checking skb_is_redirected().  Reuse that marker:
> set it right before the bridge re-injects the packet, so generic XDP is
> skipped and the head buffer is left intact.
> 
> Reported-by: syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/6a6d4406.2d659fcc.1d46f5.01ad.GAE@google.com/T/
> Signed-off-by: Zhao ShiRong <shxzhaosr@163.com>
> ---
>   net/bridge/br_input.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -26,6 +26,12 @@ static int
>   br_netif_receive_skb(struct net *net, struct sock *sk, struct sk_buff *skb)
>   {
>   	br_drop_fake_rtable(skb);
> +
> +	/* Re-injected for local delivery: do not let generic XDP run on the
> +	 * bridge device a second time, it could reallocate the head via
> +	 * pskb_expand_head() and free a buffer still in use.
> +	 */
> +	skb_set_redirected_noclear(skb, false);
>   	return netif_receive_skb(skb);
>   }
>   
> --
> 2.43.0
> 

Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>

This is wrong on multiple levels, use your head for 2 seconds before blindly
sending AI crap. This was sent ~2 hours after the report was sent, did you
even test your patch or just hit send? Very disturbing practice anyway.

Perhaps we should clone the skb for passing it up to the bridge when a fwding
helper is using it (i.e. when there are actually clones).
