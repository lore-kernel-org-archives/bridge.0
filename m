Return-Path: <WINTERA@de.ibm.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=kU85/hwEKudw2+4oyr9yDNZQ2Ir73arYRt8INE8JJHc=;
 b=dg8praPlCMR6afAPaKnaQkJqaUlYSl/v0A0c7ZQmY/CZzzxDDXHHEjOE3h7YPPEcH/WH
 eGLv+utAuBrr8poMhVUxKNwcTz/YOS+ZhQ4YH4FhoaubVwQD8B0qLKb8/UaRIj+OEDQb
 wqyTphxddXl+CmSFDkN0bz9zA+m0FdGQrl5SQ+Ghsv1XR0W53P4vwOWTuje5b94eDN1U
 Zsq37DnXX0rvcmjuRrimrFXWcwvArubI9Y6uERWyUxu0i+i1o2OAU5NPMnUiM1eqsDel
 ce5jCsUbAlmWMhQuD9sQtFpEfUVopfGhUdnyXjRKKGVZaXm6Otxz6AsOvIM0uOMjkexI hw== 
From: Alexandra Winter <wintera@linux.ibm.com>
Date: Wed, 23 Jun 2021 15:34:24 +0200
Message-Id: <20210623133426.2613847-1-wintera@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 0/2] net/bridge: Support learning_sync on
	master
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: roopa@nvidia.com, nikolay@nvidia.com, bridge@lists.linux-foundation.org, davem@davemloft.net, kuba@kernel.org, jwi@linux.ibm.com
Cc: Alexandra Winter <wintera@linux.ibm.com>

The following patches added support for 'learning_sync on/off self' to
the qeth device driver:
521c65b64916 s390/qeth: implement ndo_bridge_setlink for learning_sync
780b6e7db25e s390/qeth: implement ndo_bridge_getlink for learning_sync
10a6cfc0fc82 s390/qeth: Translate address events into switchdev notifiers
The 'learning_sync self' attribute is used to enable syncing from the
HW fdb to the software bridge's fdb via SWITCHDEV_FDB_ADD/DEL_TO_BRIDGE
notifications.

The current patchset now adds support for 'learning_sync on/off [master]'
to synchronize from the software bridge's fdb to a hardware fdb.

Alexandra Winter (2):
  net/bridge: Support learning_sync on master
  net/bridge: Update uc addr on LEARNING_SYNC bp

 include/uapi/linux/if_link.h |  2 +-
 net/bridge/br_fdb.c          | 28 ++++++++++++++++++++++++++++
 net/bridge/br_netlink.c      |  5 +++++
 3 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.25.1

