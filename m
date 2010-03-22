Date: Sun, 21 Mar 2010 21:30:49 -0700 (PDT)
Message-Id: <20100321.213049.26945651.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100320115747.GA1849@gondor.apana.org.au>
References: <20100320112049.GU5331@bicker>
	<20100320115747.GA1849@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [patch] bridge: cleanup: remove unused assignment
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: herbert@gondor.apana.org.au
Cc: error27@gmail.com, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, paulmck@linux.vnet.ibm.com, michael-dev@fami-braun.de

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sat, 20 Mar 2010 19:57:47 +0800

> On Sat, Mar 20, 2010 at 02:20:49PM +0300, Dan Carpenter wrote:
>> We never actually use iph again so this assignment can be removed.
>> 
>> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Applied, thanks.
