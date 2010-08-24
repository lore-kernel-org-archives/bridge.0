Date: Mon, 23 Aug 2010 20:15:20 -0700 (PDT)
Message-Id: <20100823.201520.90820084.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <4C72CD1C.7020901@pandora.be>
References: <1282539806-25496-1-git-send-email-xiaosuo@gmail.com>
	<4C72CD1C.7020901@pandora.be>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2] bridge: netfilter: fix a memory leak
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bdschuym@pandora.be
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, xiaosuo@gmail.com

From: Bart De Schuymer <bdschuym@pandora.be>
Date: Mon, 23 Aug 2010 21:33:48 +0200

> Looks correct to me.
> 
> Signed-off-by: Bart De Schuymer <bdschuym@pandora.be>

Bart, please do not top post.

> Changli Gao schreef:
>> nf_bridge_alloc() always reset the skb->nf_bridge, so we should always
>> put the old one.
>>
>> Signed-off-by: Changli Gao <xiaosuo@gmail.com>

Applied, thanks everyone.
