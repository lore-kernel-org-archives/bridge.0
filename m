Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=aWqWXnAUbitpBZA8zDxaXLiZR66y4oOIPE9rDEMEYzM=;
	b=Z5KoEVTqDmpx4hSMnJBZJ+i25ykeYigNc80XKqEN6UTc6QyPsTQFP096bnRpdyHd7R
	U3eQW67AjQaR7L8kexwOmlse4MKRwcq8FQI8RA1aCrSud7N9akWd3jfutPtDunYGA5Y9
	3bb0MT/4Fe5+DtBBJnw0zUgaUCAlVihkagrYE=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Thu, 19 Oct 2017 18:54:57 +0300
Message-Id: <1508428499-32355-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 0/2] bridge: make setlink/dellink
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
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, mrv@mojatatu.com, dsa@cumulusnetworks.com

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
nothing changed, so we use EEXIST to signal that and in order not to break
overlapping vlan range add or script return expectations we clear it on
return, the functions used by vlan add are not expected to return EEXIST.

Thanks,
 Nik

Nikolay Aleksandrov (2):
  bridge: netlink: make setlink/dellink notifications more accurate
  bridge: vlan: return EEXIST on add if nothing changed

 net/bridge/br_netlink.c        | 49 ++++++++++++++++++++++++++----------------
 net/bridge/br_netlink_tunnel.c | 14 +++++++-----
 net/bridge/br_private_tunnel.h |  3 ++-
 net/bridge/br_vlan.c           | 38 +++++++++++++++++++++-----------
 4 files changed, 68 insertions(+), 36 deletions(-)

-- 
2.1.4

