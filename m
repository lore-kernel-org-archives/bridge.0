Return-Path: <davem@davemloft.net>
Date: Fri, 08 Jun 2018 20:00:09 -0400 (EDT)
Message-Id: <20180608.200009.1607578368137840763.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <c41fffa00abb9a123039e5509886a0de85274291.1528450455.git.petrm@mellanox.com>
References: <c41fffa00abb9a123039e5509886a0de85274291.1528450455.git.petrm@mellanox.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v2] net: bridge: Fix locking in
	br_fdb_find_port()
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
Date: Fri, 08 Jun 2018 15:11:47 +0200

> Callers of br_fdb_find() need to hold the hash lock, which
> br_fdb_find_port() doesn't do. However, since br_fdb_find_port() is not
> doing any actual FDB manipulation, the hash lock is not really needed at
> all. So convert to br_fdb_find_rcu(), surrounded by rcu_read_lock() /
> _unlock() pair.
> 
> The device pointer copied from inside the FDB entry is then kept alive
> by the RTNL lock, which br_fdb_find_port() asserts.
> 
> Fixes: 4d4fd36126d6 ("net: bridge: Publish bridge accessor functions")
> Signed-off-by: Petr Machata <petrm@mellanox.com>

Applied, thank you.
