Return-Path: <davem@davemloft.net>
Date: Wed, 30 May 2018 12:42:15 -0400 (EDT)
Message-Id: <20180530.124215.898586103229215718.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <ff84c00d882dc646a7d69dcbdfe8417b4c0bdf91.1527522008.git.petrm@mellanox.com>
References: <ff84c00d882dc646a7d69dcbdfe8417b4c0bdf91.1527522008.git.petrm@mellanox.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: Lock before br_fdb_find()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: petrm@mellanox.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Petr Machata <petrm@mellanox.com>
Date: Mon, 28 May 2018 17:44:16 +0200

> Callers of br_fdb_find() need to hold the hash lock, which
> br_fdb_find_port() doesn't do. Add the missing lock/unlock
> pair.
> 
> Signed-off-by: Petr Machata <petrm@mellanox.com>

If all of the these uses of br_fdb_find_port() are safe, then it
should use the RCU fdb lookup variant.

So I basically agree with Stephen that this locking doesn't make any
sense.

The lock is needed when you are going to add or delete an FDB entry.

Here we are doing a lookup and returning a device pointer via the FDB
entry found in the lookup.

The RTNL assertion assures that the device returned won't disappear.

If the device can disappear, the spinlock added by this patch doesn't
change that at all.
