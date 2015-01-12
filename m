Return-Path: <davem@davemloft.net>
Date: Mon, 12 Jan 2015 16:18:33 -0500 (EST)
Message-Id: <20150112.161833.1081573233180480559.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1420780600-11313-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
References: <1420780600-11313-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 net-next] bridge: Add ability to enable TSO
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: makita.toshiaki@lab.ntt.co.jp
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Date: Fri,  9 Jan 2015 14:16:40 +0900

> Currently a bridge device turns off TSO feature if no bridge ports
> support it. We can always enable it, since packets can be segmented on
> ports by software as well as on the bridge device.
> This will reduce the number of packets processed in the bridge.
> 
> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> ---
> v2: Use an existing helper function.

Applied, thank you.
