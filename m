Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9D93A5429
	for <bridge@lists.linux.dev>; Wed, 29 Apr 2026 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447956; cv=none; b=Wc/JBe5yi0M7mI1wgX/PFD7mh2eKAkAYM/dDwThifW8A7SlSxiDQCpCKbw/XEJ4LGL0u9bUPVbXdiclLBYRNfCf0Z74D0j90Y0x0xa0mLejyGznIG/1IQ6rsPjwzkxzsepYU+s/pJzGQJZqxgzpuLx+Glx9u4jX6ZSczID9pQyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447956; c=relaxed/simple;
	bh=VrchDQYw6XG3lkPmwkiWs711W5qHQO4BPO7IIURRRyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JlPxR1bf0yN7zhqesWlAgzUeapjToJNuDZHq/iOzLf72+IZ102Bb+ITDe+ob7OnixfNKKxZSYSt5n/aNPnkBkNokFXiUIZjtpzRNTrZovH/QV9+mJrj7G7ab8vI/T8y8xv897lmW9UIutc8Xm9/y7pmu1wqTFtgTNIzJ6pfYWGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=dfL32aEr; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="dfL32aEr"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cfd832155so8949719f8f.1
        for <bridge@lists.linux.dev>; Wed, 29 Apr 2026 00:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777447953; x=1778052753; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbZ9qKVJAIwgjA5Ke+ShQG0pVzAO0Z/RB+NsoRfVfcY=;
        b=dfL32aErKsHdkdGG4K+EVVMHOR/Whc5qVMhURXoZjrIZqF4GFQd54Y2BPECK6qBDbw
         vNrPBvgXHYa53QXWws/ORqRbsnNbCRW6akow/kixF5ZTbJwbNCgg2YYriuD365leGfSA
         oY/dXtIgIQ7DQLcdXdRMIf6Hi1NsieUuY22dmZbe/s813OuVuJVDezV3A1RO1Rdo4ge4
         E7V3I+btRwJZ7I4m8DJQCm4oixMnfCV0IEpI4EfCkp3DjzJgnvq6JWArECKFxySibw7K
         0nx1z8JjcKsQLASgKY2+ja0OvvzHs1RU/TpPbqZunV/KAawbHCDcpLNVgWFMfysF4GMO
         9IeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777447953; x=1778052753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbZ9qKVJAIwgjA5Ke+ShQG0pVzAO0Z/RB+NsoRfVfcY=;
        b=aiiO7MO9usjq8wIac5N36dpWIRDyWgoJWaNxQV4HmvI86E9bJNw+MgnWxQAvPP56iU
         VajdqT99tugiINJZ4w0T4gkujAnrEswR3YOCb8Ow8D8eb3KahU1CFWzqNtp+c+WFqFk7
         DjwbW541Ru0QBT8qhd3DHlGBvh8PWWdgJKls9WQdaUdGBW8oIo7bYYXQ6JUUU7KrpnNr
         dxLF1ClVg1jCP122w3DiS+UiOoWROmGm0ZU9ebN7wK591HUqp3zpO/xY+/5asfPd3id4
         81nU/ixC8SpQT0GXJYhRQ+D7TUEN+TArAM1zZE+rSeLja9LWInR9gM1ir9iq8KriHVX5
         eAgA==
X-Forwarded-Encrypted: i=1; AFNElJ+IxQ/cL3GLziPCn6zvgD+mMb65jdx3TT7vNCHmA7ooY6pDaB/AITXtWrw9RLzp5/bveyhm0/Q=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7ZDNP11ChTlXXzLIGDpHGUZ0l8s1xPo44CCaTnYlYJX7klqVf
	E3fcf8+W96JzHEvidQiazEzmoutNBFixj+/q6owc2GOVI8kN/gnTkNrdufwPfoxqH24=
X-Gm-Gg: AeBDietvsISP5WwgirJWLL0gV2A7cZ7Q06/KhgUCJyGGmO5HrRdthKl6lrIP8DRtF76
	UzV8wOsMnSLsxlfj1B5K3hwh0RxvEQv/T4/h1U5sVU2RwHKq0RdmCgfPVEwFWmwiM2MP7azI1QH
	W6BymOhHhsSyl3oj+/jb2xwzMYNLrXb4Lrbknykg8Qv0N2Wdh1LchmaOUc0ufsEfv2p8VTIlWed
	63MrGTD+IOz1W/Ky6iBZjdu51SYtak62opJ1/EGGohRbCo1+eTl+YReluJmlocNKW7xG6FLHcfH
	OWS/TPJZ/eOCjXlEnVrwMqWqoontXR04BEVN6o0woDlcT4EoWZUaboCZ+Q+IE4QNm7dZ3NMpW6t
	XZnY4d2078iOOt9JCgHgRi5r+wvrMZ8T3U8g7l9dYzkU5l93RaXXeI5SO9rXDioLg3guTq1X0KD
	a8laoaq9HwNbOKai8+Fy/x8cK737hKv+f4uNvmbZxLZFwAji3fCiwszuzsN2KHoq5k
X-Received: by 2002:a05:6000:26cd:b0:43d:1c39:593c with SMTP id ffacd0b85a97d-446496d7a54mr11658871f8f.30.1777447952979;
        Wed, 29 Apr 2026 00:32:32 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b7ca664csm4177021f8f.35.2026.04.29.00.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 00:32:31 -0700 (PDT)
Message-ID: <c7ebbc59-1583-44fa-8702-49c11fcf9398@blackwall.org>
Date: Wed, 29 Apr 2026 10:32:30 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bridge: mcast: Fix a false positive lockdep splat
Content-Language: en-US, bg
To: Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, bridge@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 horms@kernel.org, herbert@gondor.apana.org.au, linus.luessing@c0d3.blue
References: <20260426133435.207006-1-idosch@nvidia.com>
 <ba420053-c201-47a1-83af-6b092e46d6fb@redhat.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ba420053-c201-47a1-83af-6b092e46d6fb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/04/2026 17:10, Paolo Abeni wrote:
> On 4/26/26 3:34 PM, Ido Schimmel wrote:
>> Connecting two bridges on the same system [1] can result in a lockdep
>> splat [2].
>>
>> The report is a false positive. Multicast queries are built and
>> transmitted under the bridge multicast lock. When the outgoing port of
>> one bridge is configured on top of another bridge, the transmit path
>> re-enters bridge code and acquires the other bridge's multicast lock in
>> order to snoop the query. Both lock instances share a single lockdep
>> class, so lockdep flags the nested acquisition as an AA deadlock.
>>
>> Giving each bridge its own lock class will not solve the problem: the
>> reverse topology would produce an ABBA splat with the same pair of
>> classes. It also consumes a lockdep key per bridge.
>>
>> Instead, fix the problem by deferring the transmission of the queries to
>> a workqueue. Build the skb and update querier state under the lock as
>> before, then enqueue the skb on a per multicast context queue and
>> schedule the work.
> 
> I must admit that introducing an additional WQ to fix a false positive
> feels a bit overkill to me - even if I can't think of a better solution
> on top of my head.
> 

I don't have a simpler way to fix it either, and we've had multiple reports
of this false positive in the past. It's just another job on the system wq
and if Ido limits the queue, IMO should be fine.

Cheers,
  Nik


