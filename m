From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 24 Nov 2009 00:56:02 +0000
Message-Id: <1259024166-28158-1-git-send-email-arnd@arndb.de>
Subject: [Bridge] [PATCHv2 0/4] macvlan: add vepa and bridge mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Eric Dumazet <eric.dumazet@gmail.com>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Mark Smith <lk-netdev@lk-netdev.nosense.org>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>, Edge Virtual Bridging <evb@yahoogroups.com>, David Miller <davem@davemloft.net>

Second version, all feedback so far addressed, thanks for the
help and interest!

The patch to iproute2 has not changed, so I'm not including
it this time. Patch 4/4 (the netlink interface) is basically
unchanged as well but included for completeness.

The other changes have moved forward a bit, to the point where
I find them a lot cleaner and am more confident in the code
being ready for inclusion. The implementation hardly resembles
Erics original patch now, so I've dropped his signed-off-by.

Please take a look and ack if you are happy so we can get it
into 2.6.33.

---

Version 1 description:
This is based on an earlier patch from Eric Biederman adding
forwarding between macvlans. I extended his approach to
allow the administrator to choose the mode for each macvlan,
and to implement a functional VEPA between macvlan.

Still missing from this is support for communication between
the lower device that the macvlans are based on. This would
be extremely useful but as others have found out before me
requires significant changes not only to macvlan but also
to the common transmit path.

I've tested VEPA operation with the hairpin support
added to the bridge driver by Anna Fischer.

        Arnd <><

Arnd Bergmann (4):
  veth: move loopback logic to common location
  macvlan: cleanup rx statistics
  macvlan: implement bridge, VEPA and private mode
  macvlan: export macvlan mode through netlink

 drivers/net/macvlan.c     |  183 ++++++++++++++++++++++++++++++++++++---------
 drivers/net/veth.c        |   17 +----
 include/linux/if_link.h   |   15 ++++
 include/linux/netdevice.h |    2 +
 net/core/dev.c            |   36 +++++++++
 5 files changed, 204 insertions(+), 49 deletions(-)

