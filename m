Date: Tue, 19 Jul 2005 14:00:24 -0700 (PDT)
Message-Id: <20050719.140024.131914996.davem@davemloft.net>
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050719135529.GH5031@stusta.de>
References: <20050719135529.GH5031@stusta.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [2.6 patch] BRIDGE_EBT_ARPREPLY must depend on INET
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bunk@stusta.de
Cc: coreteam@netfilter.org, bridge@osdl.org, netdev@vger.kernel.org, netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org, shemminger@osdl.org

From: Adrian Bunk <bunk@stusta.de>
Date: Tue, 19 Jul 2005 15:55:29 +0200

> BRIDGE_EBT_ARPREPLY=y and INET=n results in the following compile error:

Applied, thanks Adrian.
