Return-Path: <sfeldma@cumulusnetworks.com>
From: Scott Feldman <sfeldma@cumulusnetworks.com>
Date: Mon, 06 Jan 2014 11:00:25 -0800
Message-ID: <20140106185718.10912.92289.stgit@monster-03.cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH net-next 0/2] bridge: spin_lock fix plus sysfs
	cleanup
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, shm@cumulusnetworks.com

The following series implements:

- br_multicast_set_hash_max() is called from process context (via sysfs)
  and needs spin_lock_bh to disable bhs.

- cleanup bridge sysfs definitions by using DEVICE_ATTR_xx macros

---

Curt Brune (1):
      bridge: use spin_lock_bh() in br_multicast_set_hash_max

Scott Feldman (1):
      bridge: use DEVICE_ATTR_xx macros


 net/bridge/br_multicast.c |    4 -
 net/bridge/br_sysfs_br.c  |  249 ++++++++++++++++++++-------------------------
 2 files changed, 110 insertions(+), 143 deletions(-)

-- 
Signature
