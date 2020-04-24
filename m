Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=Gx9hNKg0l/txCpQUT0mCibQINePXOppVz6cuR/nn8AA=;
 b=a5yL4+q452l7JxoNgJo2bhKexP37/cRH1AQbPNfIZSiGptvZXs8q+gLLzv+J8bCwgP
 wUe0NXRCO+V7B6dinuZT8ts9HB26TQv6R+ai4l3w+IiZ9kBnKW9TtG0LY5VjJh+VlJDE
 Pz8EUD4+EsG1qkecWUklJ2Ysmurt3CyRnGygE=
References: <20200422161833.1123-1-horatiu.vultur@microchip.com>
 <20200422161833.1123-2-horatiu.vultur@microchip.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <2969c2e1-2ed4-87fd-7053-f70a3f923567@cumulusnetworks.com>
Date: Fri, 24 Apr 2020 16:11:16 +0300
MIME-Version: 1.0
In-Reply-To: <20200422161833.1123-2-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 01/11] bridge: uapi: mrp: Add mrp
	attributes.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net, jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org, roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On 22/04/2020 19:18, Horatiu Vultur wrote:
> Add new nested netlink attribute to configure the MRP. These attributes are used
> by the userspace to add/delete/configure MRP instances and by the kernel to
> notify the userspace when the MRP ring gets open/closed. MRP nested attribute
> has the following attributes:
> 
> IFLA_BRIDGE_MRP_INSTANCE - the parameter type is br_mrp_instance which contains
>   the instance id, and the ifindex of the two ports. The ports can't be part of
>   multiple instances. This is used to create/delete MRP instances.
> 
> IFLA_BRIDGE_MRP_PORT_STATE - the parameter type is u32. Which can be forwarding,
>   blocking or disabled.
> 
> IFLA_BRIDGE_MRP_PORT_ROLE - the parameter type is br_mrp_port_role which
>   contains the instance id and the role. The role can be primary or secondary.
> 
> IFLA_BRIDGE_MRP_RING_STATE - the parameter type is br_mrp_ring_state which
>   contains the instance id and the state. The state can be open or closed.
> 
> IFLA_BRIDGE_MRP_RING_ROLE - the parameter type is br_mrp_ring_role which
>   contains the instance id and the ring role. The role can be MRM or MRC.
> 
> IFLA_BRIDGE_MRP_START_TEST - the parameter type is br_mrp_start_test which
>   contains the instance id, the interval at which to send the MRP_Test frames,
>   how many test frames can be missed before declaring the ring open and the
>   period which represent for how long to send the test frames.
> 
> Also add the file include/uapi/linux/mrp_bridge.h which defines all the types
> used by MRP that are also needed by the userpace.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/uapi/linux/if_bridge.h  | 42 +++++++++++++++++
>  include/uapi/linux/if_ether.h   |  1 +
>  include/uapi/linux/mrp_bridge.h | 84 +++++++++++++++++++++++++++++++++
>  3 files changed, 127 insertions(+)
>  create mode 100644 include/uapi/linux/mrp_bridge.h
> 

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

