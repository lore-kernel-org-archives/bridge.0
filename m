Date: Sat, 26 Dec 2009 11:24:11 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20091226112411.0ab90bd4@nehalam>
In-Reply-To: <200911271157.25748.linux-kernel-owner@vger.kernel.org>
References: <1258497551-25959-1-git-send-email-arnd@arndb.de>
	<200911271157.25748.linux-kernel-owner@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH,
 resend] iproute2/iplink: add macvlan options for bridge mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jens Osterkamp <jens@linux.vnet.ibm.com>, virtualization@linux-foundation.com, Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>, Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Patrick, Mullaney <pmullaney@novell.com>, Edge Virtual Bridging <evb@yahoogroups.com>, Anna

On Fri, 27 Nov 2009 10:57:25 +0000
Arnd Bergmann <arnd@arndb.de> wrote:

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

Okay, applied for next version

-- 
