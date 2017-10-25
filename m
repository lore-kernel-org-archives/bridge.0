Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=G970lE9g9LZ3XiS7CgUQUDq5QMrmhrSkS4SJJi0H0GU=;
	b=EzpsGTpvCRV8BvwD4++9UFYJQrGwh3MQVKSqqkXRdIJCz+9uDROCC6Z0ScY5S+infD
	j5LzqPjeVyHFKFLNt6SpbhEln/wias/h8+HF3ixvNH9r0AIoiKUE/AkR9VPPIW0XGX+a
	YCh+eVCzd7ctDBFvg3sioRvrYawy0/IZ0QYB8=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Thu, 26 Oct 2017 01:52:32 +0300
Message-Id: <1508971954-3567-1-git-send-email-nikolay@cumulusnetworks.com>
In-Reply-To: <f6c0da96-77f0-db19-7a9a-13b246d83d39@cumulusnetworks.com>
References: <f6c0da96-77f0-db19-7a9a-13b246d83d39@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next v4 0/2] bridge: make setlink/dellink
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
 5 files changed, 108 insertions(+), 52 deletions(-)

-- 
2.1.4

