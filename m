Date: Thu, 26 May 2005 14:46:38 -0700 (PDT)
Message-Id: <20050526.144638.71091166.davem@davemloft.net>
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050526110425.27590eb8@dxpl.pdx.osdl.net>
References: <20050526110425.27590eb8@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH] (6/6) bridge: receive path optimization
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: shemminger@osdl.org
Cc: netdev@oss.sgi.com, bridge@osdl.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Thu, 26 May 2005 11:04:25 -0700

> This improves the bridge local receive path by avoiding going
> through another softirq.  The bridge receive path is already being called 
> from a netif_receive_skb() there is no point in going through another
> receiveq round trip. 
> 
> Recursion is limited because bridge can never be a port of a bridge
> so handle_bridge() always returns.

I applied all 6 patches, but this one in particular I'd like
to comment on.

Remember all of those bridge netfilter stack usage issues
we have a few months ago?  This could edge us back into
those problems again.
