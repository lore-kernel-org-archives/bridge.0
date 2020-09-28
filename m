Return-Path: <davem@davemloft.net>
Date: Mon, 28 Sep 2020 12:48:23 -0700 (PDT)
Message-Id: <20200928.124823.1821386447234078357.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200928153002.1697183-1-razor@blackwall.org>
References: <20200928153002.1697183-1-razor@blackwall.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: fdb: don't flush ext_learn
	entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: razor@blackwall.org
Cc: bridge@lists.linux-foundation.org, netdev@vger.kernel.org, roopa@nvidia.com, nikolay@nvidia.com, idosch@nvidia.com

From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 28 Sep 2020 18:30:02 +0300

> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> When a user-space software manages fdb entries externally it should
> set the ext_learn flag which marks the fdb entry as externally managed
> and avoids expiring it (they're treated as static fdbs). Unfortunately
> on events where fdb entries are flushed (STP down, netlink fdb flush
> etc) these fdbs are also deleted automatically by the bridge. That in turn
> causes trouble for the managing user-space software (e.g. in MLAG setups
> we lose remote fdb entries on port flaps).
> These entries are completely externally managed so we should avoid
> automatically deleting them, the only exception are offloaded entries
> (i.e. BR_FDB_ADDED_BY_EXT_LEARN + BR_FDB_OFFLOADED). They are flushed as
> before.
> 
> Fixes: eb100e0e24a2 ("net: bridge: allow to add externally learned entries from user-space")
> Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>

Applied and queued up for -stable, thank you.
