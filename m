Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AAE38D6A9
	for <bridge@lists.linux.dev>; Thu, 16 Apr 2026 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776336112; cv=none; b=tJAA5gh13n60HSFEroFh26+p+6DGw5EEidUpWIq/avlOQ8PxTwyJwOZ3w1Sc3qU70R8GxoqJ/uzkay9lq5lrzQZp9t2n/zsRbqzvYkQI0lMIeKLge10PY8OqZW8WfIBc9FUE50rxbSTrzZ4HSCd2oztJwczjYVMg5UFDwxWVcX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776336112; c=relaxed/simple;
	bh=uReS2x8I87OhnPC5farRpTTckVWcZG3FD+2YlAAqim8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dbRmuwUB7R191Prf/X91IlXqrKYi7ySaPOb5iSGXcFHdWAMvBdrkse5Ly/F5zsT5BRe44m84dAUHel+MXW4iJBDRwZQNpMvb69M6ZrRBgRg5hhJMNFgHVlknZNuJzcyQBa7VTQA/qQWdmzbPR72M5O5cwvPATjj+ZdEPpIF32LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QD0nFv01; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QD0nFv01"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776336110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=imp93CAJrgx+PsDLj+uCQzy3UK5uZ0qd7nXnz+Lrivs=;
	b=QD0nFv01ExjBy2uvgZC4G8CnA8Tq4l5+E+me2epvBHD6FkNHUmlHZj9D0R62ak/YXPzf3e
	SVXKwRrvZyuyWTnTlg3s3P45WtITs1my9wnsS8Rco9qz4kqJdZgSnoX7Ohj5VOuy68G6kW
	WzPO2WEHipQZgT5ou7a0Hp+ACm3F4i0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-DEq6vNPiPQCVR4tURRZOOg-1; Thu, 16 Apr 2026 06:41:49 -0400
X-MC-Unique: DEq6vNPiPQCVR4tURRZOOg-1
X-Mimecast-MFC-AGG-ID: DEq6vNPiPQCVR4tURRZOOg_1776336108
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43cfb72377bso6764350f8f.2
        for <bridge@lists.linux.dev>; Thu, 16 Apr 2026 03:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776336108; x=1776940908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imp93CAJrgx+PsDLj+uCQzy3UK5uZ0qd7nXnz+Lrivs=;
        b=AsJh0Z6iNvrQd6wc2/VgUfw3FiuiPN3GrAtfyX5pw54NisZ9ITU6w7N8kmPykoIJcH
         a5btaWUM3WcOXYcTKmhH13nGijxxOfkiGJf6NkFp71hswA1AzhbRQ5UZleNomRu4SSvI
         LSo4s7pcN1ApXMGS7Mxjt9Tzn1iTTFr6XPT30rMOajWDZPdH560wh3WUVzpFStB2ZJcY
         sbMO/oeLbVwiUWyWRO919QFqfUluNmHT0ED2nT5d34n89wWRLjcQ/skkh8R0ZxYRbcoO
         QsZ3p4W9pRLDQRKL+E0TZJQPpkmQP24+38vZGb+YL/HM+R+beXwPTPdvGQmF6XCyajnp
         65EA==
X-Gm-Message-State: AOJu0YwBrvVtnua43Fqt8PDAa1a6TFdMsaRihV2aGLWtGkPHkJ8vv0+O
	f9XKWpht7hGNobU+W1le7nAcB6vD8vACKABkmV3L3tQ0oziOYt0/1upc2zId9szMWhOKXN/O983
	fSmBL++zNGf7NlzJO4eVR55VXQKgH8/Lb9ckMxU+o4hwBdoY/NUHokqq9hQ==
X-Gm-Gg: AeBDievVHEHVPQNFNzrNQMPdWYu3ifZ9Duu7UWE19K+f7Wmr2vjDH4SzIYQ6hY83QJ4
	cv0h+Rvtda7S9nnGGEbt0xXZwTtA8GYs9Cxps7kI55/RflUVthpIbMEEWT5Ktodk7j67WXreWOH
	UiozbIyD/8rHMx9Tv4nF2r2Mgr9V8TWkYtB+fsHodFdMqrZgr/qwEvnzVz2eyJxbvxFz5GWWFeV
	GV/ybojYArPB3JpV3euvjO46GlzAAmkBW+WMtOMfk81nk0RVbvYQGktVl5s9ZNEX6PEyyh8t8O0
	LyaxgGpVFKQbBBhgM8gPMUKGQSvog/PGQMI6dO5/xOFpaDVZplNuWhrQLJGWh7vJ4Gxrbfs1+Tj
	hwhsMDr58phxzKk+OTd82hd3qEAsNekr8O/AchmlhP6OOMTMkCCsnRVPlBT4dIZCcvnA=
X-Received: by 2002:a05:6000:4203:b0:43d:9bb5:bda5 with SMTP id ffacd0b85a97d-43d9bb5bfccmr16874154f8f.40.1776336107777;
        Thu, 16 Apr 2026 03:41:47 -0700 (PDT)
X-Received: by 2002:a05:6000:4203:b0:43d:9bb5:bda5 with SMTP id ffacd0b85a97d-43d9bb5bfccmr16874118f8f.40.1776336107307;
        Thu, 16 Apr 2026 03:41:47 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5f11sm13702339f8f.18.2026.04.16.03.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 03:41:46 -0700 (PDT)
Message-ID: <83d4b4b9-7bb4-4395-8973-a94fdc908b59@redhat.com>
Date: Thu, 16 Apr 2026 12:41:45 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: bridge: use a stable FDB dst snapshot in RCU
 readers
To: Ido Schimmel <idosch@nvidia.com>, Ren Wei <n05ec@lzu.edu.cn>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org, razor@blackwall.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 makita.toshiaki@lab.ntt.co.jp, vyasevic@redhat.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, yuantan098@gmail.com, bird@lzu.edu.cn,
 enjou1224z@gmail.com, zcliangcn@gmail.com
References: <cover.1776043229.git.zcliangcn@gmail.com>
 <6570fabb85ecadb8baaf019efe856f407711c7b9.1776043229.git.zcliangcn@gmail.com>
 <20260414074722.GA321402@shredder>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260414074722.GA321402@shredder>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XOWslE_wOKe4Cc6uegLVDu5NmrGdpNw5cCwBxJVsEmo_1776336108
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/26 10:05 AM, Ido Schimmel wrote:
> On Mon, Apr 13, 2026 at 05:08:46PM +0800, Ren Wei wrote:
>> From: Zhengchuan Liang <zcliangcn@gmail.com>
>>
>> Local FDB entries can be rewritten in place by `fdb_delete_local()`, which
>> updates `f->dst` to another port or to `NULL` while keeping the entry
>> alive. Several bridge RCU readers inspect `f->dst`, including
>> `br_fdb_fillbuf()` through the `brforward_read()` sysfs path.
>>
>> These readers currently load `f->dst` multiple times and can therefore
>> observe inconsistent values across the check and later dereference.
>> In `br_fdb_fillbuf()`, this means a concurrent local-FDB update can change
>> `f->dst` after the NULL check and before the `port_no` dereference,
>> leading to a NULL-ptr-deref.
>>
>> Fix this by taking a single `READ_ONCE()` snapshot of `f->dst` in each
>> affected RCU reader and using that snapshot for the rest of the access
>> sequence. Also publish the in-place `f->dst` updates in `fdb_delete_local()`
>> with `WRITE_ONCE()` so the readers and writer use matching access patterns.
> 
> Sashiko is complaining [1] about missing READ_ONCE() annotations in some
> places, but I can handle them in net-next in a similar fashion to commit
> 3e19ae7c6fd6 ("net: bridge: use READ_ONCE() and WRITE_ONCE() compiler
> barriers for fdb->dst").

I agree they can be handled separately, because they don't look harmful.
I think a 'net' patch could be used for such follow-up (data race)

/P

