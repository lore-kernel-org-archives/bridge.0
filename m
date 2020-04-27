Return-Path: <sergei.shtylyov@cogentembedded.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=UiB8Sz4YfAvbHdDR7SWAyV+bAGQjoJnQnsYXO+tF1Jw=;
 b=P/lpHRdZrhWFk5hitl3BMEiBmG5w4opF0Oalc7Vj/JoILMg5y36ElUeI+8OqWPcNzr
 YghOBqFT5ur+fYkEaQP1DXOdxTjngMaA6419pL6Wo8lYNLTZ/Q1+lF20AKOJHiG6E5r6
 zs44vu2HOocwuzkTfmPJMGGoYFkG5TIGY8zGtoOoboq0uxJnQ5ivErKgaCD+EBfQ8hck
 ep5kHSOtNdPFTS8mI1crRmYKZ8zFxpL+hk51g4gnMMNrmYjI9TtYVcSodtRa2/bJlUtL
 wAkkoDHecXlBGiqiOuiHjlOXNxx/FvMzbAirJDyJhkyH6h5Ay0rzua9icwCF7VuqFAPE
 ioOw==
References: <20200426132208.3232-1-horatiu.vultur@microchip.com>
 <20200426132208.3232-3-horatiu.vultur@microchip.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <ea7b30af-57b7-4cad-b73a-a13cf762c742@cogentembedded.com>
Date: Mon, 27 Apr 2020 12:46:47 +0300
MIME-Version: 1.0
In-Reply-To: <20200426132208.3232-3-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 02/11] bridge: mrp: Update Kconfig
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, nikolay@cumulusnetworks.com, davem@davemloft.net, jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org, roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org

Hello!

On 26.04.2020 16:21, Horatiu Vultur wrote:

> Add the option BRIDGE_MRP to allow to build in or not MRP support.
> The default value is N.
> 
> Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>   net/bridge/Kconfig | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
> index e4fb050e2078..51a6414145d2 100644
> --- a/net/bridge/Kconfig
> +++ b/net/bridge/Kconfig
> @@ -61,3 +61,15 @@ config BRIDGE_VLAN_FILTERING
>   	  Say N to exclude this support and reduce the binary size.
>   
>   	  If unsure, say Y.
> +
> +config BRIDGE_MRP
> +	bool "MRP protocol"
> +	depends on BRIDGE
> +	default n

    Not needed, N is the default default. :-)

[...]

MBR, Sergei
