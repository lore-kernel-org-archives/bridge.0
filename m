Date: Tue, 19 Oct 2010 00:16:56 +0800
From: Herbert Xu <herbert@gondor.hengli.com.au>
Message-ID: <20101018161656.GA2403@gondor.apana.org.au>
References: <4CB9EBC3.4070905@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CB9EBC3.4070905@freenet.de>
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

On Sat, Oct 16, 2010 at 08:15:31PM +0200, Patrick Ringl wrote:
> Hi,
>
> okay I narrowed down the issue. I watched all function calls of the  
> 'bridge' module with the help of a small systemtap probe of mine. I  
> first traced a timespan where the issue did not occur, then one where it  
> did and composed an intersection of these two:

I can't reproduce this problem here so I'll need your help to
track it down.

Can you see if you can relate the lock-ups to specific events
such as a particular packet being sent through the bridge?

If we can recreate the problem on demand that that helps us to
find the root cause.

You mentioned that you took packet dumps on the system.  If you
can show us the packets through the bridge and its ports when
the problem occurs that would be great.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
