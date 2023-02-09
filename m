Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC6A960D59
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 131C660D4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ma0lMYhmkgsFbsPUuCcNQ33R7PVCiMwdt8Gw3JCvLBw=;
 b=MFLFd+7TpokBjGiqzXgb5kl0echq8+d5Bu55ymy29FUxCS2dkPN/QfdM16U8ptkEJImMXlOGOgRmE8cDrr/Wjy75XfVeQrfLvYnOmIEDp8H17deuuI9OsBxlhLO00cxvZNEn2pSWrccEqSeURKLF8P+sy+Os837mvFRjzlP5Za/jj34SzFb9j3GjPPNWs4Kv5MajLUoYcJeY7p9d7tChGxGFascRpoLJNK9Oi2XFsUNZg55KzMwwHgmeIU67Hkoci/hQXaqno/6tkniSPe/urDrE4ktAPXQ/uBswGJAMcJYpu5yoahdCW11rIIGoy/tTqxuX9Vl1MIW9qcQFhsNP0w==
From: Ido Schimmel <idosch@nvidia.com>
Date: Thu,  9 Feb 2023 09:18:52 +0200
Message-Id: <20230209071852.613102-5-idosch@nvidia.com>
In-Reply-To: <20230209071852.613102-1-idosch@nvidia.com>
References: <20230209071852.613102-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 4/4] selftests: forwarding: Add MDB dump
	test cases
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

The kernel maintains three markers for the MDB dump:

1. The last bridge device from which the MDB was dumped.
2. The last MDB entry from which the MDB was dumped.
3. The last port-group entry that was dumped.

Add test cases for large scale MDB dump to make sure that all the
configured entries are dumped and that the markers are used correctly.

Specifically, create 2 bridges with 32 ports and add 256 MDB entries in
which all the ports are member of. Test that each bridge reports 8192
(256 * 32) permanent entries. Do that with IPv4, IPv6 and L2 MDB
entries.

On my system, MDB dump of the above is contained in about 50 netlink
messages.

Example output:

 # ./bridge_mdb.sh
 [...]
 INFO: # Large scale dump tests
 TEST: IPv4 large scale dump tests                                   [ OK ]
 TEST: IPv6 large scale dump tests                                   [ OK ]
 TEST: L2 large scale dump tests                                     [ OK ]
 [...]

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 .../selftests/net/forwarding/bridge_mdb.sh    | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index b48867d8cadf..ae3f9462a2b6 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -742,10 +742,109 @@ cfg_test_port()
 	cfg_test_port_l2
 }
 
+ipv4_grps_get()
+{
+	local max_grps=$1; shift
+	local i
+
+	for i in $(seq 0 $((max_grps - 1))); do
+		echo "239.1.1.$i"
+	done
+}
+
+ipv6_grps_get()
+{
+	local max_grps=$1; shift
+	local i
+
+	for i in $(seq 0 $((max_grps - 1))); do
+		echo "ff0e::$(printf %x $i)"
+	done
+}
+
+l2_grps_get()
+{
+	local max_grps=$1; shift
+	local i
+
+	for i in $(seq 0 $((max_grps - 1))); do
+		echo "01:00:00:00:00:$(printf %02x $i)"
+	done
+}
+
+cfg_test_dump_common()
+{
+	local name=$1; shift
+	local fn=$1; shift
+	local max_bridges=2
+	local max_grps=256
+	local max_ports=32
+	local num_entries
+	local batch_file
+	local grp
+	local i j
+
+	RET=0
+
+	# Create net devices.
+	for i in $(seq 1 $max_bridges); do
+		ip link add name br-test${i} up type bridge vlan_filtering 1 \
+			mcast_snooping 1
+		for j in $(seq 1 $max_ports); do
+			ip link add name br-test${i}-du${j} up \
+				master br-test${i} type dummy
+		done
+	done
+
+	# Create batch file with MDB entries.
+	batch_file=$(mktemp)
+	for i in $(seq 1 $max_bridges); do
+		for j in $(seq 1 $max_ports); do
+			for grp in $($fn $max_grps); do
+				echo "mdb add dev br-test${i} \
+					port br-test${i}-du${j} grp $grp \
+					permanent vid 1" >> $batch_file
+			done
+		done
+	done
+
+	# Program the batch file and check for expected number of entries.
+	bridge -b $batch_file
+	for i in $(seq 1 $max_bridges); do
+		num_entries=$(bridge mdb show dev br-test${i} | \
+			grep "permanent" | wc -l)
+		[[ $num_entries -eq $((max_grps * max_ports)) ]]
+		check_err $? "Wrong number of entries in br-test${i}"
+	done
+
+	# Cleanup.
+	rm $batch_file
+	for i in $(seq 1 $max_bridges); do
+		ip link del dev br-test${i}
+		for j in $(seq $max_ports); do
+			ip link del dev br-test${i}-du${j}
+		done
+	done
+
+	log_test "$name large scale dump tests"
+}
+
+# Check large scale dump.
+cfg_test_dump()
+{
+	echo
+	log_info "# Large scale dump tests"
+
+	cfg_test_dump_common "IPv4" ipv4_grps_get
+	cfg_test_dump_common "IPv6" ipv6_grps_get
+	cfg_test_dump_common "L2" l2_grps_get
+}
+
 cfg_test()
 {
 	cfg_test_host
 	cfg_test_port
+	cfg_test_dump
 }
 
 __fwd_test_host_ip()
-- 
2.37.3

