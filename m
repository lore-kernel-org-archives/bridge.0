Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gBPQNvEnJJLckxCSGc4J1L8KyXXtbTMRUV/7fFvFRTE=;
 b=tUh/OpvG7z1rjD7dxAfgfm1IICN1lrCRRj/ZQfgIIB/2U8cf7uPLBiusc412bdcK0+
 XeQkPBcLgEmqVIaFlewufk1pI0ldkn4GtbqJH/qTRXbMm6OCpOTUjYP8cYclPqhT6LTs
 f6sK2aO8xQsGoFciaI1XV6gkvkxMc1R5j39wXpj7jcphJBchGEDD+XLuLWlyq9D13zxs
 c63PstJyt49FcQWI8Ewv0PN3/4tbSowgAtwTLnDKW2XztthDsha5+q6VRnTgHEGVShR+
 HdA3YHrpLs1vdb+G83LwfLTnc6pW4PwGk1GlxKZZbA5K/sezuLOgI7rGGtx8zF21YwYx
 WDGg==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Thu, 25 Nov 2021 16:08:48 +0200
Message-Id: <20211125140858.3639139-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 00/10] selftests: net: bridge: vlan
	multicast tests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: ivecera@redhat.com, bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Hi,
This patch-set adds selftests for the new vlan multicast options that
were recently added. Most of the tests check for default values,
changing options and try to verify that the changes actually take
effect. The last test checks if the dependency between vlan_filtering
and mcast_vlan_snooping holds. The rest are pretty self-explanatory.

TEST: Vlan multicast snooping enable                                [ OK ]
TEST: Vlan global options existence                                 [ OK ]
TEST: Vlan mcast_snooping global option default value               [ OK ]
TEST: Vlan 10 multicast snooping control                            [ OK ]
TEST: Vlan mcast_querier global option default value                [ OK ]
TEST: Vlan 10 multicast querier enable                              [ OK ]
TEST: Vlan 10 tagged IGMPv2 general query sent                      [ OK ]
TEST: Vlan 10 tagged MLD general query sent                         [ OK ]
TEST: Vlan mcast_igmp_version global option default value           [ OK ]
TEST: Vlan mcast_mld_version global option default value            [ OK ]
TEST: Vlan 10 mcast_igmp_version option changed to 3                [ OK ]
TEST: Vlan 10 tagged IGMPv3 general query sent                      [ OK ]
TEST: Vlan 10 mcast_mld_version option changed to 2                 [ OK ]
TEST: Vlan 10 tagged MLDv2 general query sent                       [ OK ]
TEST: Vlan mcast_last_member_count global option default value      [ OK ]
TEST: Vlan mcast_last_member_interval global option default value   [ OK ]
TEST: Vlan 10 mcast_last_member_count option changed to 3           [ OK ]
TEST: Vlan 10 mcast_last_member_interval option changed to 200      [ OK ]
TEST: Vlan mcast_startup_query_interval global option default value   [ OK ]
TEST: Vlan mcast_startup_query_count global option default value    [ OK ]
TEST: Vlan 10 mcast_startup_query_interval option changed to 100    [ OK ]
TEST: Vlan 10 mcast_startup_query_count option changed to 3         [ OK ]
TEST: Vlan mcast_membership_interval global option default value    [ OK ]
TEST: Vlan 10 mcast_membership_interval option changed to 200       [ OK ]
TEST: Vlan 10 mcast_membership_interval mdb entry expire            [ OK ]
TEST: Vlan mcast_querier_interval global option default value       [ OK ]
TEST: Vlan 10 mcast_querier_interval option changed to 100          [ OK ]
TEST: Vlan 10 mcast_querier_interval expire after outside query     [ OK ]
TEST: Vlan mcast_query_interval global option default value         [ OK ]
TEST: Vlan 10 mcast_query_interval option changed to 200            [ OK ]
TEST: Vlan mcast_query_response_interval global option default value   [ OK ]
TEST: Vlan 10 mcast_query_response_interval option changed to 200   [ OK ]
TEST: Port vlan 10 option mcast_router default value                [ OK ]
TEST: Port vlan 10 mcast_router option changed to 2                 [ OK ]
TEST: Flood unknown vlan multicast packets to router port only      [ OK ]
TEST: Disable multicast vlan snooping when vlan filtering is disabled   [ OK ]

Thanks,
 Nik

Nikolay Aleksandrov (10):
  selftests: net: bridge: add vlan mcast snooping control test
  selftests: net: bridge: add vlan mcast querier test
  selftests: net: bridge: add vlan mcast igmp/mld version tests
  selftests: net: bridge: add vlan mcast_last_member_count/interval
    tests
  selftests: net: bridge: add vlan mcast_startup_query_count/interval
    tests
  selftests: net: bridge: add vlan mcast_membership_interval test
  selftests: net: bridge: add vlan mcast_querier_interval tests
  selftests: net: bridge: add vlan mcast query and query response
    interval tests
  selftests: net: bridge: add vlan mcast_router tests
  selftests: net: bridge: add test for vlan_filtering dependency

 .../net/forwarding/bridge_vlan_mcast.sh       | 543 ++++++++++++++++++
 1 file changed, 543 insertions(+)
 create mode 100755 tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh

-- 
2.31.1

