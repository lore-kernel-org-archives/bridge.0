Return-Path: <davem@davemloft.net>
Date: Fri, 22 May 2020 16:17:32 -0700 (PDT)
Message-Id: <20200522.161732.2033826090264059505.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200521231907.3564679-1-horatiu.vultur@microchip.com>
References: <20200521231907.3564679-1-horatiu.vultur@microchip.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 0/3] bridge: mrp: Add br_mrp_unique_ifindex
	function
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: horatiu.vultur@microchip.com
Cc: ivecera@redhat.com, andrew@lunn.ch, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, kuba@kernel.org

From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Thu, 21 May 2020 23:19:04 +0000

> This patch series adds small fixes to MRP implementation.
> The following are fixed in this patch series:
> - now is not allow to add the same port to multiple MRP rings
> - remove unused variable
> - restore the port state according to the bridge state when the MRP instance
>   is deleted
> 
> v2:
>  - use rtnl_dereference instead of rcu_dereference in the first patch

Series applied to net-next, thanks.
