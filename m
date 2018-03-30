Return-Path: <pneira@us.es>
Date: Fri, 30 Mar 2018 11:52:31 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20180330095231.ph5hqdh2pboblhnk@salvia>
References: <c22b7398816c4533a65ff57aaa44629729fc7254.1521630169.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c22b7398816c4533a65ff57aaa44629729fc7254.1521630169.git.joe@perches.com>
Subject: Re: [Bridge] [PATCH] bridge: netfilter: ebt_stp: Use generic
 functions for comparisons
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joe Perches <joe@perches.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, "David S. Miller" <davem@davemloft.net>

On Wed, Mar 21, 2018 at 04:03:22AM -0700, Joe Perches wrote:
> Instead of unnecessary const declarations, use the generic functions to
> save a little object space.
> 
> $ size net/bridge/netfilter/ebt_stp.o*
>    text	   data	    bss	    dec	    hex	filename
>    1250	    144	      0	   1394	    572	net/bridge/netfilter/ebt_stp.o.new
>    1344	    144	      0	   1488	    5d0	net/bridge/netfilter/ebt_stp.o.old

Applied, thanks Joe.
