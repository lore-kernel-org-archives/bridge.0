Date: Mon, 7 Mar 2011 19:08:47 -0600
From: Adam Majer <adamm@zombino.com>
Message-ID: <20110308010847.GA2316@mira.lan.galacticasoftware.com>
References: <1649722795.14144.1299480074110.JavaMail.root@tahiti.vyatta.com>
	<4D748CC3.8060603@gmail.com> <20110307103406.27330529@nehalam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110307103406.27330529@nehalam>
Subject: Re: [Bridge] [PATCH] bridge: control carrier based on ports online
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: Jay Vosburgh <fubar@us.ibm.com>, "Pekka Savola (ipv6)" <pekkas@netcore.fi>, Nicolas de =?iso-8859-1?Q?Peslo=FCan?= <nicolas.2p.debian@gmail.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, James Morris <jmorris@namei.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, "David S. Miller" <davem@davemloft.net>

On Mon, Mar 07, 2011 at 10:34:06AM -0800, Stephen Hemminger wrote:
> This makes the bridge device behave like a physical device.
> In earlier releases the bridge always asserted carrier. This
> changes the behavior so that bridge device carrier is on only
> if one or more ports are in the forwarding state. This
> should help IPv6 autoconfiguration, DHCP, and routing daemons.

Yes, your patch does fix issues with IPv6 autoconfiguration in bridged
networks completely. I've just tested it with and without STP. IPv4
DHCP continues to function correctly. It is definitely much cleaner
solution than my hack.

IPv6 autoconfiguration code already checks if NETDEV_CHANGE or
NETDEV_UP represent a device that is ready to transmit data before
attempting to configure the interface. No additional changes required
there. This patch should also fix duplicate address detection of
linklocal address on bridged interfaces that I believe was also broken
prior to this patch.

If you want, you can add

Tested-By: Adam Majer <adamm@zombino.com>


Cheers,
- Adam
