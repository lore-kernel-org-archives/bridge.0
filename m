Date: Tue, 16 Mar 2010 21:27:21 -0700 (PDT)
Message-Id: <20100316.212721.40843802.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100302153209.74742a96@nehalam>
References: <20100302095831.151c8bb5@nehalam>
	<1267553173.2839.9.camel@edumazet-laptop>
	<20100302153209.74742a96@nehalam>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: per-cpu packet statistics (v3)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@vyatta.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, eric.dumazet@gmail.com

From: Stephen Hemminger <shemminger@vyatta.com>
Date: Tue, 2 Mar 2010 15:32:09 -0800

> The shared packet statistics are a potential source of slow down
> on bridged traffic. Convert to per-cpu array, but only keep those
> statistics which change per-packet.
> 
> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>

Applied.
