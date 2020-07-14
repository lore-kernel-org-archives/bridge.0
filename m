Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=2sXAyH2m1w6ieNvR8PlkbC1BL11rhRAw2ti7qH59UIk=;
 b=Kl2lrL3Abc1ANv3aD2FNLXwqQb4N0zaedWW+aDbDZbBcq+z8HoFtGrJhEQyeNVKJVW
 T1ts0UT2jqRDOVwPTO1wBEJvKRGWtU/gjBbV92tCCDrj5HgYjA7QGmlv5mEFVK3919ll
 rzQEzgwilHSVIiERhHPpxgdROpeCO2i9V1Qm0=
References: <20200714073458.1939574-1-horatiu.vultur@microchip.com>
 <20200714073458.1939574-11-horatiu.vultur@microchip.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <d30bc0f1-b64c-2bf1-fb0f-7ba1f190c4b9@cumulusnetworks.com>
Date: Tue, 14 Jul 2020 16:24:32 +0300
MIME-Version: 1.0
In-Reply-To: <20200714073458.1939574-11-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 10/12] bridge: uapi: mrp: Extend
 MRP_INFO attributes for interconnect status
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, jiri@resnulli.us, ivecera@redhat.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org

On 14/07/2020 10:34, Horatiu Vultur wrote:
> Extend the existing MRP_INFO to return status of MRP interconnect. In
> case there is no MRP interconnect on the node then the role will be
> disabled so the other attributes can be ignored.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/uapi/linux/if_bridge.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> index d840a3e37a37c..c1227aecd38fd 100644
> --- a/include/uapi/linux/if_bridge.h
> +++ b/include/uapi/linux/if_bridge.h
> @@ -243,6 +243,11 @@ enum {
>  	IFLA_BRIDGE_MRP_INFO_TEST_INTERVAL,
>  	IFLA_BRIDGE_MRP_INFO_TEST_MAX_MISS,
>  	IFLA_BRIDGE_MRP_INFO_TEST_MONITOR,
> +	IFLA_BRIDGE_MRP_INFO_I_IFINDEX,
> +	IFLA_BRIDGE_MRP_INFO_IN_STATE,
> +	IFLA_BRIDGE_MRP_INFO_IN_ROLE,
> +	IFLA_BRIDGE_MRP_INFO_IN_TEST_INTERVAL,
> +	IFLA_BRIDGE_MRP_INFO_IN_TEST_MAX_MISS,
>  	__IFLA_BRIDGE_MRP_INFO_MAX,
>  };
>  
> 

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


