From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 18 Dec 2009 14:45:07 +0100
References: <1258497551-25959-1-git-send-email-arnd@arndb.de>
	<1258497551-25959-5-git-send-email-arnd@arndb.de>
In-Reply-To: <1258497551-25959-5-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200912181445.07756.arnd@arndb.de>
Subject: Re: [Bridge] [PATCH] iplink: add macvlan options for bridge mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, Anna Fischer <anna.fischer@hp.com>
Cc: virtualization@linux-foundation.com, Herbert Xu <herbert@gondor.apana.org.au>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>

Ping!

Stephen, I submitted this twice but never heard back from you.
The changes to macvlan have been merged in 2.6.33-rc1, so it
would be good to have this included as well.

	Arnd

On Tuesday 17 November 2009, Arnd Bergmann wrote:
> Macvlan can now optionally support forwarding between its
> ports, if they are in "bridge" mode. This adds support
> for this option to "ip link add", "ip link set" and "ip
> -d link show".
> 
> The default mode in the kernel is now "vepa" mode, meaning
> "virtual ethernet port aggregator". This mode is used
> together with the "hairpin" mode of an ethernet bridge
> that the parent of the macvlan device is connected to.
> All frames still get sent out to the external interface,
> but the adjacent bridge is able to send them back on
> the same wire in hairpin mode, so the macvlan ports
> are able to see each other, which the bridge can be
> configured to monitor and control traffic between
> all macvlan instances. Multicast traffic coming in
> from the external interface is checked for the source
> MAC address and only delivered to ports that have not
> yet seen it.
> 
> In bridge mode, macvlan will send all multicast traffic
> to other interfaces that are also in bridge mode but
> not to those in vepa mode, which get them on the way
> back from the hairpin.
> 
> The third supported mode is "private", which prevents
> communication between macvlans even if the adjacent
> bridge is in hairpin mode. This behavior is closer to
> the original implementation of macvlan but stricly
> maintains isolation.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

