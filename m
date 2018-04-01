Return-Path: <davem@davemloft.net>
Date: Sun, 01 Apr 2018 14:07:12 -0400 (EDT)
Message-Id: <20180401.140712.1392918167775655287.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <5f5dafaeacbc9e9aa2d969701e510d31ef6e97db.1522521099.git.joe@perches.com>
References: <20180331173643.GD7460@lunn.ch>
	<5f5dafaeacbc9e9aa2d969701e510d31ef6e97db.1522521099.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH V2] treewide/net: Rename eth_stp_addr to
	ether_stp_addr
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: joe@perches.com
Cc: andrew@lunn.ch, f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Sat, 31 Mar 2018 11:34:06 -0700

> eth_stp_addr is not in the same form as the other global ether_<foo>_addr
> addresses like ether_broadcast_addr.
> 
> Convert it treewide.
> 
> Miscellanea:
> 
> o Add comment to the ether_stp_addr define to show it's for spanning-tree
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> 
> V2: Remove gg from initial comment (bad editing)

Joe this was part of a larger series.

Please repost the entire series when you fix a patch contained
in that series, not just the patch that is changing.

Thank you.
