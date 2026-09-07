Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4994F2309B2
	for <bridge@lists.linux.dev>; Mon,  7 Sep 2026 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789019; cv=none; b=fM456OsvWQ/Py6OTF0FjquWl9zVpfXonLdQIYGIYCzRIJtKoHswvwsoYV+X6B18S+B2O2F82FB3Uz7rfdguxEOkpI7fAdYJf74zXTyGTob/zg9EOX/RCsq2oJgJJ5yXjKEhwyUr/7KQnt/x6lO8tiVttcGCuFmR8xt/itJRd1rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789019; c=relaxed/simple;
	bh=gt9uyYj4GZqB2F/RxjOPyyNBlfGZg0cQlhP3q3hNeyY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=l9QnxqbjYBtVbf01CQR+hoxQNrn/yACn8Jyqo0v4YuEdZZZyY7Bs+mLDfEo6zRcXz9vVlAR/SvnTqiARGmbOtqa6NxekVpcxOCXfu2FfWEu/++D/CpSufDqjwl03x0Z62en7lirrPX1Z4mkR1M7WVMj9wSQB1i6pBYugk8ZrLAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=SkJxZJFF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="SkJxZJFF"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so24719175e9.1
        for <bridge@lists.linux.dev>; Mon, 07 Sep 2026 06:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788789015; x=1789393815; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HIF6gPEve0xVQ8D+U1UpgzUc5DE7tim1x6TuIJ198zc=;
        b=SkJxZJFF20byeScKQCqqwoUC+34P5J0sLgltfD6hMRW6PQpLz9YAm4NgF6cRR6+9ok
         FWub2AC50eL2+TnIul+5Pgj4aTG9Qm9T2gWX58142AcdL9aYiSZhU9sA3kEeZOMkH9h3
         vT3RD5jvl/Qze4Lb3CV+oC1mkMF5sQYAVB4kq6MAHcSf5F/lbGL3c6r42i67AA5vPFpL
         WJX5AjEkkxE5nh9AnfLnn+3K7x2/oCoRSg3k7ynZRqufMJRfdoBbieUHKCWA0meSgUJg
         t8ZoxfALK7Ar31mMkIiXu2bv/zHLPMGBiqWIIgXGZmdprKAHDkjGcyqbnUI8Uqk/aBah
         iKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788789015; x=1789393815;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HIF6gPEve0xVQ8D+U1UpgzUc5DE7tim1x6TuIJ198zc=;
        b=rwY5BFtgj/weSkAKaM9dxDbsojztYKp4envRcBwhfuvfi6e8/q0Jc+MDFljjidMlf3
         N0QrDYX5fJIm1sqVNrzyMb4YsIELWEfVAGjYPf8hjNTv8DE2a7LNB6jSvBrTqf0RtjHI
         uz/6BeZAV/cL6BmPdb8sfsfDqu9ScrCVyfGeH2kyawvzj6JNmwyaUunDYzg+c4VDLG6O
         BEqseu06WEt3GnAMeZMWUhM/Zz+NqO+njWen5gNt6c26dNr1Ucyj5ETd/aFDiQa7ffgc
         cCjDZrgxsLrneeJO+BxxQfjumeIT48mZGb9K78SMg2GINoKt71k9AmfNbPvGtJRpbI+C
         OSTQ==
X-Forwarded-Encrypted: i=1; AKwUvBytabjqB/b6lQP1crUyqAmJFTzygqhFsf1gPB3PyRCZn2+2Sg2BPzNV3IQfQespWKBYUQoFWPY=@lists.linux.dev
X-Gm-Message-State: AFuF++ngT9bR5uuWLfPajCvRrjLIkZwIwGOcGi7m2wLW5h5je4hLs1yx
	MvtSmw428BkFMRJ/AAHsHRY60fBkhl4LA7UEga8nIeK6RdMcy/AeB+3c+MnqwUlcIv4=
X-Gm-Gg: AYBFou34PFH5Clmpd2xk3PMobjmbKU+dWuVbMWN4emI0m/Pd/IUaSjq7AdWsfEjs5UN
	b/LrfU0anFBytqYnwxJrYK80mqIbXpROymiC2xr53AMbp9xo7Q7nHNOhDAB2EU6S5OsBjMonk9+
	WuifSfKYPga2J0s5wozMYMwkSVG/upbMBD9UIWAW4DStncyZUQ/IVua4kYy4G5S3kyyFC1J3scj
	gHvWaw32gN4Z8h7TM257vz+Fw6iQrq4YQiR460eNXzVMR0vGUBIZabL3rLXGVlWLW60C+PwN6wl
	QvbJ4rnMaTJYHaC0H6SL0AN14aavfPjQc8DGlrPhsW97NChX/L4sgPjV6cVqNKK1J153k3li+jJ
	SNQRgGhD64j3xoFaUNtuwBV6jMqD0Ids/m6lzDKzYFyqlaEjCprjdWRcraiKX543ZaOTq7l+RM1
	mFd7gZ91MZ0d945nyxtjfOYc0JLG2HNsQrUmRFng76uiWulT6jbjK++CnKwkSDQy7uPuDKs2FRg
	Zl5LJT5+1O+55xxStM=
X-Received: by 2002:a05:600c:a4f:b0:49c:f13d:ffe8 with SMTP id 5b1f17b1804b1-49cf13e05acmr274813835e9.12.1788789015091;
        Mon, 07 Sep 2026 06:50:15 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883a9b49sm24459531f8f.17.2026.09.07.06.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 06:50:14 -0700 (PDT)
Message-ID: <c30bdd74-d655-4e6f-a13b-ef55285b705e@blackwall.org>
Date: Mon, 7 Sep 2026 16:50:13 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bridge: bound the port VLAN lists in the
 IFLA_AF_SPEC nest
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
 Ido Schimmel <idosch@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>
References: <20260906224246.21719-1-iprintercanon@gmail.com>
 <ba2dcdb6-923d-4fc1-9c92-7a77c0b61a09@blackwall.org>
 <20260907133505.5291-1-iprintercanon@gmail.com>
 <76e98b59-9371-4700-92bf-20e41aaf0210@blackwall.org>
In-Reply-To: <76e98b59-9371-4700-92bf-20e41aaf0210@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/09/2026 16:46, Nikolay Aleksandrov wrote:
> On 07/09/2026 16:35, Artem Lytkin wrote:
>> On Mon, Sep 07, 2026 at 11:47:24AM +0300, Nikolay Aleksandrov wrote:
>>> I prefer a more explicit path - return error for both (RTM_GETLINK and notifications)
>>> you'll have to plumb down extack but then user-space will know there are too many objects or lost
>>> RTNL_LINK notifications and it should resync (e.g. use RTM_GETVLAN to dump the vlans if needed).
>>
>> OK, v2 will do that: br_fill_ifinfo() fails with -E2BIG once the nest
>> would pass 65535, kept distinct from -EMSGSIZE so the WARN_ON in
>> br_info_notify() still means what it means today and the error goes to
>> rtnl_set_sk_err(). For the dump, rtnl_bridge_getlink() can turn -E2BIG
>> into the extack message itself, which keeps ndo_bridge_getlink() as it
>> is; or do you want extack plumbed through the ndo? The size clamp and
>> the doc text go away.
>>
>> Artem
> 
> I'd prefer to plumb down the extack so the bridge can set it itself and be specific
> if needed. Others might want to fill it with something different, there are only
> a few drivers that implement it and some may decide to return user-friendly errors.
> Please make sure to split the patches well, don't do everything in a single patch.
> 
> Thanks,
>   Nik
> 

And to be more explicit - please don't add so much llm slop to the commit messages,
this can be explained clearly and much more concisely.
