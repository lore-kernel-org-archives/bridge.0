Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=kmlc1a46OxTLiMxrmwc1i50t15846Z38xGC8BVFgBFY=;
	b=KnrG+TppjA5/QU7AaotEBtz0htz8ZmVTwClsc4jhpe7HPbjwj/OoNzx8Qt6R7zmOe/
	kJ8iC5SDN/wU3TAz9QGuG/ey2qLHrN4ccAltDDxx7C90mlsTSyx7jVkgFiyL8LUNStjK
	1MhJVNekgjpPHlBLRPlJsqDxAG1zzd8JbLpt8=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri, 27 Oct 2017 13:19:35 +0300
Message-Id: <1509099577-5959-1-git-send-email-nikolay@cumulusnetworks.com>
In-Reply-To: <1f6df7e3-cd05-9b96-9f45-49c433011ff2@cumulusnetworks.com>
References: <1f6df7e3-cd05-9b96-9f45-49c433011ff2@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next v6 0/2] bridge: make setlink/dellink
	notifications more accurate
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, mrv@mojatatu.com, dsa@cumulusnetworks.com, davem@davemloft.net

Hi,
Before this set the bridge would generate a notification on vlan add or del
even if they didn't actually do any changes, which confuses listeners and
is generally not preferred. We could also lose notifications on actual
changes if one adds a range of vlans and there's an error in the middle.
The problem with just breaking and returning an error is that we could
break existing user-space scripts which rely on the vlan delete to clear
all existing entries in the specified range and ignore the non-existing
errors (typically used to clear the current vlan config).
So in order to make the notifications more accurate while keeping backwards
compatibility we add a boolean that tracks if anything actually changed
during the config calls.

The vlan add is more difficult to fix because it always returns 0 even if
nothing changed, but we cannot use a specific error because the drivers
can return anything and we may mask it, also we'd need to update all places
that directly return the add result, thus to signal that a vlan was created
or updated and in order not to break overlapping vlan range add we pass
down the new boolean that tracks changes to the add functions to check
if anything was actually updated.

v6: moved "changed" in else branch in br|nbp_vlan_add, thanks to
    Toshiaki Makita and retested everything again
v5: fix br_vlan_add return (v1 leftover) spotted by Toshiaki Makita
v4: set changed always to false in the non-vlan config case and retested
v3: rebased to latest net-next and fixed non-vlan config functions reported
    by kbuild test bot
v2: pass changed down to vlan add instead of masking errors

Thanks,
 Nik

Nikolay Aleksandrov (2):
  bridge: netlink: make setlink/dellink notifications more accurate
  bridge: vlan: signal if anything changed on vlan add

 net/bridge/br_netlink.c        | 51 ++++++++++++++++-----------
 net/bridge/br_netlink_tunnel.c | 14 +++++---
 net/bridge/br_private.h        | 14 +++++---
 net/bridge/br_private_tunnel.h |  3 +-
 net/bridge/br_vlan.c           | 78 ++++++++++++++++++++++++++++++------------
 5 files changed, 109 insertions(+), 51 deletions(-)

-- 
2.1.4

