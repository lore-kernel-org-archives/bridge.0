Date: Tue, 03 Jan 2006 14:36:29 -0800 (PST)
Message-Id: <20060103.143629.73563903.davem@davemloft.net>
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060103104157.1512f5fa@dxpl.pdx.osdl.net>
References: <20051221132527.1ef12bcf@dxpl.pdx.osdl.net>
	<20051221.195107.113618698.davem@davemloft.net>
	<20060103104157.1512f5fa@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH] BRIDGE: Fix faulty check in
 br_stp_recalculate_bridge_id()
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: shemminger@osdl.org
Cc: mikukkon@iki.fi, bridge@osdl.org, linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Tue, 3 Jan 2006 10:41:57 -0800

> One of the conversions from memcmp to compare_ether_addr is incorrect.
> We need to do relative comparison to determine min MAC address to
> use in bridge id. 
> 
> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

Applied, thanks.

Is this -stable material?
