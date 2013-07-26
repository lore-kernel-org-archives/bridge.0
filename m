Return-Path: <linux@baker-net.org.uk>
Message-ID: <51F2F5D4.50409@baker-net.org.uk>
Date: Fri, 26 Jul 2013 23:19:00 +0100
From: Adam Baker <linux@baker-net.org.uk>
MIME-Version: 1.0
References: <1374757046-12463-1-git-send-email-linus.luessing@web.de>
	<1374760580-12920-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1374760580-12920-1-git-send-email-linus.luessing@web.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCHv2] bridge: disable snooping if there is no
	querier
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?B?TGludXMgTMO8c3Npbmc=?= <linus.luessing@web.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, "David S. Miller" <davem@davemloft.net>, Cong Wang <amwang@redhat.com>

On 25/07/13 14:56, Linus Lüssing wrote:
> If there is no querier on a link then we won't get periodic reports and
> therefore won't be able to learn about multicast listeners behind ports,
> potentially leading to lost multicast packets, especially for multicast
> listeners that joined before the creation of the bridge.
>
> These lost multicast packets can appear since c5c23260594
> ("bridge: Add multicast_querier toggle and disable queries by default")
> in particular.
>
> With this patch we are flooding multicast packets if our querier is
> disabled and if we didn't detect any other querier.
>
> A grace period of the Maximum Response Delay of the querier is added to
> give multicast responses enough time to arrive and to be learned from
> before disabling the flooding behaviour again.
>
> Signed-off-by: Linus Lüssing<linus.luessing@web.de>

If the lack of queries if there is no other querier is unacceptable to 
the majority of users (and I believe it is) then surely the sensible 
option is to have the multicast querier toggle enabled by default.

The toggle was added in the first place because the queries were 
reported to be generating issues with certain other equipment. This may 
have been because the queries by default have an invalid IP address 
(although I have been unable to identify what equipment they caused 
problems with so can't verify this).

If the only reason to turn the querier off is because it interferes with 
other equipment then the solution to it being off by default isn't to 
generate queries in some instances even if it is off but rather to turn 
it on by default and only turn it off if it causes problems. If 
multicast_query_use_ifaddr was also enabled by default the the 
likelihood of the querier causing problems elsewhere should be reduced.

Regards

Adam
