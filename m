Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5waWch5DfbeJ99kzw2cUqjwTl2DYjMssW5khvUSgq2w=;
 b=XX0MtFAeQlhIUtmtgoHO5iCXTIHz2Os0iBcD3sUghfWoSWX5C+SmEZvbZIjsOQgWZU
 GHs84xYTQsCSqUydkOVg5lKP3dpLjrau2DIra76ANaYt9eljZYNqXxtuz0Mha340jQyL
 5cO2LIk06IH8kH8VnOMZghYz2B9VCKcnZ1eVGXpjnWnqt2TOEtll7CbXglZ1SQhVbsnD
 V/+YaPY8oGugmGc4415yK2Bh+6OzWcV0iJuLIzgRx2nRReD075tdY3nTgRIMqjpsacZg
 ZzqmSiHVGQHqQQmC2a5xf2H8e/9WQSwX0vJf3nEWRit7wbo4twwef+084Kv20VNXT/7O
 Kmjg==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue,  3 Nov 2020 19:23:56 +0200
Message-Id: <20201103172412.1044840-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 00/16] selftests: net: bridge: add tests
	for MLDv2
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
This is the second selftests patch-set for the new multicast functionality
which adds tests for the bridge's MLDv2 support. The tests use full
precooked packets which are sent via mausezahn and the resulting state
after each test is checked for proper X,Y sets, (*,G) source list, source
list entry timers, (S,G) existence and flags, packet forwarding and
blocking, exclude group expiration and (*,G) auto-add. The first 3 patches
factor out common functions which are used by IGMPv3 tests in lib.sh and
add support for IPv6 test UDP packet, then patch 4 adds the first test with
the initial MLDv2 setup.
The following new tests are added:
 - base case: MLDv2 report ff02::cc is_include
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

The variable names and set notation are the same as per RFC 3810,
for more information check RFC 3810 sections 2.3 and 7.

Thanks,
 Nik

Nikolay Aleksandrov (16):
  selftests: net: bridge: factor out mcast_packet_test
  selftests: net: lib: add support for IPv6 mcast packet test
  selftests: net: bridge: factor out and rename sg state functions
  selftests: net: bridge: add initial MLDv2 include test
  selftests: net: bridge: add test for mldv2 inc -> allow report
  selftests: net: bridge: add test for mldv2 inc -> is_include report
  selftests: net: bridge: add test for mldv2 inc -> is_exclude report
  selftests: net: bridge: add test for mldv2 inc -> to_exclude report
  selftests: net: bridge: add test for mldv2 exc -> allow report
  selftests: net: bridge: add test for mldv2 exc -> is_include report
  selftests: net: bridge: add test for mldv2 exc -> is_exclude report
  selftests: net: bridge: add test for mldv2 exc -> to_exclude report
  selftests: net: bridge: add test for mldv2 inc -> block report
  selftests: net: bridge: add test for mldv2 exc -> block report
  selftests: net: bridge: add test for mldv2 exclude timeout
  selftests: net: bridge: add test for mldv2 *,g auto-add

 .../selftests/net/forwarding/bridge_igmp.sh   | 211 ++-----
 .../selftests/net/forwarding/bridge_mld.sh    | 558 ++++++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh | 107 ++++
 3 files changed, 721 insertions(+), 155 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/bridge_mld.sh

-- 
2.25.4

