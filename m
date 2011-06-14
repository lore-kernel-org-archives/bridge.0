From: Joe Perches <joe@perches.com>
Date: Mon, 13 Jun 2011 19:21:25 -0700
Message-Id: <cover.1308017857.git.joe@perches.com>
Subject: [Bridge] [PATCH net-next 0/2] net: remove casts of void *
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: netfilter@vger.kernel.org, bridge@lists.linux-foundation.org, ebtables-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, ceph-devel@vger.kernel.org, ebtables-devel@lists.sourceforge.net, linux-decnet-user@lists.sourceforge.net

Joe Perches (2):
  net: Remove casts of void *
  net: netfilter: Remove casts of void *

 net/8021q/vlanproc.c                |    2 +-
 net/atm/mpc.c                       |    2 +-
 net/bridge/netfilter/ebtables.c     |    2 +-
 net/ceph/crypto.c                   |    2 +-
 net/decnet/dn_dev.c                 |    2 +-
 net/ipv4/netfilter/arp_tables.c     |   16 ++++++----------
 net/ipv4/netfilter/ip_tables.c      |   13 +++++--------
 net/ipv6/netfilter/ip6_tables.c     |   13 +++++--------
 net/irda/af_irda.c                  |    4 ++--
 net/irda/ircomm/ircomm_tty_attach.c |    2 +-
 net/irda/irda_device.c              |    2 +-
 net/irda/iriap.c                    |    8 ++++----
 net/irda/irlan/irlan_client.c       |   10 +++++-----
 net/irda/irlan/irlan_common.c       |   10 +++++-----
 net/irda/irlan/irlan_eth.c          |    2 +-
 net/irda/irlan/irlan_provider.c     |   10 +++++-----
 net/irda/irqueue.c                  |    4 ++--
 net/irda/irttp.c                    |   18 +++++++++---------
 net/key/af_key.c                    |   20 ++++++++++----------
 net/netfilter/ipset/ip_set_core.c   |    2 +-
 net/netfilter/nf_conntrack_proto.c  |    2 +-
 net/netlabel/netlabel_unlabeled.c   |   10 ++++------
 net/sctp/bind_addr.c                |    2 +-
 net/sctp/input.c                    |    3 +--
 net/sctp/sm_make_chunk.c            |   26 ++++++++++----------------
 net/sctp/sm_sideeffect.c            |    2 +-
 net/sctp/socket.c                   |   16 ++++++++--------
 27 files changed, 93 insertions(+), 112 deletions(-)

-- 
1.7.6.rc0
