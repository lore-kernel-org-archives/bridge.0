Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kDUiHW1MfcT0hQvQpNHHUdUqPUEuNLL0EOKagikppV4=;
 b=zozL3O4fhwV+eInXCTSiOV/1/3ZJZr/1Mg1iWR7NTjUN5J+d5vk3gAwc+U3YrN/JmL
 Nhvk7NI8SSSHjVUTaI0DLZvyWMmcrjiXBevmcrvUMl8LQ3Gesx/uqHwRDI+QgBxFEBTN
 poDsOAM1SO96mRkJ5ebtAX0uXFP1Eeo7HcPOQOWKb74Y1cmIAVFsE+CKTSYu1pV4hZ4j
 s3hL6JxUBxjYvkXCeajLJe1axdZJH2aFRlCKx3IfVwbvgBopxKu6jvbM5Ymv90s0ZO2+
 0AYkOfhQoCvkSJhVWGZ8ftbIQf8JTRNKWkufCgsxGzg031FjnlgFUQBY/Us1col8I+qp
 F/QA==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 27 Oct 2020 20:59:18 +0200
Message-Id: <20201027185934.227040-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 00/16] selftests: net: bridge: add tests
	for IGMPv3
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Hi,
This set adds tests for the bridge's new IGMPv3 support. The tests use
precooked packets which are sent via mausezahn and the resulting state
after each test is checked for proper X,Y sets, (*,G) source list, source
list entry timers, (S,G) existence and flags, packet forwarding and
blocking, exclude group expiration and (*,G) auto-add. The first 3 patches
prepare the existing IGMPv2 tests, then patch 4 adds new helpers which are
used throughout the rest of the v3 tests.
The following new tests are added:
 - base case: IGMPv3 report 239.10.10.10 is_include (A)
 - include -> allow report
 - include -> is_include report
 - include -> is_exclude report
 - include -> to_exclude report
 - exclude -> allow report
 - exclude -> is_include report
 - exclude -> is_exclude report
 - exclude -> to_exclude report
 - include -> block report
 - exclude -> block report
 - exclude timeout (move to include + entry deletion)
 - S,G port entry automatic add to a *,G,exclude port

The variable names and set notation are the same as per RFC 3376,
for more information check RFC 3376 sections 4.2.15 and 6.4.1.
MLDv2 tests will be added by a separate patch-set.

Thanks,
 Nik

Nikolay Aleksandrov (16):
  selftests: net: bridge: rename current igmp tests to igmpv2
  selftests: net: bridge: igmp: add support for packet source address
  selftests: net: bridge: igmp: check for specific udp ip protocol
  selftests: net: bridge: igmp: add IGMPv3 entries' state helpers
  selftests: net: bridge: add tests for igmpv3 is_include and inc ->
    allow reports
  selftests: net: bridge: add test for igmpv3 inc -> is_include report
  selftests: net: bridge: add test for igmpv3 inc -> is_exclude report
  selftests: net: bridge: add test for igmpv3 inc -> to_exclude report
  selftests: net: bridge: add test for igmpv3 exc -> allow report
  selftests: net: bridge: add test for igmpv3 exc -> is_include report
  selftests: net: bridge: add test for igmpv3 exc -> is_exclude report
  selftests: net: bridge: add test for igmpv3 exc -> to_exclude report
  selftests: net: bridge: add test for igmpv3 inc -> block report
  selftests: net: bridge: add test for igmpv3 exc -> block report
  selftests: net: bridge: add test for igmpv3 exclude timeout
  selftests: net: bridge: add test for igmpv3 *,g auto-add

 .../selftests/net/forwarding/bridge_igmp.sh   | 532 +++++++++++++++++-
 1 file changed, 520 insertions(+), 12 deletions(-)

-- 
2.25.4

