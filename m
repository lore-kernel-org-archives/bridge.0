Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=g2EyQlAqpHZO5s5qqHKlAo11WIHmOqc0rUAshNEUl2M=;
 b=borORmurH5EPJJNnd7Lhs3GNt3l3WCLMftWORGj+zrxXvkT3GSAjiw6lXlF54+CB7A
 W1bX0hSTU76d2ShMudHT/6fsfXkzmfailabgVc3MOvvjv5zJX+ncFsfpxvejGZW84o8z
 3er9h9m7CAECayAUE5SjM+MucvuPrewYpQU2c=
References: <20200714073458.1939574-1-horatiu.vultur@microchip.com>
 <20200714073458.1939574-4-horatiu.vultur@microchip.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <e877ca40-8e84-ed05-f455-369ca43a179d@cumulusnetworks.com>
Date: Tue, 14 Jul 2020 16:14:43 +0300
MIME-Version: 1.0
In-Reply-To: <20200714073458.1939574-4-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 03/12] bridge: mrp: Extend bridge
	interface
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
> This patch adds a new flag(BR_MRP_LOST_IN_CONT) to the net bridge
> ports. This bit will be set when the port lost the continuity of
> MRP_InTest frames.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/linux/if_bridge.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
> index b3a8d3054af0f..6479a38e52fa9 100644
> --- a/include/linux/if_bridge.h
> +++ b/include/linux/if_bridge.h
> @@ -49,6 +49,7 @@ struct br_ip_list {
>  #define BR_ISOLATED		BIT(16)
>  #define BR_MRP_AWARE		BIT(17)
>  #define BR_MRP_LOST_CONT	BIT(18)
> +#define BR_MRP_LOST_IN_CONT	BIT(19)
>  
>  #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
>  
> 

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


