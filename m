Return-Path: <davem@redhat.com>
Date: Mon, 26 Feb 2018 15:19:39 -0500 (EST)
Message-Id: <20180226.151939.437417379111753394.davem@redhat.com>
From: David Miller <davem@redhat.com>
In-Reply-To: <20180225195906.26399-1-idosch@mellanox.com>
References: <20180225195906.26399-1-idosch@mellanox.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: Fix VLAN reference count problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: idosch@mellanox.com
Cc: mlxsw@mellanox.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, elena.reshetova@intel.com

From: Ido Schimmel <idosch@mellanox.com>
Date: Sun, 25 Feb 2018 21:59:06 +0200

> When a VLAN is added on a port, a reference is taken on the
> corresponding master VLAN entry. If it does not already exist, then it
> is created and a reference taken.
> 
> However, in the second case a reference is not really taken when
> CONFIG_REFCOUNT_FULL is enabled as refcount_inc() is replaced by
> refcount_inc_not_zero().
> 
> Fix this by using refcount_set() on a newly created master VLAN entry.
> 
> Fixes: 251277598596 ("net, bridge: convert net_bridge_vlan.refcnt from atomic_t to refcount_t")
> Signed-off-by: Ido Schimmel <idosch@mellanox.com>

Applied and queued up for -stable, thanks!
