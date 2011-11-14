Return-Path: <davem@davemloft.net>
Date: Mon, 14 Nov 2011 00:37:02 -0500 (EST)
Message-Id: <20111114.003702.1097206603722725705.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1320941934-3534-1-git-send-email-holger.brunck@keymile.com>
References: <1320941934-3534-1-git-send-email-holger.brunck@keymile.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net,
	bridge: print log message after state changed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: holger.brunck@keymile.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, shemminger@linux-foundation.org, wolfgang.fritz@keymile.com

From: Holger Brunck <holger.brunck@keymile.com>
Date: Thu, 10 Nov 2011 17:18:54 +0100

> From: Wolfgang Fritz <wolfgang.fritz@keymile.com>
> 
> Function br_log_state writes log message "... entering XXXX state" so it
> should be called after the state has changed and not before.
> 
> Signed-off-by: Wolfgang Fritz <wolfgang.fritz@keymile.com>
> Signed-off-by: Holger Brunck <holger.brunck@keymile.com>

"entering" can roughly mean "about to enter"

The message is therefore appropriately timed as far as I'm concerned.

I'm not applying this patch.

