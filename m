Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B86B495524
	for <bridge@lists.linux.dev>; Thu,  1 Oct 2026 07:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790839464; cv=none; b=cPvOGI6EfL9rFoSoT+PiaPMF7x9kI9P1w2YU9BRmQu7w6iKWQONmTgGrXpzwfyINJROQ0U+cfQl3CYDKy8ZD1hdBSA2/Vbx3XO4n8EVQ2og40cKASZtQdYqTjpnO12BdhMIpv3pMiRFUdXCm/9pOMF2Xlm+dSnFfrDj3wlUH870=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790839464; c=relaxed/simple;
	bh=+kzzhS5v66EKTlw3lUPtyrJFzB9cfI2ObH/53846yGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qhXpyLs/3gzMU/yrm/m/s+5SDvQOEdhG3UkXM5DKCcJgCgbcVuLWQNeGHeT0CamWox0uEB6i5e6EznZipwlAETlxLgXsE59+Pi6apMv4zwaV2A6tI7COphllhas2lHYDYr4Yn3dRve4rZjT6yX3gZh4x4Hwihxe8wc4yliMvLTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=kwcZ7MxU; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="kwcZ7MxU"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d8239so49717705e9.0
        for <bridge@lists.linux.dev>; Thu, 01 Oct 2026 00:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790839458; x=1791444258; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mQWMGiVWN/VMdfjyxv3PjkOZ115osD80NYmANMAtXcY=;
        b=kwcZ7MxU6vjFtBvLXizNOAwkkl224RrW+vIsOpUeCWK50tOALgWoR35X02iFssiZzi
         y9oCQmDH7DMyTO8fPSqwpZ3Tf2Tk8EHBWCDAm+Ghm1uNxEMF1oL0ea7wJy4FNU3MM7sC
         cPZvjHDfEbW1q5n4ZhUgTVE7zMkw0A2QkpMG9SLmoXOlQ2yuTG+T7MMganN9Cu+3tbWc
         L8iWRIDv6YJ6x8eYIBFkZsoEfiL4K1ppaWicwfeFyyjkljxAbjYjGfhXm8pc2YUX+xmS
         FwEymEoogPcFEfMaTCd3vfqqiQzA7ywSZWC4q8ZR0ONZMN90lDwKCxSOmmjiXakPPRx8
         iF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790839458; x=1791444258;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mQWMGiVWN/VMdfjyxv3PjkOZ115osD80NYmANMAtXcY=;
        b=D5/oNrCNZrrCrgneOD5LRQdk/CH9SJgl2Cc8XUFD8BC+HiPTOSqR/BMLgmQSSgnfPM
         Kln//Smoh/5m4xRgpVpCWjPFGN928i+dFEUlJ2hBHRGNHUsVv/Ob39jiKGt2/u4aXKbt
         dIH2LetdyUDvTgCzVnBFPeaQ0lIOl7q9wlxz0K5Eqn4g4LQ6C10vD9ZtmP+c62Z/2Me9
         tTiMWaJ4/yzG0ahypfVKX1qtI28TsrTOcI7dvdy0s3WhkpUBury07VDOrhcXOa8bxecb
         o1pz/LmlAWl2r7raKbrnn0M+do9spExeTzY45+opTvpma3BqngDi5eVHGr9DLEIpHUhJ
         C/Ww==
X-Forwarded-Encrypted: i=1; AKwUvBxA+pwZCvjDCJKoGT3GkPOZt+BaMVX0HsqkExNXxmUxa2Y+rS2HVpsbHfZNCsDZ4NKVM9EJXTA=@lists.linux.dev
X-Gm-Message-State: AFuF++ksHn6G+rFzfBCXGBB7Vw/6ml2KPju1d9vDKKdAW2s2YXwy6xb7
	yhrTCYcF3UNHnJXGNG/VbRi6ylOyBGhRZP8fzFOF7+QKdCMn/dfxDpmy7i2ZJXatlHMDPjmygcx
	n7ytcdPM=
X-Gm-Gg: AYBFou06OeJPAnlhbq0viLY+QWFVGTOpf1tQmSWyjbrdvMAQl33kVnDUAAQHBhn1eAo
	BwHyjmymZuWSzfb/OlIziVvPbvgUl17H7Vai0ebDQakngZ8K4SxB0Fc0//3wK/qdu1Wk1lMB1Fi
	iQazW8f2+veSgjPazRHsGFE3yRKDlqyTN0U1yYAqJF+Bb+bHqJQ8SVKObmLy7LHCTbG3gtaYxjs
	vLipzP3QKhxmA5VN0lDxvnA1bvLPuEurGzrR7qd4t69GQrzeqvhEAT4Y1HlJOygANMkIwUUfyTs
	34HYYEuE/FjVuAaD0Lpt6MBjc/B33xKd1ewFr3T85gm8JFCnRYJuK4X3Lz2jk9kNKpoRqzzPN8Y
	jH9O5pg5p1edE4VB/lO2kT0QKUThfVwyVjFCBkAN3TpBtV3EObKPmKTGoLy20DdEse7GUScnEFS
	2eunnK0fAsv9ggio0A4ViQWUPYSBAzAbY0542Q0T/lpSrmZ7Zi/UGNe71XwZ1FeQ5NmDWwqrnVc
	NeER3tNN0OZZpmRpTkro+lOOa/r
X-Received: by 2002:a05:600c:1c0d:b0:49c:fa21:1c81 with SMTP id 5b1f17b1804b1-4a01aff36b2mr71267215e9.22.1790839457379;
        Thu, 01 Oct 2026 00:24:17 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f90cd4esm62840435e9.1.2026.10.01.00.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 00:24:16 -0700 (PDT)
Message-ID: <e930a549-9b26-4e5d-bdac-ec80537b6306@blackwall.org>
Date: Thu, 1 Oct 2026 10:24:15 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/12] net: bridge: introduce a bridge
 destination type
Content-Language: en-US, bg
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bridge@lists.linux.dev
References: <20260930071411.2786201-1-razor@blackwall.org>
 <20260930071411.2786201-2-razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260930071411.2786201-2-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/09/2026 10:14, Nikolay Aleksandrov wrote:
> Add an opaque destination type and helpers for representing bridge port
> destinations. Using a separate structure makes raw pointer assignments and
> comparisons fail at build time while marking its value member __private
> makes sparse warn about accesses that bypass the helpers.
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>   net/bridge/br_private.h | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 67117fb3dc88..1146187aa2ba 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -306,6 +306,10 @@ struct net_bridge_fdb_key {
>   	u16 vlan_id;
>   };
>   
> +struct net_bridge_dst {
> +	unsigned long __private value;
> +};
> +
>   struct net_bridge_fdb_entry {
>   	struct rhash_head		rhnode;
>   	struct net_bridge_port		*dst;
> @@ -670,6 +674,40 @@ struct br_input_skb_cb {
>   #define br_debug(br, format, args...)			\
>   	pr_debug("%s: " format,  (br)->dev->name, ##args)
>   
> +static inline struct net_bridge_dst
> +br_dst_read(const struct net_bridge_dst *src)
> +{
> +	struct net_bridge_dst dst;
> +
> +	ACCESS_PRIVATE(&dst, value) =
> +		READ_ONCE(ACCESS_PRIVATE(src, value));
> +
> +	return dst;
> +}
> +
> +static inline void br_dst_write(struct net_bridge_dst *dst,
> +				struct net_bridge_dst src)
> +{
> +	WRITE_ONCE(ACCESS_PRIVATE(dst, value),
> +		   ACCESS_PRIVATE(&src, value));
> +}
> +
> +static inline struct net_bridge_dst
> +br_port_to_dst(const struct net_bridge_port *p)
> +{
> +	struct net_bridge_dst dst;
> +
> +	ACCESS_PRIVATE(&dst, value) = (unsigned long)p;
> +


Sashiko says:
  Does casting this const-qualified struct net_bridge_port pointer to an
  unsigned long drop the const restriction?

  - Yes, it does but that is expected.

> +	return dst;
> +}
> +
> +static inline struct net_bridge_port *
> +br_dst_port(struct net_bridge_dst dst)
> +{
> +	return (struct net_bridge_port *)ACCESS_PRIVATE(&dst, value);
> +}

Sashiko says:
  When the opaque token from br_port_to_dst() is resolved here in
  br_dst_port(), is it unconditionally cast back to a mutable
  struct net_bridge_port pointer?
  Could this provide a silent mechanism to cast away const, bypassing C type
  safety constraints in the API design?

  - That is again expected and wanted behaviour, we're extracting the dst.


> +
>   /* called under bridge lock */
>   static inline int br_is_root_bridge(const struct net_bridge *br)
>   {

