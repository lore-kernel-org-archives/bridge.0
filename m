From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 19 Nov 2009 15:47:03 +0100
References: <1258497551-25959-1-git-send-email-arnd@arndb.de>
	<200911181059.45331.arnd@arndb.de> <4B05586C.5020308@trash.net>
In-Reply-To: <4B05586C.5020308@trash.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200911191547.03509.arnd@arndb.de>
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
To: Patrick McHardy <kaber@trash.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Eric Dumazet <eric.dumazet@gmail.com>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>, Edge Virtual Bridging <evb@yahoogroups.com>, David Miller <davem@davemloft.net>

On Thursday 19 November 2009, Patrick McHardy wrote:
> > +enum ifla_macvlan_mode {
> > +     MACVLAN_MODE_PRIVATE = 1, /* don't talk to other macvlans */
> > +     MACVLAN_MODE_VEPA    = 2, /* talk to other ports through ext bridge */
> > +     MACVLAN_MODE_BRIDGE  = 4, /* talk to bridge ports directly */
> > +};
> 
> Please also keep the enum named something without ifla_ since
> the mode values themselves are not netlink attributes. Just
> macvlan_mode seems fine.

Ok, good. I was unsure on the naming and also changed between MACVLAN_*
and MACVLAN_MODE_* a few times.

Thanks for the clarification,

	Arnd <><
