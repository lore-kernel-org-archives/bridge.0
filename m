Return-Path: <davem@davemloft.net>
Date: Thu, 29 May 2014 15:34:24 -0700 (PDT)
Message-Id: <20140529.153424.1310751217059624351.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <53815623.8020506@davidnewall.com>
References: <53803488.6000400@davidnewall.com>
	<20140524.134356.992924324126016022.davem@davemloft.net>
	<53815623.8020506@davidnewall.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Revert 462fb2af9788a82a534f8184abfde31574e1cfa0
 (bridge : Sanitize skb before it enters the IP stack)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davidn@davidnewall.com
Cc: bdschuym@pandora.be, netdev@vger.kernel.org, vyasevich@gmail.com, bridge@lists.linux-foundation.org, fw@strlen.de, stephen@networkplumber.org, bsd@redhat.com, netfilter-devel@vger.kernel.org

From: David Newall <davidn@davidnewall.com>
Date: Sun, 25 May 2014 12:02:03 +0930

> +	pskb_trim_rcsum(skb, len);

You really need to check the return value as this can perform allocations,
GFP_ATOMIC ones in fact.

Also, why are we not bumping the statistics any more?  I didn't see a
discussion of that in this thread.
