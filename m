Return-Path: <davem@davemloft.net>
Date: Fri, 26 Jun 2020 13:00:29 -0700 (PDT)
Message-Id: <20200626.130029.89317239393030387.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200626073349.3495526-1-horatiu.vultur@microchip.com>
References: <20200626073349.3495526-1-horatiu.vultur@microchip.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 0/2] bridge: mrp: Extend MRP
 netlink interface with IFLA_BRIDGE_MRP_CLEAR
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: horatiu.vultur@microchip.com
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kuba@kernel.org

From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Fri, 26 Jun 2020 09:33:47 +0200

> This patch series extends MRP netlink interface with IFLA_BRIDGE_MRP_CLEAR.
> To allow the userspace to clear all MRP instances when is started. The
> second patch in the series fix different sparse warnings.
> 
> v3:
>   - add the second patch to fix sparse warnings

These changes are completely unrelated.

The sparse stuff should probably be submitted to 'net'.

And I have to ask why you really need a clear operation.  Routing
daemons come up and see what routes are installed, and update their
internal SW tables to match.  This not only allows efficient restart
after a crash, but it also allows multiple daemons to work
cooperatively as an agent for the same forwarding/routing table.

Your usage model limits one daemon to manage the table and that
limitation is completely unnecessary.

Furthermore, even in a one-daemon scenerio, it's wasteful to throw
away all the work the previous daemon did to load the MRP entries into
the bridge.

Thanks.

