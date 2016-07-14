Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=M3f/pdKKtSDY0roxU4oJaelQ9U14HrnxdTwJFgkt1uU=;
	b=HPHWPNF35dKX3LiDUqlodarH7TFUSGtMHMYEsgmQ2G8KkxEe33teRSazn5XhfZn7Bl
	bLKgcC12FjJ0QWKUua5zaVPUNPuTD8RNaICl/OBNs66Ui0zMpwl534ZhuuEeBTFM3j0Z
	schcqhnSpa2rTbRc0wCT+iiNu2FwS6nSD6Hds=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Thu, 14 Jul 2016 06:09:58 +0300
Message-Id: <1468465802-4571-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 0/4] net: bridge: simplify receive path
	and consolidate forwarding paths
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

Hi all,
This set tries to simplify the receive and forwarding paths. Patch 01 is
a trivial style adjustment, patch 02 removes one conditional from the
unicast fast path, patch 03 removes another conditional and more imporantly
removes the skb0/skb2 ambiguity about locally receiving the skb and
switches to a boolean called "local_rcv".
Patch 04 is the most important change which consolidates the forwarding
paths for locally originated and forwarded packets into __br_forward. This
allows us to remove the function pointers giving a minor performance boost,
more importantly it makes it much easier to reason about the forwarding
path and reduces the code duplication that was needed when making changes.
Also it allows the receive path to fully setup the environment prior to
calling any forwarding functions (i.e. to properly set unicast, local_rcv
and search for unicast/mcast dst).
Functionally everything should stay the same after this set.

I've done basic tests with unicast/multicast/broadcast Tx/Rx. Please
review carefully.

Thank you,
 Nik

Nikolay Aleksandrov (4):
  net: bridge: minor style adjustments in br_handle_frame_finish
  net: bridge: rearrange flood vs unicast receive paths
  net: bridge: drop skb2/skb0 variables and use a local_rcv boolean
  net: bridge: remove _deliver functions and consolidate forward code

 net/bridge/br_device.c                   |  22 ++--
 net/bridge/br_forward.c                  | 195 +++++++++++--------------------
 net/bridge/br_input.c                    |  62 +++++-----
 net/bridge/br_private.h                  |  29 ++---
 net/bridge/netfilter/nft_reject_bridge.c |   8 +-
 5 files changed, 125 insertions(+), 191 deletions(-)

-- 
2.4.3

