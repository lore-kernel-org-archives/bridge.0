Date: Thu, 21 Oct 2010 18:07:24 -0500
From: Herbert Xu <herbert@gondor.hengli.com.au>
Message-ID: <20101021230724.GA5170@gondor.apana.org.au>
References: <4CB9EBC3.4070905@freenet.de>
	<20101018161656.GA2403@gondor.apana.org.au>
	<4CBCB014.9080108@freenet.de>
	<20101020061631.GA21679@gondor.apana.org.au>
	<4CC0BC3E.6080906@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CC0BC3E.6080906@freenet.de>
Subject: Re: [Bridge] 2.6.36-rc7: net/bridge causes temporary network I/O
	lockups [2]
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Patrick Ringl <patrick_@freenet.de>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

On Fri, Oct 22, 2010 at 12:18:38AM +0200, Patrick Ringl wrote:
>
> sorry for the late response. I've been using your patch on 2.6.36 and  
> unfortunately, the bogus ipv6 packet is not the cause of the lockups. I  
> have attached two packet dumps (br0 and eth1) again.

OK I see, I had thought that your whole system locked up for
20-30 seconds but it was only the external network responses
that stopped.

I think the problem is your switch.  It appears to purge our
port entry when it receives our general query.

So to work around this, I suggest that you disable the startup
queries through the parameter multicast_startup_query_count.
You can do this either through sysfs or a sufficiently recent
brctl command.

BTW, what brand/model is your switch? If this problem is common
enough then we may have to disable general queries by default.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
