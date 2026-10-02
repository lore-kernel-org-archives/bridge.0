Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814833FE356
	for <bridge@lists.linux.dev>; Fri,  2 Oct 2026 20:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971800; cv=none; b=ed6bg1m3KvB/b0IIsKuIgmwCXP6pebjFSaGQHGyJPixqbi5j4q389DUSB3PT5El12fjyBDCcaRYgnSWZeCb22Mgc79NZLBpw/H8Ewc8wsX0VFj8O8SW/nB4zqseMshmmZI1ZeESmlZKBay4GxYjWFhR3VRsP/ql3r5SP0aNRR+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971800; c=relaxed/simple;
	bh=2ZoneoGqU2qJkQJrPepOGNSoLBxn+BW6f35Nep/3Z9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKq0lBB7csnyTIVKwXJ+ZozxrLuJ7EFPFvOCZGLV9LJ9p/uDbsds6FH0HXZjfcs+qFvsh6rmdrnhhI91TMfLZegDAwlU1qEd8i+f9Wo5BbShnR0m/8oOji+H5W2GF023tIMX4RjoZt3UXWi5XS6TH0a3UyQD9exbbo5uqj9m4BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ZQ5Q93Av; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="ZQ5Q93Av"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso956697f8f.1
        for <bridge@lists.linux.dev>; Fri, 02 Oct 2026 13:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790971798; x=1791576598; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f+Kr/lLJxct0J1aKY/42Si+6OLzpHQvzuru0OHbvg74=;
        b=ZQ5Q93Avp74GJN6GLG+eYwa8TPEKJaoYKQZ7E93uJGvLiuYq8u9w731Dfm4rU4GOMB
         vklh0cyshWJxZkYh9mWrdfcgV4E7cwbbUaX7d1ZU16zNn6Aj+LWmRKRe9TW+QNJ2wZD1
         vn5xNET9YBd6vFI9XWQSVA0dOJKUrGW74BhDeeLDevI3YGsfMeFYy1x/jAHgIKQEvBey
         vxDyiubM/VWoTvSDFBhkLPmzoGlM/wLulE2whl7/90zSohBozYWcucMhOOJ9Biu5quCf
         IX2Friw5SNfHcTpcIH85jlvui0B3T/PB6boUh5h9xThcproKsTCSQDmz9osmLNcd3bys
         cuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790971798; x=1791576598;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f+Kr/lLJxct0J1aKY/42Si+6OLzpHQvzuru0OHbvg74=;
        b=z8FN/7bqCxQmYgv6DH32BuEp3+sD5QDn1QmaAa7MgC6FRyLUusqTHyEPm5MoWOLPdj
         1D2B8rZlN+9DlTg9W76uLt7clndd7+T1V2kNpBCDFWgZmv4iizP0oz6TtNV8YPC9v++t
         aGdL33mkS4Rc/5kV7uu4l2M0BEOx4kw5IH4yuq95Gg+44d/VYB8nrQa50uSp+lAW9rx+
         wqPReO9s6/QZGpJDca+kX+gX34z2qsmQjL0sMxGwRc5KmEjk78yhCtKi6S6IChCs1FfC
         tLbcsWVrbyhHCKrFgiTl+3FNuvVjjfDQ/VgskCsUuHIanqL/QXDECeYIoCco2PYyeNbs
         G0Rw==
X-Forwarded-Encrypted: i=1; AKwUvBzerMuxiZmYhtPUVO/+SO5THfBMIXkmPQh4iJTPSxoRdLa2HmSf/VM/uACNk+gl+c0IbLx59QI=@lists.linux.dev
X-Gm-Message-State: AFq9FYLFYU7Cl2wu+y4LHil8PAY7/5DBVNy2WDMvf/EU2txw4jFi4B62
	mk2koZ5cJ9eFaOSKgVdodplRrtFz6Doolsvpp0PVhlLsZ37xPISQgWxPGln2KAxJO0Y=
X-Gm-Gg: AYBFou2njrQAnn7lQNGBZ/rTZcgX+Av5glNlCTQP1sxCQNkg1WNz2leTHnIsi1g1/M4
	lIw5EQx8phWeXNELOKp8Pn7SQODhpAALDs22/vFYK9Ykkx+xvOWlSbXZoezWiqxyAfXOuYUyaBA
	X81wwjHpoq5ku4Wg6Xk5xbYQaPC0tYNXyKFMj5nXus6Ca7sqtEKwk/DyvJIxZ8zNfbWe5mgOCRd
	nOALm66j47H/wYLaeJ6npeelb5CXQxHoceAPviKusH+M8qXqJ0NeGu7y9PLiM6BBSsOR3AnqwPk
	BJ/FJpb3y15vJ78ukMtrwU6Gc2nIBvAkQiEuLA4LWtTmeGS+DUXEtTWslSAmadjEMzIy/VyjA9t
	4x1eJPohLqLCdkX8enWjs2sNfAMgch50cO3w0R5rmeilzoyVIWc1pslTsmbZfTzTWFnlZZd2Ae2
	v76yF7U0HzbCmCQRHrr58wotu6Jl63aRfk+h2JFWKBICiPDLtBKH9eSDh/7ONs0ZHI6OLA0XXUU
	WvCVLeB7Rtmp1aFMKdZRvv4wIjX
X-Received: by 2002:a05:6000:2384:b0:487:197a:5c1f with SMTP id ffacd0b85a97d-48c4800e2c2mr584926f8f.49.1790971797562;
        Fri, 02 Oct 2026 13:09:57 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b82253ae9sm6905080f8f.2.2026.10.02.13.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 13:09:57 -0700 (PDT)
Message-ID: <b41da7fb-0ef6-46c0-a174-cd7a7c4448ca@blackwall.org>
Date: Fri, 2 Oct 2026 23:09:56 +0300
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
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev
References: <20260930071411.2786201-1-razor@blackwall.org>
 <20260930071411.2786201-2-razor@blackwall.org>
 <20261002124531.49e3eaa3@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261002124531.49e3eaa3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/10/2026 22:45, Jakub Kicinski wrote:
> On Wed, 30 Sep 2026 10:14:00 +0300 Nikolay Aleksandrov wrote:
>> Add an opaque destination type and helpers for representing bridge port
>> destinations. Using a separate structure makes raw pointer assignments and
>> comparisons fail at build time while marking its value member __private
>> makes sparse warn about accesses that bypass the helpers.
> 
> First time I'm seeing the __private thing. FTR feels quite foreign to C.
> __bitwise works very nicely for the same thing 🤷️

I don't mind switching to __bitwise, no preference here. I saw __private initially
in the console code. It seems to be more restrictive (__bitwise allows direct member
copies and comparisons, __private warns about those), but if __bitwise is preferred
I can send a follow-up.

Cheers,
  Nik


