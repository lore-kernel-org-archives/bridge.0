Date: Wed, 07 Mar 2007 16:12:03 -0800 (PST)
Message-Id: <20070307.161203.26532896.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070307160355.0e27f425@dxpl.pdx.osdl.net>
References: <20070307160355.0e27f425@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: adding new device to bridge should
	enable if up
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: shemminger@linux-foundation.org
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org

From: Stephen Hemminger <shemminger@linux-foundation.org>
Date: Wed, 7 Mar 2007 16:03:55 -0800

> One change introduced by the workqueue removal patch is that adding an
> interface that is up to a bridge which is also up does not ever call
> br_stp_enable_port(), leaving the port in DISABLED state until we do
> ifconfig down and up or link events occur.
> 
> The following patch to the br_add_if function fixes it.
> This is a regression introduced in 2.6.21.
> 
> Submitted-by: Aji_Srinivas@emc.com
> Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>

Applied, but:

> +	if ((dev->flags & IFF_UP) && netif_carrier_ok(dev) &&
> +	    (br->dev->flags & IFF_UP)) 

I had to fix up the trailing whitespace on that second line.

Please use "git apply --check --whitespace=error-all"
or similar to validate the patches you send me.

Thanks.
