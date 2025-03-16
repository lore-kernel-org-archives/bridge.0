Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E8B42069
	for <bridge@lists.linux.dev>; Sun, 16 Mar 2025 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742157312; cv=none; b=hfnQRI5fDmeCWIvEvFOkdoiEHCh1wYV/mtjI4m3binXZoZuFPaCjb6jwqe6xY77VuVJ7f0BirnSqZoo1/6p2od2mkjJqkZUsT6Y7irglVY45LXdo01khMlqM2h9dP+USG62vG+enDfP3tRQ+PHwm1WqzKom++beGfj50k0Uv0S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742157312; c=relaxed/simple;
	bh=dKC6oKfJqlJWfKuMIbGGKu7ODihXEYGoPHTMMfdAuiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kULM5BcEFx9HjGuCqdOChe9r4fVuFeypg7WiZAJvm4awPJqekW/OLqW9uJeJyzERv6OFoTdeG3Iyau8BM26R5tkxzXflKk9AP9Hq0gshPmuAmZ/t7Hr6ufMwT/hwNDJZt5ZXKRznY9MUBfcU1UGLi2Eb0G2xU9N1nthUHLza9D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=2lBRi8nB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="2lBRi8nB"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso9774555e9.1
        for <bridge@lists.linux.dev>; Sun, 16 Mar 2025 13:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1742157308; x=1742762108; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/qniutptUO6aG/4w6T50Q5l+k6GgQyiuG2YW9LxAFI=;
        b=2lBRi8nBl1XQKj/lE7GbTjLhBYlXJ402iCYAKn0/Vu3/AW6FTWN73sDeqPyX78g3Tl
         hvP7m7XpydKw7TRTz5VnKhmxDoZK5Ee0RDwSOupFzHzSohdxZIRiKu8LAB6npSoOHeJb
         Dyv0IPJTV05tTZLzZIy7SHTCjv9xlGag5TgW94aPFkkaXitw3Iivo8NTNjYk6ua71qIz
         4/dp5CN8kdOFKaZK68Lrup0xs6do5QbJzICUdnbUqAdqRMQwzUrL0CLRcUp7qgm4yWxX
         XAF8uZ2RkraOybbuZ7YmUrjPHcWeYl/0Wlt9hfPq8mZAZrX1ROrYXE4OWCaDVlUsbKzQ
         ieVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742157308; x=1742762108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/qniutptUO6aG/4w6T50Q5l+k6GgQyiuG2YW9LxAFI=;
        b=YY25I/uLV4s5jHMNSTCbItekMQs3n9x1iEK1LNjRAVZpzGFdQI2gyplS9mdOXAw6F1
         AtR2Q06yyN35MSULx//y7i5a2/5XKKZ9FCzC9nHngyJnyYp1eh+bK1sLADLtrPWvo57N
         3Jy7oL+nTfOa7YBGyPRG86GjvrQ+JoeGrDJN+Msk3WpR+q5EB2X9Qior4lUPpv/wxvLT
         7jFeQ8VSLBRsjL09NGOrHkOUVaeTV8yzXXB2KiDLMKTBbVxVXzOFRuKvE7V53lZcExsl
         ZPObzmWXhnPdc/PkRPJoxdAbgGooy6/THvtshmmf4Z83T5ilwQcn8KvL+2J56AZ0xQiQ
         mNXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMBfuYAySX5XM4RVHmGdsY0PTwlY/LaWTcyy2gWJblfJhUkSS+9LN/z5P6ROA5/8MB1RrhobE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz45pRnpy9qVPeixMa01fCQXJXHLZnfn3AauBxZHnKeEQyygsa8
	AzwnyBHvHrTRpBKxhaIE6oU/7v+n57vZ36M6gjxpVMIu2N4mhRNkXtSot8SxHks=
X-Gm-Gg: ASbGncu9hDJBgCNNAuO7ZZlPxIsKgwma6q6NzY8SXIS8eXZ32/YcDZPGX6vnd821rZO
	FLpjutVWWn1W/8nRwQRBYWOkbQ+WGpmCu4/iIR5tE1ISA2FwB+ekbaNEJonT956cPif2jmNq+kB
	O1BnnrFV3eSkFtK0I0aAQmGYG4uQWka/mQkj5oZRItEn8RH4/i3T06uzZ6yUVTP6k0YF0VDTtUP
	o3yGnGmD93ZM7ctY/cquU9UWeg+N5FQvY9PVzqBw6xvQs+0WLUymENaHm5lycKEjl3WS2/uYJgs
	cffDnZffPqTaOYN7CSzJ56ZJrd66ykluo2Bu2fw2lFXp2+Rm70xUgbg847Un2TzB1xIN5qukmZh
	c
X-Google-Smtp-Source: AGHT+IEX4MsZy7CIHnz5nS7qR417zJFGnB5h/cnEE6O40fjH90DJYPmv+beoRj6eBarLH4rYx2UMvg==
X-Received: by 2002:a05:6000:1545:b0:391:2e6a:30de with SMTP id ffacd0b85a97d-3971e971991mr13080918f8f.19.1742157307990;
        Sun, 16 Mar 2025 13:35:07 -0700 (PDT)
Received: from [192.168.0.160] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c888117csm12690480f8f.44.2025.03.16.13.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Mar 2025 13:35:07 -0700 (PDT)
Message-ID: <d539500a-7fca-40c8-ba38-4e334a97f810@blackwall.org>
Date: Sun, 16 Mar 2025 22:35:05 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: Remove RTNL dance for SIOCBRADDIF and
 SIOCBRDELIF.
To: Kuniyuki Iwashima <kuniyu@amazon.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>
Cc: Ido Schimmel <idosch@idosch.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 bridge@lists.linux.dev, syzkaller <syzkaller@googlegroups.com>,
 yan kang <kangyan91@outlook.com>, yue sun <samsun1006219@gmail.com>
References: <20250316192851.19781-1-kuniyu@amazon.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250316192851.19781-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/25 9:28 PM, Kuniyuki Iwashima wrote:
> SIOCBRDELIF is passed to dev_ioctl() first and later forwarded to
> br_ioctl_call(), which causes unnecessary RTNL dance and the splat
> below [0] under RTNL pressure.
> 
> Let's say Thread A is trying to detach a device from a bridge and
> Thread B is trying to remove the bridge.
> 
> In dev_ioctl(), Thread A bumps the bridge device's refcnt by
> netdev_hold() and releases RTNL because the following br_ioctl_call()
> also re-acquires RTNL.
> 
> In the race window, Thread B could acquire RTNL and try to remove
> the bridge device.  Then, rtnl_unlock() by Thread B will release RTNL
> and wait for netdev_put() by Thread A.
> 
> Thread A, however, must hold RTNL after the unlock in dev_ifsioc(),
> which may take long under RTNL pressure, resulting in the splat by
> Thread B.
> 
>   Thread A (SIOCBRDELIF)           Thread B (SIOCBRDELBR)
>   ----------------------           ----------------------
>   sock_ioctl                       sock_ioctl
>   `- sock_do_ioctl                 `- br_ioctl_call
>      `- dev_ioctl                     `- br_ioctl_stub
>         |- rtnl_lock                     |
>         |- dev_ifsioc                    '
>         '  |- dev = __dev_get_by_name(...)
>            |- netdev_hold(dev, ...)      .
>        /   |- rtnl_unlock  ------.       |
>        |   |- br_ioctl_call       `--->  |- rtnl_lock
>   Race |   |  `- br_ioctl_stub           |- br_del_bridge
>   Window   |     |                       |  |- dev = __dev_get_by_name(...)
>        |   |     |  May take long        |  `- br_dev_delete(dev, ...)
>        |   |     |  under RTNL pressure  |     `- unregister_netdevice_queue(dev, ...)
>        |   |     |               |       `- rtnl_unlock
>        \   |     |- rtnl_lock  <-'          `- netdev_run_todo
>            |     |- ...                        `- netdev_run_todo
>            |     `- rtnl_unlock                   |- __rtnl_unlock
>            |                                      |- netdev_wait_allrefs_any
>            |- netdev_put(dev, ...)  <----------------'
>                                                 Wait refcnt decrement
>                                                 and log splat below
> 
> To avoid blocking SIOCBRDELBR unnecessarily, let's not call
> dev_ioctl() for SIOCBRADDIF and SIOCBRDELIF.
> 
> In the dev_ioctl() path, we do the following:
> 
>   1. Copy struct ifreq by get_user_ifreq in sock_do_ioctl()
>   2. Check CAP_NET_ADMIN in dev_ioctl()
>   3. Call dev_load() in dev_ioctl()
>   4. Fetch the master dev from ifr.ifr_name in dev_ifsioc()
> 
> 3. can be done by request_module() in br_ioctl_call(), so we move
> 1., 2., and 4. to br_ioctl_stub().
> 
> Note that 2. is also checked later in add_del_if(), but it's better
> performed before RTNL.
> 
> SIOCBRADDIF and SIOCBRDELIF have been processed in dev_ioctl() since
> the pre-git era, and there seems to be no specific reason to process
> them there.
> 
> [0]:
> unregister_netdevice: waiting for wpan3 to become free. Usage count = 2
> ref_tracker: wpan3@ffff8880662d8608 has 1/1 users at
>      __netdev_tracker_alloc include/linux/netdevice.h:4282 [inline]
>      netdev_hold include/linux/netdevice.h:4311 [inline]
>      dev_ifsioc+0xc6a/0x1160 net/core/dev_ioctl.c:624
>      dev_ioctl+0x255/0x10c0 net/core/dev_ioctl.c:826
>      sock_do_ioctl+0x1ca/0x260 net/socket.c:1213
>      sock_ioctl+0x23a/0x6c0 net/socket.c:1318
>      vfs_ioctl fs/ioctl.c:51 [inline]
>      __do_sys_ioctl fs/ioctl.c:906 [inline]
>      __se_sys_ioctl fs/ioctl.c:892 [inline]
>      __x64_sys_ioctl+0x1a4/0x210 fs/ioctl.c:892
>      do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>      do_syscall_64+0xcb/0x250 arch/x86/entry/common.c:83
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Fixes: 893b19587534 ("net: bridge: fix ioctl locking")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Reported-by: yan kang <kangyan91@outlook.com>
> Reported-by: yue sun <samsun1006219@gmail.com>
> Closes: https://lore.kernel.org/netdev/SY8P300MB0421225D54EB92762AE8F0F2A1D32@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
> v2:
>   * Use if in br_ioctl_stub()
>   * Update diagram in commit message
> 
> v1: https://lore.kernel.org/netdev/20250314010501.75798-1-kuniyu@amazon.com/
> ---
>  include/linux/if_bridge.h |  6 ++----
>  net/bridge/br_ioctl.c     | 36 +++++++++++++++++++++++++++++++++---
>  net/bridge/br_private.h   |  3 +--
>  net/core/dev_ioctl.c      | 19 -------------------
>  net/socket.c              | 19 +++++++++----------
>  5 files changed, 45 insertions(+), 38 deletions(-)
> 

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

