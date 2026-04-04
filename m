Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A241F4174
	for <bridge@lists.linux.dev>; Sat,  4 Apr 2026 00:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775262708; cv=none; b=AcOuvVp6WBjnHyP7aXMieEA8wJm+Cp2rORVECZYGuWmebWdw0a7+wXkx+mF0NGqgFHvs+kIdLYbMEAiciWyaX5QvNq8lfhAC/1APhvAuono61TZAvJ42W2Clpp8fIwWtIS51jF1czQ7UBpcQF0m7cLAiUD7uqgXvxK/jbzhVLVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775262708; c=relaxed/simple;
	bh=l/B0K4b/Ci0D5UNKWH9tcH6Wj18mUZWCi/vbU1/znLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwW5JD630vuMFFg1hUQksvW4F9Pvh1qohQrkc3LO3Oj+9u2Vo4j7f7Q9L/jE7XG/AGeaMtVON2NNEEmhJm/uhdvJXW+IDCwXrxOZEf5NEE9F7XGLr2LeQYnuP0dcQxDZ73W/60/9kmzKbSpGRPssI4Y34n0SmJMtIbhwUW9hYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=d7et7oNn; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="d7et7oNn"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c5b3d8eab1so1191684eec.1
        for <bridge@lists.linux.dev>; Fri, 03 Apr 2026 17:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1775262706; x=1775867506; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PizuDW6eX0LEcIB7Va2kka7Ym4sd3SvAd0XyjOtDdMM=;
        b=d7et7oNnKdZtIt5BW4xHLQzhj5eONnw8pVvg38pwXOTf9Jd1ou/xwZwL9JTWOsItTZ
         ah5U9jONCrzMM6L/Ew21hI1uinOh+qO3gOO1nFlNSGTzajGnEUgEatEupldtygpKyeVZ
         W8sHR3hrg96IpUXVWbFDvEyXKZGxY7wng68CItQPpA3hyvH1utTCaxYuLqFBk+Awoo/C
         bZXauG9JJ33xm9ADTR/R6GLF0IgBcCPC7k5nux8CXQkk5luhwknWUPNCJO+zqVme+/CC
         wSzWcXzQkC+uS3FyNvzPt7bqTSy4cd9NeEjBRoAwgWHygtoB1Xhti6UX057DqchHqBO3
         SF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775262706; x=1775867506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PizuDW6eX0LEcIB7Va2kka7Ym4sd3SvAd0XyjOtDdMM=;
        b=qYv0ro8GP29fKptnvZVUrMHkKiU806gDyS0G8j5938J4tgzIbX6ljJvnv260C4k2W4
         9vSy3yWXX7jqF9wZTutQ6Aysscd77qm/zuYL6PwkL5XaIkGWJoH2os32UYIwt9eahRCP
         t/JVz1oQot3QjT9BYOuMvDXStB/7/gyNXFsaRxxAsqGtvSqDEM9pVrwi2C9oHH0wBCHY
         16XNR7aHsXRzAY6K61wsm210ngWBp1ww3wz769zJEnw5/dVLVDKJLZpvVMkCu7DSUdsT
         gECFf+xq5ybq9K3qI2xpddBzOPb/Z0evZGcjYiI3qkUKwi8YT+0N2l0EVsfGQOiOLSIj
         lKGw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ0YVkFTaU+lVnNyA+908nNSj9KxtDYOkKUjPVeax+h9WzEucUQ27P/kikCf/qpaNsZD+a4KA=@lists.linux.dev
X-Gm-Message-State: AOJu0YxwyxqJ5mI4KZC0Ers9WTCWBYD2miYRow2EyywSSZuv3+cb2p1W
	gkLhwttyyFusxWSTQv9PmsoXl3Vm9P3pgP437TXZ82lcfWZGB0CBUX+By70/KAgWIg==
X-Gm-Gg: AeBDies0ZlRQNrpn/BSGZWFcaTLGxhkcjk8BFdE8zskz6qWA2+3Fosb72snykqQmhLX
	KL6QfG7TP4etME/hiH1vKV6OpTS3L1YbsBsreJjxRU20JRGhgnL7czQcJHUZ66ijduI/mmfih5s
	GKPpIYfhJWcWUKwq/Qnf+9JpxttvxA7GPsVnUtvcKYFK9W30XaZ+bKAvTLYBru7ne5syBDjjVTz
	4++X3zO3j481J9H6rkAKZ0T4AgJtldGEoGgwfTtJCiMfJ3ESrmvihrsUDPe98zMmgQN36C94vHS
	870m9X+diyupBOwXNxWS/VIVMgjvRtyTYISAZfl7desPx4hdw9DiAbRIVFcLk1V1GA31IzGCCUC
	pE4MzE5c7hfXSKXvyQdl7oBcwMyrJp323iW1HWFz69vh1OCOicdH/uLf+Z/6Hoz8/d1k6og/sG2
	t0tfd0C5LLzhHXVetc/yGo6H53HG97cw==
X-Received: by 2002:a05:693c:3005:b0:2c5:60d0:7031 with SMTP id 5a478bee46e88-2cbf97f57d8mr2610760eec.4.1775262706220;
        Fri, 03 Apr 2026 17:31:46 -0700 (PDT)
Received: from p1 (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cb7ec57f9dsm4423861eec.11.2026.04.03.17.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 17:31:45 -0700 (PDT)
Date: Fri, 3 Apr 2026 17:31:44 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Simon Horman <horms@kernel.org>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, 
	bridge@lists.linux.dev, idosch@nvidia.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bestswngs@gmail.com
Subject: Re: [PATCH net] bridge: mrp: reject zero test interval to avoid OOM
 panic
Message-ID: <7khxzrtdbjwz3wzvfhfuczi6i7vlq54atrspehj2yurbocagck@3m37lgh7xh4z>
References: <20260326032438.3307549-1-xmei5@asu.edu>
 <20260327113412.GD567789@horms.kernel.org>
 <f7fea291-bde9-4f95-8a59-1b209407ee27@blackwall.org>
 <20260403083415.GC11973@horms.kernel.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403083415.GC11973@horms.kernel.org>

On Fri, Apr 03, 2026 at 09:34:15AM +0100, Simon Horman wrote:
> On Fri, Mar 27, 2026 at 01:46:39PM +0200, Nikolay Aleksandrov wrote:
> > On 27/03/2026 13:34, Simon Horman wrote:
> > > On Wed, Mar 25, 2026 at 08:24:38PM -0700, Xiang Mei wrote:
> > > > br_mrp_start_test() and br_mrp_start_in_test() accept the user-supplied
> > > > interval value from netlink without validation. When interval is 0,
> > > > usecs_to_jiffies(0) yields 0, causing the delayed work
> > > > (br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedule
> > > > itself with zero delay. This creates a tight loop on system_percpu_wq
> > > > that allocates and transmits MRP test frames at maximum rate, exhausting
> > > > all system memory and causing a kernel panic via OOM deadlock.
> > > 
> > > I would suspect the primary outcome of this problem is high CPU consumption
> > > rather than memory exhaustion. Is there a reason to expect that
> > > the transmitted fames can't be consumed as fast as they are created?
> > > 
> > 
> > +1
> > More so with CAP_NET_ADMIN you can cause all sorts of OOM and high-cpu usage
> > conditions. This is a configuration error and OOM doesn't lead to panic unless
> > instructed to. I don't think this is worth changing at all.
> 
> Right, I was getting to think that too.
> 
> ...


Thank you for the review.

Regarding the privilege argument: this path is reachable from an
unprivileged user namespace, which checks CAP_NET_ADMIN against the
network namespace's user_ns. An unprivileged user can create a 
user+net namespace, obtain CAP_NET_ADMIN within it, set up a bridge
with MRP, and trigger the zero-interval loop. So this crosses a 
security boundary.

Regarding the OOM behavior: this does lead to a kernel panic without
panic_on_oom or oops=panic. The zero-delay workqueue loop allocates
memory from kernel context continuously. The OOM killer fires and kills
all related userspace processes, but the memory pressure originates 
from a kernel workqueue which the OOM killer cannot target. Once no 
killable processes remain, the kernel hits "System is deadlocked on 
memory" and panics. Below is the relevant dmesg from a test without
oops=panic:

[    5.254108] Kernel panic - not syncing: System is deadlocked on memory
[    5.254470] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 7.0.0-rc4+ #6
[    5.255524] Call Trace:
[    5.255796]  vpanic+0x694/0x780
[    5.256607]  out_of_memory+0x124e/0x1350
[    5.257281]  __alloc_pages_slowpath.constprop.0+0x2325/0x2dd0
[    5.258777]  __alloc_frozen_pages_noprof+0x4f8/0x800     

Best,
Xiang


