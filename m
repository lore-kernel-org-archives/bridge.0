Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711CC47DD56
	for <bridge@lists.linux.dev>; Tue, 15 Sep 2026 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467949; cv=none; b=JNgV/4PNJwcdr3d/scLXuBT9He/xotYd7V0rF0HOclSMiQj/0q8R4HWp9d8BqejGpa3IYC1AXYFJfklNnA+o4eeUuJK3VbW/1y55wBEoD59MglsJEYcIUwRrFeZYQexq1d+BvZwpUOqqJSmRBGTuBNh6UjCQeXy810mqY668Ylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467949; c=relaxed/simple;
	bh=iULOzttYr2n0EJHmyLMcC6+ASJIWMJB4gX7gYBPR1Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aWa6nAhtEMggbS2HWvcoyDZBQoz6e9RbAE1s3NfVDmSszfdxy9zNiUJ2iN5PwqFKCPM1sWWe54uarVo/a/kATYaMvI2pEMvXLnYpuNuctR/mJ6dlax7C/ephXjJkahvzhoOl1yqxWCGJUqXokFBZAW8UnhjihdRc0vxVZspHJg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=SHaAuU+G; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="SHaAuU+G"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so19522755e9.2
        for <bridge@lists.linux.dev>; Tue, 15 Sep 2026 03:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789467944; x=1790072744; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wbiTQv/9uPbaqQlAXhrI//2y+UzzYyIuwCVG2sZ1MZg=;
        b=SHaAuU+GXWzYL/Xd4YGz4VAzCn+pP4BNI3fvooCZAeAWXimVrUpRcnR0bUJlrY7it5
         4qxZOo6tg77l3ipMKfnjoU/Tk2xJPkEGHow2CHiz23Y1BdKnZs2oS3oVoyTlG54X4oCb
         LqSx8UjlYWoRThTzGBeNyeFkPjUHqc6OZHEpiD69dmThOJLCZoLjC5ATVPxBV2Jo9fBR
         HcvVhkGwK8d2z+AsixSY8twjV9KU8aoljvFUUjpysG65lc20AC1ccQzO72dMu1C5601p
         xISJB+Pyd1PANbck9tyFplfS6odwyQ9xvgnFa/HCVd44R/03iWgSwRbsGIuabDozim5a
         D35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789467944; x=1790072744;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wbiTQv/9uPbaqQlAXhrI//2y+UzzYyIuwCVG2sZ1MZg=;
        b=JBNnnKUKGrhoth34WqxAbVxpjvHx4Aj23cB4pzdLsUma+4gliDx2CFtUtaEOug3IUT
         8nARHFc7lB7bipLmQAzlfjt/B2mHmgpgNhzz3misTEgfGGPCkBXoct6VPEsi9cyvtzm0
         g2FeuF3J9F4due4GyKD9zLQSJN2QKo+q2gqkwQC4ryqt3jsdX9SSfZH1+M9oGbPn/+S0
         9JtC0lpZ7YARvnbShYTmVt6Xcz0Pu5uMRa6yhzysPvGvVxnvDo+9Lx7lkzFI5N13tqHB
         z3UW4JlovNIlakWyD64syx5ML1SnwfOzLBwJpnZtFP9a3Gnn0LkgIkslES+JAExjbjTj
         bmMQ==
X-Forwarded-Encrypted: i=1; AKwUvBywfEnBAPPwRhTgcWOFjmDLXj2DdgprnIDDgqHbyVlICg+2rh6/mKV43G7DdpKABAyhLso03xs=@lists.linux.dev
X-Gm-Message-State: AFuF++lk3o82btTlLLSfy84YzhGCgvCcXkL3iHm5eg/Kx5QMS8pxYhxA
	sqGidxteBBC6jQIZ7rrNaS1HHSv2gihvn9zinzTQU9RDfi38CTVJgYp4qgd+/E3G7gg=
X-Gm-Gg: AYBFou0tBFBNlmYFx87D2PgFWgHt3JtgMaktuSguoTb5/kj/jMFg78e5hPl1YZ1NCXj
	Kr1yL/j3DeHaRkY8FoP+d8DOKmd/fxxiB40dEAk+CYIMglFsvWAzZ46kUuvBXzRh4vCM7witM+r
	00F3lrpYBM7OaOMcN2XctfWXBYMCqvsrSTUHj+UmYzxIk+mDnyzlRpQ6J7aQTuZfv562b6NObK9
	R0zsY3h6+n84jWpdGU7fet3VGI4LqN8rMaajPgqqDq+rc6BwWWUCsCvRot7ytqx3zdTOMikbG9Y
	N6W3KSyhyfI1X2rCdjWT4WSd8/LhrphS3UAJC4w8r2F3IuOdio9oHGNWXUsGtnD9swMX6jHqfdF
	36y85GLFAQ9rWjcbtU5/Uq9L7thoLYCnjqRxxgt4NpXPzPwNahwx7L7Pi/+zS6r3TuENvp6YvwO
	k7+Y6YtYRkdtmfqalJUHLcQM+4YcGIycWi+QObWIrAEhCbBOu1FovcfC7v+d4+3osT+VXs2jaPG
	YFPh87c4A8rUaWPuwFnTiRaBrRwpQ==
X-Received: by 2002:a05:600c:358a:b0:49d:2607:4ada with SMTP id 5b1f17b1804b1-49e7a6870f4mr176898075e9.14.1789467944007;
        Tue, 15 Sep 2026 03:25:44 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7ef2e117sm54564695e9.1.2026.09.15.03.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 03:25:43 -0700 (PDT)
Message-ID: <b696c600-4ab1-41d5-b391-3f6373200cd8@blackwall.org>
Date: Tue, 15 Sep 2026 13:25:42 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: mst: move switchdev call outside rcu
Content-Language: en-US, bg
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, tobias@waldekranz.com,
 bridge@lists.linux.dev
References: <20260911105021.1385934-1-razor@blackwall.org>
 <7043a1fb-fd55-4a4a-82bf-c5428f67a035@redhat.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <7043a1fb-fd55-4a4a-82bf-c5428f67a035@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/09/2026 13:23, Paolo Abeni wrote:
> On 9/11/26 12:50 PM, Nikolay Aleksandrov wrote:
>> This is a follow-up of one of sashiko's pre-existing bug reports.
>> br_mst_set_state() calls switchdev_port_attr_set() for nonzero MSTIs
>> while holding rcu_read_lock() which invokes the blocking switchdev
>> notifier chain and may sleep. Nonzero MSTI changes come from netlink
>> with rtnl held. Move the switchdev call before entering the rcu section and
>> assert that rtnl is held.
>>
>> The call cannot be deferred because netlink needs its error and extack.
>> Also DSA reads the old bridge MST state during the callback and checks it.
>> A deferred callback will be late and will see the updated state.
>>
>> Fixes: 7ae9147f4312 ("net: bridge: mst: Notify switchdev drivers of MST state changes")
>> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> Clashiko noted that the fixes tag looks inaccurate, should be:
> 
> Fixes: 3a7c1661ae1383 ("net: bridge: mst: fix vlan use-after-free")
> 
> do you agree? I can fix the tag while applying the patch no need to repost.
> 
> /P
> 

Yeah, I agree. As Ido also noted, that is the correct commit id but it is
from the same set. :)
Thank you for taking care of this.
