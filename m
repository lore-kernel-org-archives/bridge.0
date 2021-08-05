Return-Path: <hdanton@sina.com>
From: Hillf Danton <hdanton@sina.com>
Date: Thu,  5 Aug 2021 17:53:52 +0800
Message-Id: <20210805095352.2913-1-hdanton@sina.com>
In-Reply-To: <53339ad0-1028-2660-3241-58ee70d8247a@nvidia.com>
References: <20210805082903.711396-1-razor@blackwall.org>
 <20210805082903.711396-2-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: syzbot+34fe5894623c4ab1b379@syzkaller.appspotmail.com, bridge@lists.linux-foundation.org, arnd@arndb.de, roopa@nvidia.com

On Thu, 5 Aug 2021 12:29:34 +0300 Nikolay Aleksandrov wrote:
> 
> I fixed the bridge side of things,

Thanks for your fix.

> but the unlock/lock suggestion was made first by Hillf.
> I forgot to add:
> 
> Suggested-by: Hillf Danton <hdanton@sina.com>
> 
> +CC Hillf
> 
> Hillf, since the rtnl unlock/lock suggestion was yours feel free to add
> your signed-off-by

I prefer the Cc tag over signed-off-by.
