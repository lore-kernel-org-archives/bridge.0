Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=G2uXfV2zQ6YcJDE/jPT/znzd8EhGd4IlBIY8GlaqseU=;
 b=boaoa6QxxZN3lCBv5P/sBvwVlfHCoZjiR0gPpaqf3dyoRwSHGfxFtQStzuk++J/6To
 4n5I0Jvx6fc19Pv+X2xswYOFxMK3keWFmkmu4j8r60wq9yJeXq1wqyMxR2WUlB0Fv38R
 Sk68/ReojCiQxUbN0FG1hf2ZUMLZLX0F3+EAQ=
References: <20200422161833.1123-1-horatiu.vultur@microchip.com>
 <20200422161833.1123-3-horatiu.vultur@microchip.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <cfbeabee-8df5-3a50-b43f-8833723b8ed9@cumulusnetworks.com>
Date: Fri, 24 Apr 2020 16:11:18 +0300
MIME-Version: 1.0
In-Reply-To: <20200422161833.1123-3-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 02/11] bridge: mrp: Update Kconfig
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
> Add the option BRIDGE_MRP to allow to build in or not MRP support.
> The default value is N.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/Kconfig | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
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
> 

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

