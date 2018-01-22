Return-Path: <davem@davemloft.net>
Date: Mon, 22 Jan 2018 16:13:35 -0500 (EST)
Message-Id: <20180122.161335.550690891035903469.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180118233745.GA23355@embeddedor.com>
References: <20180118233745.GA23355@embeddedor.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: return boolean instead of integer in
 br_multicast_is_router
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: garsilva@embeddedor.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Thu, 18 Jan 2018 17:37:45 -0600

> Return statements in functions returning bool should use
> true/false instead of 1/0.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Applied to net-next.
