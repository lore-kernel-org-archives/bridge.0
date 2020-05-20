Return-Path: <ivecera@redhat.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589990214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sno0GmQ/eQv+Rs74eF1UQLVprtgb41HhzSqFhBF9Z8s=;
 b=UGc0n8gsFBKCSOZzkOk4vrC5yRgj8I47bMYFEwPk1eVq3HH0ZUZMOxi5kj2WQ77BLn0Gh9
 wusGfxZ10FWb2xiNcJUdQW1X75P1QNr6Krbi+B5XdUz2E0nkwzy4VgbbMfJaYdG4zu9AyC
 qYyQeVs/w7fSX4FZqSwzwn1uBcuffUA=
Date: Wed, 20 May 2020 17:56:47 +0200
From: Ivan Vecera <ivecera@redhat.com>
Message-ID: <20200520175647.32e6f5eb@ceranb>
In-Reply-To: <20200520130923.3196432-3-horatiu.vultur@microchip.com>
References: <20200520130923.3196432-1-horatiu.vultur@microchip.com>
 <20200520130923.3196432-3-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 2/3] switchdev: mrp: Remove the variable
	mrp_ring_state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, kuba@kernel.org, davem@davemloft.net

On Wed, 20 May 2020 13:09:22 +0000
Horatiu Vultur <horatiu.vultur@microchip.com> wrote:

> Remove the variable mrp_ring_state from switchdev_attr because is not
> used anywhere.
> The ring state is set using SWITCHDEV_OBJ_ID_RING_STATE_MRP.
> 
> Fixes: c284b5459008 ("switchdev: mrp: Extend switchdev API to offload MRP")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/net/switchdev.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/net/switchdev.h b/include/net/switchdev.h
> index ae7aeb0d1f9ca..db519957e134b 100644
> --- a/include/net/switchdev.h
> +++ b/include/net/switchdev.h
> @@ -62,7 +62,6 @@ struct switchdev_attr {
>  #if IS_ENABLED(CONFIG_BRIDGE_MRP)
>  		u8 mrp_port_state;			/* MRP_PORT_STATE */
>  		u8 mrp_port_role;			/* MRP_PORT_ROLE */
> -		u8 mrp_ring_state;			/* MRP_RING_STATE */
>  #endif
>  	} u;
>  };

Acked-by: Ivan Vecera <ivecera@redhat.com>

