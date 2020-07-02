Return-Path: <davem@davemloft.net>
Date: Thu, 02 Jul 2020 14:19:31 -0700 (PDT)
Message-Id: <20200702.141931.1713593201879768648.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200702081307.933471-1-horatiu.vultur@microchip.com>
References: <20200702081307.933471-1-horatiu.vultur@microchip.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 0/3] bridge: mrp: Add support for
 getting the status
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: horatiu.vultur@microchip.com
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, jiri@mellanox.com, kuba@kernel.org

From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Thu, 2 Jul 2020 10:13:04 +0200

> This patch series extends the MRP netlink interface to allow the userspace
> daemon to get the status of the MRP instances in the kernel.
> 
> v3:
>   - remove misleading comment
>   - fix to use correctly the RCU
> 
> v2:
>   - fix sparse warnings

Series applied, thank you.
