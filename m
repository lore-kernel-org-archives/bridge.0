Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPt8VrMrbL4mgZExAQeWUV6gm5gc+UY8BvtMWzyjT0k=;
 b=I9dCwdsx+wru7b0+aVrhfHs3QiWq+WRS2lfRdK1jVjAxbf6c7OTNMAI9HaFt9CFuMJQOXhsHBF8+GJbk7D0eRrbCp2H/uSfGyO7XgjA7bwX9Rk5z9wQ6rMKO1YNvUWw56jlg7Y/uU9e4XWp2j/Lb8q1yOw/20DLKDzV2BfOYKs5mkpInDkIp12mj8LFdsHvTWbuorwfxPWkUUS7EIFaS1JSU0yT6sSpnbtqIdbAZQ69XDbaz02QhEphDV+Hy0vsdNtcVqqjfL4YRPF3045Er7gxlAzD0vZ6r6h7Ic1r+n4YfkFdNtTHTkFhs8ai50sN2jhQEtKrhQJoXkxZGHrbjag==
References: <000000000000fdb19d05cb15c938@google.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <4c482173-e2fa-4533-13e0-f8eeb6218eb1@nvidia.com>
Date: Fri, 3 Sep 2021 14:47:11 +0300
In-Reply-To: <000000000000fdb19d05cb15c938@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [syzbot] KASAN: slab-out-of-bounds Read in add_del_if
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: syzbot <syzbot+24b98616278c31afc800@syzkaller.appspotmail.com>, bridge@lists.linux-foundation.org, davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, roopa@nvidia.com, syzkaller-bugs@googlegroups.com

On 03/09/2021 14:42, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-and-tested-by: syzbot+24b98616278c31afc800@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         d15040a3 Merge branch 'bridge-ioctl-fixes'
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> kernel config:  https://syzkaller.appspot.com/x/.config?x=aba0c23f8230e048
> dashboard link: https://syzkaller.appspot.com/bug?extid=24b98616278c31afc800
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> 
> Note: testing is done by a robot and is best-effort only.
> 

#syz fix: net: core: don't call SIOCBRADD/DELIF for non-bridge devices

