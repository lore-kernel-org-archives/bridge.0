Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A37327BEC
	for <bridge@lists.linux.dev>; Sat, 19 Sep 2026 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789841276; cv=none; b=p9TPzicbOC+fHAGS/Ka8jj5yvSVKn246QyP7WQdj8+PJ/GkzdduIpTH4BtXDfmzAlPwYyLhIL3m7ZrfbbtNjsbuHIoiU0wqqflUTbr9HO2KLh6ArmWxa8n54W9dZx+11OE4ZVKX1SAO+OFTiZTmTB87OycNtevFoNdwxJhTDchI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789841276; c=relaxed/simple;
	bh=zZ+Qj6Es0NnBBB/krCM072RlGUjbGN1xFNtnJKtKur8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ymg0Zh/q5sHx91BhdWFNApyiAojexGyWZx9/xwb2YaHEHQfAR8DuqUzDzNXzuAWGUQKq0VIuMqTGJ8Jrjzt1fZ8Vsm5/qTARrE3vFYR2fvc61bsV2Rm3K9eC82ZVXKibn/R5DXcALfvWJyAQMpdBALJPDztUXRZtVN1iqPo48RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=UyHGRGJ9; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="UyHGRGJ9"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so8120045e9.0
        for <bridge@lists.linux.dev>; Sat, 19 Sep 2026 11:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789841270; x=1790446070; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jaIZI05s3E2LLLYS99VJR5T7zbgwyUaaN0d4bzMK8Qg=;
        b=UyHGRGJ9jjXd4CgZ1g5t0Yw8Ewpr2wes2AucQ6RAUXtXQ6r6G94yESNAG0ARbP7swu
         V4UX8bW7WXl5zYJaevqkfWYuMSwSmZN7FI6afVCPx+GmW9azIEw7ijzt3IOU7RzKGtNq
         LpWR2fHl4d0zyTVdOc8cxIKnkxfi1P2Ipvt8g15vDVnSKzCWvkuuebmmPewOxu2oRrNg
         nFwacxC3xPCUCzQpYlNNdF5Dv0d0Kqa6Y+LzCZys/S7PUUSnjjvQk/nvm5wbf5l0B6Hf
         waGNlM6JSe6VXXbg/v3Y0WpRPM4WrOo8OoIG7TFbgrImMtcLFWEvLl8znpvE1RvD9YQg
         u87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789841270; x=1790446070;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jaIZI05s3E2LLLYS99VJR5T7zbgwyUaaN0d4bzMK8Qg=;
        b=jUkc3002rCJlSFyRHwJl8ghonbwmULuhT5jRLCD9XbvaLQqshdx8Fl3ebRmhWu2/be
         XZi9DXnRT4wfwj+RPz1FzVX7t1MqNhrwda69Czb0cBCoolUV55nq1GY3CI2xsfWeaqNw
         /f/3XihRoaAWojUD0TwCnqNDziAhHLkolEq1cZA2BJJ9FFgb2K3FJ6bXJMfjV17wlRau
         ZJNgzIL4YFYQbqVlWx8uVM7vC9T3lKltjfGViSIvGlK88jQ9/Ax0EML5/moeN+f9jEI9
         i8JNcS6GzwLd1/j29y585ba+nw9F/JqeK7bASOx3MDHBuF0qS1SjGU1CGuC3bTFRpgmv
         X80w==
X-Forwarded-Encrypted: i=1; AKwUvBzVinoesncDlu5UMh1rLqgtxIoRg4pvvSLZgk14VCOFrE6fUhKvavL9RQIzUyoGFKkHCFEl3AQ=@lists.linux.dev
X-Gm-Message-State: AFuF++m4foKV9qdqT1YDg2VT9JNNXB/RitTlWevlOT7pNtvxRn+7a6he
	QYLh8Rao/uyO8SIwz82R5Ena4rjSTCLd60xgTM0bJYYt0Odx5ah7724D+TMa9foHJIk=
X-Gm-Gg: AYBFou16ox2II2O8+JX2molrAaPzbE8fC/0XGe2T1VMjpPslO3NI0Owd1ueZbhu9+hw
	Ghb09cJL6TH2KL94W+MkAwbgKf4yArGj4XgcH7wm/1wfjh+JQix0Kox0MMffpCin3/gHUuT0EVe
	yxFYSfsJRCq3rnGxXvt/qnpJkB7kX6n74jAcvTtgKXiEoCWND0mKnI1a9P8NVZQM+9yfHE+P+fN
	SbtgbIkbKhaMK9Yz83H473sab6xG86rMIrJna7XWwi6N2CzY6EWN5OI0F8L9JJRsLOpVWtVflHd
	4/HmFtnOv1/mge5U0zgCDr+TrmqseNFYVuK3ioiLdIM7h5zwjn2s7MOcT78al4vYv15JAO0JWi2
	pOCm9pwVkRZ9MwPumr0Dydhbvwd55x4wElioacG7EGwAiO8lqVbjN+JKkjlWjrmkZ0ZwsQorVFb
	Y55dPs16CjCbtNvhZLszQlZH0qDyrxNKd42reT8i2zu6/I4PWbhM53SjTZlZqys/zlJ8asF5AHW
	+x6vmlaTVUYb8B8VSYgElNmfH/DxQ==
X-Received: by 2002:a05:600c:c493:b0:49c:fa20:cc02 with SMTP id 5b1f17b1804b1-49fc573697bmr79722755e9.25.1789841269149;
        Sat, 19 Sep 2026 11:07:49 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm333932115e9.4.2026.09.19.11.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 11:07:48 -0700 (PDT)
Message-ID: <859a23ef-81a5-4bba-a728-49dbfc8a575e@blackwall.org>
Date: Sat, 19 Sep 2026 21:07:47 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/9] net: bridge: vlan: cache the pvid vlan entry
 directly
Content-Language: en-US, bg
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bridge@lists.linux.dev
References: <20260918152950.1938259-1-razor@blackwall.org>
 <20260918152950.1938259-4-razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260918152950.1938259-4-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/09/2026 18:29, Nikolay Aleksandrov wrote:
> VLAN groups cache the pvid and its state separately requiring state
> updates to keep both copies synchronized. Lockless readers can also
> observe the pvid and state from different updates. Cache an rcu protected
> pointer to the pvid vlan entry instead. This makes the vlan entry the
> single source of truth and lets the ingress path reuse it without another
> lookup. It also makes the vlan entry always available at the ingress path
> for subsequent forwarding-path optimizations.
> 
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>   net/bridge/br_mst.c          | 13 ++----
>   net/bridge/br_private.h      | 25 +++++-------
>   net/bridge/br_vlan.c         | 76 ++++++++++++++----------------------
>   net/bridge/br_vlan_options.c | 12 ++----
>   4 files changed, 46 insertions(+), 80 deletions(-)
> 

for this patch Sashiko says:
  Does this code introduce a memory corruption regression due to a missing
  release barrier?
  RCU_INIT_POINTER() publishes the pointer to the datapath without an
  smp_store_release() barrier, unlike rcu_assign_pointer().
  If a lockless reader observes the new vg->pvid pointer before the VLAN
  fields are fully initialized (due to CPU out-of-order execution), it might
  read an uninitialized v->stats pointer in __allowed_ingress() when an
  untagged packet arrives.
  Calling this_cpu_ptr() on an uninitialized v->stats pointer could resolve
  to the base of the per-cpu memory region or an invalid address, causing
  subsequent u64_stats_add() increments to silently corrupt per-cpu variables
  or cause a kernel oops.
  Could rcu_assign_pointer() be used instead to ensure prior initialization
  is visible to readers?


Nik says: No, if that could happen we would be in trouble even today. These
           fields are initialized before the VLAN is published, i.e. before
           inserting it in the VLAN rhashtable and linking it to the VLAN
           list, only after that the pvid is applied by __vlan_flags_commit()

Cheers,
  Nik

