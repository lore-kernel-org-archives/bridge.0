Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=WYFITaaT1BncDtNMM/RoDBsqGjAFkSfw0DOTJFDWPi0=;
 b=XG1RcADnklId5AQ2Mf+qLBIdYcwOp7cqlnm8mCfZsA020g9D87x2oFiiuDbX8l4oEi
 aIHw/qAdH/QGt1gVsAB6GpbRwjd1em5990YrvZmxYaIqvd9QGjlygV+tl7G2Qnm8xpZO
 uZMgkEYo7wuqbjCqDWAAmjxTzABqX7lNpTe14=
References: <20200414112618.3644-1-horatiu.vultur@microchip.com>
 <20200414112618.3644-4-horatiu.vultur@microchip.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <2b387697-0e4c-7d8a-ae52-d1e8ce1f6bf4@cumulusnetworks.com>
Date: Sat, 18 Apr 2020 11:11:21 +0300
MIME-Version: 1.0
In-Reply-To: <20200414112618.3644-4-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC net-next v5 3/9] bridge: mrp: Expose function
 br_mrp_port_open
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net, jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org, roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, UNGLinuxDriver@microchip.com

On 14/04/2020 14:26, Horatiu Vultur wrote:
> In case the HW is capable to detect when the MRP ring is open or closed. It is
> expected that the network driver will notify the SW that the ring is open or
> closed.
> 
> The function br_mrp_port_open is used to notify the kernel that one of the ports
> stopped receiving MRP_Test frames. The argument 'loc' has a value of '1' when
> the port stopped receiving MRP_Test and '0' when it started to receive MRP_Test.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/linux/mrp_bridge.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 include/linux/mrp_bridge.h
> 
> diff --git a/include/linux/mrp_bridge.h b/include/linux/mrp_bridge.h
> new file mode 100644
> index 000000000000..23d46b356263
> --- /dev/null
> +++ b/include/linux/mrp_bridge.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef _LINUX_MRP_BRIDGE_H
> +#define _LINUX_MRO_BRIDGE_H
> +
> +#include <linux/netdevice.h>
> +
> +/* The drivers are responsible to call this function when it detects that the
> + * MRP port stopped receiving MRP_Test frames or it started to receive MRP_Test.
> + * The argument dev represents the port and loc(Lost of Continuity) has a value
> + * of 1 when it stopped receiving MRP_Test frames and a value of 0 when it
> + * started to receive frames.
> + *
> + * This eventually notify the userspace which is required to react on these
> + * changes.
> + */
> +
> +#if IS_ENABLED(CONFIG_BRIDGE_MRP)
> +int br_mrp_port_open(struct net_device *dev, u8 loc);
> +#else
> +inline int br_mrp_port_open(struct net_device *dev, u8 loc)  {}

static and put {} on their own, check how such functions are defined in other places (e.g. br_private.h)
but in general I think you can drop this function favor of br_ifinfo_notify(). More about that in my review
of next patches.

> +#endif
> +
> +#endif
> 

