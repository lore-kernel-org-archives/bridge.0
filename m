Date: Tue, 27 Feb 2007 09:56:03 -0800 (PST)
Message-Id: <20070227.095603.18302562.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070227095251.0c20eebd@freekitty>
References: <20070221224107.741532037@linux-foundation.org>
	<20070221224255.790379091@linux-foundation.org>
	<20070227095251.0c20eebd@freekitty>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 3+/4] bridge: fix locking of set path cost
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: shemminger@linux-foundation.org
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org, Aji_Srinivas@emc.com

From: Stephen Hemminger <shemminger@linux-foundation.org>
Date: Tue, 27 Feb 2007 09:52:51 -0800

> This change goes with earlier change to get rid of 
> work queue for path cost. Now stp_set_path_cost does its own
> locking. This is to allow it to call br_path_cost() which calls
> ethtool interfaces (might sleep).
> 
> 
> Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>

Applied, thanks Stephen.
