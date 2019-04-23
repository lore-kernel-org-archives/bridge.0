Return-Path: <davem@davemloft.net>
Date: Mon, 22 Apr 2019 22:18:22 -0700 (PDT)
Message-Id: <20190422.221822.843228393584991897.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190422093307.10206-1-idosch@mellanox.com>
References: <20190422093307.10206-1-idosch@mellanox.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: Fix possible use-after-free
 when deleting bridge port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: idosch@mellanox.com
Cc: mlxsw@mellanox.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, mmanning@vyatta.att-mail.com

From: Ido Schimmel <idosch@mellanox.com>
Date: Mon, 22 Apr 2019 09:33:19 +0000

> When a bridge port is being deleted, do not dereference it later in
> br_vlan_port_event() as it can result in a use-after-free [1] if the RCU
> callback was executed before invoking the function.
> 
> [1]
 ...
> Fixes: 9c0ec2e7182a ("bridge: support binding vlan dev link state to vlan member bridge ports")
> Signed-off-by: Ido Schimmel <idosch@mellanox.com>
> Cc: Mike Manning <mmanning@vyatta.att-mail.com>

Applied, thanks.
