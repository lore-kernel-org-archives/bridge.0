Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=0hvg8EcOFy1hV2UV4sVHiLXXFhFD6hDENq5iidN2YYU=;
	b=qSY3vN9kfRyMrR0s+KtgMC54iFwLVcFRzH9+NcDJCePlL2a8xUzCkuImtzreATJyvq
	VihcLboVrvBQOosXlNGS6P7BXq2Gk+Ex82CskP8ZyojkWoR2uLDDKGgbHphzjV/80Yxe
	AhGH/HKzjwSR/aJx8544cJIpvmePOx+WDhSBkvVL4mGJeNyk3VsmcLwvtaP8ftry8HDK
	42/Ppc2RMtFvE2Xkh55152WJnXm6Z88+JqmnNU7Am+AaErt7G1yd/1EMiJJtUlOvXmNX
	eiEmzTVNUC7P4yvfpA89otsB11yyAPDnF6ueut9V7AROStf57qPAOonQfx8vP7PHsNdf
	gHfg==
Date: Sat, 24 Aug 2019 08:05:37 -0400
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20190824080537.5ce7083d@xps13.local.tld>
In-Reply-To: <1566500850-6247-1-git-send-email-horatiu.vultur@microchip.com>
References: <1566500850-6247-1-git-send-email-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: alexandre.belloni@bootlin.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, allan.nielsen@microchip.com, davem@davemloft.net

On Thu, 22 Aug 2019 21:07:27 +0200
Horatiu Vultur <horatiu.vultur@microchip.com> wrote:

> Current implementation of the SW bridge is setting the interfaces in
> promisc mode when they are added to bridge if learning of the frames is
> enabled.
> In case of Ocelot which has HW capabilities to switch frames, it is not
> needed to set the ports in promisc mode because the HW already capable of
> doing that. Therefore add NETIF_F_HW_BRIDGE feature to indicate that the
> HW has bridge capabilities. Therefore the SW bridge doesn't need to set
> the ports in promisc mode to do the switching.
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

IMHO there are already enough nerd knobs in bridge to support this.
If you hardware can't do real bridging, it is only doing MACVLAN so that
is what you should support instead.
