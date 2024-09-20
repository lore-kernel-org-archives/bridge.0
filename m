Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84383BBF5
	for <bridge@lists.linux.dev>; Fri, 20 Sep 2024 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726814548; cv=none; b=tsxycR+7krXRUFhDztKuF9A01an5QNO1pV2BxY5jv8GNOmmew8wBkzpNx2fqzvWo7sKPfIuY0u89r8qjh3TzGyRCwlFBF/BnzBK1mlrhJczhOo0/GgWvupWAyi7GnH5aSvJ+fXigqoXI+kNY497/u7nk3K65KUf9hj3vDs8/kU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726814548; c=relaxed/simple;
	bh=Hb2b/+q+hToRh61WxWnw+lJdABcYLPuii7nIFRD9qsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijc7yR4+4jWj/zbeo03h9n+3DR0a2aVXGLeNS0PO8ogCc5av42M4xRa0d3oBCKccDWsMndghUIZ0uUmvo2tVKeezb+PqJKdalB8NMI0sQbXekTJslVcMIxrHRA03UKuKIIxnkaPgfTy9cjI28qA6hWRYn6KIzD7DgOmX2NEepNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=urzWkxn9; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="urzWkxn9"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d3cde1103so203892766b.2
        for <bridge@lists.linux.dev>; Thu, 19 Sep 2024 23:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1726814545; x=1727419345; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=98uSNXWBdtIj2loX7w9P5NmjIJ5+wZsoyxlrEw5OdHs=;
        b=urzWkxn9PhSSGwF8FhnHQNRHjbWhilaGxehQBDmgsGD8F53DGwdD71cbBjMuXebJNF
         /iinLarYD4OK0vNhxsvM58izXlbdQpoSnGPstKgyUoEZDHz6y8EYKvd/Gdmn8c7ETDnU
         20coeFNn9l8ikDyc1drveflNC26SoLTyIRRJJsLgC6ALLobKsboJwqk0T6XydX9nt6Js
         UUkrPJcjHfAobTxe6fViDYcJ8eOC6PDt+1D9uKm+numy3QRSUalN5z5lw3Z83JviVLQH
         bvbIwb0nwEO+7X8xz/qOz+x0o4pOcXHPA7MLN/9B7jrCK4xW/yQcwoktayfZwxZNttkm
         Yjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726814545; x=1727419345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=98uSNXWBdtIj2loX7w9P5NmjIJ5+wZsoyxlrEw5OdHs=;
        b=C/N/iR1k0VByrEJKr9aqVQSHEkbdH/ELBYYoXZoQCZdrwP4wJuxsm8poybzDWSbeBl
         yPDpwtZ+w5z++gQIyWhbC5DmJwn6hZktEYkxUbKlz61GRieH//NXCsILPrZ1FPLrSskq
         B+yl7ruTtrLfxBUDB3rswkUr0z9xFXvfA9nI3Le5Pcr9Y5bfvA61OL3ottIY7yAbXcXq
         xCXJT2Ky/PN8svkkyYq8D73a2K02nuqlZijtxiQqvzVo4Hqs+Jt9/4GeKaIQVkj7U4tp
         Axd3YJ0khzynhx8Q0wkSnaie0wpVQgMLv+JjJqfuE0FPoc3kd5sLIhviesTm0TZI6WaD
         ZAbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhclef4qrmyS/8WPfBCFAMrpJjx+UGM3BkjfvjIxlGhMcjyd52Q8kKuPShnGcUOZccBehnH78=@lists.linux.dev
X-Gm-Message-State: AOJu0YwGZPzGnN0ow7PjxEJhKtICyKZzPPR58uoYUH7G+6xeGJk+roQ8
	n79Zf6aFRRlAF2fVooEx312zyfX1HrB55NCmfo6wbQQztI/ziTCGQ6YExffl4Tg=
X-Google-Smtp-Source: AGHT+IFK3LECOgNL2LQB34zytpe20wT+mFRQaW0BYumib9GiIXC7awb6RQOknCMw9j46sSiKv4IBmw==
X-Received: by 2002:a17:907:e6de:b0:a86:68a1:6a08 with SMTP id a640c23a62f3a-a90d56b44a3mr138829566b.29.1726814544477;
        Thu, 19 Sep 2024 23:42:24 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90d21bc502sm76613066b.25.2024.09.19.23.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 23:42:24 -0700 (PDT)
Message-ID: <34a42cfa-9f72-4a66-be63-e6179e04f86e@blackwall.org>
Date: Fri, 20 Sep 2024 09:42:22 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] net: bridge: drop packets with a local
 source
To: Thomas Martitz <tmartitz-oss@avm.de>, Roopa Prabhu <roopa@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Nixdorf <jnixdorf-oss@avm.de>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240919085803.105430-1-tmartitz-oss@avm.de>
 <934bf1f6-3f1c-4de4-be91-ba1913d1cb0e@blackwall.org>
 <7aa4c66e-d0dc-452f-aebd-eb02a1b15a44@avm.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <7aa4c66e-d0dc-452f-aebd-eb02a1b15a44@avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/09/2024 14:13, Thomas Martitz wrote:
> Am 19.09.24 um 12:33 schrieb Nikolay Aleksandrov:
>> On 19/09/2024 11:58, Thomas Martitz wrote:
>>> Currently, there is only a warning if a packet enters the bridge
>>> that has the bridge's or one port's MAC address as source.
>>>
>>> Clearly this indicates a network loop (or even spoofing) so we
>>> generally do not want to process the packet. Therefore, move the check
>>> already done for 802.1x scenarios up and do it unconditionally.
>>>
>>> For example, a common scenario we see in the field:
>>> In a accidental network loop scenario, if an IGMP join
>>> loops back to us, it would cause mdb entries to stay indefinitely
>>> even if there's no actual join from the outside. Therefore
>>> this change can effectively prevent multicast storms, at least
>>> for simple loops.
>>>
>>> Signed-off-by: Thomas Martitz <tmartitz-oss@avm.de>
>>> ---
>>>   net/bridge/br_fdb.c   |  4 +---
>>>   net/bridge/br_input.c | 17 ++++++++++-------
>>>   2 files changed, 11 insertions(+), 10 deletions(-)
>>>
>>
>> Absolutely not, I'm sorry but we're not all going to take a performance hit
>> of an additional lookup because you want to filter src address. You can filter
>> it in many ways that won't affect others and don't require kernel changes
>> (ebpf, netfilter etc). To a lesser extent there is also the issue where we might
>> break some (admittedly weird) setup.
>>
> 
> Hello Nikolay,
> 
> thanks for taking a look at the patch. I expected concerns, therefore the RFC state.
> 
> So I understand that performance is your main concern. Some users might
> be willing to pay for that cost, however, in exchange for increased
> system robustness. May I suggest per-bridge or even per-port flags to
> opt-in to this behavior? We'd set this from our userspace. This would
> also address the concern to not break weird, existing setups.
> 

That is the usual way these things are added, as opt-in. A flag sounds good
to me, if you're going to make it per-bridge take a look at the bridge bool
opts, they were added for such cases.

> This would be analogous to the check added for MAB in 2022
> (commit a35ec8e38cdd "bridge: Add MAC Authentication Bypass (MAB) support").
> 
> While there are maybe other methods, only in the bridge code I may
> access the resulting FDB to test for the BR_FDB_LOCAL flag. There's
> typically not only a single MAC adress to check for, but such a local
> FDB is maintained for the enslaved port's MACs as well. Replicating
> the check outside of the bridge receive code would be orders more
> complex. For example, you need to update the filter each time a port is
> added or removed from the bridge.
> 

That is not entirely true, you can make a solution that dynamically compares
the mac addresses of net devices with src mac of incoming frames, you may need
to keep a list of the ports themselves or use ebpf though. It isn't complicated
at all, you just need to keep that list updated when adding/removing ports
you can even do it with a simple ip monitor and a bash script as a poc, there's nothing
complicated about it and we won't have to maintain another bridge option forever.

> Since a very similar check exists already using a per-port opt-in flag,
> would a similar approach acceptable for you? If yes, I'd send a
> follow-up shortly.
> 

Yeah, that would work although I try to limit the new options as the bridge
has already too many options.

> PS: I haven't spottet you, but in case you're at LPC in Vienna we can
> chat in person about it, I'm here.
> 

That would've been nice, but unfortunately I couldn't make it this year.

Cheers,
 Nik

> Best regards.
> 
> 
>> Cheers,
>>   Nik
>>
> 

