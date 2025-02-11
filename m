Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEAC22331E
	for <bridge@lists.linux.dev>; Tue, 11 Feb 2025 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739293372; cv=none; b=IiImoPjM6bCWuTv5NSfRMET0VoNJ1aFM/VZw+brlTEkdhMR+Vezvc3//a2tabt49DzWjTX6Dz73ZbKTyZkrDBGCT8FqHHSzpp3AFkNP0ccV14KgUcvFFX/vgL9awqPFXweMTC2ghn+kuVaYSVlafO1w0yYUNz56eAZtZUHVkY2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739293372; c=relaxed/simple;
	bh=cl5VRTIaQVhnhX7Mp5CHjRfQCdJZoCwXZgpTFNL919I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBQHXtcdwagdSRKQrJxqYNT3IZPbWB/i0p7YqUiAn5eM7pFSsnu1N6C2beuq96kH6kJxUwiSU4AWjonv7Z/1UQUXaTmLjmU7Kxtwzm+7bPLlsUWoKq/eaxPr0/MqlwxHNGY+7usyM+2v2/jHS6tSNjp4+jJg49Uel6EsOUuXiC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=hDe9XSTR; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="hDe9XSTR"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab7ca64da5dso361600366b.0
        for <bridge@lists.linux.dev>; Tue, 11 Feb 2025 09:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1739293369; x=1739898169; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b/56BFQCA/x0+5Zxz4AvQg+9pW1+xObkEyrqUGNwQiI=;
        b=hDe9XSTRd3KZTwjcGZ2sVb3iY0dkwaYaV2VnEfMhDwH8pBL1WHnQVoCfO5OheTuaO2
         PumxBLAgPpSnJdLMpVdGFkQvN1QTgSiKiKmbVNntTmk4SXb1AFVtfHYEDT86xOIg4tVD
         EG2N10Hr9qJSNl83/D1DmaGiDR1HS5/07e8rVoDoP22oSXLR+WeD7unfGJ5i/o4mkp5H
         DTNhosjIM5/mYxeIlQErpAN0RTEygM1q4k2DzUEh0068HTyNtCVwBm990bsT2hM3BpX4
         zGzHp5oNlh41kObrwvbDnfvj8/hXdAZgigKoiCn+hcCe5hqCjp1bL4KvGVl+3ZB7cNgv
         q94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739293369; x=1739898169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/56BFQCA/x0+5Zxz4AvQg+9pW1+xObkEyrqUGNwQiI=;
        b=PZjTbdhajglsa0+pNCvHDiYvwb/JjKMlV3tYw2LUCB3c4eNKYZt9G2S45SeI3Xzrj0
         IqH6QPi7kxG+T0WUUCD8CkIbIo6ENXWUeHYeE0n+U8RspBbNPyxzui5+XvFkZvtbGK1d
         aAe9X7sg24QvNsIbB3FPpg1IvOHUbAqQOzUGjbIs3DqVbPWYV44yDO0xRF884M/xmaOp
         WwtU3fTR+bqqX1hhUPESXBHdYRl4nXFG4zKL0VNtH7ZbqLainqK4T5f0EMrkv2RfNyZC
         Laepm+9Bqm5AjWnS51clPvZqGr8+OhxXKHipuTNoJbLw6ioMX9zHUXi95z2zphWjuhLf
         TG6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUX5owyvw/Ic5k09OXa+RV9EXX2peJqZxjrlF9CBz5TQ2+nUpM8KVAZoYNzhZWJZ2EniJb+/qM=@lists.linux.dev
X-Gm-Message-State: AOJu0YzAOmOjo4gidzJuwX08pIpZJrL1eEKZqnj5BN2oewT6sp4/RUML
	lvF5e8id7Nrf9FKs34URBO3Shsqnbftr7s0i+ScTjjHz5YLc0GUSj4G54yl5hF8=
X-Gm-Gg: ASbGncsvFP6Rjpu1IsGxMospDDT5eSAwh8wyVKmrQSCuuFOIp3omEADDsEbQzBN/lvO
	rdgJYbhzXmj1Uaa4I380wDE897SmKSkt2t6okRhm7DOoqNB+joj+WbQyxgpixjOtFL81kVKeZ/a
	YG/xjjA8sKsscB4g0+GxudOIfi/4RCzTeD+nAcsbqebrLFfUheyMb22sQSjcyRwJ0sQGM4DHSoi
	tADcZTmIbTPvnUgO/gbEE9T9aEX0LTbIvt7HUAF3neLTqOgCQY23Cw19tp6xdtXQu+Oq4zFSNbz
	mPIAbcnc5MFOKeZPxjz+uR88BBEdwexv8GNTZg/AIqdQQrQ=
X-Google-Smtp-Source: AGHT+IGAPbzjetBMyKn9xpkEx6mNiLaz6Iu+7FJStrC2CQYkHtGpuLCTUuKU+eMJA/ubyZG+xRvimw==
X-Received: by 2002:a17:907:7fac:b0:ab7:cd14:2472 with SMTP id a640c23a62f3a-ab7dafca27emr340636066b.23.1739293367291;
        Tue, 11 Feb 2025 09:02:47 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7b4e96185sm543848166b.86.2025.02.11.09.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 09:02:46 -0800 (PST)
Message-ID: <2609939e-fce9-42ff-93ee-890598437f25@blackwall.org>
Date: Tue, 11 Feb 2025 19:02:45 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 05/14] bridge: Add filling forward path from
 port to port
To: Eric Woudstra <ericwouds@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Pablo Neira Ayuso
 <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>,
 Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Joe Damato <jdamato@fastly.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250209111034.241571-1-ericwouds@gmail.com>
 <20250209111034.241571-6-ericwouds@gmail.com>
 <20250211132832.aiy6ocvqppoqkd65@skbuf>
 <91d709aa-2414-4fb4-b3e1-94e0e330d33c@blackwall.org>
 <1aa60578-ba4c-458b-b020-cff59b119bdc@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <1aa60578-ba4c-458b-b020-cff59b119bdc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/25 18:35, Eric Woudstra wrote:
> 
> 
> On 2/11/25 5:00 PM, Nikolay Aleksandrov wrote:
>> On 2/11/25 15:28, Vladimir Oltean wrote:
>>> On Sun, Feb 09, 2025 at 12:10:25PM +0100, Eric Woudstra wrote:
>>>> @@ -1453,7 +1454,10 @@ void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
>>>>  	if (!br_opt_get(br, BROPT_VLAN_ENABLED))
>>>>  		return;
>>>>  
>>>> -	vg = br_vlan_group(br);
>>>> +	if (p)
>>>> +		vg = nbp_vlan_group(p);
>>>> +	else
>>>> +		vg = br_vlan_group(br);
>>>>  
>>>>  	if (idx >= 0 &&
>>>>  	    ctx->vlan[idx].proto == br->vlan_proto) {
>>>
>>> I think the original usage of br_vlan_group() here was incorrect, and so
>>> is the new usage of nbp_vlan_group(). They should be br_vlan_group_rcu()
>>> and nbp_vlan_group_rcu().
>>>
>>
>> Oops, right. Nice catch!
>>
> 
> Hi Nikolay,
> 
> I gather that I can include your Acked-by also in the corrected patch.
> 

Yes, thanks.

