Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27763C660C
	for <bridge@lists.linux.dev>; Tue, 14 Apr 2026 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159240; cv=none; b=FcpKeOzgkbq0NoMeRZqQkx24T4zoq0DiAUBOKnc2RaBIw/pSso8FFuaMilJKHnPKmnqXnCegPJAow2SeHLb6kNP+bZioUzxcYL9ohYNRCPRV6A+FWZZ7WtmpBnSyU7twWHDw15BOEQCx8SGYjuQP57mwEIPjBixWC4/mjCOTVh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159240; c=relaxed/simple;
	bh=qpIuniXDudM0XboRaWxykSn2rrqlQMfFwWmEQwMUzO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XzDsJTUFnmy6X4oExDuLatBk4CFBAteWvM7rJQ82GVDaGc+CQuBroA9Z/8qLtILpoCLUX5OmPGS45Ln61L+3pvJQ0YV7T5UsWOptTvhbF/nY14FIEuqgfDf+8Mx4P+lU7+HFVj3JJoqMUy9xZGmClyrj8zwKBbqSTh5Nm92p6zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=JIkbN1Cq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="JIkbN1Cq"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488c2690057so52383935e9.0
        for <bridge@lists.linux.dev>; Tue, 14 Apr 2026 02:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1776159237; x=1776764037; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h5D/wg1b6VK+Oa91JECSbBLRKMJ3Bb4xR5XlVGb/8nU=;
        b=JIkbN1Cqw2pSyw1Am6KnD3+tfIgYtmE+K+SwVINvt08wheVXQtSeKVe34n/Lb2Rx9m
         82C7CFsqVKD7o6E1TpUZ2IuNtGF3fk3JB8gCO96gkFg/nUi7Cde5w/M6d/bKB6N6zX0T
         rbcIJfeLbQrskgBlVkuY7MIAjirKaNnu9TjAx5rWRkpfoa5l/tfHPkM71cO/nnARTyRe
         dRBU7PUTGq2c5bcnaKzk74oOFMktl7OjdJgeMI4kJ6Vtl86QTBJlH4UlH7BFsRSZP4fH
         khw9BCH2xB9LPpnwAUAWSa+XnhJKtUK2Zq1TtSSFu4aI9mUI+SGnjUqZeOZ+m8ICkvuv
         +avQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776159237; x=1776764037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5D/wg1b6VK+Oa91JECSbBLRKMJ3Bb4xR5XlVGb/8nU=;
        b=AL9/VuIBxhDTRuZq/Zqjuz/+WAnoRJIXGSZy31ebouyJ8BD24u6winBgHniR254oTt
         lHuRVbw8Qk8bJr2T/NZY99yaU8wvZhNG2vCjNCgcUcyAR7TTkegoGjfQwY1u/mlIgd/0
         x9QRsRGIu2MyJMBG27PlA2LROCPno38TL5tuyhsSsptyXty/DuOvXN+sD9bIGucW7PUz
         tLVBVggo5ggZlKQvhAYl+HXSRPXbXIz9Jof3DdllyYAsCfYlEMlUyEAAr/dE/468m0Hp
         E0+WMwJmcVV/2kkkvdvuEHf8a/8m3fij9CTdliYEYYtf7IUJl7h53cajDLSEuO2lrs4P
         Onew==
X-Forwarded-Encrypted: i=1; AFNElJ+8eoqG1CX/GnRUlMMVSrwjHQtGt1/ZV+A4EIrWanyKzri7OPaGy909ITKPfBbGjEYTVm+g2/U=@lists.linux.dev
X-Gm-Message-State: AOJu0YwxGiQSC24KaK5wpcxOcnfImsUsopNqaUbrJyTPfy0hBQGwwhim
	idqpLgXC8WHTFo1WmZAaZFWdtLWfjsxX7ZsOR1E9trJKoR6KEPwARQ8KxV2VHqjWUpY=
X-Gm-Gg: AeBDietZm/rVbA4x6Jd6xpj5gacmqTuzh80N4N3Wb3jqNjm/uVrjAm+856Z6D+FZfdX
	6kyZPO4utxB6+vRhp+bC9e2+aFivQVjUbHLxbbY6Ohg69MKXBkLUVHhsfNprswu5EUot4QcUnvo
	XWgSNDP9yGIwPDjolpkhm3aI6A2vyeOY178J7rX04L3gvKSTdpH1K9U7Xbc6LbjZyokYUrepcYE
	SOf1PWils/IjPMa1P9YKlEj92yh+b4B1V+CBuypmK3JIZaWeVUBLmMUKzTVLzxyuMRz+CrU6f6D
	VsXxoPTK5MLLWjdXiwTVqxMJlbsVMfyrFl+Za1max3eT4lVVSUwQBc2PM1kWRg1zAoXrNEJRU3h
	J0NyVFlPbSdjD7/hByLyFbGn+yyJJMbi3dtPkqHytx8TZkwdNR1Ggx5i6lABzolgzVsRr8i/ho+
	utTy+17x7Ham/+HIH5JPtF/tYvUU+gRdA+mTpEkzUGdaxkfUyqWXiyCTFaIpP4LGNl
X-Received: by 2002:a05:600c:450a:b0:488:a882:b7 with SMTP id 5b1f17b1804b1-488d6ad17e6mr217660055e9.29.1776159237157;
        Tue, 14 Apr 2026 02:33:57 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ecde5b26sm48082835e9.2.2026.04.14.02.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:33:56 -0700 (PDT)
Message-ID: <f02a8b8f-bb27-48f1-bae6-2cda240a79d0@blackwall.org>
Date: Tue, 14 Apr 2026 12:33:55 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: bridge: use a stable FDB dst snapshot in RCU
 readers
To: Ren Wei <n05ec@lzu.edu.cn>, bridge@lists.linux.dev, netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 makita.toshiaki@lab.ntt.co.jp, vyasevic@redhat.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, yuantan098@gmail.com, bird@lzu.edu.cn,
 enjou1224z@gmail.com, zcliangcn@gmail.com
References: <cover.1776043229.git.zcliangcn@gmail.com>
 <6570fabb85ecadb8baaf019efe856f407711c7b9.1776043229.git.zcliangcn@gmail.com>
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <6570fabb85ecadb8baaf019efe856f407711c7b9.1776043229.git.zcliangcn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/04/2026 12:08, Ren Wei wrote:
> From: Zhengchuan Liang <zcliangcn@gmail.com>
> 
> Local FDB entries can be rewritten in place by `fdb_delete_local()`, which
> updates `f->dst` to another port or to `NULL` while keeping the entry
> alive. Several bridge RCU readers inspect `f->dst`, including
> `br_fdb_fillbuf()` through the `brforward_read()` sysfs path.
> 
> These readers currently load `f->dst` multiple times and can therefore
> observe inconsistent values across the check and later dereference.
> In `br_fdb_fillbuf()`, this means a concurrent local-FDB update can change
> `f->dst` after the NULL check and before the `port_no` dereference,
> leading to a NULL-ptr-deref.
> 
> Fix this by taking a single `READ_ONCE()` snapshot of `f->dst` in each
> affected RCU reader and using that snapshot for the rest of the access
> sequence. Also publish the in-place `f->dst` updates in `fdb_delete_local()`
> with `WRITE_ONCE()` so the readers and writer use matching access patterns.
> 
> Fixes: 960b589f86c7 ("bridge: Properly check if local fdb entry can be deleted in br_fdb_change_mac_address")
> Cc: stable@kernel.org
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Tested-by: Ren Wei <enjou1224z@gmail.com>
> Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>   net/bridge/br_arp_nd_proxy.c |  8 +++++---
>   net/bridge/br_fdb.c          | 28 ++++++++++++++++++----------
>   2 files changed, 23 insertions(+), 13 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
