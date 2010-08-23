Date: Sun, 22 Aug 2010 21:36:32 -0700 (PDT)
Message-Id: <20100822.213632.191389158.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1282280596-18992-1-git-send-email-xiaosuo@gmail.com>
References: <1282280596-18992-1-git-send-email-xiaosuo@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: netfilter: fix a memory leak
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: xiaosuo@gmail.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Changli Gao <xiaosuo@gmail.com>
Date: Fri, 20 Aug 2010 13:03:16 +0800

> nf_bridge_alloc() always reset the skb->nf_bridge, so we should always
> put the old one. skb->nf_bridge->use is initialized in nf_bridge_alloc(),
> so we don't need to initialize it again.
> 
> Signed-off-by: Changli Gao <xiaosuo@gmail.com>

We just memcpy()'d 'nf_bridge' to 'tmp', that why the ->use count is
going to be something other than '1'.  It now has the ->use count that
'nf_bridge' did.

And that is why we must explicitly do atomic_set() on 'tmp'.
