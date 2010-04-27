Date: Tue, 27 Apr 2010 15:22:36 -0700 (PDT)
Message-Id: <20100427.152236.73676344.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100427075937.4908.18468.sendpatchset@localhost.localdomain>
References: <20100427075937.4908.18468.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [v4 Patch 1/3] netpoll: add generic support for bridge
 and bonding devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: amwang@redhat.com
Cc: fubar@us.ibm.com, nhorman@tuxdriver.com, netdev@vger.kernel.org, mpm@selenic.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jmoyer@redhat.com, gospo@redhat.com, bonding-devel@lists.sourceforge.net

From: Amerigo Wang <amwang@redhat.com>
Date: Tue, 27 Apr 2010 03:55:41 -0400

> +	if (ndev->priv_flags & IFF_DISABLE_NETPOLL
> +			|| !ndev->netdev_ops->ndo_poll_controller) {

" ||" goes on first line, not second, and second line needs to be indented
properly so that "!ndev->..." matches up with "ndev->priv_flags ..." on
the previous line.
