From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 10 Aug 2009 17:28:15 +0200
References: <D2E118A1E7268F449C469EA2F301D92902BC39B2@exil.voltaire.com>
	<4A7EB0AC.2030104@Voltaire.com> <20090810082037.17b352c2@nehalam>
In-Reply-To: <20090810082037.17b352c2@nehalam>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200908101728.15649.arnd@arndb.de>
Subject: Re: [Bridge] [evb] RE: [PATCH][RFC] net/bridge: add basic VEPA
	support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: "Paul Congdon (UC Davis)" <ptcongdon@ucdavis.edu>, "evb@yahoogroups.com" <evb@yahoogroups.com>, anna.fischer@hp.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, adobriyan@gmail.com, Or Gerlitz <ogerlitz@voltaire.com>, virtualization@lists.linux-foundation.org, davem@davemloft.net

On Monday 10 August 2009, Stephen Hemminger wrote:
> On Sun, 09 Aug 2009 14:19:08 +0300, Or Gerlitz <ogerlitz@voltaire.com> wrote:
> > Looking in macvlan_set_multicast_list() it acts in a similar manner to
> > macvlan_set_mac_address() in the sense that it calls dev_mc_sync(). I
> > assume what's left is to add macvlan_hash_xxx multicast logic to
> > map/unmap multicast groups to what macvlan devices want to receive them
> > and this way the flooding can be removed, correct?
> 
> The device can just flood all multicast packets, since the filtering
> is done on the receive path anyway.

But we'd still have to copy the frames to user space (for both
macvtap and raw packet sockets) and exit from the guest to inject
it into its stack, right?

I guess for multicast heavy workloads, we could save a lot of cycles
by throwing the frames away as early as possible. How common are those
setups in virtual servers though?

	Arnd <><
