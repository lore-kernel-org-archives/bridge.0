Return-Path: <davem@davemloft.net>
Date: Wed, 05 Dec 2012 16:25:33 -0500 (EST)
Message-Id: <20121205.162533.472441435180068286.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1354691991-18499-1-git-send-email-amwang@redhat.com>
References: <20121204084431.72f9084c@nehalam.linuxnetplumber.net>
	<1354691991-18499-1-git-send-email-amwang@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3] bridge: implement multicast fast
	leave
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: amwang@redhat.com
Cc: netdev@vger.kernel.org, shemminger@vyatta.com, bridge@lists.linux-foundation.org, herbert@gondor.hengli.com.au

From: Cong Wang <amwang@redhat.com>
Date: Wed,  5 Dec 2012 15:19:51 +0800

> V3: make it a flag
> V2: make the toggle per-port
> 
> Fast leave allows bridge to immediately stops the multicast
> traffic on the port receives IGMP Leave when IGMP snooping is enabled,
> no timeouts are observed.
> 
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Stephen Hemminger <shemminger@vyatta.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Cong Wang <amwang@redhat.com>

Applied.
