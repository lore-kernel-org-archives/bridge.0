Date: Thu, 06 Jan 2011 11:33:20 -0800 (PST)
Message-Id: <20110106.113320.28809548.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <AANLkTikb+o2tXg0uU92Q9foVqX2P49dhJX+umLX=Nhfn@mail.gmail.com>
References: <20110103101533.3f98b311@nehalam>
	<20110103.121336.212692696.davem@davemloft.net>
	<AANLkTikb+o2tXg0uU92Q9foVqX2P49dhJX+umLX=Nhfn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net: bridge: check the length of skb after
 nf_bridge_maybe_copy_header()
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
Date: Wed, 5 Jan 2011 21:37:28 +0800

> On Tue, Jan 4, 2011 at 4:13 AM, David Miller <davem@davemloft.net> wrote:
>> From: Stephen Hemminger <shemminger@linux-foundation.org>
>>>
>>> Because PPPOE happens afterwards and is not part the calculation.
>>> The check should be moved until after skb has reached final form.
>>
>> That works for me.
>>
> 
> So, is my patch acceptable?

Yes, I've applied it, thank you.
