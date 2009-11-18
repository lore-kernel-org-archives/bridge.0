From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 18 Nov 2009 10:48:04 +0100
References: <1258497551-25959-1-git-send-email-arnd@arndb.de>
	<1258497551-25959-3-git-send-email-arnd@arndb.de>
	<4B03974D.3010708@gmail.com>
In-Reply-To: <4B03974D.3010708@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200911181048.04233.arnd@arndb.de>
Subject: Re: [Bridge] [PATCH 2/3] macvlan: implement VEPA and private mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, virtualization@lists.linux-foundation.com, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>, Edge Virtual Bridging <evb@yahoogroups.com>

On Wednesday 18 November 2009, Eric Dumazet wrote:
> > +                     macvlan_broadcast(skb, port, NULL, MACVLAN_MODE_VEPA
> > +                             | MACVLAN_MODE_VEPA | MACVLAN_MODE_BRIDGE);
> 
> typo here, you probably meant MACVLAN_PRIVATE | MACVLAN_VEPA | MACVLAN_BRIDGE 

Well spotted. One last minute-change gone wrong.

Thanks,

	Arnd <><
