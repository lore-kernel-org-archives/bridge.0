Return-Path: <vyasevich@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=NtQhkxHSlhE/7ffnDPr2S8c3TTTEP2w2tj8UFbjixMs=;
	b=nRuc+0w/WBeQfQXI/tY0a3+doIGU10xQfrdV9vJmuKZw5lpCSbCxn7s7emb4MAJzp8
	vCOBzf5M0vIViYPUcoqvYa3ma00wrpUGA3LU8AW395GZcv0kFsVc7mgitFoOY3Va/086
	UIhOPy8vyAsr5AkCn0B1zndzD4e8TdDS3npx/uvYpYs1ZvDKm8WMJuKoaoJd6MiRYrrp
	pTromFQWASVrBaJ6v6XRjyfRUQij22Q1t9kGPVTNp9AckVs4xJkDJgMjAJno6cDlAla9
	o55JaL8qo4oQVs24HGLc5MTr//z+06Ci3Pyi6C6PizY+a30M6ACIGxFFUQywGAUgnmZ+
	QKJw==
From: Vladislav Yasevich <vyasevich@gmail.com>
Date: Thu,  2 Oct 2014 19:54:27 -0400
Message-Id: <1412294070-11930-1-git-send-email-vyasevic@redhat.com>
Subject: [Bridge] [PATCH v3 net-next 0/3] bridge: Add vlan filtering support
	for default pvid
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org, bridge@lists.linux-foundation.org, Vladislav Yasevich <vyasevic@redhat.com>

This series adds default pvid support to vlan filtering in the bridge.
VLAN 1 (as recommended by 802.1q spec) is used as default pvid on ports. 
The the user can over-ride this configuration by configuring their
own vlan information. 
The user can additionally change the default value throught the
sysfs interface (netlink comming shortly).
The user can turn off default pvid functionality by setting default
pvid to 0. 
This series changes the default behavior of the bridge when
vlan filtering is turned on.  Currently, ports without any vlan
filtering configured will not recevie any traffic at all.  This patch
changes the behavior of the above ports to receive only untagged traffic.

Since v2:
- Fix handling of invalid values in sysfs interface.
- Add some additional log messages.
- Fix default_pvid handling when vlan filtering is compiled out.
- Fix sparse issues with new code.
- Fix how we located the old default pvid (added a helper function).

Since v1:
- Add ability to turn off default_pvid settings.
- Drop the automiatic filtering support based on configured vlan devices (will
  be its own series)

Thanks
-vlad


Vladislav Yasevich (3):
  bridge: Add a default_pvid sysfs attribute
  bridge: Simplify pvid checks.
  bridge: Add filtering support for default_pvid

 net/bridge/br_device.c   |   8 ++-
 net/bridge/br_if.c       |   3 +
 net/bridge/br_private.h  |  23 ++++---
 net/bridge/br_sysfs_br.c |  17 +++++
 net/bridge/br_vlan.c     | 158 ++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 197 insertions(+), 12 deletions(-)

-- 
1.9.3

