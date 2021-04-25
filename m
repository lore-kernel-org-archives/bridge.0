Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEkoeTyegjO1k7XOGHDcE5f8uOI/emx6l/0U6mSNdOM=;
 b=Ux+JF9biQFDKB25CT9H6kTMylUZ2/+nhTstXvlezTPkXdPCooCDpsk81TlaeyJobjQWcLkkz8hcGd4ZeBlLbEei6PeNSZA1DmyGo2kUJSsZSrSjbIgMNkPmhYMNX5NH0Yuom31PMOxIo4Prl4rjJVl8Qz6BK+wwQA8VutBUZFkDv/sHd7M9Z8lCEjGYhzDPaKdXZX/ReR3F03lNc6Exqlerx2GCkx8x01np+tkDrmmU8uziZ1o/C38R130DwYxdoaEN9Y89gKrBz9bM6L7VQQJrdZ8i8EUv5Opt70vvTWbi4z9u2+VejfP8kkBX/xW001tbUBuZnveY5ATWfivwJKw==
References: <20210425155742.30057-1-ap420073@gmail.com>
 <20210425155742.30057-3-ap420073@gmail.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <ed54816f-2591-d8a7-61d8-63b7f49852c1@nvidia.com>
Date: Sun, 25 Apr 2021 19:45:27 +0300
In-Reply-To: <20210425155742.30057-3-ap420073@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net 2/2] net: bridge: fix lockdep
 multicast_lock false positive splat
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net, roopa@nvidia.com, ast@kernel.org, andriin@fb.com, daniel@iogearbox.net, weiwan@google.com, cong.wang@bytedance.com, bjorn@kernel.org, herbert@gondor.apana.org.au, bridge@lists.linux-foundation.org

On 25/04/2021 18:57, Taehee Yoo wrote:
> multicast_lock is a per-interface(bridge) lock.
> This lock can be used recursively because interfaces can be used
> recursively. So, it should use spin_lock_nested() but it doesn't.
> So lockdep false positive splat occurred.
> 
> Some inline helper functions are added.
> These functions internally get 'subclass' variable, which is used as
> parameter of spin_lock_nested() and use spin_lock_nested() with a
> subclass parameter.
> 
> Test commands:
>     ip link add br0 type bridge
>     ip link add bond0 type bond
>     ip link add br1 type bridge
>     ip link set br0 master bond0
>     ip link set bond0 up
>     ip link set bond0 master br1
>     ip link set br0 up
>     ip link set br1 up
>     ip link set br0 type bridge mcast_router 1 mcast_querier 1
>     ip link set br1 type bridge mcast_querier 1 mcast_router 1
> 
> Splat looks like:
> ============================================
> WARNING: possible recursive locking detected
> 5.12.0-rc7+ #855 Not tainted
> --------------------------------------------
> kworker/5:1/56 is trying to acquire lock:
> ffff88810f833000 (&br->multicast_lock){+.-.}-{2:2}, at:
> br_multicast_rcv+0x1484/0x5280 [bridge]
> 
[snip]
> 
> Fixes: eb1d16414339 ("bridge: Add core IGMP snooping support")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
> 
> v2:
>  - No change
> 
>  net/bridge/br_mdb.c           |  12 +--
>  net/bridge/br_multicast.c     | 146 +++++++++++++++++++++-------------
>  net/bridge/br_multicast_eht.c |  18 +++--
>  net/bridge/br_private.h       |  48 +++++++++++
>  4 files changed, 158 insertions(+), 66 deletions(-)
> 

Hi Taehee,
Ugh.. that's just very ugly. :) The setup you've described above is by all means invalid, but
possible unfortunately. The bridge already checks if it's being added as a port to another
bridge, but not through multiple levels of indirection. These locks are completely unrelated
as they're in very different contexts (different devices).

At the very least please push the rcu_read_lock() calls in br_multicast_lock_rcu/_bh() 
as they're needed only to get the nest level for netdev_get_nest_level_rcu(), we don't need
them for the whole code paths (right ?), we could save a few lines in the process and
avoid confusion about the locking rules for those code paths.

I wish there was a better solution.

Thanks,
 Nik

