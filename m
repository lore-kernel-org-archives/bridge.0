Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=O2/HKTzuPQzXFYnOU04mpGq15x9OswvlZvuEDIRAAnQ=;
	b=V/SyXvw7xrd+MWLR/nh0fkmNxWZ/WQ8km4+6y9dvSkoeS0pJy984CiDAuOnYi5IVK4
	P7Kj4fZwZ5ak+jjhlnu18TVd69ejsSTikKhaDYHQSvHWOavQtMxyCcAjpJJodIWR4ljq
	MJ6F+WcRksuQezr5hpPx3Pj16nxVXikG2YLBI=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed, 14 Aug 2019 20:04:57 +0300
Message-Id: <20190814170501.1808-1-nikolay@cumulusnetworks.com>
In-Reply-To: <81258876-5f03-002c-5aa8-2d6d00e6d99e@cumulusnetworks.com>
References: <81258876-5f03-002c-5aa8-2d6d00e6d99e@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 0/4] net: bridge: mdb: allow
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

v2: change patch 04 to avoid double notification and improve host group
    manual removal if no ports are present in the group

Thanks,
 Nik

Nikolay Aleksandrov (4):
  net: bridge: mdb: move vlan comments
  net: bridge: mdb: factor out mdb filling
  net: bridge: mdb: dump host-joined entries as well
  net: bridge: mdb: allow add/delete for host-joined groups

 net/bridge/br_mdb.c       | 173 +++++++++++++++++++++++++-------------
 net/bridge/br_multicast.c |  30 +++++--
 net/bridge/br_private.h   |   2 +
 3 files changed, 141 insertions(+), 64 deletions(-)

-- 
2.21.0

