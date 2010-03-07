Date: Sun, 07 Mar 2010 15:27:57 -0800 (PST)
Message-Id: <20100307.152757.142897943.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100306122031.GA15864@gondor.apana.org.au>
References: <20100306111408.GJ4958@bicker>
	<20100306122031.GA15864@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [patch] bridge: cleanup: remove unneed check
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: herbert@gondor.apana.org.au
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, bridge@lists.linux-foundation.org, error27@gmail.com

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sat, 6 Mar 2010 20:20:32 +0800

> On Sat, Mar 06, 2010 at 02:14:09PM +0300, Dan Carpenter wrote:
>> We dereference "port" on the lines immediately before and immediately 
>> after the test so port should hopefully never be null here.
>> 
>> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> Yes this looks correct to me.

Applied.
