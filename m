Date: Fri, 02 May 2008 16:53:48 -0700 (PDT)
Message-Id: <20080502.165348.226972498.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20080501134209.3012de69@extreme>
References: <20080501134209.3012de69@extreme>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: forwarding table information for >256
	devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@vyatta.com
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org

From: Stephen Hemminger <shemminger@vyatta.com>
Date: Thu, 1 May 2008 13:42:09 -0700

> The forwarding table binary interface (my bad choice), only exposes the
> port number of the first 8 bits. The bridge code was limited to 256 ports
> at the time, but now the kernel supports up 1024 ports, so the upper bits
> are lost when doing:
>    brctl showmacs
> 
> The fix is to squeeze the extra bits into small hole left in data structure,
> to maintain binary compatiablity.
> 
> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>

At least you had somewhere to stick the high bits :)

Applied, thanks.
