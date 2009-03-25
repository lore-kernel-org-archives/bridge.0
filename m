Date: Wed, 25 Mar 2009 14:35:58 -0700 (PDT)
Message-Id: <20090325.143558.35670359.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <2a27d3730903250143u58a3c67dp132a8a5755d50d93@mail.gmail.com>
References: <20090323085122.4c9d21f2@nehalam>
	<20090323.152028.205335400.davem@davemloft.net>
	<2a27d3730903250143u58a3c67dp132a8a5755d50d93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net/bridge: use the maximum hard_header_len of
 ports for bridging device
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: leoli@freescale.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Li Yang <leoli@freescale.com>
Date: Wed, 25 Mar 2009 16:43:53 +0800

> Dynamically adjusting is a good idea, but the rx_alloc_extra can only
> go up not the other way down in your code.

That's not a problem.

> Another thought is that if you re-allocate skb here the driver would
> be saved from checking the headroom in the fastpath, am I right?

You're going to need it for other paths.  There are other kinds of
tunnels et al. that eat that headroom space on you.
