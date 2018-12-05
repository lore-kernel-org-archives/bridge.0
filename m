Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=JzfUd/E18TcbJCC0GpcQlxGYkzyoaZlGDywabw/nkmk=;
	b=RKiIAllTNHwJiBzXCY0oYveWLcjo1lDSPU7OClBwvjw33dTPly81D5V/uXFYTYP0i+
	Yr7BGli5Y509S2w143IlI2ZxqiBt8BUFk9wNm9wm8Xv+yZrUgP7O83KiAe94o2qfcIK+
	KuE6gW9TzEicLEi/tqIkkNjL4SqN1cJqHwia8=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed,  5 Dec 2018 15:14:23 +0200
Message-Id: <20181205131427.4989-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next v3 0/4] net: bridge: convert multicast to
	generic rhashtable
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
The current bridge multicast code uses a custom rhashtable
implementation which predates the generic rhashtable API. Patch 01
converts it to use the generic kernel rhashtable which simplifies the
code a lot and removes duplicated functionality. The convert also makes
hash_elasticity obsolete as the generic rhashtable already has such
checks and has a fixed elasticity of RHT_ELASTICITY (16 currently) so we
emit a warning whenever elasticity is set and return RHT_ELASTICITY when
read (patch 03). Patch 02 converts the multicast code to use non-bh RCU
flavor as it was mixing bh and non-bh. Since now we have the generic
rhashtable which autoshrinks we can be more liberal with the default
hash maximum so patch 04 increases it to 4096 and moves it to a define in
br_private.h.

v3: add non-rcu br_mdb_get variant and use it where we have
    multicast_lock, drop special hash_max handling and just set it where
    needed and use non-bh RCU consistently (patch 02, new)
v2: send the latest version of the set which handles when IGMP snooping
    is not defined, changes are in patch 01

Thanks,
 Nik


Nikolay Aleksandrov (4):
  net: bridge: convert multicast to generic rhashtable
  net: bridge: multicast: use non-bh rcu flavor
  net: bridge: mark hash_elasticity as obsolete
  net: bridge: increase multicast's default maximum number of entries

 net/bridge/br_device.c    |  10 +
 net/bridge/br_mdb.c       | 122 +++++------
 net/bridge/br_multicast.c | 439 +++++++-------------------------------
 net/bridge/br_netlink.c   |  20 +-
 net/bridge/br_private.h   |  42 ++--
 net/bridge/br_sysfs_br.c  |  14 +-
 6 files changed, 177 insertions(+), 470 deletions(-)

-- 
2.17.2

