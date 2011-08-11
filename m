Date: Thu, 11 Aug 2011 05:53:33 -0700 (PDT)
Message-Id: <20110811.055333.1199553373699762518.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1313063978-29400-1-git-send-email-julia@diku.dk>
References: <1313063978-29400-1-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net/bridge/netfilter/ebtables.c: use available
 error handling code
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: julia@diku.dk
Cc: coreteam@netfilter.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, netfilter@vger.kernel.org, bart.de.schuymer@pandora.be, netfilter-devel@vger.kernel.org

From: Julia Lawall <julia@diku.dk>
Date: Thu, 11 Aug 2011 13:59:38 +0200

> From: Julia Lawall <julia@diku.dk>
> 
> Free the locally allocated table and newinfo as done in adjacent error
> handling code.
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>

Applied.
