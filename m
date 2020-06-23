Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uv7xIdydepaKJnDBGkm+1SZ9hRYqS6as0NEV32nUerQ=;
 b=WhsCKEmAKCzXCOj5ZmN9FqMRB9Q8KlNOSPEc/KIIXN54z54HJuPthWufBdup+uEi/f
 4nmei+myBeh/U+9F6FLuklNrS8dtyXKu3yZ/SKs0wjxiUj1WQJNEctBrV/5U31E+43Jg
 hmVLHjfyo2D2hPcHJkpE8QOHpIxH+QTLzGl0g=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 23 Jun 2020 23:47:14 +0300
Message-Id: <20200623204718.1057508-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 0/4] net: bridge: fdb activity tracking
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net, anuradhak@cumulusnetworks.com

Hi,
This set adds extensions needed for EVPN multi-homing proper and
efficient mac sync. User-space (e.g. FRR) needs to be able to track
non-dynamic entry activity on per-fdb basis depending if a tracked fdb is
currently peer active or locally active and needs to be able to add new
peer active fdb (static + track + inactive) without refreshing it to get
real activity tracking. Patch 02 adds a new NDA attribute - NDA_FDB_EXT_ATTRS
to avoid future pollution of NDA attributes by bridge or vxlan. New
bridge/vxlan specific fdb attributes are embedded in NDA_FDB_EXT_ATTRS,
which is used in patch 03 to pass the new NFEA_ACTIVITY_NOTIFY attribute
which controls if an fdb should be tracked and also reflects its current
state when dumping. It is treated as a bitfield, current valid bits are:
 1 - mark an entry for activity tracking
 2 - mark an entry as inactive to avoid multiple notifications and
     reflect state properly

Patch 04 adds the ability to avoid refreshing an entry when changing it
via the NFEA_DONT_REFRESH flag. That allows user-space to mark a static
entry for tracking and keep its real activity unchanged.
The set has been extensively tested with FRR and those changes will
be upstreamed if/after it gets accepted.

Thanks,
 Nik


Nikolay Aleksandrov (4):
  net: bridge: fdb_add_entry takes ndm as argument
  net: neighbor: add fdb extended attribute
  net: bridge: add option to allow activity notifications for any fdb
    entries
  net: bridge: add a flag to avoid refreshing fdb when changing/adding

 include/uapi/linux/neighbour.h |  24 +++++++
 net/bridge/br_fdb.c            | 127 ++++++++++++++++++++++++++++-----
 net/bridge/br_private.h        |   4 ++
 net/core/neighbour.c           |   1 +
 4 files changed, 139 insertions(+), 17 deletions(-)

-- 
2.25.4

