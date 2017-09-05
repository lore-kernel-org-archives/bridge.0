Return-Path: <davem@davemloft.net>
Date: Tue, 05 Sep 2017 11:51:56 -0700 (PDT)
Message-Id: <20170905.115156.375758250405492055.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170903144413.21946-1-idosch@mellanox.com>
References: <20170903144413.21946-1-idosch@mellanox.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: switchdev: Use an helper to
 clear forward mark
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: idosch@mellanox.com
Cc: mlxsw@mellanox.com, yotamg@mellanox.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Ido Schimmel <idosch@mellanox.com>
Date: Sun,  3 Sep 2017 17:44:13 +0300

> Instead of using ifdef in the C file.
> 
> Signed-off-by: Ido Schimmel <idosch@mellanox.com>
> Suggested-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Tested-by: Yotam Gigi <yotamg@mellanox.com>

Applied.
