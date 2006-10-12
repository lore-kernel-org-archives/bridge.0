Date: Thu, 12 Oct 2006 14:48:15 -0700 (PDT)
Message-Id: <20061012.144815.112851880.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061012112431.0550b252@dxpl.pdx.osdl.net>
References: <20061012112431.0550b252@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: flush forwarding table when device
	carrier off
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: shemminger@osdl.org
Cc: netdev@vger.kernel.org, bridge@osdl.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Thu, 12 Oct 2006 11:24:31 -0700

> Flush the forwarding table when carrier is lost. This helps for
> availability because we don't want to forward to a downed device and
> new packets may come in on other links.
> 
> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
 ...
> +			if (f->is_static & !do_all)
> +				continue;

Applied with "&" changed to "&&" as mentioned elsewhere :)
