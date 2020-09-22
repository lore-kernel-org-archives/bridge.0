Return-Path: <davem@davemloft.net>
Date: Mon, 21 Sep 2020 17:38:33 -0700 (PDT)
Message-Id: <20200921.173833.705760978025831604.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200921220709.96107-1-vladimir.oltean@nxp.com>
References: <20200921220709.96107-1-vladimir.oltean@nxp.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: br_vlan_get_pvid_rcu() should
 dereference the VLAN group under RCU
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: vladimir.oltean@nxp.com
Cc: andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, vivien.didelot@gmail.com, pablo@netfilter.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 22 Sep 2020 01:07:09 +0300

> When calling the RCU brother of br_vlan_get_pvid(), lockdep warns:
> 
> =============================
> WARNING: suspicious RCU usage
> 5.9.0-rc3-01631-g13c17acb8e38-dirty #814 Not tainted
> -----------------------------
> net/bridge/br_private.h:1054 suspicious rcu_dereference_protected() usage!
> 
> Call trace:
>  lockdep_rcu_suspicious+0xd4/0xf8
>  __br_vlan_get_pvid+0xc0/0x100
>  br_vlan_get_pvid_rcu+0x78/0x108
> 
> The warning is because br_vlan_get_pvid_rcu() calls nbp_vlan_group()
> which calls rtnl_dereference() instead of rcu_dereference(). In turn,
> rtnl_dereference() calls rcu_dereference_protected() which assumes
> operation under an RCU write-side critical section, which obviously is
> not the case here. So, when the incorrect primitive is used to access
> the RCU-protected VLAN group pointer, READ_ONCE() is not used, which may
> cause various unexpected problems.
> 
> I'm sad to say that br_vlan_get_pvid() and br_vlan_get_pvid_rcu() cannot
> share the same implementation. So fix the bug by splitting the 2
> functions, and making br_vlan_get_pvid_rcu() retrieve the VLAN groups
> under proper locking annotations.
> 
> Fixes: 7582f5b70f9a ("bridge: add br_vlan_get_pvid_rcu()")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Applied and queued up for -stable, thank you.
