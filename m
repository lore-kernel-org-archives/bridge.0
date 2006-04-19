Date: Wed, 19 Apr 2006 15:59:25 -0700
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20060419155925.7aae7d25.akpm@osdl.org>
In-Reply-To: <20060419.154126.64036253.davem@davemloft.net>
References: <20060419065025.GE17192@random.pao.digeo.com>
	<20060419.154126.64036253.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [RESEND][PATCH] ebtables: clean up vmalloc usage in
 net/bridge/netfilter/ebtables.c
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>
Cc: bdschuym@pandora.be, jchandra@digeo.com, bridge@osdl.org, netdev@vger.kernel.org

"David S. Miller" <davem@davemloft.net> wrote:
>
> An earlier variant of your patch was applied already, included below.
> You'll need to submit the newer parts relative to the current tree.

This is a similar-but-different patch.  It applies OK.

I reviewed it (mostly - it's somewhat non-trivial to do this) and queued it
up and was planning on sending it to you for post-2.6.17.
