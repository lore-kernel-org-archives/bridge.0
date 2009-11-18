From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 18 Nov 2009 10:59:45 +0100
References: <1258497551-25959-1-git-send-email-arnd@arndb.de>
	<1258497551-25959-4-git-send-email-arnd@arndb.de>
	<4B0398D4.8030904@gmail.com>
In-Reply-To: <4B0398D4.8030904@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200911181059.45331.arnd@arndb.de>
Subject: Re: [Bridge] [PATCH 3/3] macvlan: export macvlan mode through
	netlink
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>, Edge Virtual Bridging <evb@yahoogroups.com>, virtualization@lists.linux-foundation.org

On Wednesday 18 November 2009, Eric Dumazet wrote:
> > --- a/drivers/net/macvlan.c
> > +++ b/drivers/net/macvlan.c
> > @@ -33,12 +33,6 @@
> >  
> >  #define MACVLAN_HASH_SIZE    (1 << BITS_PER_BYTE)
> >  
> > -enum macvlan_type {
> > -     MACVLAN_PRIVATE         = 1,
> > -     MACVLAN_VEPA            = 2,
> > -     MACVLAN_BRIDGE          = 4,
> > -};
> 
> I realize you defined MACVLAN_PRIVATE in patch 2, but used MACVLAN_MODE_PRIVATE,
> so patch 2 is not compilable and breaks bisection ?
> 

Hmm, right. I'll fix that up as well.

Thanks,

	Arnd <><
