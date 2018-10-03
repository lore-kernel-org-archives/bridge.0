Return-Path: <davem@davemloft.net>
Date: Tue, 02 Oct 2018 22:27:51 -0700 (PDT)
Message-Id: <20181002.222751.1282381500734131142.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181001085701.23295-1-idosch@mellanox.com>
References: <20181001085701.23295-1-idosch@mellanox.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: mcast: Default back to
 multicast enabled state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: idosch@mellanox.com
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, mlxsw@mellanox.com

From: Ido Schimmel <idosch@mellanox.com>
Date: Mon,  1 Oct 2018 11:57:01 +0300

> Commit 13cefad2f2c1 ("net: bridge: convert and rename mcast disabled")
> converted the 'multicast_disabled' field to an option bit named
> 'BROPT_MULTICAST_ENABLED'.
> 
> While the old field was implicitly initialized to 0, the new field is
> not initialized, resulting in the bridge defaulting to multicast
> disabled state and breaking existing applications.
> 
> Fix this by explicitly initializing the option.
> 
> Fixes: 13cefad2f2c1 ("net: bridge: convert and rename mcast disabled")
> Signed-off-by: Ido Schimmel <idosch@mellanox.com>

Applied.
