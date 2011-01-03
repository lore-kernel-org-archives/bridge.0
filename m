MIME-Version: 1.0
In-Reply-To: <20101231.111003.48499853.davem@davemloft.net>
References: <1293284490-17114-1-git-send-email-xiaosuo@gmail.com>
	<20101231.111003.48499853.davem@davemloft.net>
From: Changli Gao <xiaosuo@gmail.com>
Date: Mon, 3 Jan 2011 18:44:59 +0800
Message-ID: <AANLkTingFk8qJ8tBwSRCxD=9k-0O3GnTv9V9TbF4N=bg@mail.gmail.com>
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

On Sat, Jan 1, 2011 at 3:10 AM, David Miller <davem@davemloft.net> wrote:
> From: Changli Gao <xiaosuo@gmail.com>
> Date: Sat, 25 Dec 2010 21:41:30 +0800
>
>> Since nf_bridge_maybe_copy_header() may change the length of skb,
>> we should check the length of skb after it to handle the ppoe skbs.
>>
>> Signed-off-by: Changli Gao <xiaosuo@gmail.com>
>
> This is really strange.
>
> packet_length() subtracts VLAN_HLEN from the value it returns, so the
> correct fix seems to be to make this function handle the PPPOE case
> too.
>

It is correct. The actual MTU of 802.1q frame is 4 bytes larger. For
example, the MTU of ethernet is normally 1500, however the actual MTU
of the 802.1Q is 1504.

Please see this patch:
http://git.kernel.org/?p=linux/kernel/git/davem/net-next-2.6.git;a=commitdiff;h=c893b8066c7bf6156e4d760e5acaf4c148e37190;hp=3c0fef0b7d36e5f8d3ea3731a8228102274e3c23

> Otherwise I suspect you have many other functions to fix as well.
>
> I'm not applying this patch.
>



-- 
Regards,
Changli Gao(xiaosuo@gmail.com)
