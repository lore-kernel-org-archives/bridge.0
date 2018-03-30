Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=+Xw36LK18buwCsEp6htWuVK5g26S15kIchqYIVXr/Gw=;
	b=G/e2uHy0A0W02D1LGNaS7oPfGvz3a24RG8epXHofGxJ2ZugdS+T4tJ/xLaLJkk+Fns
	9lW6VOjlIcje8h53bxJ/rWn9751VQlJtPz1ZmtCnPupMtjGNz56CP9QzFLQjpuFdpYxt
	LKQOvRrHVB5JI+nKgLzTEBuWG0G5gdhxe6QpM=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri, 30 Mar 2018 13:46:17 +0300
Message-Id: <20180330104619.31479-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 0/2] net: bridge: MTU handling changes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, 3chas3@gmail.com, davem@davemloft.net

Hi,
As previously discussed the recent changes break some setups and could lead
to packet drops. Thus the first patch reverts the behaviour for the bridge
to follow the minimum MTU but also keeps the ability to set the MTU to the
maximum (out of all ports) if vlan filtering is enabled. Patch 02 is the
bigger change in behaviour - we've always had trouble when configuring
bridges and their MTU which is auto tuning on port events
(add/del/changemtu), which means config software needs to chase it and fix
it after each such event, after patch 02 we allow the user to configure any
MTU (ETH_MIN/MAX limited) but once that is done the bridge stops auto
tuning and relies on the user to keep the MTU correct.
This should be compatible with cases that don't touch the MTU (or set it
to the same value), while allowing to configure the MTU and not worry
about it changing afterwards.

The patches are intentionally split like this, so that if they get accepted
and there are any complaints patch 02 can be reverted.

Thanks,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: set min MTU on port events and allow user to set max
  net: bridge: disable bridge MTU auto tuning if it was set manually

 net/bridge/br.c         |  2 +-
 net/bridge/br_device.c  |  4 ++--
 net/bridge/br_if.c      | 49 ++++++++++++++++++++-----------------------------
 net/bridge/br_private.h |  3 ++-
 4 files changed, 25 insertions(+), 33 deletions(-)

-- 
2.11.0

