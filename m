Return-Path: <arnd@arndb.de>
MIME-Version: 1.0
References: <00000000000014105005c87cffdc@google.com>
 <20210801131406.1750-1-hdanton@sina.com>
 <6f05c1a9-801a-6174-048a-90688a23941d@nvidia.com>
In-Reply-To: <6f05c1a9-801a-6174-048a-90688a23941d@nvidia.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 2 Aug 2021 10:40:42 +0200
Message-ID: <CAK8P3a0dX1GRDTUp50kW81dD-dUw_=H4sx6tyeCVJea-FOBCQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [syzbot] possible deadlock in br_ioctl_call
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: Hillf Danton <hdanton@sina.com>, Arnd Bergmann <arnd@arndb.de>, Networking <netdev@vger.kernel.org>, syzbot <syzbot+34fe5894623c4ab1b379@syzkaller.appspotmail.com>, bridge@lists.linux-foundation.org, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Aug 2, 2021 at 10:30 AM Nikolay Aleksandrov <nikolay@nvidia.com> wrote:
> On 01/08/2021 16:14, Hillf Danton wrote:
> > On Sun, 01 Aug 2021 03:34:24 -0700
> >> syzbot found the following issue on:
>
> Thanks, but it will need more work, the bridge ioctl calls were divided in two parts
> before: one was deviceless called by sock_ioctl and didn't expect rtnl to be held, the other was
> with a device called by dev_ifsioc() and expected rtnl to be held.
> Then ad2f99aedf8f ("net: bridge: move bridge ioctls out of .ndo_do_ioctl")
> united them in a single ioctl stub, but didn't take care of the locking expectations.
> For sock_ioctl now we acquire  (1) br_ioctl_mutex, (2) rtnl and for dev_ifsioc we
> acquire (1) rtnl, (2) br_ioctl_mutex as the lockdep warning has demonstrated.

Right, sorry about causing problems here.

> That fix above can work if rtnl gets reacquired by the ioctl in the proper switch cases.
> To avoid playing even more locking games it'd probably be best to always acquire and
> release rtnl by the bridge ioctl which will need a bit more work.
>
> Arnd, should I take care of it?

That would be best I think. As you have already analyzed the problem and come
up with a possible solution, I'm sure you will get to a better fix
more quickly than
I would.

Thanks,

       Arnd
