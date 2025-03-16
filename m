Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255581993B1
	for <bridge@lists.linux.dev>; Sun, 16 Mar 2025 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742143319; cv=none; b=TbMmwtNBdztxE1dMjr+7jE8b4pN5sx7JWJxG99+HYtSXgWmVCvAG6jLLYOzvtQCzu/GnSSjNGEZAQcqPKlcAOLvCyvhSifFAaZYExXSqvCKrdinUjGfyA781OnBd1T1JcyLHM6tcuHfaDzJcxgnrTz2KTrwbpeyo7fPoRrEGTTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742143319; c=relaxed/simple;
	bh=BA2PaE3NYW+aVBBLWMmVbiWA/xSnqlWWpzhT5hvQzg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/y/FAqt5L/XBpHy02C7y4GxVt+Iz13h9faim0D9SVdOiWx4CtRcZtn2d1/KfqiTMvj8pWFwIw9kDlcBC7Yy4OcOJ2OTKdeTfhP79NXHBgANlNSJFFxr03DvpwYTuZaR8mrdhNk97AjYC8hF/R3jgC8KRPeRjTr2Q5JYiDT7Z+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJ8pfWIB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJ8pfWIB"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22359001f1aso13221825ad.3
        for <bridge@lists.linux.dev>; Sun, 16 Mar 2025 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742143317; x=1742748117; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1t7i2k+qpddSOT6lrsF95vAec+0YDsSW3ORX2scnraI=;
        b=hJ8pfWIB7yZyT4l+LvQQLWYxSWbnGOKIPZIQGFijV4Y3lst3nP5xlUVyOrLW3mMI7f
         bM7ihpez8o4WK3b0JKkb59mOXFvvouNxEiUQrtrEp9HicPr+hoRdui8mCU6tfB9FgQff
         aRXC3J1htr4wH4uXYVe0WiNw8oBHiPpqlBisPI0HORcScMDrBOfBdVoiZ49oaLeWOFHA
         CgoOt8LoEAWSvblrbHotxxxcxWBr3oFZSDauNAz6M36esXIgq26mpf6LwgDU8SIRK7Yy
         UcCdSbCmZK5FnMQhy/v4E6jbFU1/QQ9jTEclp6tCUT46Nn2ylNPhXjvLBauuCi5WbtHr
         L6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742143317; x=1742748117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1t7i2k+qpddSOT6lrsF95vAec+0YDsSW3ORX2scnraI=;
        b=NA857cBPPM8Axnhm2hrQ3slPT3OcCQrEwR3pxuf1FND84DsSFHPjRm7hJaEjrwGFa2
         ECkM5D2Hgbuh44Rihtm5URuhuhlxjtcP1Z1szFgrexB6M1QVt0b1afKlmXKcq7iIhGjN
         SYgsqUN2IQDp8HXNjcifUz3HjCQt/jv7jLufR65CU1+5Zoz5F8yXqeh0dlzTNMDpAl+s
         RxJWOG3ptkkj2xwjZJcFKqYlZluPM79oehf5u74thWJfT5hpP/QdexyGq3p9/tS7noh3
         1i30dPOYGG/eZ4zSACK6rVHFhQEwxEWwrRuz2il31T49sg3dJTIXhMGLXLmAOZwYXXsF
         zLpg==
X-Forwarded-Encrypted: i=1; AJvYcCWCASG7OtFDiQgP7ihuLC3n/gYR9R0941WX85edvWZLtzh+6t29vtuAdy2Zd3fjWkscYUJSpkw=@lists.linux.dev
X-Gm-Message-State: AOJu0YxE7WHDpUwFdcVMrykQkkKW4jXiwJusl4m+/Pi/sPfBJ0nTzUOr
	m9Uy40Eko9SaAg2Oc4LbIbsQXwH0Uh7DMnYmtwmgZMO5rnZl8NjyU+MDuGhxIQ==
X-Gm-Gg: ASbGncu11MPgYtZXC6p4Y1XQUTJQ+AccPVV3zV88nzKVOZWIBRZRwx1TnOq13KCymAH
	pM0L38b94aynmHcx+loBj3cDnx+I+y605Ons2Yton7pRmhvcLmOxUunWcCLSf6lbHkPTURogs25
	SeRnYiObkV48ZGBzdXcNTs7tgQJPU5GQXIJ4LARy7pq7LK87wvIlPhbNrcdCWuyh/q3U/mpOz1T
	0mPom+AOWOYITzj4SZErvqaDJOXijyBG1ufjnXZPUesn0jzgETN0ISfteIPDmb6He0KZaVo0z7B
	w2JJvu8Q7K8BkjNLn0qFzkkYthvg9/dzJyMPV/nTGg5Q
X-Google-Smtp-Source: AGHT+IH+gC5/AF7fQ/nODds+CLzi/mSoDdhCQD4zxfJmTqOpndJJjUsBKADkQTXD988rSMfcIE5Qxg==
X-Received: by 2002:a17:902:f686:b0:223:397f:46be with SMTP id d9443c01a7336-225e0aff8abmr118629555ad.47.1742143317261;
        Sun, 16 Mar 2025 09:41:57 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c688841fsm59623795ad.26.2025.03.16.09.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 09:41:56 -0700 (PDT)
Date: Sun, 16 Mar 2025 09:41:56 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	bridge@lists.linux.dev, syzkaller <syzkaller@googlegroups.com>,
	yan kang <kangyan91@outlook.com>, yue sun <samsun1006219@gmail.com>
Subject: Re: [PATCH v1 net] net: Remove RTNL dance for SIOCBRADDIF and
 SIOCBRDELIF.
Message-ID: <Z9b_VP-F_3iAKvCw@mini-arch>
References: <20250314010501.75798-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250314010501.75798-1-kuniyu@amazon.com>

On 03/13, Kuniyuki Iwashima wrote:
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
> Thread A, however, must hold RTNL twice after the unlock in dev_ifsioc(),
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
>        |   |     |                |      `- rtnl_unlock
>        |   |     |- rtnl_lock  <--|         `- netdev_run_todo
>        |   |     |- ...           |            `- netdev_run_todo
>        |   |     `- rtnl_unlock   |               |- __rtnl_unlock
>        |   |                      |               |- netdev_wait_allrefs_any
>        \   |- rtnl_lock  <--------'                  |
>            |- netdev_put(dev, ...)  <----------------'  Wait refcnt decrement
>                                                         and log splat below
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
> ---
>  include/linux/if_bridge.h |  6 ++----
>  net/bridge/br_ioctl.c     | 39 ++++++++++++++++++++++++++++++++++++---
>  net/bridge/br_private.h   |  3 +--
>  net/core/dev_ioctl.c      | 19 -------------------
>  net/socket.c              | 19 +++++++++----------
>  5 files changed, 48 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
> index 3ff96ae31bf6..c5fe3b2a53e8 100644
> --- a/include/linux/if_bridge.h
> +++ b/include/linux/if_bridge.h
> @@ -65,11 +65,9 @@ struct br_ip_list {
>  #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
>  
>  struct net_bridge;
> -void brioctl_set(int (*hook)(struct net *net, struct net_bridge *br,
> -			     unsigned int cmd, struct ifreq *ifr,
> +void brioctl_set(int (*hook)(struct net *net, unsigned int cmd,
>  			     void __user *uarg));
> -int br_ioctl_call(struct net *net, struct net_bridge *br, unsigned int cmd,
> -		  struct ifreq *ifr, void __user *uarg);
> +int br_ioctl_call(struct net *net, unsigned int cmd, void __user *uarg);
>  
>  #if IS_ENABLED(CONFIG_BRIDGE) && IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING)
>  int br_multicast_list_adjacent(struct net_device *dev,
> diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
> index f213ed108361..b5a607f6da4e 100644
> --- a/net/bridge/br_ioctl.c
> +++ b/net/bridge/br_ioctl.c
> @@ -394,10 +394,29 @@ static int old_deviceless(struct net *net, void __user *data)
>  	return -EOPNOTSUPP;
>  }
>  
> -int br_ioctl_stub(struct net *net, struct net_bridge *br, unsigned int cmd,
> -		  struct ifreq *ifr, void __user *uarg)
> +int br_ioctl_stub(struct net *net, unsigned int cmd, void __user *uarg)
>  {
>  	int ret = -EOPNOTSUPP;
> +	struct ifreq ifr;
> +
> +	switch (cmd) {
> +	case SIOCBRADDIF:
> +	case SIOCBRDELIF: {
> +		void __user *data;
> +		char *colon;
> +
> +		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
> +			return -EPERM;
> +
> +		if (get_user_ifreq(&ifr, &data, uarg))
> +			return -EFAULT;
> +
> +		ifr.ifr_name[IFNAMSIZ - 1] = 0;
> +		colon = strchr(ifr.ifr_name, ':');
> +		if (colon)
> +			*colon = 0;
> +	}
> +	}

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Although these double } } look funky. Maybe properly declare variables
at the top instead?
