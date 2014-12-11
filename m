Return-Path: <davem@davemloft.net>
Date: Wed, 10 Dec 2014 21:13:06 -0500 (EST)
Message-Id: <20141210.211306.1331714594864472914.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <5488FBBC.2050105@lab.ntt.co.jp>
References: <1418179394-4470-2-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<20141210.145047.1148744559031706340.davem@davemloft.net>
	<5488FBBC.2050105@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: Add ability to always enable
	TSO/UFO
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: makita.toshiaki@lab.ntt.co.jp
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Date: Thu, 11 Dec 2014 11:04:44 +0900

> On 2014/12/11 4:50, David Miller wrote:
>> From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
>> Date: Wed, 10 Dec 2014 11:43:14 +0900
>> 
>>> -	features &= ~NETIF_F_ONE_FOR_ALL;
>>> +	features &= ~NETIF_F_ONE_FOR_ALL | NETIF_F_GSO_SOFTWARE;
>> 
>> I don't think this is the expression you intend to use.
> 
> Thank you, but this is really my intended expression.
> 
> "features &= ~NETIF_F_ONE_FOR_ALL" drops all of ONE_FOR_ALL bits
> including GSO_SOFTWARE.
> But I want to leave GSO_SOFTWARE bits here.

It is clearer to say this as:

	~(NETIF_F_ONE_FOR_ALL & ~NETIF_F_GSO_SOFTWARE)

Or create a new NETIF_F_* macro to express this idea succinctly.
