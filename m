Return-Path: <vyasevic@redhat.com>
From: Vlad Yasevich <vyasevic@redhat.com>
Date: Wed, 26 Mar 2014 12:14:48 -0400
Message-Id: <1395850490-27628-1-git-send-email-vyasevic@redhat.com>
Subject: [Bridge] [PATCH v2 net 0/2] bridge: Fix forwarding of 8021AD frames
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Vlad Yasevich <vyasevic@redhat.com>, shemminger@vyatta.com, bridge@lists.linux-foundation.org

Bridge has its own way to deterine if the packet is forwardable and it doesn't
support 8021ad tags correctly.  Instead just allow bridge to use an
existing is_skb_forwardable() function.

v2: Fix missing hunk in patch 2/2 to make it build.


Vlad Yasevich (2):
  net: Allow modules to use is_skb_forwardable
  bridge: use is_skb_forwardable in forward path

 include/linux/netdevice.h | 1 +
 net/bridge/br_forward.c   | 9 ++-------
 net/core/dev.c            | 3 ++-
 3 files changed, 5 insertions(+), 8 deletions(-)

-- 
1.8.5.3

