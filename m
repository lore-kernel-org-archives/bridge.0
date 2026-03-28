Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A186A2C326F
	for <bridge@lists.linux.dev>; Sat, 28 Mar 2026 06:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774677999; cv=none; b=SB1kUrEBhrAz8pRq4Jl5UE4VdpGW6ZAYoOVYofg65gQLzzWONNdyQ6z+O4sB2o0Cdv10vL0GhGVAW2YaPYNTQokxqAM/0UsNmrEWKhn5r11IPkHfkUwADGy3CgK5GPdro67RuFcJHWiwcdvLI8CnoThIAIEb43M0hYhPTPjA4nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774677999; c=relaxed/simple;
	bh=0Xp/nC473N6MzrjjihQ+pA/SoM0IAByS0Khxi3q9oP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DI4WcjuZwzQjXmk8yCPqpmNE4lL6wRdSa7fd7j6RiM6iPrtqNY08OY0qAT+It86rYcVP7TPhyrZwqnub0eYReLROjBOFeNCkKfIwBmA3UHNVR7lfET1YdwMWlgHsY1p4nPxA9zJeghnJTo6QSXLVIPv2RJO145mkp/FUakN+7cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=JzNEW9St; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="JzNEW9St"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2c175635a33so1979337eec.0
        for <bridge@lists.linux.dev>; Fri, 27 Mar 2026 23:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774677996; x=1775282796; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UFRU1bS8HFHkRjVrl9E5GNOg3WQVTUj/Y+AMxYSKfQ=;
        b=JzNEW9StGgWhO6itn0QIpUBji0JcIJ9x3lphTrP49nbG7lNvQWWtlcvXKOIFFjKgSj
         tEe9ZCjFRYPazJjd4bZXL/WTqH1bHertuvEvX4ktLAEO0ZbBr2UppUBNz2lvYAnpZAGM
         u6th6TesZELErP0Cu5IPTgjdu8e1qvsoWncMY0gWDnggB28eOS3uh+jCE8Rnh8xL/aWq
         mbsjI2s/fXD4rRW9KRcgoSwhD0Pvgc54siF6+4sTBi13vSsArPBFKFwXG1wxRkd3/Uuh
         UdagXB5OSy8vDObYexnVXplN4y1+IhbOlKIjH5XvVZ+SIDwji8+b7WaFo9GjfNF04pus
         3AXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774677996; x=1775282796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UFRU1bS8HFHkRjVrl9E5GNOg3WQVTUj/Y+AMxYSKfQ=;
        b=pI5aiyyl85d7tlpsUHYM66Creh2/crfz9uaL/x9My76B1cOnJCQn2FazXFwi2/5Vvz
         2cPEGaBOgzTtZ6sNVk0+SIZzuGxxhy4I9mxdYasg1jwdhxm51wLTs2R/XCWYBfdW+jiJ
         NnzBgOM2Fdr3NuF4NU5wg+YtnLK303zKGWY6qgDnILSV5our7HDlR6Cg0v/j0T4se5Zj
         xSS3TnHFXmoShjDzuogZjolJRekFMS2iS+2X0Ef63969sDVK4bGaK+m3hI/50+CSI1w1
         mwDOpVshXlm4VlgjJ0GOdX80X3aqRAkRfO+WEtGLxBgJ6VcsOJvDW/KoDd4kIPzrUdF1
         TwWg==
X-Forwarded-Encrypted: i=1; AJvYcCW00uBDOQTyMab71s3t6OLAO/4ok1GtgC8sCSUxMu+NtNsURzo9O2uekmar97W05HXTd2sMIAs=@lists.linux.dev
X-Gm-Message-State: AOJu0YxCscpoP1iEoldrpAgkY5l2Vx7P372wS+HSadcSkExkN5iMquK+
	MKgin67H64iteD5L8Q7g5wXj5D+bOBJCCFoDQ8fbmQa2lzK9Da4iZ5ITsnr5Rvy0jA==
X-Gm-Gg: ATEYQzxOg2t7ozAXE1aAH59O0P18anmhxr+aSU6j8E3NOpzXbPE0irmkbv2pfyXTAXf
	e4oxmb/x7Jm6p5zSG+YrujX3tSM6jEdpexGKWTB5mseFATzqaLgbeomosLB+I8kic7wz2R8w4vG
	bfRlbCkb4yGv4h7QQXmd+zmLucSAlubA+xSanjNE9XQFIhDL0thn8PM9Y3TgZwJTzcYc1s/EUgn
	IvDeZI96RH3wh0PZncSz5oQuOWA91eJ+9nEM1zVArztAWFPTaH8ViklO2ucdY78dQSg0mIMTvZW
	Rz5K54EW+0DFQbKbhEXsvJmsm2zVw4wp3n7tvcXPLF8+gofNTk3g/Y92Zs6iqpYBBPtes/I8cmG
	QUBxN7M4UwwmdQe8Hp71C5gI2Fs4AD74GDepfQTa/BEFQuWwu8hm8WMY9PQkjJlOwG61Ha08w0s
	FzYjncIeR1td/7DauKf5V8WxQetxFvag==
X-Received: by 2002:a05:7300:ec18:b0:2c0:c482:805 with SMTP id 5a478bee46e88-2c185deb4a5mr3348153eec.15.1774677995658;
        Fri, 27 Mar 2026 23:06:35 -0700 (PDT)
Received: from p1 (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c49a5b0fsm1461097eec.11.2026.03.27.23.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 23:06:35 -0700 (PDT)
Date: Fri, 27 Mar 2026 23:06:32 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, razor@blackwall.org, 
	idosch@nvidia.com, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	bestswngs@gmail.com
Subject: Re: [PATCH net] bridge: mrp: reject zero test interval to avoid OOM
 panic
Message-ID: <ddglb3jhxn453xi3csd2telvziriqzveqsokxdtestwrgeptan@ptrhexbfkvsx>
References: <20260326032438.3307549-1-xmei5@asu.edu>
 <20260327113412.GD567789@horms.kernel.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327113412.GD567789@horms.kernel.org>

On Fri, Mar 27, 2026 at 11:34:12AM +0000, Simon Horman wrote:
> On Wed, Mar 25, 2026 at 08:24:38PM -0700, Xiang Mei wrote:
> > br_mrp_start_test() and br_mrp_start_in_test() accept the user-supplied
> > interval value from netlink without validation. When interval is 0,
> > usecs_to_jiffies(0) yields 0, causing the delayed work
> > (br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedule
> > itself with zero delay. This creates a tight loop on system_percpu_wq
> > that allocates and transmits MRP test frames at maximum rate, exhausting
> > all system memory and causing a kernel panic via OOM deadlock.
> 
> I would suspect the primary outcome of this problem is high CPU consumption
> rather than memory exhaustion. Is there a reason to expect that
> the transmitted fames can't be consumed as fast as they are created?
> 

yes, you are right. In the default veth setup, the primary effect there 
is CPU exhaustion. However, if a qdisc with delay (e.g., netem) is 
attached to the bridge port, skbs accumulate in the qdisc and are never
freed, leading to actual OOM. Both the qdisc attachment and the MRP 
configuration are reachable from the same unprivileged context.

In our test, for a 3.5GB ram machine, with interval=0, OOM leads to a
kernel panic in 10 sec:

[   10.901868] Kernel panic - not syncing: System is deadlocked on memory
[   10.902139] CPU: 0 UID: 0 PID: 2 Comm: kthreadd Not tainted 7.0.0-rc4+ #6 PREEMPTLAZY 
[   10.902525] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[   10.903045] Call Trace:
[   10.903163]  <TASK>
[   10.903262]  vpanic+0x694/0x780
[   10.903451]  ? __pfx_vpanic+0x10/0x10
[   10.903625]  ? __pfx__raw_spin_lock+0x10/0x10
[   10.903811]  panic+0xca/0xd0
[   10.903952]  ? __pfx_panic+0x10/0x10
[   10.904118]  ? panic_on_this_cpu+0x1a/0x40
[   10.904319]  out_of_memory+0x124e/0x1350
[   10.904497]  ? __pfx_out_of_memory+0x10/0x10
[   10.904694]  __alloc_pages_slowpath.constprop.0+0x2325/0x2dd0
[   10.904949]  ? __pfx___alloc_pages_slowpath.constprop.0+0x10/0x10
[   10.905214]  __alloc_frozen_pages_noprof+0x4f8/0x800
[   10.905445]  ? __pfx___alloc_frozen_pages_noprof+0x10/0x10
[   10.905686]  ? kasan_save_track+0x14/0x30

When interval=1, we can't crash the kernel even though netem reaching
sch->limit. You are right, it's a race between creating and comsuming.
But interval=0 gives the the user too much power to win the race easily.

> > 
> > The same zero-interval issue applies to br_mrp_start_in_test_parse()
> > for interconnect test frames.
> > 
> > Use NLA_POLICY_MIN(NLA_U32, 1) in the nla_policy tables for both
> > IFLA_BRIDGE_MRP_START_TEST_INTERVAL and
> > IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL, so zero is rejected at the
> > netlink attribute parsing layer before the value ever reaches the
> > workqueue scheduling code. This is consistent with how other bridge
> > subsystems (br_fdb, br_mst) enforce range constraints on netlink
> > attributes.
> > 
> > Fixes: 7ab1748e4ce6 ("bridge: mrp: Extend MRP netlink interface for configuring MRP interconnect")
> 
> I think you also want
> 
> Fixes: 20f6a05ef635 ("bridge: mrp: Rework the MRP netlink interface")
> 
> As highlighted by AI review.

Thanks for the reminder.

> 
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> 
> ...
