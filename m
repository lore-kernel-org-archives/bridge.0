Return-Path: <davem@davemloft.net>
Date: Fri, 22 Jun 2018 07:20:56 +0900 (KST)
Message-Id: <20180622.072056.1223319763674661318.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180621201427.4961-1-garrmcnu@gmail.com>
References: <20180621201427.4961-1-garrmcnu@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net: bridge: fix potential null pointer
 dereference on return from br_port_get_rtnl()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: garrmcnu@gmail.com
Cc: jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

From: Garry McNulty <garrmcnu@gmail.com>
Date: Thu, 21 Jun 2018 21:14:27 +0100

> br_port_get_rtnl() can return NULL if the network device is not a bridge
> port (IFF_BRIDGE_PORT flag not set). br_port_slave_changelink() and
> br_port_fill_slave_info() callbacks dereference this pointer without
> checking. Currently this is not a problem because slave devices always
> set this flag. Add null check in case these conditions ever change.
> 
> Detected by CoverityScan, CID 1339613 ("Dereference null return value")
> 
> Signed-off-by: Garry McNulty <garrmcnu@gmail.com>

I don't think this is reasonable.

The bridge code will never, ever, install a slave that doesn't have
that bit set.  It's the most fundamental aspect of how these objects
are managed.
