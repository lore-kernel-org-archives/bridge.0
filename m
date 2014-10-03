Return-Path: <vyasevich@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=hnYRRGiSvLKwSaWxnBMZa550d4rLwoCWrs+XCwGANGs=;
	b=DWLkD5ZErC45ciXozRouOYjvedMwk0FxapTxD38fjnoYqv868uhLGQCdBzj/iT2N8Y
	jIJMI69NdRj+t9eZ6Bum90bS7A4bIujmjxaulak0+zy/4hx6mt3B4LuwGPqmMtaku2//
	g2UxkG0dblQdUJZH56dBY0hF9xIkGPMtmakFmKIdl+/v0NN6wFyEaVoYVFsRqiOKXgf2
	q1BOAMtVWY2J7PDwi2Tq5zJ/xqXFncjCYJhT4WokA9h2aygbTKqy/CVHy7GFaFJnioKW
	ktDyakplohikslh7yUggrFfDjPtIm0UxNR26tr1O/n9YI7nqFZ+YhUgPAtTvHR7rgLbJ
	ykhQ==
From: Vladislav Yasevich <vyasevich@gmail.com>
Date: Fri,  3 Oct 2014 11:29:15 -0400
Message-Id: <1412350158-19061-1-git-send-email-vyasevic@redhat.com>
Subject: [Bridge] [PATCH v4 net-next 0/3] bridge: Add vlan filtering support
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
Cc: stephen@networkplumber.org, bridge@lists.linux-foundation.org, Vladislav Yasevich <vyasevic@redhat.com>, cwang@twopensource.com

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

Since v3:
- allocated 'changed' bitmap on the heap and re-arrange code to clean it up.
- remove extra blank lines.
- Fix patch1 to build by itself.
- Fix error recover to not add vlan 0.
- Restructure nbp_vlan_init to remove uneeded variable.

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
 net/bridge/br_private.h  |  23 +++++---
 net/bridge/br_sysfs_br.c |  17 ++++++
 net/bridge/br_vlan.c     | 148 ++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 187 insertions(+), 12 deletions(-)

-- 
1.9.3

