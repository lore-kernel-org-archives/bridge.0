MIME-Version: 1.0
In-Reply-To: <20110103.121336.212692696.davem@davemloft.net>
References: <AANLkTingFk8qJ8tBwSRCxD=9k-0O3GnTv9V9TbF4N=bg@mail.gmail.com>
	<20110103.092214.193706896.davem@davemloft.net>
	<20110103101533.3f98b311@nehalam>
	<20110103.121336.212692696.davem@davemloft.net>
From: Changli Gao <xiaosuo@gmail.com>
Date: Wed, 5 Jan 2011 21:37:28 +0800
Message-ID: <AANLkTikb+o2tXg0uU92Q9foVqX2P49dhJX+umLX=Nhfn@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On Tue, Jan 4, 2011 at 4:13 AM, David Miller <davem@davemloft.net> wrote:
> From: Stephen Hemminger <shemminger@linux-foundation.org>
>>
>> Because PPPOE happens afterwards and is not part the calculation.
>> The check should be moved until after skb has reached final form.
>
> That works for me.
>

So, is my patch acceptable?

-- 
Regards,
Changli Gao(xiaosuo@gmail.com)
