Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=1wjTQ8kSFEtHQTXiFNn5xmo0XMmmUMj65r7WNBjKJEs=;
 b=NXWy+rZceFxcX4Q1BJl0H6GFSnc8ZUNALstxT4T+qvd8/wDRTj6ZJJvxrBNPnQNrqv
 yxCIbphz2+7r3DPHzNv2pmmsU3LBsO8/U8o4rR5OyMC7a/0ye+6Wx/LpBfCxCrhkLoYC
 qjxGOvLw3i7MDYFX+YK+9yRHVnuKJWeB0zWeU=
References: <20200420150947.30974-1-horatiu.vultur@microchip.com>
 <20200420150947.30974-5-horatiu.vultur@microchip.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <cc388b70-701c-4600-791b-8170683a7666@cumulusnetworks.com>
Date: Mon, 20 Apr 2020 20:30:34 +0300
MIME-Version: 1.0
In-Reply-To: <20200420150947.30974-5-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 04/13] bridge: mrp: Expose function
 br_mrp_port_open
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net, jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org, roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On 20/04/2020 18:09, Horatiu Vultur wrote:
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
>  include/linux/mrp_bridge.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 include/linux/mrp_bridge.h
> 
> diff --git a/include/linux/mrp_bridge.h b/include/linux/mrp_bridge.h
> new file mode 100644
> index 000000000000..61c1f0d395c7
> --- /dev/null
> +++ b/include/linux/mrp_bridge.h
> @@ -0,0 +1,27 @@
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
> + * Needs to be called with rcu_read_lock().
> + *
> + * This eventually notify the userspace which is required to react on these
> + * changes.
> + */
> +
> +#if IS_ENABLED(CONFIG_BRIDGE_MRP)
> +int br_mrp_port_open(struct net_device *dev, u8 loc);
> +#else
> +static inline int br_mrp_port_open(struct net_device *dev, u8 loc)
> +{
> +}
> +#endif
> +
> +#endif
> 

I see that in order to pass this "loc" to br_ifinfo_notify() you add a new port variable,
but it's a boolean, so you can just use the port flags for it which will simplify things a lot
and remove some ifdefs along the way. And please rename it to something longer (so it's easier
to get what it does).

One question - now that it's always sent to user-space as IFLA_BRPORT_MRP_RING_OPEN attribute
wouldn't it be a problem, or is it read as a current state?
I mean you'll receive that attribute about a port even if you get a completely unrelated to MRP
notification (e.g. about a vlan change).

Thanks,
 Nik
