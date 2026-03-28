Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2FB223708
	for <bridge@lists.linux.dev>; Sat, 28 Mar 2026 06:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774678779; cv=none; b=Z7cC7suQFVui2RaVXgcOYagvN0l5QjPw2d+6KMn3pPi2892g28Qc8zRQH3pHGI571cOWiJ4Okfh2n+BTL78wlZvNoXoO9ssHNqob/2Dw5hVzBX7DxeyilLz9pJd6RkU7xhW51eLS4tuyrEGUFqQvn7rtUsZ3ufV+k4z9K+BMSSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774678779; c=relaxed/simple;
	bh=WU2xZt3YCmje/kJ14AXJ+weAoZGqbyywvIn3eOH58VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqp0gaoPlpbT3TmswNPk3d+2TMxzfeViu69l8Ua+bItxlnmybi9CzjWh0wkADBtirT6nHBmVTU5MnZLG5K6w0Gk4r8vZ5oY+FCEbXAOQy0s5yhVA+oUXv5FBaGA1kSQwOOAIPmTjRUPOC5B3hYCeCX/IMW62qKvXPqILnMMtB10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=TZsoAdZz; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="TZsoAdZz"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c175635a33so1982349eec.0
        for <bridge@lists.linux.dev>; Fri, 27 Mar 2026 23:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774678776; x=1775283576; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ygBNExZBLlphU7WjlAjN1m9FBWe2QMN06zkttNgKTcY=;
        b=TZsoAdZzK0RtxywSY+jxjhRwZ4BIzB3clafUXEKiGP8W22ZSFFzplyKdYhi+oQdN2P
         EYYqn3uXHLl1Qs/Wh1Bkxt7jq/VuSiXlt2aET7SLMjSTy93izCaKJ1Tj+Gv03ewROQro
         xwFrPv5eANIeDn8luqxkddrElgooT8CMWIy0/0vlHNgyoryD5/uvFC9ZKTneeI88s0R8
         sOvf+h001Pm55MW5rAcSeeydap5m3Mh9lWq3IaSGdbqk1pwQhfiB5WZ6yCSunW1Eh8PP
         6hA6wgY1tSCnFywPJiv10lhOb4xiOyj0NmT2JxK/quTBCe2h0nk8Ditv8cQt+nhTBtEV
         pb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774678776; x=1775283576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygBNExZBLlphU7WjlAjN1m9FBWe2QMN06zkttNgKTcY=;
        b=OBPCtUMeH0NS6LPuackvSn8Mn/gMAHFpS0qkfStrtuufMBB3Fa/B+/km5b6o6ZT+j1
         jI+NE7twZDS5nzKFhqsgxhjOzO/w0SyOoYF3aBr84a+YhpLmYxExS2RTj/uYTtiiZTpi
         zunRrCMHfYTEDfJPzEQ8BuFUFtFEzu1YlRf36BUmfrcwP6rQachPlA1AZDbUQPdzeDEF
         jKhM0TtyIuewGg8D3l8UjdJry1a2qB4i9SvC+SnrHMzPMYVBT7Zr06o1H25Ge9MLeiU8
         qpdsxJ4xqd/WvypfMkmdOyu8Gb3xde+LclnDflulo97zDzui64HHvCmU9q/9sb0AlgEA
         +7jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCQFuWQpUktSxCi2QS6AhDW+Brai48bwnhzx60v/JFiybI8kgsFDUjzH6luUz6moYn4tKuruk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7aKxhsVX+Ez8zgpaCxD1yjSPd9e0FBQEQC7ZNomrxoGaFeC2H
	4HaLxJ/vQ8UtMPQrA6O94E0bPipIZVqiwrnw3ZHzr+IOSLrsSPVp4VVLS5a7Ed06yg==
X-Gm-Gg: ATEYQzzu7mr6wfYEELCZxiu1dsmmYq92Axb40cAsUU3veCYVd/yJfcEdYqOo0bW2W/c
	Om5SvZdCtGP92AUxIpVXlnT26jGsFKuGlffMftsM9qSs3lhXW4daJx/5NCwiQECRwsqDlERzWU4
	Qc2DcmzB/vsYqJbv1Eo4ZdQAoJMKh/Gf/rAyqTV3uAtQDvzxK8MsVgJPWD+5sw41bkWO4+F+DEm
	aL6apUsNaw6QX8WsVzvG4GMoypy8IJ1ibiqJWBMPwuyrcmWHbXi86P4YPTvddvhskKm+ZbWUJj3
	KA2rV/cvlRpzsDQqsA5J+eCgniPfHUG8gGAWNt/ovaX3JN76YjCG8L8Vb8o776eoAj1pAzJXhxZ
	Z7E/Kuhw+MhOwXLY9rVghoAdCf3IUX/Z1csPaOPaYxIzZs+SHN1CSdtaxfHzCQBRgPVzCnLzuUI
	FGs57l7jSbLIiZYA6At4lSOYNU0hTlNA==
X-Received: by 2002:a05:693c:3005:b0:2c1:7793:7bbb with SMTP id 5a478bee46e88-2c185f3905emr2941453eec.27.1774678776219;
        Fri, 27 Mar 2026 23:19:36 -0700 (PDT)
Received: from p1 (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c6e9d38fsm1791956eec.23.2026.03.27.23.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 23:19:35 -0700 (PDT)
Date: Fri, 27 Mar 2026 23:19:34 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	bridge@lists.linux.dev, idosch@nvidia.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bestswngs@gmail.com
Subject: Re: [PATCH net] bridge: mrp: reject zero test interval to avoid OOM
 panic
Message-ID: <cxf6kerzseqczgsdgznoqaxcgnx3hql65tbupt7rk4arjp6www@5jnc3nkrvljt>
References: <20260326032438.3307549-1-xmei5@asu.edu>
 <20260327113412.GD567789@horms.kernel.org>
 <f7fea291-bde9-4f95-8a59-1b209407ee27@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7fea291-bde9-4f95-8a59-1b209407ee27@blackwall.org>

On Fri, Mar 27, 2026 at 01:46:39PM +0200, Nikolay Aleksandrov wrote:
> On 27/03/2026 13:34, Simon Horman wrote:
> > On Wed, Mar 25, 2026 at 08:24:38PM -0700, Xiang Mei wrote:
> > > br_mrp_start_test() and br_mrp_start_in_test() accept the user-supplied
> > > interval value from netlink without validation. When interval is 0,
> > > usecs_to_jiffies(0) yields 0, causing the delayed work
> > > (br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedule
> > > itself with zero delay. This creates a tight loop on system_percpu_wq
> > > that allocates and transmits MRP test frames at maximum rate, exhausting
> > > all system memory and causing a kernel panic via OOM deadlock.
> > 
> > I would suspect the primary outcome of this problem is high CPU consumption
> > rather than memory exhaustion. Is there a reason to expect that
> > the transmitted fames can't be consumed as fast as they are created?
> > 
> 
> +1
> More so with CAP_NET_ADMIN you can cause all sorts of OOM and high-cpu usage
> conditions. This is a configuration error and OOM doesn't lead to panic unless
> instructed to. I don't think this is worth changing at all.

Thanks for your review. This path is reachable from an unprivileged user
namespace. The capability check goes through rtnetlink_rcv_msg() -> 
netlink_net_capable() -> netlink_ns_capable(), which checks 
CAP_NET_ADMIN against the network namespace's user_ns, not init_user_ns.
An unprivileged user can create a user+net namespace, get CAP_NET_ADMIN
within it, set up a bridge with MRP, and trigger the zero-interval loop.
This is not a privileged misconfiguration scenario.

Also, the PoC can crash a kernel without "oops=panic" with this bug.

> 
> > > 
> > > The same zero-interval issue applies to br_mrp_start_in_test_parse()
> > > for interconnect test frames.
> > > 
> > > Use NLA_POLICY_MIN(NLA_U32, 1) in the nla_policy tables for both
> > > IFLA_BRIDGE_MRP_START_TEST_INTERVAL and
> > > IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL, so zero is rejected at the
> > > netlink attribute parsing layer before the value ever reaches the
> > > workqueue scheduling code. This is consistent with how other bridge
> > > subsystems (br_fdb, br_mst) enforce range constraints on netlink
> > > attributes.
> > > 
> > > Fixes: 7ab1748e4ce6 ("bridge: mrp: Extend MRP netlink interface for configuring MRP interconnect")
> > 
> > I think you also want
> > 
> > Fixes: 20f6a05ef635 ("bridge: mrp: Rework the MRP netlink interface")
> > 
> > As highlighted by AI review.
> > 
> > > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > 
> > ...
> 
