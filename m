Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A464A82C9C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D50F82BF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1692437117; x=1693041917;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qp+p88acw4RYdUK5z2c5JXRcScXCLt4N2yRM056qyZI=;
 b=VRR5HDmZ87vfAsOdbfbSMy3DH2tEGsp2n37sFPGHgHf6WJE6uIG4yAWcDCPiimPf9Y
 g5xXFg7TPYdKcb5jl7DplAamSO61UWaTu/PSgQ4Oc2VdSKqhz5y2imgL1SGTUGce7DhW
 YkIld5h6JkxGQ4xBy1o2SvHqcy982wGk0ZNtngsGuIVTuMB1IhHThiyKJ8YI4Fw7NuxC
 fPhsJzKOHsmaIq+vUlkq7v+ZjfFG+h3uvMucYasHduWlSim2hBKkjMQ96TYQvhUFxhvK
 8TzlZGlFBzKsohUfKrApwHBiQoo7Mh+s9wU2IPUg9P5FV8yqsBs/mPXujg2UV4whPYLv
 PgsA==
Message-ID: <df28eac7-ee6e-431c-acee-36a1c29a4ae0@blackwall.org>
Date: Sat, 19 Aug 2023 12:25:15 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <00000000000051197705fdbc7e54@google.com>
 <20230819081057.330728-1-astrajoan@yahoo.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230819081057.330728-1-astrajoan@yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net: bridge: Fix refcnt issues in dev_ioctl
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ziqi Zhao <astrajoan@yahoo.com>, arnd@arndb.de, bridge@lists.linux-foundation.org, davem@davemloft.net, edumazet@google.com, f.fainelli@gmail.com, ivan.orlov0322@gmail.com, keescook@chromium.org, kuba@kernel.org, hkallweit1@gmail.com, mudongliangabcd@gmail.com, nikolay@nvidia.com, pabeni@redhat.com, roopa@nvidia.com, skhan@linuxfoundation.org, syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com, vladimir.oltean@nxp.com
Cc: netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org

Hi Ziqi,
On 8/19/23 11:10, Ziqi Zhao wrote:
> In the bug reported by Syzbot, certain bridge devices would have a
> leaked reference created by race conditions in dev_ioctl, specifically,
> under SIOCBRADDIF or SIOCBRDELIF operations. The reference leak would

How would it leak a reference, could you elaborate?
The reference is always taken and always released after the call.

> be shown in the periodic unregister_netdevice call, which throws a
> warning and cause Syzbot to report a crash. Upon inspection of the

If you reproduced it, is the device later removed or is it really stuck?

> logic in dev_ioctl, it seems the reference was introduced to ensure
> proper access to the bridge device after rtnl_unlock. and the latter
> function is necessary to maintain the following lock order in any
> bridge related ioctl calls:
> 
> 1) br_ioctl_mutex => 2) rtnl_lock
> 
> Conceptually, though, br_ioctl_mutex could be considered more specific
> than rtnl_lock given their usages, hence swapping their order would be
> a reasonable proposal. This patch changes all related call sites to
> maintain the reversed order of the two locks:
> 
> 1) rtnl_lock => 2) br_ioctl_mutex
> 
> By doing so, the extra reference introduced in dev_ioctl is no longer
> needed, and hence the reference leak bug is now resolved.

IIRC there was no bug, it was a false-positive. The reference is held a 
bit longer but then released, so the device is deleted later.
I might be remembering wrong, but I think I briefly looked into this 
when it was reported. If that's not the case I'd be interested to see
a new report/trace because the bug might be somewhere else.

> 
> Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
> Fixes: ad2f99aedf8f ("net: bridge: move bridge ioctls out of .ndo_do_ioctl")
> Signed-off-by: Ziqi Zhao <astrajoan@yahoo.com>
> ---
>   net/bridge/br_ioctl.c | 4 ----
>   net/core/dev_ioctl.c  | 8 +-------
>   net/socket.c          | 2 ++
>   3 files changed, 3 insertions(+), 11 deletions(-)
> 

Thanks,
  Nik


