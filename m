Return-Path: <davem@davemloft.net>
Date: Sat, 24 May 2014 13:43:56 -0400 (EDT)
Message-Id: <20140524.134356.992924324126016022.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <53803488.6000400@davidnewall.com>
References: <537CF5A2.3080401@pandora.be>
	<20140521.161841.1806439174351824310.davem@davemloft.net>
	<53803488.6000400@davidnewall.com>
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
Date: Sat, 24 May 2014 15:26:24 +0930

> The patch now reverts the commit and mitigates the original problem by
> ensuring bridge's use of cb does not overlap ip's.

This patch was substantially corrupted by your email client.
