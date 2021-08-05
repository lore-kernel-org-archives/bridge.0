Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAqOag5PAh66I8vpti32dYOZs6rrHwP+fodCPAXcCOM=;
 b=GJWF4U0XO4nnYzt+m9BjggFBUZVi6irZV9dtbrv8npKa9hZHJPRA3Dx2imTYytQK8akIl24XrQuh938wPpPLo/Hk9sIbEzw5F6dizbm/HPvPcbtY1yPVY92pFTc9acjqhioYcEuRtgCXQ4+lIZZfK13jbVVPcXdKrmufdR5RUd5CpF8FRQf/h+vlJsJQMFxeRELE+FBjY4LmfH7xpiAE4qc+8mNTMu5y9i5RyO+Y+VUMj3/46mTIf/3EYrOZKFVeCpPkWNITTcoceaVeHgvZQoCwCX3tF44KbDIe3PkXg/MROUuSSu4c1VcR4BNiTsTC37gpYINPTvkwV2j3V9XBmQ==
References: <20210805082903.711396-1-razor@blackwall.org>
 <20210805082903.711396-2-razor@blackwall.org>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <53339ad0-1028-2660-3241-58ee70d8247a@nvidia.com>
Date: Thu, 5 Aug 2021 12:29:34 +0300
In-Reply-To: <20210805082903.711396-2-razor@blackwall.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 1/3] net: bridge: fix ioctl locking
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: syzbot+34fe5894623c4ab1b379@syzkaller.appspotmail.com, bridge@lists.linux-foundation.org, Hillf Danton <hdanton@sina.com>, arnd@arndb.de, roopa@nvidia.com

On 05/08/2021 11:29, Nikolay Aleksandrov wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> Before commit ad2f99aedf8f ("net: bridge: move bridge ioctls out of
> .ndo_do_ioctl") the bridge ioctl calls were divided in two parts:
> one was deviceless called by sock_ioctl and didn't expect rtnl to be held,
> the other was with a device called by dev_ifsioc() and expected rtnl to be
> held. After the commit above they were united in a single ioctl stub, but
> it didn't take care of the locking expectations.
> For sock_ioctl now we acquire  (1) br_ioctl_mutex, (2) rtnl
> and for dev_ifsioc we acquire  (1) rtnl,           (2) br_ioctl_mutex
> 
> The fix is to get a refcnt on the netdev for dev_ifsioc calls and drop rtnl
> then to reacquire it in the bridge ioctl stub after br_ioctl_mutex has
> been acquired. That will avoid playing locking games and make the rules
> straight-forward: we always take br_ioctl_mutex first, and then rtnl.
> 
> Reported-by: syzbot+34fe5894623c4ab1b379@syzkaller.appspotmail.com
> Fixes: ad2f99aedf8f ("net: bridge: move bridge ioctls out of .ndo_do_ioctl")
> Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> ---
>  net/bridge/br_if.c    |  4 +---
>  net/bridge/br_ioctl.c | 37 ++++++++++++++++++++++++-------------
>  net/core/dev_ioctl.c  |  7 ++++++-
>  3 files changed, 31 insertions(+), 17 deletions(-)
> 
[snip]

I fixed the bridge side of things, but the unlock/lock suggestion was made first by Hillf.
I forgot to add:

Suggested-by: Hillf Danton <hdanton@sina.com>

+CC Hillf

Hillf, since the rtnl unlock/lock suggestion was yours feel free to add
your signed-off-by

Thanks,
 Nik
