MIME-Version: 1.0
In-Reply-To: <1249595428-21594-1-git-send-email-arnd@arndb.de>
References: <1249595428-21594-1-git-send-email-arnd@arndb.de>
Date: Fri, 7 Aug 2009 11:35:48 -0600
Message-ID: <de7adc5e0908071035m4898dc5chaf9515d4a70465d@mail.gmail.com>
From: Daniel Robbins <drobbins@funtoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] macvlan: add tap device backend
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, "Fischer,
	Anna" <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Or Gerlitz <ogerlitz@voltaire.com>, Edge Virtual Bridging <evb@yahoogroups.com>, "David S. Miller\"" <davem@davemloft.net>

On Thu, Aug 6, 2009 at 3:50 PM, Arnd Bergmann<arnd@arndb.de> wrote:
> This is a first prototype of a new interface into the network
> stack, to eventually replace tun/tap and the bridge driver
> in certain virtual machine setups.

I have some general questions about the intended use and benefits of
VEPA, from an IT perspective:

In which virtual machine setups and technologies do you forsee this
interface being used?
Is this new interface to be used within a virtual machine or
container, on the master node, or both?
What interface(s) would need to be configured for a single virtual
machine to use VEPA to access the network?
What are the current flexibility, security or performance limitations
of tun/tap and bridge that make this new interface necessary or
beneficial?
Is this new interface useful at all for VPN solutions or is it
*specifically* targeted for connecting virtual machines to the
network?
Is this essentially a bridge with layer-2 isolation for the virtual
machine interfaces built-in? If isolation is provided, what mechanism
is used to accomplish this, and how secure is it?
Does VEPA look like a regular ethernet interface (eth0) on the virtual
machine side?
Are there any associated user-space tools required for configuring a VEPA?

Do you have any HOWTO-style documentation that would demonstrate how
this interface would be used in production? Or a FAQ?

This seems like a very interesting effort but I don't quite have a
good grasp of VEPA's benefits and limitations -- I imagine that others
are in the same boat too.

Best Regards,

Daniel
