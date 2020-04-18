Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=6JMWvrxsDtQ9ilM24fbTzz0O+inwACTx3EExqxO39Rw=;
 b=OISfzco/7CbYk6TPPk7+8YkHWT0blNPM9zUkdIpx0Qwcb91aQ8KAPlbA1zypwbsk1X
 M2IZSiPc7vIA5BY/c5/Q6XHICoYSPN+TZEBsZEiE7wKPkt75cQFuTxVm90FsDNHQ9upB
 1kIJb0zrVXadd0IP81uRJbDdXjhWJnSwca5u0=
References: <20200414112618.3644-1-horatiu.vultur@microchip.com>
 <20200414112618.3644-3-horatiu.vultur@microchip.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <b53142fb-9dd3-7ead-7978-6ac5172c8791@cumulusnetworks.com>
Date: Sat, 18 Apr 2020 11:49:40 +0300
MIME-Version: 1.0
In-Reply-To: <20200414112618.3644-3-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC net-next v5 2/9] bridge: mrp: Update Kconfig and
	Makefile
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
> Add the option BRIDGE_MRP to allow to build in or not MRP support.
> The default value is N.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/Kconfig  | 12 ++++++++++++
>  net/bridge/Makefile |  2 ++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
> index e4fb050e2078..51a6414145d2 100644
> --- a/net/bridge/Kconfig
> +++ b/net/bridge/Kconfig
> @@ -61,3 +61,15 @@ config BRIDGE_VLAN_FILTERING
>  	  Say N to exclude this support and reduce the binary size.
>  
>  	  If unsure, say Y.
> +
> +config BRIDGE_MRP
> +	bool "MRP protocol"
> +	depends on BRIDGE
> +	default n
> +	help
> +	  If you say Y here, then the Ethernet bridge will be able to run MRP
> +	  protocol to detect loops
> +
> +	  Say N to exclude this support and reduce the binary size.
> +
> +	  If unsure, say N.
> diff --git a/net/bridge/Makefile b/net/bridge/Makefile
> index 49da7ae6f077..9bf3e1be3328 100644
> --- a/net/bridge/Makefile
> +++ b/net/bridge/Makefile
> @@ -25,3 +25,5 @@ bridge-$(CONFIG_BRIDGE_VLAN_FILTERING) += br_vlan.o br_vlan_tunnel.o br_vlan_opt
>  bridge-$(CONFIG_NET_SWITCHDEV) += br_switchdev.o
>  
>  obj-$(CONFIG_NETFILTER) += netfilter/
> +
> +bridge-$(CONFIG_BRIDGE_MRP)	+= br_mrp.o br_mrp_netlink.o br_mrp_switchdev.o
> 

This is not bisectable, if you choose Y here you'll be missing some files.

