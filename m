Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=uGqrtStYIQ/gG4009jwt9tOaQZGkVkkXlx2NS4SiirU=;
	b=ZtM9408P+KgDletkOKWAlAdeR4QyapJg85TBbsvBLmOlmikx7HU4TLtj8fWPtGO5pb
	wGMfntiiKHX6RnFeLHAYEQ+BpM40BftYYtJVu8xKz6M6252kQAlCSjOIxZyTvPCES3fU
	5Az6CwpXff6ksO92Mc5WM8UdDiWlhJHqzbvKo=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Sat, 17 Aug 2019 14:22:09 +0300
Message-Id: <20190817112213.27097-1-nikolay@cumulusnetworks.com>
In-Reply-To: <20190816.130417.1610388599335442981.davem@davemloft.net>
References: <20190816.130417.1610388599335442981.davem@davemloft.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v3 0/4] net: bridge: mdb: allow
	dump/add/del of host-joined entries
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

Hi,
This set makes the bridge dump host-joined mdb entries, they should be
treated as normal entries since they take a slot and are aging out.
We already have notifications for them but we couldn't dump them until
now so they remained hidden. We dump them similar to how they're
notified, in order to keep user-space compatibility with the dumped
objects (e.g. iproute2 dumps mdbs in a format which can be fed into
add/del commands) we allow host-joined groups also to be added/deleted via
mdb commands. That can later be used for L2 mcast MAC manipulation as
was recently discussed. Note that iproute2 changes are not necessary,
this set will work with the current user-space mdb code.

Patch 01 - a trivial comment move
Patch 02 - factors out the mdb filling code so it can be
           re-used for the host-joined entries
Patch 03 - dumps host-joined entries
Patch 04 - allows manipulation of host-joined entries via standard mdb
           calls

v3: fix compiler warning in patch 04 (DaveM)
v2: change patch 04 to avoid double notification and improve host group
    manual removal if no ports are present in the group

Thanks,
 Nik


Nikolay Aleksandrov (4):
  net: bridge: mdb: move vlan comments
  net: bridge: mdb: factor out mdb filling
  net: bridge: mdb: dump host-joined entries as well
  net: bridge: mdb: allow add/delete for host-joined groups

 net/bridge/br_mdb.c       | 175 +++++++++++++++++++++++++-------------
 net/bridge/br_multicast.c |  30 +++++--
 net/bridge/br_private.h   |   2 +
 3 files changed, 142 insertions(+), 65 deletions(-)

-- 
2.21.0

