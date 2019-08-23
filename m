Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=uPi/KDmvISehppyWVNHHSaIi7WFfyu07bTBcLesv7Z8=;
	b=QRL9FeD76Y02CXTIlZwSM32pdG66/rRUt7mDHwUUSk9isuuIXCw/p/Te5iB5sBLmSK
	8TYgq4gM+2p3cWg3ld/PyFk6KAv1K2f5fKhuqZp68Vuy/wkhGErmTjS53fT0vBf7bHxA
	b9DGe/DX0TsZaSPjupbWK/pcPSgMBRUJC2IcLz+v2OiU8PCxgA0zCfSSe2l+LTJseOjv
	u1T1vCGCL/mCbRN2qocZuYlvL3YOGvp1H/bv43pkOLFfRGaYR2IKbClLS+FlDMvAaH1D
	1uRR4MylgU2KKxNJncuuCwKVG5gTwJMcY/4KeDctUn30QYWQzuNuFXnZ/Sunbulz17n5
	/dUA==
References: <1566500850-6247-1-git-send-email-horatiu.vultur@microchip.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e47a318c-6446-71cd-660c-8592037d8166@gmail.com>
Date: Fri, 23 Aug 2019 16:25:02 -0700
MIME-Version: 1.0
In-Reply-To: <1566500850-6247-1-git-send-email-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 0/3] Add NETIF_F_HW_BRIDGE feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, davem@davemloft.net, UNGLinuxDriver@microchip.com, alexandre.belloni@bootlin.com, allan.nielsen@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org

On 8/22/19 12:07 PM, Horatiu Vultur wrote:
> Current implementation of the SW bridge is setting the interfaces in
> promisc mode when they are added to bridge if learning of the frames is
> enabled.
> In case of Ocelot which has HW capabilities to switch frames, it is not
> needed to set the ports in promisc mode because the HW already capable of
> doing that. Therefore add NETIF_F_HW_BRIDGE feature to indicate that the
> HW has bridge capabilities. Therefore the SW bridge doesn't need to set
> the ports in promisc mode to do the switching.

Then do not do anything when the ndo_set_rx_mode() for the ocelot
network device is called and indicates that IFF_PROMISC is set and that
your network port is a bridge port member. That is what mlxsw does AFAICT.

As other pointed out, the Linux bridge implements a software bridge by
default, and because it needs to operate on a wide variety of network
devices, all with different capabilities, the easiest way to make sure
that all management (IGMP, BPDU, etc. ) as well as non-management
traffic can make it to the bridge ports, is to put the network devices
in promiscuous mode. If this is suboptimal for you, you can take
shortcuts in your driver that do not hinder the overall functionality.

> This optimization takes places only if all the interfaces that are part
> of the bridge have this flag and have the same network driver.
> 
> If the bridge interfaces is added in promisc mode then also the ports part
> of the bridge are set in promisc mode.
> 
> Horatiu Vultur (3):
>   net: Add HW_BRIDGE offload feature
>   net: mscc: Use NETIF_F_HW_BRIDGE
>   net: mscc: Implement promisc mode.
> 
>  drivers/net/ethernet/mscc/ocelot.c | 26 ++++++++++++++++++++++++--
>  include/linux/netdev_features.h    |  3 +++
>  net/bridge/br_if.c                 | 29 ++++++++++++++++++++++++++++-
>  net/core/ethtool.c                 |  1 +
>  4 files changed, 56 insertions(+), 3 deletions(-)
> 


-- 
Florian
