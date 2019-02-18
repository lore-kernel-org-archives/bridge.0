Return-Path: <rong.a.chen@intel.com>
Date: Mon, 18 Feb 2019 10:15:43 +0800
From: kernel test robot <rong.a.chen@intel.com>
Message-ID: <20190218021543.GE29177@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jL2BoiuKMElzg3CS"
Content-Disposition: inline
In-Reply-To: <20190215130427.29824-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [LKP] [net] 5c261115ce: hwsim.ap_vlan_without_station.fail
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, wkok@cumulusnetworks.com, anuradhak@cumulusnetworks.com, lkp@01.org, davem@davemloft.net


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

FYI, we noticed the following commit (built with gcc-7):

commit: 5c261115cef6e99302690935266ad113e26ae4bb ("[PATCH RFC] net: bridge: don't flood known multicast traffic when snooping is enabled")
url: https://github.com/0day-ci/linux/commits/Nikolay-Aleksandrov/net-bridge-don-t-flood-known-multicast-traffic-when-snooping-is-enabled/20190216-033700


in testcase: hwsim
with following parameters:

	group: hwsim-02



on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):




2019-02-18 03:45:08 export USER=root
2019-02-18 03:45:08 ./build.sh
Building TNC testing tools
Building wlantest
Building hostapd
Building wpa_supplicant
2019-02-18 03:47:57 ./start.sh
2019-02-18 03:47:58 	./run-tests.py ap_open_ifdown 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_ifdown 1/1
Test: AP with open mode and external ifconfig down
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_open_ifdown 1.297904 2019-02-18 03:48:02.252163
passed all 1 test case(s)
2019-02-18 03:48:02 	./run-tests.py ap_open_invalid_wmm_action 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_invalid_wmm_action 1/1
Test: AP with open mode configuration and invalid WMM Action frame
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_invalid_wmm_action 0.466601 2019-02-18 03:48:03.408871
passed all 1 test case(s)
2019-02-18 03:48:03 	./run-tests.py ap_open_multicast_to_unicast 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_multicast_to_unicast 1/1
Test: Multicast-to-unicast conversion enabled
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_multicast_to_unicast 0.43067 2019-02-18 03:48:04.324180
passed all 1 test case(s)
2019-02-18 03:48:04 	./run-tests.py ap_open_multicast_to_unicast_disabled 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_multicast_to_unicast_disabled 1/1
Test: Multicast-to-unicast conversion disabled
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_multicast_to_unicast_disabled 0.44771 2019-02-18 03:48:05.305661
passed all 1 test case(s)
2019-02-18 03:48:05 	./run-tests.py ap_open_no_reflection 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_no_reflection 1/1
Test: AP with open mode, STA sending packets to itself
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_no_reflection 1.534071 2019-02-18 03:48:07.376354
passed all 1 test case(s)
2019-02-18 03:48:07 	./run-tests.py ap_open_noncountry 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_noncountry 1/1
Test: AP with open mode and noncountry entity as Country String
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_noncountry 6.70197 2019-02-18 03:48:14.689721
passed all 1 test case(s)
2019-02-18 03:48:14 	./run-tests.py ap_open_out_of_memory 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_out_of_memory 1/1
Test: hostapd failing to setup interface due to allocation failure
Starting AP wlan3
Starting AP wlan4
Starting AP wlan4
Starting AP wlan4
Starting AP wlan4
Starting AP wlan4
Starting AP wlan4
Starting AP wlan4
Starting AP wlan4
Starting AP wlan4
Starting AP wlan4
Starting AP wlan4
Starting AP wlan4
Starting AP wlan4
PASS ap_open_out_of_memory 0.704106 2019-02-18 03:48:15.925191
passed all 1 test case(s)
2019-02-18 03:48:16 	./run-tests.py ap_open_packet_loss 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_packet_loss 1/1
Test: AP with open mode configuration and large packet loss
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
PASS ap_open_packet_loss 11.462469 2019-02-18 03:48:28.121312
passed all 1 test case(s)
2019-02-18 03:48:28 	./run-tests.py ap_open_per_sta_vif 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_per_sta_vif 1/1
Test: AP VLAN with open network
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_per_sta_vif 0.454378 2019-02-18 03:48:29.049047
passed all 1 test case(s)
2019-02-18 03:48:29 	./run-tests.py ap_open_pmf_default 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_pmf_default 1/1
Test: AP with open mode (no security) configuration and pmf=2
Starting AP wlan3
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
PASS ap_open_pmf_default 0.767375 2019-02-18 03:48:30.321162
passed all 1 test case(s)
2019-02-18 03:48:30 	./run-tests.py ap_open_poll_sta 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_poll_sta 1/1
Test: AP with open mode and STA poll
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_poll_sta 0.422021 2019-02-18 03:48:31.251816
passed all 1 test case(s)
2019-02-18 03:48:31 	./run-tests.py ap_open_reassoc_not_found 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_reassoc_not_found 1/1
Test: AP with open mode and REASSOCIATE not finding a match
Connect STA wlan0 to AP
PASS ap_open_reassoc_not_found 0.254328 2019-02-18 03:48:32.003562
passed all 1 test case(s)
2019-02-18 03:48:32 	./run-tests.py ap_open_reassoc_same 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_reassoc_same 1/1
Test: AP with open mode and STA reassociating back to same AP without auth exchange
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_reassoc_same 0.515153 2019-02-18 03:48:33.050044
passed all 1 test case(s)
2019-02-18 03:48:33 	./run-tests.py ap_open_reconnect_on_inactivity_disconnect 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_reconnect_on_inactivity_disconnect 1/1
Test: Reconnect to open mode AP after inactivity related disconnection
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_reconnect_on_inactivity_disconnect 0.691548 2019-02-18 03:48:34.289003
passed all 1 test case(s)
2019-02-18 03:48:34 	./run-tests.py ap_open_select_any 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_select_any 1/1
Test: AP with open mode and select any network
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_open_select_any 0.711917 2019-02-18 03:48:35.567014
passed all 1 test case(s)
2019-02-18 03:48:35 	./run-tests.py ap_open_select_network 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_select_network 1/1
Test: Open mode connection and SELECT_NETWORK to change network
Starting AP wlan3
Starting AP wlan4
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_open_select_network 0.91725 2019-02-18 03:48:37.080350
passed all 1 test case(s)
2019-02-18 03:48:37 	./run-tests.py ap_open_select_network_freq 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_select_network_freq 1/1
Test: AP with open mode and use for SELECT_NETWORK freq parameter
Starting AP wlan3
Connect STA wlan0 to AP
Scan duration: 0.0400000000373 seconds
PASS ap_open_select_network_freq 0.380548 2019-02-18 03:48:37.933411
passed all 1 test case(s)
2019-02-18 03:48:37 	./run-tests.py ap_open_select_twice 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_select_twice 1/1
Test: AP with open mode and select network twice
Connect STA wlan0 to AP
Starting AP wlan3
PASS ap_open_select_twice 0.467613 2019-02-18 03:48:38.869172
passed all 1 test case(s)
2019-02-18 03:48:38 	./run-tests.py ap_open_sta_enable_disable 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_sta_enable_disable 1/1
Test: AP with open mode and wpa_supplicant ENABLE/DISABLE_NETWORK
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan5 to AP
PASS ap_open_sta_enable_disable 0.697957 2019-02-18 03:48:40.073084
passed all 1 test case(s)
2019-02-18 03:48:40 	./run-tests.py ap_open_sta_statistics 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_sta_statistics 1/1
Test: AP with open mode and STA statistics
Starting AP wlan3
Connect STA wlan0 to AP
stats1: {'ht_mcs_bitmask': 'ffff0000000000000000', 'listen_interval': '5', 'rx_packets': '3', 'timeout_next': 'NULLFUNC POLL', 'ext_capab': '04000a02014000400001', 'addr': '02:00:00:00:00:00', 'rx_bytes': '232', 'tx_rate_info': '10', 'signal': '-30', 'inactive_msec': '1', 'rx_rate_info': '585 mcs 6', 'supported_rates': '02 04 0b 16 0c 12 18 24 30 48 60 6c', 'capability': '0x421', 'supp_op_classes': '5151525354737475767778797a7b7c7d7e7f808182', 'flags': '[AUTH][ASSOC][AUTHORIZED][SHORT_PREAMBLE][WMM][HT]', 'connected_time': '0', 'tx_bytes': '196', 'aid': '1', 'tx_packets': '3', 'ht_caps_info': '0x1076'}
stats2: {'ht_mcs_bitmask': 'ffff0000000000000000', 'listen_interval': '5', 'rx_packets': '6', 'timeout_next': 'NULLFUNC POLL', 'ext_capab': '04000a02014000400001', 'addr': '02:00:00:00:00:00', 'rx_bytes': '375', 'tx_rate_info': '10', 'signal': '-30', 'inactive_msec': '343', 'rx_rate_info': '1300 mcs 15', 'supported_rates': '02 04 0b 16 0c 12 18 24 30 48 60 6c', 'capability': '0x421', 'supp_op_classes': '5151525354737475767778797a7b7c7d7e7f808182', 'flags': '[AUTH][ASSOC][AUTHORIZED][SHORT_PREAMBLE][WMM][HT]', 'connected_time': '0', 'tx_bytes': '229', 'aid': '1', 'tx_packets': '4', 'ht_caps_info': '0x1076'}
stats3: {'ht_mcs_bitmask': 'ffff0000000000000000', 'listen_interval': '5', 'rx_packets': '10', 'timeout_next': 'NULLFUNC POLL', 'ext_capab': '04000a02014000400001', 'addr': '02:00:00:00:00:00', 'rx_bytes': '3448', 'tx_rate_info': '585 mcs 6', 'signal': '-30', 'inactive_msec': '10', 'rx_rate_info': '650 mcs 7', 'supported_rates': '02 04 0b 16 0c 12 18 24 30 48 60 6c', 'capability': '0x421', 'supp_op_classes': '5151525354737475767778797a7b7c7d7e7f808182', 'flags': '[AUTH][ASSOC][AUTHORIZED][SHORT_PREAMBLE][WMM][HT]', 'connected_time': '0', 'tx_bytes': '1782', 'aid': '1', 'tx_packets': '6', 'ht_caps_info': '0x1076'}
PASS ap_open_sta_statistics 0.990526 2019-02-18 03:48:41.535840
passed all 1 test case(s)
2019-02-18 03:48:41 	./run-tests.py ap_open_start_disabled 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_start_disabled 1/1
Test: AP with open mode and beaconing disabled
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_start_disabled 0.716674 2019-02-18 03:48:42.688999
passed all 1 test case(s)
2019-02-18 03:48:42 	./run-tests.py ap_open_start_disabled2 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_start_disabled2 1/1
Test: AP with open mode and beaconing disabled (2)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_start_disabled2 1.079394 2019-02-18 03:48:44.253009
passed all 1 test case(s)
2019-02-18 03:48:44 	./run-tests.py ap_open_tdls 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_tdls 1/1
Test: Open AP and two stations using TDLS
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Setup TDLS
Teardown TDLS
Setup TDLS
Teardown TDLS
PASS ap_open_tdls 7.216686 2019-02-18 03:48:51.943189
passed all 1 test case(s)
2019-02-18 03:48:52 	./run-tests.py ap_open_tdls_external_control 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_tdls_external_control 1/1
Test: TDLS and tdls_external_control
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_open_tdls_external_control 0.731239 2019-02-18 03:48:53.299147
passed all 1 test case(s)
2019-02-18 03:48:53 	./run-tests.py ap_open_tdls_vht 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_tdls_vht 1/1
Test: Open AP and two stations using TDLS
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Setup TDLS
Teardown TDLS
Setup TDLS
Teardown TDLS
PASS ap_open_tdls_vht 6.735755 2019-02-18 03:49:00.475475
passed all 1 test case(s)
2019-02-18 03:49:00 	./run-tests.py ap_open_tdls_vht160 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_tdls_vht160 1/1
Test: Open AP and two stations using TDLS with VHT 160
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Setup TDLS
Station dump on dev[0]:
Station 02:00:00:00:03:00 (on wlan0)
	inactive time:	33 ms
	rx bytes:	150405
	rx packets:	170
	tx bytes:	64712
	tx packets:	54
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	25
	rx drop misc:	30
	signal:  	-30 dBm
	signal avg:	-30 dBm
	beacon signal avg:	226 dBm
	tx bitrate:	6.5 MBit/s MCS 0
	rx bitrate:	6.5 MBit/s MCS 0
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	no
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	3 seconds
Station 02:00:00:00:01:00 (on wlan0)
	inactive time:	54 ms
	rx bytes:	18306
	rx packets:	16
	tx bytes:	18306
	tx packets:	14
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	25
	rx drop misc:	0
	signal:  	-30 dBm
	signal avg:	-30 dBm
	beacon signal avg:	226 dBm
	tx bitrate:	6.5 MBit/s MCS 0
	rx bitrate:	6.5 MBit/s MCS 0
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	yes
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	2 seconds

Station dump on dev[1]:
Station 02:00:00:00:03:00 (on wlan0)
	inactive time:	37 ms
	rx bytes:	150405
	rx packets:	170
	tx bytes:	64712
	tx packets:	54
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	25
	rx drop misc:	30
	signal:  	-30 dBm
	signal avg:	-30 dBm
	beacon signal avg:	226 dBm
	tx bitrate:	6.5 MBit/s MCS 0
	rx bitrate:	6.5 MBit/s MCS 0
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	no
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	3 seconds
Station 02:00:00:00:01:00 (on wlan0)
	inactive time:	58 ms
	rx bytes:	18306
	rx packets:	16
	tx bytes:	18306
	tx packets:	14
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	25
	rx drop misc:	0
	signal:  	-30 dBm
	signal avg:	-30 dBm
	beacon signal avg:	226 dBm
	tx bitrate:	6.5 MBit/s MCS 0
	rx bitrate:	6.5 MBit/s MCS 0
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	yes
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	2 seconds

PASS ap_open_tdls_vht160 3.651131 2019-02-18 03:49:04.716265
passed all 1 test case(s)
2019-02-18 03:49:04 	./run-tests.py ap_open_tdls_vht80 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_tdls_vht80 1/1
Test: Open AP and two stations using TDLS with VHT 80
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Setup TDLS
Station dump on dev[0]:
Station 02:00:00:00:03:00 (on wlan0)
	inactive time:	43 ms
	rx bytes:	150306
	rx packets:	169
	tx bytes:	64624
	tx packets:	53
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	25
	rx drop misc:	29
	signal:  	-30 dBm
	signal avg:	-30 dBm
	beacon signal avg:	226 dBm
	tx bitrate:	6.5 MBit/s MCS 0
	rx bitrate:	6.5 MBit/s MCS 0
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	no
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	2 seconds
Station 02:00:00:00:01:00 (on wlan0)
	inactive time:	100 ms
	rx bytes:	18306
	rx packets:	16
	tx bytes:	18306
	tx packets:	14
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	25
	rx drop misc:	0
	signal:  	-30 dBm
	signal avg:	-30 dBm
	beacon signal avg:	226 dBm
	tx bitrate:	6.5 MBit/s MCS 0
	rx bitrate:	6.5 MBit/s MCS 0
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	yes
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	2 seconds

Station dump on dev[1]:
Station 02:00:00:00:03:00 (on wlan0)
	inactive time:	65 ms
	rx bytes:	150306
	rx packets:	169
	tx bytes:	64624
	tx packets:	53
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	25
	rx drop misc:	29
	signal:  	-30 dBm
	signal avg:	-30 dBm
	beacon signal avg:	226 dBm
	tx bitrate:	6.5 MBit/s MCS 0
	rx bitrate:	6.5 MBit/s MCS 0
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	no
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	2 seconds
Station 02:00:00:00:01:00 (on wlan0)
	inactive time:	122 ms
	rx bytes:	18306
	rx packets:	16
	tx bytes:	18306
	tx packets:	14
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	25
	rx drop misc:	0
	signal:  	-30 dBm
	signal avg:	-30 dBm
	beacon signal avg:	226 dBm
	tx bitrate:	6.5 MBit/s MCS 0
	rx bitrate:	6.5 MBit/s MCS 0
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	yes
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	2 seconds

PASS ap_open_tdls_vht80 3.933894 2019-02-18 03:49:09.148975
passed all 1 test case(s)
2019-02-18 03:49:09 	./run-tests.py ap_open_tdls_vht80plus80 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_tdls_vht80plus80 1/1
Test: Open AP and two stations using TDLS with VHT 80+80
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Setup TDLS
Station dump on dev[0]:
Station 02:00:00:00:03:00 (on wlan0)
	inactive time:	44 ms
	rx bytes:	150703
	rx packets:	173
	tx bytes:	64624
	tx packets:	53
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	27
	rx drop misc:	29
	signal:  	-30 dBm
	signal avg:	-30 dBm
	beacon signal avg:	226 dBm
	tx bitrate:	6.5 MBit/s MCS 0
	rx bitrate:	6.5 MBit/s MCS 0
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	no
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	3 seconds
Station 02:00:00:00:01:00 (on wlan0)
	inactive time:	71 ms
	rx bytes:	18306
	rx packets:	16
	tx bytes:	18306
	tx packets:	14
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	27
	rx drop misc:	0
	signal:  	-30 dBm
	signal avg:	-30 dBm
	beacon signal avg:	226 dBm
	tx bitrate:	6.5 MBit/s MCS 0
	rx bitrate:	6.5 MBit/s MCS 0
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	yes
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	3 seconds

Station dump on dev[1]:
Station 02:00:00:00:03:00 (on wlan0)
	inactive time:	49 ms
	rx bytes:	150703
	rx packets:	173
	tx bytes:	64624
	tx packets:	53
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	27
	rx drop misc:	29
	signal:  	-30 dBm
	signal avg:	-30 dBm
	beacon signal avg:	226 dBm
	tx bitrate:	6.5 MBit/s MCS 0
	rx bitrate:	6.5 MBit/s MCS 0
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	no
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	3 seconds
Station 02:00:00:00:01:00 (on wlan0)
	inactive time:	76 ms
	rx bytes:	18306
	rx packets:	16
	tx bytes:	18306
	tx packets:	14
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	27
	rx drop misc:	0
	signal:  	-30 dBm
	signal avg:	-30 dBm
	beacon signal avg:	226 dBm
	tx bitrate:	6.5 MBit/s MCS 0
	rx bitrate:	6.5 MBit/s MCS 0
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	yes
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	3 seconds

PASS ap_open_tdls_vht80plus80 4.15715 2019-02-18 03:49:13.840598
passed all 1 test case(s)
2019-02-18 03:49:13 	./run-tests.py ap_open_unexpected_assoc_event 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_unexpected_assoc_event 1/1
Test: AP with open mode and unexpected association event
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_unexpected_assoc_event 1.013542 2019-02-18 03:49:15.422983
passed all 1 test case(s)
2019-02-18 03:49:15 	./run-tests.py ap_open_unknown_action 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_unknown_action 1/1
Test: AP with open mode configuration and unknown Action frame
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_unknown_action 0.466839 2019-02-18 03:49:16.376144
passed all 1 test case(s)
2019-02-18 03:49:16 	./run-tests.py ap_open_wpas_in_bridge 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_wpas_in_bridge 1/1
Test: Open mode AP and wpas interface in a bridge
Starting AP wlan3
Ignore expected interface_add failure due to missing bridge interface: Failed to add a dynamic wpa_supplicant interface
Connect STA wlan5 to AP
PASS ap_open_wpas_in_bridge 0.793123 2019-02-18 03:49:17.652060
passed all 1 test case(s)
2019-02-18 03:49:17 	./run-tests.py ap_pmf_assoc_comeback 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_assoc_comeback 1/1
Test: WPA2-PSK AP with PMF association comeback
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_pmf_assoc_comeback 1.846603 2019-02-18 03:49:19.954055
passed all 1 test case(s)
2019-02-18 03:49:20 	./run-tests.py ap_pmf_assoc_comeback2 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_assoc_comeback2 1/1
Test: WPA2-PSK AP with PMF association comeback (using DROP_SA)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_pmf_assoc_comeback2 1.942487 2019-02-18 03:49:22.519084
passed all 1 test case(s)
2019-02-18 03:49:22 	./run-tests.py ap_pmf_inject_auth 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_inject_auth 1/1
Test: WPA2-PSK AP with PMF and Authentication frame injection
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_pmf_inject_auth 0.475774 2019-02-18 03:49:23.596880
passed all 1 test case(s)
2019-02-18 03:49:23 	./run-tests.py ap_pmf_negative 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_negative 1/1
Test: WPA2-PSK AP without PMF (negative test)
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_pmf_negative 10.580822 2019-02-18 03:49:34.679440
passed all 1 test case(s)
2019-02-18 03:49:34 	./run-tests.py ap_pmf_optional 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_optional 1/1
Test: WPA2-PSK AP with PMF optional
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_pmf_optional 0.739529 2019-02-18 03:49:35.842875
passed all 1 test case(s)
2019-02-18 03:49:35 	./run-tests.py ap_pmf_optional_2akm 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_optional_2akm 1/1
Test: WPA2-PSK AP with PMF optional (2 AKMs)
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_pmf_optional_2akm 0.756945 2019-02-18 03:49:37.088057
passed all 1 test case(s)
2019-02-18 03:49:37 	./run-tests.py ap_pmf_optional_eap 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_optional_eap 1/1
Test: WPA2EAP AP with PMF optional
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_pmf_optional_eap 0.734661 2019-02-18 03:49:38.260818
passed all 1 test case(s)
2019-02-18 03:49:38 	./run-tests.py ap_pmf_required 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_required 1/1
Test: WPA2-PSK AP with PMF required
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_pmf_required 0.832322 2019-02-18 03:49:39.540459
passed all 1 test case(s)
2019-02-18 03:49:39 	./run-tests.py ap_pmf_required_eap 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_required_eap 1/1
Test: WPA2-EAP AP with PMF required
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_pmf_required_eap 0.688298 2019-02-18 03:49:40.722560
passed all 1 test case(s)
2019-02-18 03:49:40 	./run-tests.py ap_pmf_required_sha1 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_required_sha1 1/1
Test: WPA2-PSK AP with PMF required with SHA1 AKM
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_pmf_required_sha1 0.501929 2019-02-18 03:49:41.683135
passed all 1 test case(s)
2019-02-18 03:49:41 	./run-tests.py ap_pmf_required_sta_no_pmf 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_required_sta_no_pmf 1/1
Test: WPA2-PSK AP with PMF required and PMF disabled on STA
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_pmf_required_sta_no_pmf 0.521766 2019-02-18 03:49:42.635987
passed all 1 test case(s)
2019-02-18 03:49:42 	./run-tests.py ap_pmf_sta_sa_query 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_sta_sa_query 1/1
Test: WPA2-PSK AP with station using SA Query
Connect STA wlan0 to AP
PASS ap_pmf_sta_sa_query 2.876061 2019-02-18 03:49:45.994251
passed all 1 test case(s)
2019-02-18 03:49:46 	./run-tests.py ap_pmf_sta_sa_query_local_failure 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_sta_sa_query_local_failure 1/1
Test: WPA2-PSK AP with station using SA Query (local failure)
Connect STA wlan0 to AP
PASS ap_pmf_sta_sa_query_local_failure 1.023772 2019-02-18 03:49:47.517876
passed all 1 test case(s)
2019-02-18 03:49:47 	./run-tests.py ap_pmf_sta_sa_query_no_response 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_sta_sa_query_no_response 1/1
Test: WPA2-PSK AP with station using SA Query and getting no response
Connect STA wlan0 to AP
PASS ap_pmf_sta_sa_query_no_response 4.428357 2019-02-18 03:49:52.652890
passed all 1 test case(s)
2019-02-18 03:49:52 	./run-tests.py ap_pmf_sta_sa_query_oom 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_sta_sa_query_oom 1/1
Test: WPA2-PSK AP with station using SA Query (OOM)
Connect STA wlan0 to AP
PASS ap_pmf_sta_sa_query_oom 1.088031 2019-02-18 03:49:54.243853
passed all 1 test case(s)
2019-02-18 03:49:54 	./run-tests.py ap_pmf_sta_unprot_deauth_burst 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_sta_unprot_deauth_burst 1/1
Test: WPA2-PSK AP with station receiving burst of unprotected Deauthentication frames
Connect STA wlan0 to AP
PASS ap_pmf_sta_unprot_deauth_burst 13.33517 2019-02-18 03:50:08.062647
passed all 1 test case(s)
2019-02-18 03:50:08 	./run-tests.py ap_pmf_tkip_reject 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_tkip_reject 1/1
Test: Mixed mode BSS and MFP-enabled AP rejecting TKIP
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
PASS ap_pmf_tkip_reject 1.675624 2019-02-18 03:50:10.533035
passed all 1 test case(s)
2019-02-18 03:50:10 	./run-tests.py ap_pmf_toggle 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_toggle 1/1
Test: WPA2-PSK AP with PMF optional and changing PMF on reassociation
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_pmf_toggle 1.089346 2019-02-18 03:50:12.194528
passed all 1 test case(s)
2019-02-18 03:50:12 	./run-tests.py ap_qosmap 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_qosmap 1/1
Test: QoS mapping
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_qosmap 1.501566 2019-02-18 03:50:14.306758
passed all 1 test case(s)
2019-02-18 03:50:14 	./run-tests.py ap_qosmap_default 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_qosmap_default 1/1
Test: QoS mapping with default values
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_qosmap_default 1.316463 2019-02-18 03:50:16.189782
passed all 1 test case(s)
2019-02-18 03:50:16 	./run-tests.py ap_qosmap_default_acm 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_qosmap_default_acm 1/1
Test: QoS mapping with default values and ACM=1 for VO/VI
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_qosmap_default_acm 1.281505 2019-02-18 03:50:18.165012
passed all 1 test case(s)
2019-02-18 03:50:18 	./run-tests.py ap_qosmap_invalid 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_qosmap_invalid 1/1
Test: QoS mapping ctrl_iface error handling
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_qosmap_invalid 0.620016 2019-02-18 03:50:19.658660
passed all 1 test case(s)
2019-02-18 03:50:19 	./run-tests.py ap_reassociation_to_same_bss 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_reassociation_to_same_bss 1/1
Test: Reassociate to the same BSS
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_reassociation_to_same_bss 10.23471 2019-02-18 03:50:30.490735
passed all 1 test case(s)
2019-02-18 03:50:30 	./run-tests.py ap_reconnect_auth_timeout 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_reconnect_auth_timeout 1/1
Test: Reconnect to 2nd AP and authentication times out
Starting AP wlan3
Connect STA wlan5 to AP
Starting AP wlan4
Wait ~10s for auth timeout...
PASS ap_reconnect_auth_timeout 11.801595 2019-02-18 03:50:42.870953
passed all 1 test case(s)
2019-02-18 03:50:42 	./run-tests.py ap_remove_during_acs 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_remove_during_acs 1/1
Test: Remove interface during ACS
Starting AP wlan3
Removing BSS wlan3
Starting AP wlan3
Removing BSS wlan3
PASS ap_remove_during_acs 7.360816 2019-02-18 03:50:50.758836
passed all 1 test case(s)
2019-02-18 03:50:50 	./run-tests.py ap_remove_during_acs2 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_remove_during_acs2 1/1
Test: Remove BSS during ACS in multi-BSS configuration
Starting AP wlan3
Removing BSS wlan3
Starting AP wlan3
Removing BSS wlan3
PASS ap_remove_during_acs2 0.773318 2019-02-18 03:50:52.285577
passed all 1 test case(s)
2019-02-18 03:50:52 	./run-tests.py ap_remove_during_acs3 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_remove_during_acs3 1/1
Test: Remove second BSS during ACS in multi-BSS configuration
Starting AP wlan3
Removing BSS wlan3
Starting AP wlan3
Removing BSS wlan3-2
PASS ap_remove_during_acs3 0.706935 2019-02-18 03:50:53.825074
passed all 1 test case(s)
2019-02-18 03:50:53 	./run-tests.py ap_remove_during_ht_coex_scan 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_remove_during_ht_coex_scan 1/1
Test: Remove interface during HT co-ex scan
Starting AP wlan3
Removing BSS wlan3
PASS ap_remove_during_ht_coex_scan 1.761081 2019-02-18 03:50:56.324913
passed all 1 test case(s)
2019-02-18 03:50:56 	./run-tests.py ap_remove_during_ht_coex_scan2 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_remove_during_ht_coex_scan2 1/1
Test: Remove BSS during HT co-ex scan in multi-BSS configuration
Starting AP wlan3
Removing BSS wlan3
PASS ap_remove_during_ht_coex_scan2 0.297697 2019-02-18 03:50:57.365153
passed all 1 test case(s)
2019-02-18 03:50:57 	./run-tests.py ap_remove_during_ht_coex_scan3 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_remove_during_ht_coex_scan3 1/1
Test: Remove second BSS during HT co-ex scan in multi-BSS configuration
Starting AP wlan3
Removing BSS wlan3-2
PASS ap_remove_during_ht_coex_scan3 0.287574 2019-02-18 03:50:58.504939
passed all 1 test case(s)
2019-02-18 03:50:58 	./run-tests.py ap_require_ht 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_require_ht 1/1
Test: Require HT
Starting AP wlan3
Connect STA wlan1 to AP
Connect STA wlan0 to AP
Connect STA wlan2 to AP
PASS ap_require_ht 6.152003 2019-02-18 03:51:05.399988
passed all 1 test case(s)
2019-02-18 03:51:05 	./run-tests.py ap_require_ht_limited_rates 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_require_ht_limited_rates 1/1
Test: Require HT with limited supported rates
Starting AP wlan3
Connect STA wlan1 to AP
Connect STA wlan0 to AP
PASS ap_require_ht_limited_rates 5.709097 2019-02-18 03:51:12.178598
passed all 1 test case(s)
2019-02-18 03:51:12 	./run-tests.py ap_roam_open 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_roam_open 1/1
Test: Roam between two open APs
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan4
PASS ap_roam_open 16.610558 2019-02-18 03:51:29.945006
passed all 1 test case(s)
2019-02-18 03:51:30 	./run-tests.py ap_roam_open_failed 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_roam_open_failed 1/1
Test: Roam failure due to rejected authentication
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan4
PASS ap_roam_open_failed 1.610171 2019-02-18 03:51:32.504307
passed all 1 test case(s)
2019-02-18 03:51:32 	./run-tests.py ap_roam_set_bssid 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_roam_set_bssid 1/1
Test: Roam control
Starting AP wlan3
Starting AP wlan4
Connect STA wlan0 to AP
PASS ap_roam_set_bssid 0.987355 2019-02-18 03:51:34.254787
passed all 1 test case(s)
2019-02-18 03:51:34 	./run-tests.py ap_roam_with_reassoc_auth_timeout 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_roam_with_reassoc_auth_timeout 1/1
Test: Roam using reassoc between two APs and authentication times out
Starting AP wlan3
Connect STA wlan5 to AP
Starting AP wlan4
Wait ~10s for auth timeout...
PASS ap_roam_with_reassoc_auth_timeout 12.445467 2019-02-18 03:51:47.578201
passed all 1 test case(s)
2019-02-18 03:51:47 	./run-tests.py ap_roam_wpa2_psk 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_roam_wpa2_psk 1/1
Test: Roam between two WPA2-PSK APs
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan4
PASS ap_roam_wpa2_psk 17.391712 2019-02-18 03:52:06.129840
passed all 1 test case(s)
2019-02-18 03:52:06 	./run-tests.py ap_roam_wpa2_psk_failed 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_roam_wpa2_psk_failed 1/1
Test: Roam failure with WPA2-PSK AP due to wrong passphrase
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan4
PASS ap_roam_wpa2_psk_failed 5.745806 2019-02-18 03:52:12.834889
passed all 1 test case(s)
2019-02-18 03:52:12 	./run-tests.py ap_roam_wpa2_psk_race 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_roam_wpa2_psk_race 1/1
Test: Roam between two WPA2-PSK APs and try to hit a disconnection race
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan4
PASS ap_roam_wpa2_psk_race 4.286711 2019-02-18 03:52:18.119818
passed all 1 test case(s)
2019-02-18 03:52:18 	./run-tests.py ap_short_preamble 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_short_preamble 1/1
Test: Open AP with short preamble
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_short_preamble 0.702471 2019-02-18 03:52:19.815715
passed all 1 test case(s)
2019-02-18 03:52:19 	./run-tests.py ap_spectrum_management_required 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_spectrum_management_required 1/1
Test: Open AP with spectrum management required
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_spectrum_management_required 0.881917 2019-02-18 03:52:21.703931
passed all 1 test case(s)
2019-02-18 03:52:21 	./run-tests.py ap_tdls_chan_switch_prohibit 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_tdls_chan_switch_prohibit 1/1
Test: Open AP and TDLS channel switch prohibited
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Setup TDLS
PASS ap_tdls_chan_switch_prohibit 2.594155 2019-02-18 03:52:25.101262
passed all 1 test case(s)
2019-02-18 03:52:25 	./run-tests.py ap_tdls_discovery 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_tdls_discovery 1/1
Test: WPA2-PSK AP and two stations using TDLS discovery
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_tdls_discovery 1.54158 2019-02-18 03:52:27.343200
passed all 1 test case(s)
2019-02-18 03:52:27 	./run-tests.py ap_tdls_link_status 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_tdls_link_status 1/1
Test: Check TDLS link status between two stations
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
wlan0: TDLS link status: peer does not exist
wlan1: TDLS link status: peer does not exist
Setup TDLS
wlan0: TDLS link status: connected
wlan1: TDLS link status: connected
Teardown TDLS
wlan0: TDLS link status: peer does not exist
wlan1: TDLS link status: peer does not exist
PASS ap_tdls_link_status 3.883501 2019-02-18 03:52:31.930046
passed all 1 test case(s)
2019-02-18 03:52:32 	./run-tests.py ap_tdls_prohibit 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_tdls_prohibit 1/1
Test: Open AP and TDLS prohibited
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_tdls_prohibit 1.340085 2019-02-18 03:52:34.333396
passed all 1 test case(s)
2019-02-18 03:52:34 	./run-tests.py ap_track_sta 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_track_sta 1/1
Test: Dualband AP tracking unconnected stations
Starting AP wlan3
Starting AP wlan4
PASS ap_track_sta 3.278663 2019-02-18 03:52:38.424321
passed all 1 test case(s)
2019-02-18 03:52:38 	./run-tests.py ap_track_sta_force_2ghz 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_track_sta_force_2ghz 1/1
Test: Dualband AP forcing dualband STA to connect on 2.4 GHz
Starting AP wlan3
Starting AP wlan4
Connect STA wlan0 to AP
PASS ap_track_sta_force_2ghz 1.66752 2019-02-18 03:52:40.984266
passed all 1 test case(s)
2019-02-18 03:52:41 	./run-tests.py ap_track_sta_force_5ghz 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_track_sta_force_5ghz 1/1
Test: Dualband AP forcing dualband STA to connect on 5 GHz
Starting AP wlan3
Starting AP wlan4
Connect STA wlan0 to AP
PASS ap_track_sta_force_5ghz 1.232844 2019-02-18 03:52:42.834494
passed all 1 test case(s)
2019-02-18 03:52:42 	./run-tests.py ap_track_sta_no_auth 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_track_sta_no_auth 1/1
Test: Dualband AP rejecting authentication from dualband STA on 2.4 GHz
Starting AP wlan3
Starting AP wlan4
Connect STA wlan1 to AP
Connect STA wlan0 to AP
PASS ap_track_sta_no_auth 1.321395 2019-02-18 03:52:45.095514
passed all 1 test case(s)
2019-02-18 03:52:45 	./run-tests.py ap_track_sta_no_auth_passive 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_track_sta_no_auth_passive 1/1
Test: AP rejecting authentication from dualband STA on 2.4 GHz (passive)
Starting AP wlan3
Starting AP wlan4
Connect STA wlan0 to AP
PASS ap_track_sta_no_auth_passive 1.383806 2019-02-18 03:52:47.236338
passed all 1 test case(s)
2019-02-18 03:52:47 	./run-tests.py ap_track_sta_no_probe_resp 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_track_sta_no_probe_resp 1/1
Test: Dualband AP not replying to probes from dualband STA on 2.4 GHz
Starting AP wlan3
Starting AP wlan4
PASS ap_track_sta_no_probe_resp 1.290614 2019-02-18 03:52:49.379728
passed all 1 test case(s)
2019-02-18 03:52:49 	./run-tests.py ap_track_taxonomy 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_track_taxonomy 1/1
Test: AP tracking STA taxonomy
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan5 to AP
sta0: wifi4|probe:0,1,50,3,45,127,255,221(0050f2,4),221(506f9a,9),114,221(506f9a,22),htcap:107e,htagg:1b,htmcs:0000ffff,extcap:04000a02014000400001,wps:_|assoc:0,1,50,45,127,59,221(0050f2,2),htcap:1076,htagg:1b,htmcs:0000ffff,extcap:04000a02014000400001
sta1: wifi4|probe:0,1,50,3,45,127,114,255,221(506f9a,22),htcap:107e,htagg:1b,htmcs:0000ffff,extcap:04000a02014000400001|assoc:0,1,50,45,127,59,221(0050f2,2),htcap:1076,htagg:1b,htmcs:0000ffff,extcap:04000a02014000400001
sta: wifi4|probe:0,1,50,3,45,127,255,221(0050f2,4),221(506f9a,9),114,221(506f9a,22),htcap:107e,htagg:1b,htmcs:0000ffff,extcap:04000a02014000400001,wps:track_test|assoc:0,1,50,45,127,59,221(0050f2,2),htcap:1076,htagg:1b,htmcs:0000ffff,extcap:04000a02014000400001
Connect STA wlan2 to AP
sta2: wifi4|probe:0,1,50,3,45,127,255,221(0050f2,4),221(506f9a,9),114,221(506f9a,22),htcap:107e,htagg:1b,htmcs:0000ffff,extcap:04000a02014000400001,wps:_|assoc:0,1,50,45,127,59,221(0050f2,2),htcap:1076,htagg:1b,htmcs:0000ffff,extcap:04000a02014000400001
flush_scan_cache: Could not clear all BSS entries. These remain:
bssid / frequency / signal level / flags / ssid
02:00:00:00:03:00	2437	-30	[ESS]	track

flush_scan_cache: Could not clear all BSS entries. These remain:
bssid / frequency / signal level / flags / ssid
02:00:00:00:03:00	2437	-30	[ESS]	track

flush_scan_cache: Could not clear all BSS entries. These remain:
bssid / frequency / signal level / flags / ssid
02:00:00:00:03:00	2437	-30	[ESS]	track

PASS ap_track_taxonomy 3.6158 2019-02-18 03:52:54.032243
passed all 1 test case(s)
2019-02-18 03:52:54 	./run-tests.py ap_tx_queue_params 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_tx_queue_params 1/1
Test: Open AP with TX queue params set
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_tx_queue_params 0.902553 2019-02-18 03:52:55.662101
passed all 1 test case(s)
2019-02-18 03:52:55 	./run-tests.py ap_tx_queue_params_invalid 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_tx_queue_params_invalid 1/1
Test: Invalid TX queue params set (cwmin/cwmax)
Starting AP wlan3
PASS ap_tx_queue_params_invalid 0.612112 2019-02-18 03:52:56.962271
passed all 1 test case(s)
2019-02-18 03:52:57 	./run-tests.py ap_vendor_elements 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vendor_elements 1/1
Test: WPA2-PSK AP with vendor elements added
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vendor_elements 1.113925 2019-02-18 03:52:59.048956
passed all 1 test case(s)
ignored_by_lkp ap_vht160
2019-02-18 03:52:59 	./run-tests.py ap_vht160_no_dfs 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht160_no_dfs 1/1
Test: VHT with 160 MHz channel width and no DFS (104 minus)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht160_no_dfs 1.453284 2019-02-18 03:53:01.472052
passed all 1 test case(s)
2019-02-18 03:53:01 	./run-tests.py ap_vht160_no_dfs_100_plus 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht160_no_dfs_100_plus 1/1
Test: VHT with 160 MHz channel width and no DFS (100 plus)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht160_no_dfs_100_plus 1.529072 2019-02-18 03:53:04.038338
passed all 1 test case(s)
2019-02-18 03:53:04 	./run-tests.py ap_vht160_no_dfs_108_plus 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht160_no_dfs_108_plus 1/1
Test: VHT with 160 MHz channel width and no DFS (108 plus)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht160_no_dfs_108_plus 1.368689 2019-02-18 03:53:06.085228
passed all 1 test case(s)
2019-02-18 03:53:06 	./run-tests.py ap_vht160_no_dfs_112_minus 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht160_no_dfs_112_minus 1/1
Test: VHT with 160 MHz channel width and no DFS (112 minus)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht160_no_dfs_112_minus 1.308186 2019-02-18 03:53:08.216280
passed all 1 test case(s)
2019-02-18 03:53:08 	./run-tests.py ap_vht160_no_dfs_116_plus 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht160_no_dfs_116_plus 1/1
Test: VHT with 160 MHz channel width and no DFS (116 plus)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht160_no_dfs_116_plus 1.319312 2019-02-18 03:53:10.347411
passed all 1 test case(s)
2019-02-18 03:53:10 	./run-tests.py ap_vht160_no_dfs_120_minus 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht160_no_dfs_120_minus 1/1
Test: VHT with 160 MHz channel width and no DFS (120 minus)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht160_no_dfs_120_minus 1.265689 2019-02-18 03:53:12.308748
passed all 1 test case(s)
2019-02-18 03:53:12 	./run-tests.py ap_vht160_no_dfs_124_plus 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht160_no_dfs_124_plus 1/1
Test: VHT with 160 MHz channel width and no DFS (124 plus)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht160_no_dfs_124_plus 1.289689 2019-02-18 03:53:14.594918
passed all 1 test case(s)
2019-02-18 03:53:14 	./run-tests.py ap_vht160_no_dfs_128_minus 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht160_no_dfs_128_minus 1/1
Test: VHT with 160 MHz channel width and no DFS (128 minus)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht160_no_dfs_128_minus 1.26795 2019-02-18 03:53:16.726790
passed all 1 test case(s)
2019-02-18 03:53:16 	./run-tests.py ap_vht160_no_ht40 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht160_no_ht40 1/1
Test: VHT with 160 MHz channel width and HT40 disabled
Starting AP wlan3
PASS ap_vht160_no_ht40 0.298702 2019-02-18 03:53:17.937075
passed all 1 test case(s)
2019-02-18 03:53:18 	./run-tests.py ap_vht160b 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht160b 1/1
Test: VHT with 160 MHz channel width (2)
Starting AP wlan4
Waiting for CAC to complete
Connect STA wlan0 to AP
PASS ap_vht160b 63.447712 2019-02-18 03:54:22.289042
passed all 1 test case(s)
2019-02-18 03:54:22 	./run-tests.py ap_vht80 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80 1/1
Test: VHT with 80 MHz channel width
Starting AP wlan3
Connect STA wlan0 to AP
hostapd STATUS: {'olbc_ht': '0', 'cac_time_left_seconds': 'N/A', 'num_sta_no_short_slot_time': '1', 'vht_caps_info': '00000000', 'olbc': '0', 'vht_oper_centr_freq_seg0_idx': '42', 'num_sta_non_erp': '0', 'supported_rates': '0c 12 18 24 30 48 60 6c', 'ht_op_mode': '0x0', 'tx_vht_mcs_map': 'aaaa', 'state': 'ENABLED', 'vht_oper_centr_freq_seg1_idx': '0', 'num_sta_ht40_intolerant': '0', 'channel': '36', 'ht_mcs_bitmask': 'ffff0000000000000000', 'vht_oper_chwidth': '1', 'bssid[0]': '02:00:00:00:03:00', 'ieee80211n': '1', 'cac_time_seconds': '0', 'num_sta[0]': '1', 'ieee80211ac': '1', 'phy': 'phy3', 'max_txpower': '23', 'num_sta_ht_no_gf': '0', 'freq': '5180', 'num_sta_ht_20_mhz': '0', 'num_sta_no_short_preamble': '1', 'secondary_channel': '1', 'rx_vht_mcs_map': 'aaaa', 'ssid[0]': 'vht', 'dtim_period': '2', 'beacon_int': '100', 'num_sta_no_ht': '0', 'bss[0]': 'wlan3', 'ht_caps_info': '000e'}
hostapd STA: {'connected_time': '0', 'vht_caps_info': '0x038004fa', 'capability': '0x1', 'addr': '02:00:00:00:00:00', 'rx_vht_mcs_map': 'aaaa', 'supp_op_classes': '73515354737475767778797a7b808182', 'supported_rates': '0c 12 18 24 30 48 60 6c', 'tx_vht_mcs_map': 'aaaa', 'tx_packets': '6', 'ht_mcs_bitmask': 'ffff0000000000000000', 'rx_packets': '10', 'ext_capab': '04000a02014000400001', 'rx_rate_info': '1300 vhtmcs 7 vhtnss 2', 'tx_bytes': '1797', 'tx_rate_info': '65 mcs 0', 'timeout_next': 'NULLFUNC POLL', 'rx_bytes': '3367', 'signal': '-30', 'inactive_msec': '15', 'listen_interval': '5', 'flags': '[AUTH][ASSOC][AUTHORIZED][WMM][HT][VHT]', 'aid': '1', 'ht_caps_info': '0x1076'}
PASS ap_vht80 0.827731 2019-02-18 03:54:23.642805
passed all 1 test case(s)
2019-02-18 03:54:23 	./run-tests.py ap_vht80_csa 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80_csa 1/1
Test: VHT with 80 MHz channel width and CSA
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht80_csa 3.670639 2019-02-18 03:54:27.866965
passed all 1 test case(s)
2019-02-18 03:54:27 	./run-tests.py ap_vht80_invalid 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80_invalid 1/1
Test: VHT with invalid 80 MHz channel configuration (seg1)
Starting AP wlan3
PASS ap_vht80_invalid 0.414459 2019-02-18 03:54:28.658308
passed all 1 test case(s)
2019-02-18 03:54:28 	./run-tests.py ap_vht80_invalid2 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80_invalid2 1/1
Test: VHT with invalid 80 MHz channel configuration (seg0)
Starting AP wlan3
PASS ap_vht80_invalid2 0.407354 2019-02-18 03:54:29.619404
passed all 1 test case(s)
2019-02-18 03:54:29 	./run-tests.py ap_vht80_params 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80_params 1/1
Test: VHT with 80 MHz channel width and number of optional features enabled
Starting AP wlan3
Connect STA wlan1 to AP
Connect STA wlan0 to AP
PASS ap_vht80_params 0.978619 2019-02-18 03:54:31.087551
passed all 1 test case(s)
2019-02-18 03:54:31 	./run-tests.py ap_vht80_pwr_constraint 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80_pwr_constraint 1/1
Test: VHT with 80 MHz channel width and local power constraint
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht80_pwr_constraint 0.760777 2019-02-18 03:54:32.340006
passed all 1 test case(s)
2019-02-18 03:54:32 	./run-tests.py ap_vht80_to_24g_ht 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80_to_24g_ht 1/1
Test: VHT with 80 MHz channel width reconfigured to 2.4 GHz HT
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht80_to_24g_ht 0.956588 2019-02-18 03:54:33.780176
passed all 1 test case(s)
2019-02-18 03:54:33 	./run-tests.py ap_vht80b 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80b 1/1
Test: VHT with 80 MHz channel width (HT40- channel 40)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht80b 0.968629 2019-02-18 03:54:35.292958
passed all 1 test case(s)
2019-02-18 03:54:35 	./run-tests.py ap_vht80c 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80c 1/1
Test: VHT with 80 MHz channel width (HT40+ channel 44)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht80c 0.949574 2019-02-18 03:54:36.726849
passed all 1 test case(s)
2019-02-18 03:54:36 	./run-tests.py ap_vht80d 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80d 1/1
Test: VHT with 80 MHz channel width (HT40- channel 48)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht80d 1.053612 2019-02-18 03:54:38.260818
passed all 1 test case(s)
2019-02-18 03:54:38 	./run-tests.py ap_vht80plus80 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80plus80 1/1
Test: VHT with 80+80 MHz channel width
Starting AP wlan3
Starting AP wlan4
Connect STA wlan1 to AP
PASS ap_vht80plus80 1.194404 2019-02-18 03:54:39.994603
passed all 1 test case(s)
2019-02-18 03:54:40 	./run-tests.py ap_vht80plus80_invalid 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80plus80_invalid 1/1
Test: VHT with invalid 80+80 MHz channel
Starting AP wlan3
PASS ap_vht80plus80_invalid 0.468483 2019-02-18 03:54:40.909884
passed all 1 test case(s)
2019-02-18 03:54:40 	./run-tests.py ap_vht_20 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht_20 1/1
Test: VHT and 20 MHz channel
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht_20 0.616448 2019-02-18 03:54:42.105781
passed all 1 test case(s)
2019-02-18 03:54:42 	./run-tests.py ap_vht_40 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht_40 1/1
Test: VHT and 40 MHz channel
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht_40 0.874736 2019-02-18 03:54:43.468565
passed all 1 test case(s)
2019-02-18 03:54:43 	./run-tests.py ap_vht_40_fallback_to_20 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht_40_fallback_to_20 1/1
Test: VHT and 40 MHz channel configuration falling back to 20 MHz
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht_40_fallback_to_20 0.848963 2019-02-18 03:54:44.783780
passed all 1 test case(s)
2019-02-18 03:54:44 	./run-tests.py ap_vht_capab_not_supported 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht_capab_not_supported 1/1
Test: VHT configuration with driver not supporting all vht_capab entries
Starting AP wlan3
PASS ap_vht_capab_not_supported 0.151441 2019-02-18 03:54:45.378652
passed all 1 test case(s)
2019-02-18 03:54:45 	./run-tests.py ap_vht_csa_vht20 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht_csa_vht20 1/1
Test: VHT CSA with VHT20 getting enabled
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_vht_csa_vht20 2.649841 2019-02-18 03:54:48.507921
passed all 1 test case(s)
2019-02-18 03:54:48 	./run-tests.py ap_vht_csa_vht40 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht_csa_vht40 1/1
Test: VHT CSA with VHT40 getting enabled
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_vht_csa_vht40 3.187669 2019-02-18 03:54:52.404297
passed all 1 test case(s)
2019-02-18 03:54:52 	./run-tests.py ap_vht_csa_vht40_disable 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht_csa_vht40_disable 1/1
Test: VHT CSA with VHT40 getting disabled
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_vht_csa_vht40_disable 3.062347 2019-02-18 03:54:56.469628
passed all 1 test case(s)
2019-02-18 03:54:56 	./run-tests.py ap_vht_on_24ghz 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht_on_24ghz 1/1
Test: Subset of VHT features on 2.4 GHz
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_vht_on_24ghz 1.5841 2019-02-18 03:54:58.908579
passed all 1 test case(s)
2019-02-18 03:54:59 	./run-tests.py ap_vht_tkip 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht_tkip 1/1
Test: VHT and TKIP
Starting AP wlan3
Connect STA wlan0 to AP
hostapd STATUS: {'olbc_ht': '0', 'cac_time_left_seconds': 'N/A', 'num_sta_no_short_slot_time': '1', 'olbc': '0', 'num_sta_non_erp': '0', 'supported_rates': '0c 12 18 24 30 48 60 6c', 'ht_op_mode': '0x13', 'state': 'ENABLED', 'num_sta_ht40_intolerant': '0', 'channel': '36', 'bssid[0]': '02:00:00:00:03:00', 'ieee80211n': '0', 'cac_time_seconds': '0', 'num_sta[0]': '1', 'ieee80211ac': '0', 'phy': 'phy3', 'max_txpower': '23', 'num_sta_ht_no_gf': '0', 'freq': '5180', 'num_sta_ht_20_mhz': '0', 'num_sta_no_short_preamble': '1', 'secondary_channel': '0', 'ssid[0]': 'vht', 'dtim_period': '2', 'beacon_int': '100', 'num_sta_no_ht': '1', 'bss[0]': 'wlan3'}
PASS ap_vht_tkip 1.818004 2019-02-18 03:55:01.709886
passed all 1 test case(s)
2019-02-18 03:55:01 	./run-tests.py ap_vht_use_sta_nsts 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht_use_sta_nsts 1/1
Test: VHT with 80 MHz channel width and use_sta_nsts=1
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht_use_sta_nsts 1.212397 2019-02-18 03:55:03.824251
passed all 1 test case(s)
2019-02-18 03:55:03 	./run-tests.py ap_vlan_file_open 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_file_open 1/1
Test: AP VLAN with open network and vlan_file mapping
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
PASS ap_vlan_file_open 2.172376 2019-02-18 03:55:06.670709
passed all 1 test case(s)
2019-02-18 03:55:06 	./run-tests.py ap_vlan_file_open2 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_file_open2 1/1
Test: AP VLAN with open network and vlan_file mapping (2)
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
PASS ap_vlan_file_open2 1.834327 2019-02-18 03:55:09.166559
passed all 1 test case(s)
2019-02-18 03:55:09 	./run-tests.py ap_vlan_file_parsing 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_file_parsing 1/1
Test: hostapd vlan_file/mac_file parsing
Starting AP wlan3
PASS ap_vlan_file_parsing 0.617818 2019-02-18 03:55:10.321704
passed all 1 test case(s)
2019-02-18 03:55:10 	./run-tests.py ap_vlan_iface_cleanup_multibss 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_iface_cleanup_multibss 1/1
Test: AP VLAN operation in multi-BSS multi-VLAN case
RTNETLINK answers: File exists
Starting AP wlan4
Starting interface wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
wlan0 -> VLAN 2
test wlan1 == VLAN 1
wlan1 -> VLAN 2
test wlan0 == VLAN 2
PASS ap_vlan_iface_cleanup_multibss 6.159491 2019-02-18 03:55:17.360016
passed all 1 test case(s)
2019-02-18 03:55:17 	./run-tests.py ap_vlan_iface_cleanup_multibss_per_sta_vif 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_iface_cleanup_multibss_per_sta_vif 1/1
Test: AP VLAN operation in multi-BSS multi-VLAN case with per-sta-vif set
Starting AP wlan4
Starting interface wlan3
Connect STA wlan0 to AP
dev1->dev2 unicast data delivery failed
Traceback (most recent call last):
  File "./run-tests.py", line 466, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_ap_vlan.py", line 505, in test_ap_vlan_iface_cleanup_multibss_per_sta_vif
    'multi-bss-iface-per_sta_vif.conf')
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_ap_vlan.py", line 404, in ap_vlan_iface_cleanup_multibss
    hwsim_utils.test_connectivity_iface(dev[0], hapd, "brvlan1")
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 176, in test_connectivity_iface
    max_tries=max_tries, timeout=timeout)
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 169, in test_connectivity
    raise Exception(last_err)
Exception: dev1->dev2 unicast data delivery failed
FAIL ap_vlan_iface_cleanup_multibss_per_sta_vif 7.965708 2019-02-18 03:55:25.909762
passed 0 test case(s)
skipped 0 test case(s)
failed tests: ap_vlan_iface_cleanup_multibss_per_sta_vif
2019-02-18 03:55:26 	./run-tests.py ap_vlan_open 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_open 1/1
Test: AP VLAN with open network
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
PASS ap_vlan_open 2.102242 2019-02-18 03:55:28.763859
passed all 1 test case(s)
2019-02-18 03:55:28 	./run-tests.py ap_vlan_open_per_sta_vif 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_open_per_sta_vif 1/1
Test: AP VLAN (dynamic) with open network
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vlan_open_per_sta_vif 0.847503 2019-02-18 03:55:30.465482
passed all 1 test case(s)
2019-02-18 03:55:30 	./run-tests.py ap_vlan_reconnect 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_reconnect 1/1
Test: AP VLAN with WPA2-PSK connect, disconnect, connect
Starting AP wlan3
connect sta
Connect STA wlan0 to AP
disconnect sta
reconnect sta
Connect STA wlan0 to AP
PASS ap_vlan_reconnect 2.54459 2019-02-18 03:55:33.672956
passed all 1 test case(s)
2019-02-18 03:55:33 	./run-tests.py ap_vlan_tagged 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_tagged 1/1
Test: AP VLAN with tagged interface
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
PASS ap_vlan_tagged 2.285961 2019-02-18 03:55:36.723342
passed all 1 test case(s)
2019-02-18 03:55:36 	./run-tests.py ap_vlan_tagged_wpa2_radius_id_change 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_tagged_wpa2_radius_id_change 1/1
Test: AP tagged VLAN with WPA2-Enterprise and RADIUS attributes changing VLANID
Starting AP wlan4
Starting AP wlan3
Connect STA wlan0 to AP
VLAN-ID -> 2
VLAN-ID -> 1
PASS ap_vlan_tagged_wpa2_radius_id_change 4.797598 2019-02-18 03:55:42.210015
passed all 1 test case(s)
2019-02-18 03:55:42 	./run-tests.py ap_vlan_without_station 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_without_station 1/1
Test: AP VLAN with WPA2-PSK and no station
Starting AP wlan3
Connect STA wlan0 to AP
first frame not observed
second frame not observed
Traceback (most recent call last):
  File "./run-tests.py", line 464, in main
    t(dev, apdev, params)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_ap_vlan.py", line 569, in test_ap_vlan_without_station
    raise Exception("second frame not observed")
Exception: second frame not observed
FAIL ap_vlan_without_station 3.525371 2019-02-18 03:55:46.600545
passed 0 test case(s)
skipped 0 test case(s)
failed tests: ap_vlan_without_station
2019-02-18 03:55:46 	./run-tests.py ap_vlan_wpa2 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_wpa2 1/1
Test: AP VLAN with WPA2-PSK
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
PASS ap_vlan_wpa2 1.968433 2019-02-18 03:55:49.347561
passed all 1 test case(s)
2019-02-18 03:55:49 	./run-tests.py ap_vlan_wpa2_psk_radius_required 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_wpa2_psk_radius_required 1/1
Test: AP VLAN with WPA2-PSK and RADIUS attributes required
Starting AP wlan3
connecting without VLAN
Connect STA wlan0 to AP
Received authentication request
connecting without VLAN failed as expected
connecting without VLAN (CUI/User-Name)
Connect STA wlan1 to AP
Received authentication request
connecting without VLAN failed as expected(2)
connecting with VLAN
Connect STA wlan2 to AP
Received authentication request
connecting with VLAN succeeded as expected
PASS ap_vlan_wpa2_psk_radius_required 6.585046 2019-02-18 03:55:56.784261
passed all 1 test case(s)
2019-02-18 03:55:56 	./run-tests.py ap_vlan_wpa2_radius 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_wpa2_radius 1/1
Test: AP VLAN with WPA2-Enterprise and RADIUS attributes
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
PASS ap_vlan_wpa2_radius 2.196264 2019-02-18 03:55:59.592897
passed all 1 test case(s)
2019-02-18 03:55:59 	./run-tests.py ap_vlan_wpa2_radius_2 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_wpa2_radius_2 1/1
Test: AP VLAN with WPA2-Enterprise and RADIUS EGRESS_VLANID attributes
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vlan_wpa2_radius_2 1.22128 2019-02-18 03:56:01.344570
passed all 1 test case(s)
2019-02-18 03:56:01 	./run-tests.py ap_vlan_wpa2_radius_id_change 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_wpa2_radius_id_change 1/1
Test: AP VLAN with WPA2-Enterprise and RADIUS attributes changing VLANID
Starting AP wlan4
Starting AP wlan3
Connect STA wlan0 to AP
VLAN-ID -> 2
VLAN-ID -> 1
PASS ap_vlan_wpa2_radius_id_change 3.514212 2019-02-18 03:56:05.460140
passed all 1 test case(s)
2019-02-18 03:56:05 	./run-tests.py ap_vlan_wpa2_radius_mixed 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_wpa2_radius_mixed 1/1
Test: AP VLAN with WPA2-Enterprise and tagged+untagged VLANs
Starting AP wlan3
Connect STA wlan0 to AP
Test connectivity in untagged VLAN 2
Test connectivity in tagged VLAN 1
PASS ap_vlan_wpa2_radius_mixed 1.822332 2019-02-18 03:56:08.176305
passed all 1 test case(s)
2019-02-18 03:56:08 	./run-tests.py ap_vlan_wpa2_radius_required 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_wpa2_radius_required 1/1
Test: AP VLAN with WPA2-Enterprise and RADIUS attributes required
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan2 to AP
PASS ap_vlan_wpa2_radius_required 1.20929 2019-02-18 03:56:10.616721
passed all 1 test case(s)
2019-02-18 03:56:10 	./run-tests.py ap_vlan_wpa2_radius_tagged 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_wpa2_radius_tagged 1/1
Test: AP VLAN with WPA2-Enterprise and RADIUS EGRESS_VLANID attributes
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vlan_wpa2_radius_tagged 1.161304 2019-02-18 03:56:12.544577
passed all 1 test case(s)
2019-02-18 03:56:12 	./run-tests.py ap_wds_sta 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wds_sta 1/1
Test: WPA2-PSK AP with STA using 4addr mode
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wds_sta 1.663096 2019-02-18 03:56:15.096223
passed all 1 test case(s)
2019-02-18 03:56:15 	./run-tests.py ap_wds_sta_open 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wds_sta_open 1/1
Test: Open AP with STA using 4addr mode
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wds_sta_open 1.436037 2019-02-18 03:56:17.319670
passed all 1 test case(s)
2019-02-18 03:56:17 	./run-tests.py ap_wds_sta_wep 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wds_sta_wep 1/1
Test: WEP AP with STA using 4addr mode
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wds_sta_wep 1.453279 2019-02-18 03:56:19.754751
passed all 1 test case(s)
2019-02-18 03:56:19 	./run-tests.py ap_wep_tdls 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wep_tdls 1/1
Test: WEP AP and two stations using TDLS
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Setup TDLS
Teardown TDLS
Setup TDLS
PASS ap_wep_tdls 5.21386 2019-02-18 03:56:25.945241
passed all 1 test case(s)
2019-02-18 03:56:26 	./run-tests.py ap_wep_to_wpa 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wep_to_wpa 1/1
Test: WEP to WPA2-PSK configuration change in hostapd
Starting AP wlan3
flush_scan_cache: Could not clear all BSS entries. These remain:
bssid / frequency / signal level / flags / ssid
02:00:00:00:03:00	2412	-30	[WEP][ESS]	wep-to-wpa

Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_wep_to_wpa 1.675087 2019-02-18 03:56:28.817724
passed all 1 test case(s)
2019-02-18 03:56:28 	./run-tests.py ap_wmm_uapsd 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wmm_uapsd 1/1
Test: AP with U-APSD advertisement
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wmm_uapsd 0.680948 2019-02-18 03:56:30.498942
passed all 1 test case(s)
2019-02-18 03:56:30 	./run-tests.py ap_wowlan_triggers 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wowlan_triggers 1/1
Test: AP with wowlan_triggers
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wowlan_triggers 0.628063 2019-02-18 03:56:31.928285
passed all 1 test case(s)
2019-02-18 03:56:32 	./run-tests.py ap_wpa2_already_in_bridge 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_already_in_bridge 1/1
Test: hostapd behavior with interface already in bridge
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_already_in_bridge 1.060688 2019-02-18 03:56:33.867243
passed all 1 test case(s)
2019-02-18 03:56:33 	./run-tests.py ap_wpa2_bridge_fdb 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_bridge_fdb 1/1
Test: Bridge FDB entry removal
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_wpa2_bridge_fdb 2.373252 2019-02-18 03:56:37.070589
passed all 1 test case(s)
ignored_by_lkp ap_wpa2_delayed_group_m1_retransmission
ignored_by_lkp ap_wpa2_delayed_m1_m3_retransmission
ignored_by_lkp ap_wpa2_delayed_m1_m3_retransmission2
2019-02-18 03:56:37 	./run-tests.py ap_wpa2_delayed_m1_m3_zero_tk 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_delayed_m1_m3_zero_tk 1/1
Test: Delayed M1+M3 retransmission and zero TK
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_delayed_m1_m3_zero_tk 1.980082 2019-02-18 03:56:40.026558
passed all 1 test case(s)
ignored_by_lkp ap_wpa2_delayed_m3_retransmission
2019-02-18 03:56:40 	./run-tests.py ap_wpa2_disable_eapol_retry 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_disable_eapol_retry 1/1
Test: WPA2-PSK disable EAPOL-Key retry
Starting AP wlan3
Verify working 4-way handshake without retries
Connect STA wlan0 to AP
Verify no retransmission of message 3/4
Connect STA wlan0 to AP
PASS ap_wpa2_disable_eapol_retry 5.06931 2019-02-18 03:56:45.674770
passed all 1 test case(s)
2019-02-18 03:56:45 	./run-tests.py ap_wpa2_disable_eapol_retry_group 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_disable_eapol_retry_group 1/1
Test: WPA2-PSK disable EAPOL-Key retry for group handshake
Starting AP wlan3
Connect STA wlan1 to AP
Connect STA wlan0 to AP
PASS ap_wpa2_disable_eapol_retry_group 6.40001 2019-02-18 03:56:52.860652
passed all 1 test case(s)
2019-02-18 03:56:52 	./run-tests.py ap_wpa2_eap_aka 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_aka 1/1
Test: WPA2-Enterprise connection using EAP-AKA
Starting AP wlan3
Connect STA wlan0 to AP
Negative test with incorrect key
Connect STA wlan0 to AP
Invalid Milenage key
Connect STA wlan0 to AP
Invalid Milenage key(2)
Connect STA wlan0 to AP
Invalid Milenage key(3)
Connect STA wlan0 to AP
Invalid Milenage key(4)
Connect STA wlan0 to AP
Invalid Milenage key(5)
Connect STA wlan0 to AP
Invalid Milenage key(6)
Connect STA wlan0 to AP
Missing key configuration
Connect STA wlan0 to AP
PASS ap_wpa2_eap_aka 3.102522 2019-02-18 03:56:56.708046
passed all 1 test case(s)
2019-02-18 03:56:56 	./run-tests.py ap_wpa2_eap_aka_config 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_aka_config 1/1
Test: EAP-AKA configuration options
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_aka_config 0.768344 2019-02-18 03:56:58.087304
passed all 1 test case(s)
2019-02-18 03:56:58 	./run-tests.py ap_wpa2_eap_aka_ext 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_aka_ext 1/1
Test: WPA2-Enterprise connection using EAP-AKA and external UMTS auth
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_aka_ext 3.556318 2019-02-18 03:57:02.400173
passed all 1 test case(s)
2019-02-18 03:57:02 	./run-tests.py ap_wpa2_eap_aka_ext_auth_fail 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_aka_ext_auth_fail 1/1
Test: EAP-AKA with external UMTS auth and auth failing
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_aka_ext_auth_fail 0.611019 2019-02-18 03:57:03.830989
passed all 1 test case(s)
2019-02-18 03:57:03 	./run-tests.py ap_wpa2_eap_aka_prime 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_aka_prime 1/1
Test: WPA2-Enterprise connection using EAP-AKA'
Starting AP wlan3
Connect STA wlan0 to AP
EAP-AKA' bidding protection when EAP-AKA enabled as well
Connect STA wlan1 to AP
Negative test with incorrect key
Connect STA wlan0 to AP
PASS ap_wpa2_eap_aka_prime 1.632476 2019-02-18 03:57:06.456149
passed all 1 test case(s)
2019-02-18 03:57:06 	./run-tests.py ap_wpa2_eap_aka_prime_ext 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_aka_prime_ext 1/1
Test: EAP-AKA' with external UMTS auth to hit Synchronization-Failure
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_aka_prime_ext 0.855597 2019-02-18 03:57:08.394548
passed all 1 test case(s)
2019-02-18 03:57:08 	./run-tests.py ap_wpa2_eap_aka_prime_ext_auth_fail 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_aka_prime_ext_auth_fail 1/1
Test: EAP-AKA' with external UMTS auth and auth failing
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_aka_prime_ext_auth_fail 0.687723 2019-02-18 03:57:09.967309
passed all 1 test case(s)
ignored_by_lkp ap_wpa2_eap_aka_prime_sql
2019-02-18 03:57:10 	./run-tests.py ap_wpa2_eap_aka_sql 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_aka_sql 1/1
Test: WPA2-Enterprise connection using EAP-AKA (SQL)
Starting AP wlan3
Connect STA wlan0 to AP
AKA fast re-authentication
AKA full auth with pseudonym
AKA full auth with permanent identity
AKA reauth with mismatching MK
Connect STA wlan0 to AP
AKA reauth with mismatching counter
Connect STA wlan0 to AP
AKA reauth with max reauth count reached
PASS ap_wpa2_eap_aka_sql 1.67753 2019-02-18 03:57:12.590868
passed all 1 test case(s)
2019-02-18 03:57:12 	./run-tests.py ap_wpa2_eap_assoc_rsn 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_assoc_rsn 1/1
Test: WPA2-Enterprise AP and association request RSN IE differences
Starting AP wlan3
Starting AP wlan4
Normal wpa_supplicant assoc req RSN IE
Connect STA wlan0 to AP
Extra PMKIDCount field in RSN IE
Connect STA wlan0 to AP
Extra Group Management Cipher Suite in RSN IE
Connect STA wlan0 to AP
Extra undefined extension field in RSN IE
Connect STA wlan0 to AP
RSN IE without RSN Capabilities
Connect STA wlan0 to AP
RSN IE without AKM
Connect STA wlan0 to AP
RSN IE without pairwise
Connect STA wlan0 to AP
RSN IE without group
Connect STA wlan0 to AP
Normal wpa_supplicant assoc req RSN IE
Connect STA wlan0 to AP
Group management cipher included in assoc req RSN IE
Connect STA wlan0 to AP
Invalid group cipher
Connect STA wlan0 to AP
Invalid pairwise cipher
Connect STA wlan0 to AP
Management frame protection not enabled
Connect STA wlan0 to AP
Unsupported management group cipher
Connect STA wlan0 to AP
PASS ap_wpa2_eap_assoc_rsn 3.983073 2019-02-18 03:57:17.522490
passed all 1 test case(s)
2019-02-18 03:57:17 	./run-tests.py ap_wpa2_eap_eke 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_eke 1/1
Test: WPA2-Enterprise connection using EAP-EKE
Starting AP wlan3
Connect STA wlan0 to AP
Test forced algorithm selection
Test failed algorithm negotiation
Negative test with incorrect password
Connect STA wlan0 to AP
PASS ap_wpa2_eap_eke 4.163842 2019-02-18 03:57:22.940469
passed all 1 test case(s)
2019-02-18 03:57:23 	./run-tests.py ap_wpa2_eap_eke_many --long
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_eke_many 1/1
Test: WPA2-Enterprise connection using EAP-EKE (many connections) [long]
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Total success=300 failure=0
PASS ap_wpa2_eap_eke_many 74.35472 2019-02-18 03:58:38.380717
passed all 1 test case(s)
ignored_by_lkp ap_wpa2_eap_eke_server_oom
ignored_by_lkp ap_wpa2_eap_eke_serverid_nai
2019-02-18 03:58:38 	./run-tests.py ap_wpa2_eap_expanded_nak 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_expanded_nak 1/1
Test: WPA2-Enterprise connection with EAP resulting in expanded NAK
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_expanded_nak 4.44168 2019-02-18 03:58:43.325725
passed all 1 test case(s)
2019-02-18 03:58:43 	./run-tests.py ap_wpa2_eap_ext_enable_network_while_connected 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_ext_enable_network_while_connected 1/1
Test: WPA2-Enterprise interactive identity entry and ENABLE_NETWORK
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_wpa2_eap_ext_enable_network_while_connected 1.775412 2019-02-18 03:58:45.717845
passed all 1 test case(s)
2019-02-18 03:58:45 	./run-tests.py ap_wpa2_eap_fast_binary_pac 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_binary_pac 1/1
Test: WPA2-Enterprise connection using EAP-FAST and binary PAC format
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_binary_pac 1.406704 2019-02-18 03:58:47.654618
passed all 1 test case(s)
2019-02-18 03:58:47 	./run-tests.py ap_wpa2_eap_fast_binary_pac_errors 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_binary_pac_errors 1/1
Test: EAP-FAST and binary PAC errors
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_binary_pac_errors 9.403607 2019-02-18 03:58:57.965410
passed all 1 test case(s)
2019-02-18 03:58:58 	./run-tests.py ap_wpa2_eap_fast_cipher_suites 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_cipher_suites 1/1
Test: EAP-FAST and different TLS cipher suites
Starting AP wlan3
Connect STA wlan0 to AP
Testing DHE-RSA-AES128-SHA
Connect STA wlan0 to AP
Testing RC4-SHA
Connect STA wlan0 to AP
Allow failure due to missing TLS library support
Testing AES128-SHA
Connect STA wlan0 to AP
Testing AES256-SHA
Connect STA wlan0 to AP
Testing DHE-RSA-AES256-SHA
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_cipher_suites 2.888002 2019-02-18 03:59:01.960077
passed all 1 test case(s)
2019-02-18 03:59:02 	./run-tests.py ap_wpa2_eap_fast_eap_aka 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_eap_aka 1/1
Test: WPA2-Enterprise connection using EAP-FAST/EAP-AKA
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_eap_aka 0.974931 2019-02-18 03:59:04.076214
passed all 1 test case(s)
2019-02-18 03:59:04 	./run-tests.py ap_wpa2_eap_fast_eap_sim 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_eap_sim 1/1
Test: WPA2-Enterprise connection using EAP-FAST/EAP-SIM
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_eap_sim 0.929913 2019-02-18 03:59:05.862302
passed all 1 test case(s)
2019-02-18 03:59:05 	./run-tests.py ap_wpa2_eap_fast_eap_sim_ext 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_eap_sim_ext 1/1
Test: WPA2-Enterprise connection using EAP-FAST/EAP-SIM and external GSM auth
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_eap_sim_ext 0.852774 2019-02-18 03:59:07.641296
passed all 1 test case(s)
2019-02-18 03:59:07 	./run-tests.py ap_wpa2_eap_fast_gtc_auth_prov 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_gtc_auth_prov 1/1
Test: WPA2-Enterprise connection using EAP-FAST/GTC and authenticated provisioning
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_gtc_auth_prov 1.024947 2019-02-18 03:59:09.578109
passed all 1 test case(s)
2019-02-18 03:59:09 	./run-tests.py ap_wpa2_eap_fast_gtc_identity_change 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_gtc_identity_change 1/1
Test: WPA2-Enterprise connection using EAP-FAST/GTC and identity changing
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_gtc_identity_change 1.320837 2019-02-18 03:59:11.945942
passed all 1 test case(s)
2019-02-18 03:59:12 	./run-tests.py ap_wpa2_eap_fast_missing_pac_config 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_missing_pac_config 1/1
Test: WPA2-Enterprise connection using EAP-FAST and missing PAC config
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_missing_pac_config 0.933775 2019-02-18 03:59:14.222675
passed all 1 test case(s)
2019-02-18 03:59:14 	./run-tests.py ap_wpa2_eap_fast_mschapv2_unauth_prov 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_mschapv2_unauth_prov 1/1
Test: WPA2-Enterprise connection using EAP-FAST/MSCHAPv2 and unauthenticated provisioning
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_mschapv2_unauth_prov 1.424351 2019-02-18 03:59:17.065810
passed all 1 test case(s)
2019-02-18 03:59:17 	./run-tests.py ap_wpa2_eap_fast_pac_file 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_pac_file 1/1
Test: WPA2-Enterprise connection using EAP-FAST/MSCHAPv2 and PAC file
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan1 to AP
PASS ap_wpa2_eap_fast_pac_file 2.923583 2019-02-18 03:59:21.505107
passed all 1 test case(s)
2019-02-18 03:59:21 	./run-tests.py ap_wpa2_eap_fast_pac_lifetime 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_pac_lifetime 1/1
Test: EAP-FAST and PAC lifetime
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_pac_lifetime 4.376031 2019-02-18 03:59:26.943570
passed all 1 test case(s)
2019-02-18 03:59:27 	./run-tests.py ap_wpa2_eap_fast_pac_refresh 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_pac_refresh 1/1
Test: EAP-FAST and PAC refresh
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_pac_refresh 3.517503 2019-02-18 03:59:31.585812
passed all 1 test case(s)
2019-02-18 03:59:31 	./run-tests.py ap_wpa2_eap_fast_pac_truncate 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_pac_truncate 1/1
Test: EAP-FAST and PAC list truncation
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_pac_truncate 5.803978 2019-02-18 03:59:38.146524
passed all 1 test case(s)
2019-02-18 03:59:38 	./run-tests.py ap_wpa2_eap_fast_prf_oom 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_prf_oom 1/1
Test: WPA2-Enterprise connection using EAP-FAST and OOM in PRF
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_prf_oom 0.668612 2019-02-18 03:59:39.763243
passed all 1 test case(s)
2019-02-18 03:59:39 	./run-tests.py ap_wpa2_eap_fast_prov 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_prov 1/1
Test: EAP-FAST and provisioning options
Starting AP wlan3
Provisioning attempt while server has provisioning disabled
Connect STA wlan0 to AP
Authenticated provisioning
Provisioning disabled - using previously provisioned PAC
Drop PAC and verify connection failure
Anonymous provisioning
Provisioning disabled - using previously provisioned PAC
PASS ap_wpa2_eap_fast_prov 3.631459 2019-02-18 03:59:44.247819
passed all 1 test case(s)
2019-02-18 03:59:44 	./run-tests.py ap_wpa2_eap_fast_server_oom 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_server_oom 1/1
Test: EAP-FAST/MSCHAPv2 and server OOM
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_server_oom 1.649876 2019-02-18 03:59:47.585881
passed all 1 test case(s)
2019-02-18 03:59:47 	./run-tests.py ap_wpa2_eap_fast_text_pac_errors 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_text_pac_errors 1/1
Test: EAP-FAST and text PAC errors
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Starting AP wlan4
Connect STA wlan0 to AP
Starting AP wlan4
Connect STA wlan0 to AP
Starting AP wlan4
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_text_pac_errors 8.64542 2019-02-18 03:59:57.312444
passed all 1 test case(s)
2019-02-18 03:59:57 	./run-tests.py ap_wpa2_eap_gpsk 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_gpsk 1/1
Test: WPA2-Enterprise connection using EAP-GPSK
Starting AP wlan3
Connect STA wlan0 to AP
Test forced algorithm selection
Test failed algorithm negotiation
Negative test with incorrect password
Connect STA wlan0 to AP
PASS ap_wpa2_eap_gpsk 2.622526 2019-02-18 04:00:00.917552
passed all 1 test case(s)
2019-02-18 04:00:01 	./run-tests.py ap_wpa2_eap_gpsk_ptk_rekey_ap 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_gpsk_ptk_rekey_ap 1/1
Test: WPA2-Enterprise with EAP-GPSK and PTK rekey enforced by AP
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_gpsk_ptk_rekey_ap 3.047803 2019-02-18 04:00:05.099445
passed all 1 test case(s)
2019-02-18 04:00:05 	./run-tests.py ap_wpa2_eap_ikev2 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_ikev2 1/1
Test: WPA2-Enterprise connection using EAP-IKEv2
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Negative test with incorrect password
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_wpa2_eap_ikev2 1.751638 2019-02-18 04:00:07.941861
passed all 1 test case(s)
2019-02-18 04:00:08 	./run-tests.py ap_wpa2_eap_ikev2_as_frag 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_ikev2_as_frag 1/1
Test: WPA2-Enterprise connection using EAP-IKEv2 with server fragmentation
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_ikev2_as_frag 0.801185 2019-02-18 04:00:09.496354
passed all 1 test case(s)
2019-02-18 04:00:09 	./run-tests.py ap_wpa2_eap_ikev2_oom 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_ikev2_oom 1/1
Test: WPA2-Enterprise connection using EAP-IKEv2 and OOM
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_wpa2_eap_ikev2_oom 1.486708 2019-02-18 04:00:11.674223
passed all 1 test case(s)
ignored_by_lkp ap_wpa2_eap_in_bridge
2019-02-18 04:00:11 	./run-tests.py ap_wpa2_eap_interactive 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_interactive 1/1
Test: WPA2-Enterprise connection using interactive identity/password entry
Starting AP wlan3
Connection with dynamic TTLS/MSCHAPv2 password entry
Connect STA wlan0 to AP
Connection with dynamic TTLS/MSCHAPv2 identity and password entry
Connect STA wlan0 to AP
Connection with dynamic TTLS/EAP-MSCHAPv2 password entry
Connect STA wlan0 to AP
Connection with dynamic TTLS/EAP-MD5 password entry
Connect STA wlan0 to AP
Connection with dynamic PEAP/EAP-MSCHAPv2 password entry
Connect STA wlan0 to AP
Connection with dynamic PEAP/EAP-GTC password entry
Connect STA wlan0 to AP
PASS ap_wpa2_eap_interactive 2.229559 2019-02-18 04:00:14.931981
passed all 1 test case(s)
2019-02-18 04:00:15 	./run-tests.py ap_wpa2_eap_no_workaround 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_no_workaround 1/1
Test: WPA2-Enterprise connection using EAP-TTLS and eap_workaround=0
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_no_workaround 0.748379 2019-02-18 04:00:16.464873
passed all 1 test case(s)
2019-02-18 04:00:16 	./run-tests.py ap_wpa2_eap_non_ascii_identity 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_non_ascii_identity 1/1
Test: WPA2-Enterprise connection attempt using non-ASCII identity
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_wpa2_eap_non_ascii_identity 4.926255 2019-02-18 04:00:22.186021
passed all 1 test case(s)
2019-02-18 04:00:22 	./run-tests.py ap_wpa2_eap_non_ascii_identity2 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_non_ascii_identity2 1/1
Test: WPA2-Enterprise connection attempt using non-ASCII identity
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_wpa2_eap_non_ascii_identity2 4.897567 2019-02-18 04:00:28.131459
passed all 1 test case(s)
2019-02-18 04:00:28 	./run-tests.py ap_wpa2_eap_oom 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_oom 1/1
Test: EAP server and OOM
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_oom 2.9186 2019-02-18 04:00:31.869330
passed all 1 test case(s)
2019-02-18 04:00:31 	./run-tests.py ap_wpa2_eap_pax 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_pax 1/1
Test: WPA2-Enterprise connection using EAP-PAX
Starting AP wlan3
Connect STA wlan0 to AP
Negative test with incorrect password
Connect STA wlan0 to AP
PASS ap_wpa2_eap_pax 0.988707 2019-02-18 04:00:33.697369
passed all 1 test case(s)
2019-02-18 04:00:33 ./stop.sh
2019-02-18 04:00:35 ./start.sh channels=4
2019-02-18 04:00:36 ./stop.sh



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email



Thanks,
Rong Chen

--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.0.0-rc5-00320-g5c26111"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.0.0-rc5 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70300
CONFIG_CLANG_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_RCU_NOCB_CPU=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT_ALWAYS_ON is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
# CONFIG_QUEUED_LOCK_STAT is not set
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
CONFIG_XEN_DOM0=y
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_512GB=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
CONFIG_X86_INTEL_MPX=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
# CONFIG_EFI_MIXED is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
# CONFIG_LIVEPATCH is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_TEST_SUSPEND=y
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_MMU_AUDIT=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
# CONFIG_VHOST_VSOCK is not set
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_HAVE_RCU_TABLE_INVALIDATE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_ZONE_DEVICE=y
CONFIG_ARCH_HAS_HMM=y
CONFIG_DEV_PAGEMAP_OPS=y
# CONFIG_HMM_MIRROR is not set
# CONFIG_DEVICE_PRIVATE is not set
# CONFIG_DEVICE_PUBLIC is not set
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_XFRM_MODE_TRANSPORT=m
CONFIG_INET_XFRM_MODE_TUNNEL=m
CONFIG_INET_XFRM_MODE_BEET=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
# CONFIG_TCP_CONG_DCTCP is not set
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_INET6_XFRM_MODE_TRANSPORT=m
CONFIG_INET6_XFRM_MODE_TUNNEL=m
CONFIG_INET6_XFRM_MODE_BEET=m
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
# CONFIG_IPV6_GRE is not set
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
CONFIG_NETLABEL=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
# CONFIG_NF_CONNTRACK_TIMEOUT is not set
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=m
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_NEEDED=y
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
# CONFIG_NF_TABLES_SET is not set
# CONFIG_NF_TABLES_INET is not set
# CONFIG_NF_TABLES_NETDEV is not set
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
# CONFIG_NFT_CONNLIMIT is not set
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
# CONFIG_NFT_MASQ is not set
# CONFIG_NFT_REDIR is not set
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
# CONFIG_NFT_OBJREF is not set
# CONFIG_NFT_QUEUE is not set
# CONFIG_NFT_QUOTA is not set
# CONFIG_NFT_REJECT is not set
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
# CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
# CONFIG_NETFILTER_XT_MATCH_SOCKET is not set
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
# CONFIG_IP_SET_HASH_IPMARK is not set
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
# CONFIG_IP_SET_HASH_IPMAC is not set
# CONFIG_IP_SET_HASH_MAC is not set
# CONFIG_IP_SET_HASH_NETPORTNET is not set
CONFIG_IP_SET_HASH_NET=m
# CONFIG_IP_SET_HASH_NETNET is not set
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
# CONFIG_NF_SOCKET_IPV4 is not set
CONFIG_NF_TPROXY_IPV4=m
# CONFIG_NF_TABLES_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_IPV4=m
CONFIG_NF_NAT_MASQUERADE_IPV4=y
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_SOCKET_IPV6 is not set
CONFIG_NF_TPROXY_IPV6=m
# CONFIG_NF_TABLES_IPV6 is not set
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_NF_NAT_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
# CONFIG_IP6_NF_NAT is not set
CONFIG_NF_DEFRAG_IPV6=m
# CONFIG_NF_TABLES_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_CAKE is not set
# CONFIG_NET_SCH_FQ is not set
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
# CONFIG_NET_CLS_FLOWER is not set
# CONFIG_NET_CLS_MATCHALL is not set
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
# CONFIG_NET_ACT_SAMPLE is not set
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_VLAN is not set
# CONFIG_NET_ACT_BPF is not set
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_SKBMOD is not set
# CONFIG_NET_ACT_IFE is not set
# CONFIG_NET_ACT_TUNNEL_KEY is not set
CONFIG_NET_CLS_IND=y
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
# CONFIG_VIRTIO_VSOCKETS is not set
# CONFIG_HYPERV_VSOCKETS is not set
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
# CONFIG_MPLS_ROUTING is not set
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
# CONFIG_CAN_SJA1000 is not set
# CONFIG_CAN_SOFTING is not set

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
CONFIG_FAILOVER=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCI_HYPERV is not set
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# CONFIG_VMD is not set

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8

#
# Bus devices
#
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#
# CONFIG_MTD_REDBOOT_PARTS is not set

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
# CONFIG_XEN_BLKDEV_BACKEND is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
# CONFIG_BLK_DEV_RBD is not set
CONFIG_BLK_DEV_RSXX=m

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_FC is not set
# CONFIG_NVME_TARGET_TCP is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_SGI_IOC4=m
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
# CONFIG_INTEL_MEI_TXE is not set
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_IPR=m
CONFIG_SCSI_IPR_TRACE=y
CONFIG_SCSI_IPR_DUMP=y
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
# CONFIG_TCM_QLA2XXX is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
CONFIG_SCSI_CHELSIO_FCOE=m
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
CONFIG_SCSI_OSD_INITIATOR=m
CONFIG_SCSI_OSD_ULD=m
CONFIG_SCSI_OSD_DPRINT_SENSE=1
# CONFIG_SCSI_OSD_DEBUG is not set
CONFIG_ATA=m
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
# CONFIG_DM_ERA is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_DELAY=m
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
# CONFIG_TCM_USER2 is not set
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
# CONFIG_ISCSI_TARGET_CXGB4 is not set
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=m
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=y
CONFIG_NLMON=m
CONFIG_NET_VRF=y
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
CONFIG_IXGB=m
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=m
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=m
CONFIG_SKGE_DEBUG=y
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
CONFIG_SKY2_DEBUG=y
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_QLGE=m
CONFIG_NETXEN_NIC=m
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
# CONFIG_SFC_FALCON is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
# CONFIG_MDIO_BCM_UNIMAC is not set
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_ASIX_PHY is not set
CONFIG_AT803X_PHY=m
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BROADCOM_PHY=m
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
CONFIG_LXT_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=m
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=y
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=y
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
# CONFIG_DSCC4 is not set
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=m
# CONFIG_XEN_NETDEV_BACKEND is not set
CONFIG_VMXNET3=m
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=y
CONFIG_ISDN=y
CONFIG_ISDN_I4L=m
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
CONFIG_IPPP_FILTER=y
# CONFIG_ISDN_PPP_BSDCOMP is not set
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y

#
# ISDN feature submodules
#
CONFIG_ISDN_DIVERSION=m

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
# CONFIG_ISDN_DRV_HISAX is not set
CONFIG_ISDN_CAPI=m
# CONFIG_CAPI_TRACE is not set
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPIDRV=m
# CONFIG_ISDN_CAPI_CAPIDRV_VERBOSE is not set

#
# CAPI hardware drivers
#
CONFIG_CAPI_AVM=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m
CONFIG_ISDN_DRV_GIGASET=m
CONFIG_GIGASET_CAPI=y
CONFIG_GIGASET_BASE=m
CONFIG_GIGASET_M105=m
CONFIG_GIGASET_M101=m
# CONFIG_GIGASET_DEBUG is not set
CONFIG_HYSDN=m
CONFIG_HYSDN_CAPI=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
CONFIG_ISDN_HDLC=m
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
# CONFIG_TOUCHSCREEN_ELO is not set
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
# CONFIG_INPUT_GP2A is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_OLPC_APSP is not set
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
CONFIG_NOZOMI=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
# CONFIG_RANDOM_TRUST_CPU is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PCI=m
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_DESIGNWARE=m
# CONFIG_SPI_DW_PCI is not set
# CONFIG_SPI_DW_MMIO is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_OC_TINY is not set
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=m
CONFIG_PTP_1588_CLOCK_KVM=y
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_LYNXPOINT=m
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VX855 is not set

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_ISP1704 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LTC3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_IR35221 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=m
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_INTEL_MEI_WDT is not set
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS68470 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
# CONFIG_LIRC is not set
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_XMP_DECODER=m
# CONFIG_IR_IMON_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_V4L2=m
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
CONFIG_DVB_CORE=m
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=m
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_USBVISION=m
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
CONFIG_VIDEO_SAA711X=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m

#
# Camera sensor devices
#

#
# Flash devices
#

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_M52790=m

#
# Sensors used on soc_camera driver
#

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
CONFIG_MEDIA_TUNER=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_GP8PSK_FE=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_QXL=m
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
# CONFIG_SND_HDA_RECONFIG is not set
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_PREALLOC_SIZE=512
CONFIG_SND_SPI=y
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
# CONFIG_SND_USB_POD is not set
# CONFIG_SND_USB_PODHD is not set
# CONFIG_SND_USB_TONEPORT is not set
# CONFIG_SND_USB_VARIAX is not set
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
# CONFIG_SND_SOC is not set
CONFIG_SND_X86=y
# CONFIG_HDMI_LPE_AUDIO is not set
CONFIG_SND_SYNTH_EMUX=m
# CONFIG_SND_XEN_FRONTEND is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y

#
# I2C HID support
#
CONFIG_I2C_HID=m

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_MON=y
CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
CONFIG_USB_DWC3=y
# CONFIG_USB_DWC3_HOST is not set
CONFIG_USB_DWC3_GADGET=y
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
CONFIG_USB_DWC3_HAPS=y
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
# CONFIG_USB_FOTG210_UDC is not set
# CONFIG_USB_GR_UDC is not set
# CONFIG_USB_R8A66597 is not set
# CONFIG_USB_PXA27X is not set
# CONFIG_USB_MV_UDC is not set
# CONFIG_USB_MV_U3D is not set
# CONFIG_USB_M66592 is not set
# CONFIG_USB_BDC_UDC is not set
# CONFIG_USB_AMD5536UDC is not set
# CONFIG_USB_NET2272 is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
# CONFIG_USB_DUMMY_HCD is not set
CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_MASS_STORAGE=m
# CONFIG_USB_CONFIGFS is not set
# CONFIG_USB_ZERO is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
# CONFIG_USB_GADGETFS is not set
# CONFIG_USB_FUNCTIONFS is not set
CONFIG_USB_MASS_STORAGE=m
# CONFIG_USB_GADGET_TARGET is not set
# CONFIG_USB_G_SERIAL is not set
# CONFIG_USB_MIDI_GADGET is not set
# CONFIG_USB_G_PRINTER is not set
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_ACM_MS is not set
# CONFIG_USB_G_MULTI is not set
# CONFIG_USB_G_HID is not set
# CONFIG_USB_G_DBGP is not set
# CONFIG_USB_G_WEBCAM is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=m
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=m
CONFIG_UWB_I1480U=m
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
# CONFIG_EDAC_GHES is not set
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
# CONFIG_EDAC_IE31200 is not set
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_PND2 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV8803 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RX4581 is not set
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IOATDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
# CONFIG_UIO_HV_GENERIC is not set
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI_IGD=y
# CONFIG_VFIO_MDEV is not set
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_INPUT is not set
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TSCPAGE=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_SELFBALLOONING is not set
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
CONFIG_XEN_BACKEND=y
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_TMEM=m
CONFIG_XEN_PCIDEV_BACKEND=m
# CONFIG_XEN_PVCALLS_FRONTEND is not set
# CONFIG_XEN_PVCALLS_BACKEND is not set
# CONFIG_XEN_SCSI_BACKEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_ACPI_PROCESSOR=m
# CONFIG_XEN_MCE_LOG is not set
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_SYMS=y
CONFIG_XEN_HAVE_VPMU=y
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
# CONFIG_RTL8723BS is not set
CONFIG_R8712U=m
# CONFIG_R8188EU is not set
# CONFIG_R8822BE is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_PI433 is not set
# CONFIG_MTK_MMC is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# CONFIG_XIL_AXIS_FIFO is not set
# CONFIG_EROFS_FS is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACERHDF=m
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=m
CONFIG_DCDBAS=m
# CONFIG_DELL_SMBIOS is not set
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBTN is not set
CONFIG_DELL_RBU=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_AMILO_RFKILL=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_HP_WIRELESS is not set
CONFIG_HP_WMI=m
# CONFIG_LG_LAPTOP is not set
CONFIG_MSI_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_COMPAL_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_SURFACE3_WMI is not set
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_WMI=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_INTEL_WMI_THUNDERBOLT is not set
CONFIG_MSI_WMI=m
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=m
CONFIG_INTEL_OAKTRAIL=m
CONFIG_SAMSUNG_Q10=m
CONFIG_APPLE_GMUX=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_HUAWEI_WMI is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_IOVA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# NXP/Freescale QorIQ SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_NVMEM=y

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# CONFIG_FPGA is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
CONFIG_F2FS_FS_ENCRYPTION=y
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EXOFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
# CONFIG_NFSD_SCSILAYOUT is not set
# CONFIG_NFSD_FLEXFILELAYOUT is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
# CONFIG_NFSD_FAULT_INJECTION is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_SUNRPC_DEBUG=y
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_ACL=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE=1
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_DEFAULT_SECURITY="selinux"
CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128L is not set
# CONFIG_CRYPTO_AEGIS256 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS256_AESNI_SSE2 is not set
# CONFIG_CRYPTO_MORUS640 is not set
# CONFIG_CRYPTO_MORUS640_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280 is not set
# CONFIG_CRYPTO_MORUS1280_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280_AVX2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=m
CONFIG_CRYPTO_SHA256_SSSE3=m
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
# CONFIG_CRYPTO_DEV_CHELSIO is not set
CONFIG_CRYPTO_DEV_VIRTIO=m
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=m
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_SBITMAP=y
CONFIG_PRIME_NUMBERS=m
# CONFIG_STRING_SELFTEST is not set

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
# CONFIG_KASAN is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_TRACING_EVENTS_GPIO=y
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=m
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=m
CONFIG_INTERVAL_TREE_TEST=m
CONFIG_PERCPU_TEST=m
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_ASYNC_RAID6_TEST=m
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_KSTRTOX=m
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
CONFIG_TEST_UDELAY=m
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_EFI is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set

--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='hwsim'
	export testcase='hwsim'
	export category='functional'
	export need_memory='1G'
	export job_origin='/lkp/lkp/.src-20190216-121343/allot/cyclic:vm:linux-devel:devel-hourly/vm-snb-4G/hwsim.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='validate'
	export testbox='vm-snb-4G-449'
	export tbox_group='vm-snb-4G'
	export submit_id='5c69b99b0b9a939e117b0ac6'
	export job_file='/lkp/jobs/scheduled/vm-snb-4G-449/hwsim-hwsim-02-debian-x86_64-2018-04-03.cgz-5c261115cef6e9930269093-20190218-40465-ov5plh-3.yaml'
	export id='beee74d841f2956bf2c3c3ceb8043402e7caf975'
	export queuer_version='/lkp/lkp/.src-20190216-121343'
	export need_kconfig='CONFIG_WLAN=y
CONFIG_CFG80211=m
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HWSIM=m
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_DEBUGFS=y
CONFIG_KVM_GUEST=y'
	export commit='5c261115cef6e99302690935266ad113e26ae4bb'
	export ssh_base_port=23032
	export kconfig='x86_64-rhel-7.2'
	export compiler='gcc-7'
	export rootfs='debian-x86_64-2018-04-03.cgz'
	export enqueue_time='2019-02-18 03:44:27 +0800'
	export _id='5c69b99b0b9a939e117b0ac7'
	export _rt='/result/hwsim/hwsim-02/vm-snb-4G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/5c261115cef6e99302690935266ad113e26ae4bb'
	export user='lkp'
	export head_commit='558dd67ee7ace40296eb150281fdcf587331d111'
	export base_commit='f17b5f06cb92ef2250513a1e154c47b78df07d40'
	export branch='linux-devel/devel-hourly-2019021706'
	export result_root='/result/hwsim/hwsim-02/vm-snb-4G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/5c261115cef6e99302690935266ad113e26ae4bb/3'
	export scheduler_version='/lkp/lkp/.src-20190216-121343'
	export LKP_SERVER='inn'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-x86_64-2018-04-03.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/vm-snb-4G-449/hwsim-hwsim-02-debian-x86_64-2018-04-03.cgz-5c261115cef6e9930269093-20190218-40465-ov5plh-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.2
branch=linux-devel/devel-hourly-2019021706
commit=5c261115cef6e99302690935266ad113e26ae4bb
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.2/gcc-7/5c261115cef6e99302690935266ad113e26ae4bb/vmlinuz-5.0.0-rc5-00320-g5c26111
max_uptime=3600
RESULT_ROOT=/result/hwsim/hwsim-02/vm-snb-4G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/5c261115cef6e99302690935266ad113e26ae4bb/3
LKP_SERVER=inn
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-7.2/gcc-7/5c261115cef6e99302690935266ad113e26ae4bb/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/hwsim_2018-09-18.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/hwsim-x86_64-ee98dd631_2018-12-26.cgz'
	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export repeat_to=4
	export schedule_notify_address=
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='4G'
	export hdd_partitions='/dev/vda /dev/vdb /dev/vdc /dev/vdd /dev/vde /dev/vdf'
	export swap_partitions='/dev/vdg'
	export vm_tbox_group='vm-snb-4G'
	export nr_vm=56
	export vm_base_id=1001
	export kernel='/pkg/linux/x86_64-rhel-7.2/gcc-7/5c261115cef6e99302690935266ad113e26ae4bb/vmlinuz-5.0.0-rc5-00320-g5c26111'
	export dequeue_time='2019-02-18 03:44:37 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-snb-4G-449/hwsim-hwsim-02-debian-x86_64-2018-04-03.cgz-5c261115cef6e9930269093-20190218-40465-ov5plh-3.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='hwsim-02' $LKP_SRC/tests/wrapper hwsim
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper hwsim
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time hwsim.time
	$LKP_SRC/stats/wrapper time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper last_state
}

"$@"

--jL2BoiuKMElzg3CS
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=hwsim

2019-02-18 03:45:08 export USER=root
2019-02-18 03:45:08 ./build.sh
Building TNC testing tools
Building wlantest
Building hostapd
Building wpa_supplicant
2019-02-18 03:47:57 ./start.sh
2019-02-18 03:47:58 	./run-tests.py ap_open_ifdown 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_ifdown 1/1
Test: AP with open mode and external ifconfig down
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_open_ifdown 1.297904 2019-02-18 03:48:02.252163
passed all 1 test case(s)
2019-02-18 03:48:02 	./run-tests.py ap_open_invalid_wmm_action 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_invalid_wmm_action 1/1
Test: AP with open mode configuration and invalid WMM Action frame
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_invalid_wmm_action 0.466601 2019-02-18 03:48:03.408871
passed all 1 test case(s)
2019-02-18 03:48:03 	./run-tests.py ap_open_multicast_to_unicast 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_multicast_to_unicast 1/1
Test: Multicast-to-unicast conversion enabled
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_multicast_to_unicast 0.43067 2019-02-18 03:48:04.324180
passed all 1 test case(s)
2019-02-18 03:48:04 	./run-tests.py ap_open_multicast_to_unicast_disabled 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_multicast_to_unicast_disabled 1/1
Test: Multicast-to-unicast conversion disabled
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_multicast_to_unicast_disabled 0.44771 2019-02-18 03:48:05.305661
passed all 1 test case(s)
2019-02-18 03:48:05 	./run-tests.py ap_open_no_reflection 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_no_reflection 1/1
Test: AP with open mode, STA sending packets to itself
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_no_reflection 1.534071 2019-02-18 03:48:07.376354
passed all 1 test case(s)
2019-02-18 03:48:07 	./run-tests.py ap_open_noncountry 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_noncountry 1/1
Test: AP with open mode and noncountry entity as Country String
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_noncountry 6.70197 2019-02-18 03:48:14.689721
passed all 1 test case(s)
2019-02-18 03:48:14 	./run-tests.py ap_open_out_of_memory 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_out_of_memory 1/1
Test: hostapd failing to setup interface due to allocation failure
Starting AP wlan3
Starting AP wlan4
Starting AP wlan4
Starting AP wlan4
Starting AP wlan4
Starting AP wlan4
Starting AP wlan4
Starting AP wlan4
Starting AP wlan4
Starting AP wlan4
Starting AP wlan4
Starting AP wlan4
Starting AP wlan4
Starting AP wlan4
PASS ap_open_out_of_memory 0.704106 2019-02-18 03:48:15.925191
passed all 1 test case(s)
2019-02-18 03:48:16 	./run-tests.py ap_open_packet_loss 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_packet_loss 1/1
Test: AP with open mode configuration and large packet loss
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
PASS ap_open_packet_loss 11.462469 2019-02-18 03:48:28.121312
passed all 1 test case(s)
2019-02-18 03:48:28 	./run-tests.py ap_open_per_sta_vif 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_per_sta_vif 1/1
Test: AP VLAN with open network
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_per_sta_vif 0.454378 2019-02-18 03:48:29.049047
passed all 1 test case(s)
2019-02-18 03:48:29 	./run-tests.py ap_open_pmf_default 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_pmf_default 1/1
Test: AP with open mode (no security) configuration and pmf=2
Starting AP wlan3
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
PASS ap_open_pmf_default 0.767375 2019-02-18 03:48:30.321162
passed all 1 test case(s)
2019-02-18 03:48:30 	./run-tests.py ap_open_poll_sta 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_poll_sta 1/1
Test: AP with open mode and STA poll
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_poll_sta 0.422021 2019-02-18 03:48:31.251816
passed all 1 test case(s)
2019-02-18 03:48:31 	./run-tests.py ap_open_reassoc_not_found 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_reassoc_not_found 1/1
Test: AP with open mode and REASSOCIATE not finding a match
Connect STA wlan0 to AP
PASS ap_open_reassoc_not_found 0.254328 2019-02-18 03:48:32.003562
passed all 1 test case(s)
2019-02-18 03:48:32 	./run-tests.py ap_open_reassoc_same 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_reassoc_same 1/1
Test: AP with open mode and STA reassociating back to same AP without auth exchange
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_reassoc_same 0.515153 2019-02-18 03:48:33.050044
passed all 1 test case(s)
2019-02-18 03:48:33 	./run-tests.py ap_open_reconnect_on_inactivity_disconnect 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_reconnect_on_inactivity_disconnect 1/1
Test: Reconnect to open mode AP after inactivity related disconnection
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_reconnect_on_inactivity_disconnect 0.691548 2019-02-18 03:48:34.289003
passed all 1 test case(s)
2019-02-18 03:48:34 	./run-tests.py ap_open_select_any 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_select_any 1/1
Test: AP with open mode and select any network
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_open_select_any 0.711917 2019-02-18 03:48:35.567014
passed all 1 test case(s)
2019-02-18 03:48:35 	./run-tests.py ap_open_select_network 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_select_network 1/1
Test: Open mode connection and SELECT_NETWORK to change network
Starting AP wlan3
Starting AP wlan4
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_open_select_network 0.91725 2019-02-18 03:48:37.080350
passed all 1 test case(s)
2019-02-18 03:48:37 	./run-tests.py ap_open_select_network_freq 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_select_network_freq 1/1
Test: AP with open mode and use for SELECT_NETWORK freq parameter
Starting AP wlan3
Connect STA wlan0 to AP
Scan duration: 0.0400000000373 seconds
PASS ap_open_select_network_freq 0.380548 2019-02-18 03:48:37.933411
passed all 1 test case(s)
2019-02-18 03:48:37 	./run-tests.py ap_open_select_twice 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_select_twice 1/1
Test: AP with open mode and select network twice
Connect STA wlan0 to AP
Starting AP wlan3
PASS ap_open_select_twice 0.467613 2019-02-18 03:48:38.869172
passed all 1 test case(s)
2019-02-18 03:48:38 	./run-tests.py ap_open_sta_enable_disable 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_sta_enable_disable 1/1
Test: AP with open mode and wpa_supplicant ENABLE/DISABLE_NETWORK
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan5 to AP
PASS ap_open_sta_enable_disable 0.697957 2019-02-18 03:48:40.073084
passed all 1 test case(s)
2019-02-18 03:48:40 	./run-tests.py ap_open_sta_statistics 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_sta_statistics 1/1
Test: AP with open mode and STA statistics
Starting AP wlan3
Connect STA wlan0 to AP
stats1: {'ht_mcs_bitmask': 'ffff0000000000000000', 'listen_interval': '5', 'rx_packets': '3', 'timeout_next': 'NULLFUNC POLL', 'ext_capab': '04000a02014000400001', 'addr': '02:00:00:00:00:00', 'rx_bytes': '232', 'tx_rate_info': '10', 'signal': '-30', 'inactive_msec': '1', 'rx_rate_info': '585 mcs 6', 'supported_rates': '02 04 0b 16 0c 12 18 24 30 48 60 6c', 'capability': '0x421', 'supp_op_classes': '5151525354737475767778797a7b7c7d7e7f808182', 'flags': '[AUTH][ASSOC][AUTHORIZED][SHORT_PREAMBLE][WMM][HT]', 'connected_time': '0', 'tx_bytes': '196', 'aid': '1', 'tx_packets': '3', 'ht_caps_info': '0x1076'}
stats2: {'ht_mcs_bitmask': 'ffff0000000000000000', 'listen_interval': '5', 'rx_packets': '6', 'timeout_next': 'NULLFUNC POLL', 'ext_capab': '04000a02014000400001', 'addr': '02:00:00:00:00:00', 'rx_bytes': '375', 'tx_rate_info': '10', 'signal': '-30', 'inactive_msec': '343', 'rx_rate_info': '1300 mcs 15', 'supported_rates': '02 04 0b 16 0c 12 18 24 30 48 60 6c', 'capability': '0x421', 'supp_op_classes': '5151525354737475767778797a7b7c7d7e7f808182', 'flags': '[AUTH][ASSOC][AUTHORIZED][SHORT_PREAMBLE][WMM][HT]', 'connected_time': '0', 'tx_bytes': '229', 'aid': '1', 'tx_packets': '4', 'ht_caps_info': '0x1076'}
stats3: {'ht_mcs_bitmask': 'ffff0000000000000000', 'listen_interval': '5', 'rx_packets': '10', 'timeout_next': 'NULLFUNC POLL', 'ext_capab': '04000a02014000400001', 'addr': '02:00:00:00:00:00', 'rx_bytes': '3448', 'tx_rate_info': '585 mcs 6', 'signal': '-30', 'inactive_msec': '10', 'rx_rate_info': '650 mcs 7', 'supported_rates': '02 04 0b 16 0c 12 18 24 30 48 60 6c', 'capability': '0x421', 'supp_op_classes': '5151525354737475767778797a7b7c7d7e7f808182', 'flags': '[AUTH][ASSOC][AUTHORIZED][SHORT_PREAMBLE][WMM][HT]', 'connected_time': '0', 'tx_bytes': '1782', 'aid': '1', 'tx_packets': '6', 'ht_caps_info': '0x1076'}
PASS ap_open_sta_statistics 0.990526 2019-02-18 03:48:41.535840
passed all 1 test case(s)
2019-02-18 03:48:41 	./run-tests.py ap_open_start_disabled 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_start_disabled 1/1
Test: AP with open mode and beaconing disabled
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_start_disabled 0.716674 2019-02-18 03:48:42.688999
passed all 1 test case(s)
2019-02-18 03:48:42 	./run-tests.py ap_open_start_disabled2 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_start_disabled2 1/1
Test: AP with open mode and beaconing disabled (2)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_start_disabled2 1.079394 2019-02-18 03:48:44.253009
passed all 1 test case(s)
2019-02-18 03:48:44 	./run-tests.py ap_open_tdls 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_tdls 1/1
Test: Open AP and two stations using TDLS
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Setup TDLS
Teardown TDLS
Setup TDLS
Teardown TDLS
PASS ap_open_tdls 7.216686 2019-02-18 03:48:51.943189
passed all 1 test case(s)
2019-02-18 03:48:52 	./run-tests.py ap_open_tdls_external_control 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_tdls_external_control 1/1
Test: TDLS and tdls_external_control
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_open_tdls_external_control 0.731239 2019-02-18 03:48:53.299147
passed all 1 test case(s)
2019-02-18 03:48:53 	./run-tests.py ap_open_tdls_vht 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_tdls_vht 1/1
Test: Open AP and two stations using TDLS
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Setup TDLS
Teardown TDLS
Setup TDLS
Teardown TDLS
PASS ap_open_tdls_vht 6.735755 2019-02-18 03:49:00.475475
passed all 1 test case(s)
2019-02-18 03:49:00 	./run-tests.py ap_open_tdls_vht160 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_tdls_vht160 1/1
Test: Open AP and two stations using TDLS with VHT 160
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Setup TDLS
Station dump on dev[0]:
Station 02:00:00:00:03:00 (on wlan0)
	inactive time:	33 ms
	rx bytes:	150405
	rx packets:	170
	tx bytes:	64712
	tx packets:	54
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	25
	rx drop misc:	30
	signal:  	-30 dBm
	signal avg:	-30 dBm
	beacon signal avg:	226 dBm
	tx bitrate:	6.5 MBit/s MCS 0
	rx bitrate:	6.5 MBit/s MCS 0
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	no
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	3 seconds
Station 02:00:00:00:01:00 (on wlan0)
	inactive time:	54 ms
	rx bytes:	18306
	rx packets:	16
	tx bytes:	18306
	tx packets:	14
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	25
	rx drop misc:	0
	signal:  	-30 dBm
	signal avg:	-30 dBm
	beacon signal avg:	226 dBm
	tx bitrate:	6.5 MBit/s MCS 0
	rx bitrate:	6.5 MBit/s MCS 0
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	yes
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	2 seconds

Station dump on dev[1]:
Station 02:00:00:00:03:00 (on wlan0)
	inactive time:	37 ms
	rx bytes:	150405
	rx packets:	170
	tx bytes:	64712
	tx packets:	54
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	25
	rx drop misc:	30
	signal:  	-30 dBm
	signal avg:	-30 dBm
	beacon signal avg:	226 dBm
	tx bitrate:	6.5 MBit/s MCS 0
	rx bitrate:	6.5 MBit/s MCS 0
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	no
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	3 seconds
Station 02:00:00:00:01:00 (on wlan0)
	inactive time:	58 ms
	rx bytes:	18306
	rx packets:	16
	tx bytes:	18306
	tx packets:	14
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	25
	rx drop misc:	0
	signal:  	-30 dBm
	signal avg:	-30 dBm
	beacon signal avg:	226 dBm
	tx bitrate:	6.5 MBit/s MCS 0
	rx bitrate:	6.5 MBit/s MCS 0
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	yes
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	2 seconds

PASS ap_open_tdls_vht160 3.651131 2019-02-18 03:49:04.716265
passed all 1 test case(s)
2019-02-18 03:49:04 	./run-tests.py ap_open_tdls_vht80 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_tdls_vht80 1/1
Test: Open AP and two stations using TDLS with VHT 80
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Setup TDLS
Station dump on dev[0]:
Station 02:00:00:00:03:00 (on wlan0)
	inactive time:	43 ms
	rx bytes:	150306
	rx packets:	169
	tx bytes:	64624
	tx packets:	53
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	25
	rx drop misc:	29
	signal:  	-30 dBm
	signal avg:	-30 dBm
	beacon signal avg:	226 dBm
	tx bitrate:	6.5 MBit/s MCS 0
	rx bitrate:	6.5 MBit/s MCS 0
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	no
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	2 seconds
Station 02:00:00:00:01:00 (on wlan0)
	inactive time:	100 ms
	rx bytes:	18306
	rx packets:	16
	tx bytes:	18306
	tx packets:	14
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	25
	rx drop misc:	0
	signal:  	-30 dBm
	signal avg:	-30 dBm
	beacon signal avg:	226 dBm
	tx bitrate:	6.5 MBit/s MCS 0
	rx bitrate:	6.5 MBit/s MCS 0
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	yes
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	2 seconds

Station dump on dev[1]:
Station 02:00:00:00:03:00 (on wlan0)
	inactive time:	65 ms
	rx bytes:	150306
	rx packets:	169
	tx bytes:	64624
	tx packets:	53
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	25
	rx drop misc:	29
	signal:  	-30 dBm
	signal avg:	-30 dBm
	beacon signal avg:	226 dBm
	tx bitrate:	6.5 MBit/s MCS 0
	rx bitrate:	6.5 MBit/s MCS 0
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	no
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	2 seconds
Station 02:00:00:00:01:00 (on wlan0)
	inactive time:	122 ms
	rx bytes:	18306
	rx packets:	16
	tx bytes:	18306
	tx packets:	14
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	25
	rx drop misc:	0
	signal:  	-30 dBm
	signal avg:	-30 dBm
	beacon signal avg:	226 dBm
	tx bitrate:	6.5 MBit/s MCS 0
	rx bitrate:	6.5 MBit/s MCS 0
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	yes
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	2 seconds

PASS ap_open_tdls_vht80 3.933894 2019-02-18 03:49:09.148975
passed all 1 test case(s)
2019-02-18 03:49:09 	./run-tests.py ap_open_tdls_vht80plus80 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_tdls_vht80plus80 1/1
Test: Open AP and two stations using TDLS with VHT 80+80
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Setup TDLS
Station dump on dev[0]:
Station 02:00:00:00:03:00 (on wlan0)
	inactive time:	44 ms
	rx bytes:	150703
	rx packets:	173
	tx bytes:	64624
	tx packets:	53
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	27
	rx drop misc:	29
	signal:  	-30 dBm
	signal avg:	-30 dBm
	beacon signal avg:	226 dBm
	tx bitrate:	6.5 MBit/s MCS 0
	rx bitrate:	6.5 MBit/s MCS 0
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	no
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	3 seconds
Station 02:00:00:00:01:00 (on wlan0)
	inactive time:	71 ms
	rx bytes:	18306
	rx packets:	16
	tx bytes:	18306
	tx packets:	14
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	27
	rx drop misc:	0
	signal:  	-30 dBm
	signal avg:	-30 dBm
	beacon signal avg:	226 dBm
	tx bitrate:	6.5 MBit/s MCS 0
	rx bitrate:	6.5 MBit/s MCS 0
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	yes
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	3 seconds

Station dump on dev[1]:
Station 02:00:00:00:03:00 (on wlan0)
	inactive time:	49 ms
	rx bytes:	150703
	rx packets:	173
	tx bytes:	64624
	tx packets:	53
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	27
	rx drop misc:	29
	signal:  	-30 dBm
	signal avg:	-30 dBm
	beacon signal avg:	226 dBm
	tx bitrate:	6.5 MBit/s MCS 0
	rx bitrate:	6.5 MBit/s MCS 0
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	no
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	3 seconds
Station 02:00:00:00:01:00 (on wlan0)
	inactive time:	76 ms
	rx bytes:	18306
	rx packets:	16
	tx bytes:	18306
	tx packets:	14
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	27
	rx drop misc:	0
	signal:  	-30 dBm
	signal avg:	-30 dBm
	beacon signal avg:	226 dBm
	tx bitrate:	6.5 MBit/s MCS 0
	rx bitrate:	6.5 MBit/s MCS 0
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	yes
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	3 seconds

PASS ap_open_tdls_vht80plus80 4.15715 2019-02-18 03:49:13.840598
passed all 1 test case(s)
2019-02-18 03:49:13 	./run-tests.py ap_open_unexpected_assoc_event 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_unexpected_assoc_event 1/1
Test: AP with open mode and unexpected association event
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_unexpected_assoc_event 1.013542 2019-02-18 03:49:15.422983
passed all 1 test case(s)
2019-02-18 03:49:15 	./run-tests.py ap_open_unknown_action 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_unknown_action 1/1
Test: AP with open mode configuration and unknown Action frame
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_unknown_action 0.466839 2019-02-18 03:49:16.376144
passed all 1 test case(s)
2019-02-18 03:49:16 	./run-tests.py ap_open_wpas_in_bridge 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_wpas_in_bridge 1/1
Test: Open mode AP and wpas interface in a bridge
Starting AP wlan3
Ignore expected interface_add failure due to missing bridge interface: Failed to add a dynamic wpa_supplicant interface
Connect STA wlan5 to AP
PASS ap_open_wpas_in_bridge 0.793123 2019-02-18 03:49:17.652060
passed all 1 test case(s)
2019-02-18 03:49:17 	./run-tests.py ap_pmf_assoc_comeback 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_assoc_comeback 1/1
Test: WPA2-PSK AP with PMF association comeback
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_pmf_assoc_comeback 1.846603 2019-02-18 03:49:19.954055
passed all 1 test case(s)
2019-02-18 03:49:20 	./run-tests.py ap_pmf_assoc_comeback2 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_assoc_comeback2 1/1
Test: WPA2-PSK AP with PMF association comeback (using DROP_SA)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_pmf_assoc_comeback2 1.942487 2019-02-18 03:49:22.519084
passed all 1 test case(s)
2019-02-18 03:49:22 	./run-tests.py ap_pmf_inject_auth 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_inject_auth 1/1
Test: WPA2-PSK AP with PMF and Authentication frame injection
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_pmf_inject_auth 0.475774 2019-02-18 03:49:23.596880
passed all 1 test case(s)
2019-02-18 03:49:23 	./run-tests.py ap_pmf_negative 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_negative 1/1
Test: WPA2-PSK AP without PMF (negative test)
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_pmf_negative 10.580822 2019-02-18 03:49:34.679440
passed all 1 test case(s)
2019-02-18 03:49:34 	./run-tests.py ap_pmf_optional 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_optional 1/1
Test: WPA2-PSK AP with PMF optional
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_pmf_optional 0.739529 2019-02-18 03:49:35.842875
passed all 1 test case(s)
2019-02-18 03:49:35 	./run-tests.py ap_pmf_optional_2akm 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_optional_2akm 1/1
Test: WPA2-PSK AP with PMF optional (2 AKMs)
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_pmf_optional_2akm 0.756945 2019-02-18 03:49:37.088057
passed all 1 test case(s)
2019-02-18 03:49:37 	./run-tests.py ap_pmf_optional_eap 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_optional_eap 1/1
Test: WPA2EAP AP with PMF optional
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_pmf_optional_eap 0.734661 2019-02-18 03:49:38.260818
passed all 1 test case(s)
2019-02-18 03:49:38 	./run-tests.py ap_pmf_required 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_required 1/1
Test: WPA2-PSK AP with PMF required
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_pmf_required 0.832322 2019-02-18 03:49:39.540459
passed all 1 test case(s)
2019-02-18 03:49:39 	./run-tests.py ap_pmf_required_eap 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_required_eap 1/1
Test: WPA2-EAP AP with PMF required
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_pmf_required_eap 0.688298 2019-02-18 03:49:40.722560
passed all 1 test case(s)
2019-02-18 03:49:40 	./run-tests.py ap_pmf_required_sha1 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_required_sha1 1/1
Test: WPA2-PSK AP with PMF required with SHA1 AKM
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_pmf_required_sha1 0.501929 2019-02-18 03:49:41.683135
passed all 1 test case(s)
2019-02-18 03:49:41 	./run-tests.py ap_pmf_required_sta_no_pmf 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_required_sta_no_pmf 1/1
Test: WPA2-PSK AP with PMF required and PMF disabled on STA
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_pmf_required_sta_no_pmf 0.521766 2019-02-18 03:49:42.635987
passed all 1 test case(s)
2019-02-18 03:49:42 	./run-tests.py ap_pmf_sta_sa_query 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_sta_sa_query 1/1
Test: WPA2-PSK AP with station using SA Query
Connect STA wlan0 to AP
PASS ap_pmf_sta_sa_query 2.876061 2019-02-18 03:49:45.994251
passed all 1 test case(s)
2019-02-18 03:49:46 	./run-tests.py ap_pmf_sta_sa_query_local_failure 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_sta_sa_query_local_failure 1/1
Test: WPA2-PSK AP with station using SA Query (local failure)
Connect STA wlan0 to AP
PASS ap_pmf_sta_sa_query_local_failure 1.023772 2019-02-18 03:49:47.517876
passed all 1 test case(s)
2019-02-18 03:49:47 	./run-tests.py ap_pmf_sta_sa_query_no_response 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_sta_sa_query_no_response 1/1
Test: WPA2-PSK AP with station using SA Query and getting no response
Connect STA wlan0 to AP
PASS ap_pmf_sta_sa_query_no_response 4.428357 2019-02-18 03:49:52.652890
passed all 1 test case(s)
2019-02-18 03:49:52 	./run-tests.py ap_pmf_sta_sa_query_oom 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_sta_sa_query_oom 1/1
Test: WPA2-PSK AP with station using SA Query (OOM)
Connect STA wlan0 to AP
PASS ap_pmf_sta_sa_query_oom 1.088031 2019-02-18 03:49:54.243853
passed all 1 test case(s)
2019-02-18 03:49:54 	./run-tests.py ap_pmf_sta_unprot_deauth_burst 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_sta_unprot_deauth_burst 1/1
Test: WPA2-PSK AP with station receiving burst of unprotected Deauthentication frames
Connect STA wlan0 to AP
PASS ap_pmf_sta_unprot_deauth_burst 13.33517 2019-02-18 03:50:08.062647
passed all 1 test case(s)
2019-02-18 03:50:08 	./run-tests.py ap_pmf_tkip_reject 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_tkip_reject 1/1
Test: Mixed mode BSS and MFP-enabled AP rejecting TKIP
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
PASS ap_pmf_tkip_reject 1.675624 2019-02-18 03:50:10.533035
passed all 1 test case(s)
2019-02-18 03:50:10 	./run-tests.py ap_pmf_toggle 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_toggle 1/1
Test: WPA2-PSK AP with PMF optional and changing PMF on reassociation
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_pmf_toggle 1.089346 2019-02-18 03:50:12.194528
passed all 1 test case(s)
2019-02-18 03:50:12 	./run-tests.py ap_qosmap 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_qosmap 1/1
Test: QoS mapping
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_qosmap 1.501566 2019-02-18 03:50:14.306758
passed all 1 test case(s)
2019-02-18 03:50:14 	./run-tests.py ap_qosmap_default 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_qosmap_default 1/1
Test: QoS mapping with default values
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_qosmap_default 1.316463 2019-02-18 03:50:16.189782
passed all 1 test case(s)
2019-02-18 03:50:16 	./run-tests.py ap_qosmap_default_acm 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_qosmap_default_acm 1/1
Test: QoS mapping with default values and ACM=1 for VO/VI
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_qosmap_default_acm 1.281505 2019-02-18 03:50:18.165012
passed all 1 test case(s)
2019-02-18 03:50:18 	./run-tests.py ap_qosmap_invalid 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_qosmap_invalid 1/1
Test: QoS mapping ctrl_iface error handling
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_qosmap_invalid 0.620016 2019-02-18 03:50:19.658660
passed all 1 test case(s)
2019-02-18 03:50:19 	./run-tests.py ap_reassociation_to_same_bss 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_reassociation_to_same_bss 1/1
Test: Reassociate to the same BSS
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_reassociation_to_same_bss 10.23471 2019-02-18 03:50:30.490735
passed all 1 test case(s)
2019-02-18 03:50:30 	./run-tests.py ap_reconnect_auth_timeout 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_reconnect_auth_timeout 1/1
Test: Reconnect to 2nd AP and authentication times out
Starting AP wlan3
Connect STA wlan5 to AP
Starting AP wlan4
Wait ~10s for auth timeout...
PASS ap_reconnect_auth_timeout 11.801595 2019-02-18 03:50:42.870953
passed all 1 test case(s)
2019-02-18 03:50:42 	./run-tests.py ap_remove_during_acs 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_remove_during_acs 1/1
Test: Remove interface during ACS
Starting AP wlan3
Removing BSS wlan3
Starting AP wlan3
Removing BSS wlan3
PASS ap_remove_during_acs 7.360816 2019-02-18 03:50:50.758836
passed all 1 test case(s)
2019-02-18 03:50:50 	./run-tests.py ap_remove_during_acs2 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_remove_during_acs2 1/1
Test: Remove BSS during ACS in multi-BSS configuration
Starting AP wlan3
Removing BSS wlan3
Starting AP wlan3
Removing BSS wlan3
PASS ap_remove_during_acs2 0.773318 2019-02-18 03:50:52.285577
passed all 1 test case(s)
2019-02-18 03:50:52 	./run-tests.py ap_remove_during_acs3 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_remove_during_acs3 1/1
Test: Remove second BSS during ACS in multi-BSS configuration
Starting AP wlan3
Removing BSS wlan3
Starting AP wlan3
Removing BSS wlan3-2
PASS ap_remove_during_acs3 0.706935 2019-02-18 03:50:53.825074
passed all 1 test case(s)
2019-02-18 03:50:53 	./run-tests.py ap_remove_during_ht_coex_scan 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_remove_during_ht_coex_scan 1/1
Test: Remove interface during HT co-ex scan
Starting AP wlan3
Removing BSS wlan3
PASS ap_remove_during_ht_coex_scan 1.761081 2019-02-18 03:50:56.324913
passed all 1 test case(s)
2019-02-18 03:50:56 	./run-tests.py ap_remove_during_ht_coex_scan2 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_remove_during_ht_coex_scan2 1/1
Test: Remove BSS during HT co-ex scan in multi-BSS configuration
Starting AP wlan3
Removing BSS wlan3
PASS ap_remove_during_ht_coex_scan2 0.297697 2019-02-18 03:50:57.365153
passed all 1 test case(s)
2019-02-18 03:50:57 	./run-tests.py ap_remove_during_ht_coex_scan3 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_remove_during_ht_coex_scan3 1/1
Test: Remove second BSS during HT co-ex scan in multi-BSS configuration
Starting AP wlan3
Removing BSS wlan3-2
PASS ap_remove_during_ht_coex_scan3 0.287574 2019-02-18 03:50:58.504939
passed all 1 test case(s)
2019-02-18 03:50:58 	./run-tests.py ap_require_ht 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_require_ht 1/1
Test: Require HT
Starting AP wlan3
Connect STA wlan1 to AP
Connect STA wlan0 to AP
Connect STA wlan2 to AP
PASS ap_require_ht 6.152003 2019-02-18 03:51:05.399988
passed all 1 test case(s)
2019-02-18 03:51:05 	./run-tests.py ap_require_ht_limited_rates 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_require_ht_limited_rates 1/1
Test: Require HT with limited supported rates
Starting AP wlan3
Connect STA wlan1 to AP
Connect STA wlan0 to AP
PASS ap_require_ht_limited_rates 5.709097 2019-02-18 03:51:12.178598
passed all 1 test case(s)
2019-02-18 03:51:12 	./run-tests.py ap_roam_open 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_roam_open 1/1
Test: Roam between two open APs
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan4
PASS ap_roam_open 16.610558 2019-02-18 03:51:29.945006
passed all 1 test case(s)
2019-02-18 03:51:30 	./run-tests.py ap_roam_open_failed 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_roam_open_failed 1/1
Test: Roam failure due to rejected authentication
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan4
PASS ap_roam_open_failed 1.610171 2019-02-18 03:51:32.504307
passed all 1 test case(s)
2019-02-18 03:51:32 	./run-tests.py ap_roam_set_bssid 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_roam_set_bssid 1/1
Test: Roam control
Starting AP wlan3
Starting AP wlan4
Connect STA wlan0 to AP
PASS ap_roam_set_bssid 0.987355 2019-02-18 03:51:34.254787
passed all 1 test case(s)
2019-02-18 03:51:34 	./run-tests.py ap_roam_with_reassoc_auth_timeout 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_roam_with_reassoc_auth_timeout 1/1
Test: Roam using reassoc between two APs and authentication times out
Starting AP wlan3
Connect STA wlan5 to AP
Starting AP wlan4
Wait ~10s for auth timeout...
PASS ap_roam_with_reassoc_auth_timeout 12.445467 2019-02-18 03:51:47.578201
passed all 1 test case(s)
2019-02-18 03:51:47 	./run-tests.py ap_roam_wpa2_psk 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_roam_wpa2_psk 1/1
Test: Roam between two WPA2-PSK APs
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan4
PASS ap_roam_wpa2_psk 17.391712 2019-02-18 03:52:06.129840
passed all 1 test case(s)
2019-02-18 03:52:06 	./run-tests.py ap_roam_wpa2_psk_failed 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_roam_wpa2_psk_failed 1/1
Test: Roam failure with WPA2-PSK AP due to wrong passphrase
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan4
PASS ap_roam_wpa2_psk_failed 5.745806 2019-02-18 03:52:12.834889
passed all 1 test case(s)
2019-02-18 03:52:12 	./run-tests.py ap_roam_wpa2_psk_race 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_roam_wpa2_psk_race 1/1
Test: Roam between two WPA2-PSK APs and try to hit a disconnection race
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan4
PASS ap_roam_wpa2_psk_race 4.286711 2019-02-18 03:52:18.119818
passed all 1 test case(s)
2019-02-18 03:52:18 	./run-tests.py ap_short_preamble 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_short_preamble 1/1
Test: Open AP with short preamble
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_short_preamble 0.702471 2019-02-18 03:52:19.815715
passed all 1 test case(s)
2019-02-18 03:52:19 	./run-tests.py ap_spectrum_management_required 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_spectrum_management_required 1/1
Test: Open AP with spectrum management required
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_spectrum_management_required 0.881917 2019-02-18 03:52:21.703931
passed all 1 test case(s)
2019-02-18 03:52:21 	./run-tests.py ap_tdls_chan_switch_prohibit 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_tdls_chan_switch_prohibit 1/1
Test: Open AP and TDLS channel switch prohibited
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Setup TDLS
PASS ap_tdls_chan_switch_prohibit 2.594155 2019-02-18 03:52:25.101262
passed all 1 test case(s)
2019-02-18 03:52:25 	./run-tests.py ap_tdls_discovery 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_tdls_discovery 1/1
Test: WPA2-PSK AP and two stations using TDLS discovery
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_tdls_discovery 1.54158 2019-02-18 03:52:27.343200
passed all 1 test case(s)
2019-02-18 03:52:27 	./run-tests.py ap_tdls_link_status 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_tdls_link_status 1/1
Test: Check TDLS link status between two stations
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
wlan0: TDLS link status: peer does not exist
wlan1: TDLS link status: peer does not exist
Setup TDLS
wlan0: TDLS link status: connected
wlan1: TDLS link status: connected
Teardown TDLS
wlan0: TDLS link status: peer does not exist
wlan1: TDLS link status: peer does not exist
PASS ap_tdls_link_status 3.883501 2019-02-18 03:52:31.930046
passed all 1 test case(s)
2019-02-18 03:52:32 	./run-tests.py ap_tdls_prohibit 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_tdls_prohibit 1/1
Test: Open AP and TDLS prohibited
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_tdls_prohibit 1.340085 2019-02-18 03:52:34.333396
passed all 1 test case(s)
2019-02-18 03:52:34 	./run-tests.py ap_track_sta 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_track_sta 1/1
Test: Dualband AP tracking unconnected stations
Starting AP wlan3
Starting AP wlan4
PASS ap_track_sta 3.278663 2019-02-18 03:52:38.424321
passed all 1 test case(s)
2019-02-18 03:52:38 	./run-tests.py ap_track_sta_force_2ghz 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_track_sta_force_2ghz 1/1
Test: Dualband AP forcing dualband STA to connect on 2.4 GHz
Starting AP wlan3
Starting AP wlan4
Connect STA wlan0 to AP
PASS ap_track_sta_force_2ghz 1.66752 2019-02-18 03:52:40.984266
passed all 1 test case(s)
2019-02-18 03:52:41 	./run-tests.py ap_track_sta_force_5ghz 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_track_sta_force_5ghz 1/1
Test: Dualband AP forcing dualband STA to connect on 5 GHz
Starting AP wlan3
Starting AP wlan4
Connect STA wlan0 to AP
PASS ap_track_sta_force_5ghz 1.232844 2019-02-18 03:52:42.834494
passed all 1 test case(s)
2019-02-18 03:52:42 	./run-tests.py ap_track_sta_no_auth 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_track_sta_no_auth 1/1
Test: Dualband AP rejecting authentication from dualband STA on 2.4 GHz
Starting AP wlan3
Starting AP wlan4
Connect STA wlan1 to AP
Connect STA wlan0 to AP
PASS ap_track_sta_no_auth 1.321395 2019-02-18 03:52:45.095514
passed all 1 test case(s)
2019-02-18 03:52:45 	./run-tests.py ap_track_sta_no_auth_passive 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_track_sta_no_auth_passive 1/1
Test: AP rejecting authentication from dualband STA on 2.4 GHz (passive)
Starting AP wlan3
Starting AP wlan4
Connect STA wlan0 to AP
PASS ap_track_sta_no_auth_passive 1.383806 2019-02-18 03:52:47.236338
passed all 1 test case(s)
2019-02-18 03:52:47 	./run-tests.py ap_track_sta_no_probe_resp 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_track_sta_no_probe_resp 1/1
Test: Dualband AP not replying to probes from dualband STA on 2.4 GHz
Starting AP wlan3
Starting AP wlan4
PASS ap_track_sta_no_probe_resp 1.290614 2019-02-18 03:52:49.379728
passed all 1 test case(s)
2019-02-18 03:52:49 	./run-tests.py ap_track_taxonomy 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_track_taxonomy 1/1
Test: AP tracking STA taxonomy
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan5 to AP
sta0: wifi4|probe:0,1,50,3,45,127,255,221(0050f2,4),221(506f9a,9),114,221(506f9a,22),htcap:107e,htagg:1b,htmcs:0000ffff,extcap:04000a02014000400001,wps:_|assoc:0,1,50,45,127,59,221(0050f2,2),htcap:1076,htagg:1b,htmcs:0000ffff,extcap:04000a02014000400001
sta1: wifi4|probe:0,1,50,3,45,127,114,255,221(506f9a,22),htcap:107e,htagg:1b,htmcs:0000ffff,extcap:04000a02014000400001|assoc:0,1,50,45,127,59,221(0050f2,2),htcap:1076,htagg:1b,htmcs:0000ffff,extcap:04000a02014000400001
sta: wifi4|probe:0,1,50,3,45,127,255,221(0050f2,4),221(506f9a,9),114,221(506f9a,22),htcap:107e,htagg:1b,htmcs:0000ffff,extcap:04000a02014000400001,wps:track_test|assoc:0,1,50,45,127,59,221(0050f2,2),htcap:1076,htagg:1b,htmcs:0000ffff,extcap:04000a02014000400001
Connect STA wlan2 to AP
sta2: wifi4|probe:0,1,50,3,45,127,255,221(0050f2,4),221(506f9a,9),114,221(506f9a,22),htcap:107e,htagg:1b,htmcs:0000ffff,extcap:04000a02014000400001,wps:_|assoc:0,1,50,45,127,59,221(0050f2,2),htcap:1076,htagg:1b,htmcs:0000ffff,extcap:04000a02014000400001
flush_scan_cache: Could not clear all BSS entries. These remain:
bssid / frequency / signal level / flags / ssid
02:00:00:00:03:00	2437	-30	[ESS]	track

flush_scan_cache: Could not clear all BSS entries. These remain:
bssid / frequency / signal level / flags / ssid
02:00:00:00:03:00	2437	-30	[ESS]	track

flush_scan_cache: Could not clear all BSS entries. These remain:
bssid / frequency / signal level / flags / ssid
02:00:00:00:03:00	2437	-30	[ESS]	track

PASS ap_track_taxonomy 3.6158 2019-02-18 03:52:54.032243
passed all 1 test case(s)
2019-02-18 03:52:54 	./run-tests.py ap_tx_queue_params 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_tx_queue_params 1/1
Test: Open AP with TX queue params set
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_tx_queue_params 0.902553 2019-02-18 03:52:55.662101
passed all 1 test case(s)
2019-02-18 03:52:55 	./run-tests.py ap_tx_queue_params_invalid 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_tx_queue_params_invalid 1/1
Test: Invalid TX queue params set (cwmin/cwmax)
Starting AP wlan3
PASS ap_tx_queue_params_invalid 0.612112 2019-02-18 03:52:56.962271
passed all 1 test case(s)
2019-02-18 03:52:57 	./run-tests.py ap_vendor_elements 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vendor_elements 1/1
Test: WPA2-PSK AP with vendor elements added
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vendor_elements 1.113925 2019-02-18 03:52:59.048956
passed all 1 test case(s)
ignored_by_lkp ap_vht160
2019-02-18 03:52:59 	./run-tests.py ap_vht160_no_dfs 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht160_no_dfs 1/1
Test: VHT with 160 MHz channel width and no DFS (104 minus)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht160_no_dfs 1.453284 2019-02-18 03:53:01.472052
passed all 1 test case(s)
2019-02-18 03:53:01 	./run-tests.py ap_vht160_no_dfs_100_plus 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht160_no_dfs_100_plus 1/1
Test: VHT with 160 MHz channel width and no DFS (100 plus)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht160_no_dfs_100_plus 1.529072 2019-02-18 03:53:04.038338
passed all 1 test case(s)
2019-02-18 03:53:04 	./run-tests.py ap_vht160_no_dfs_108_plus 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht160_no_dfs_108_plus 1/1
Test: VHT with 160 MHz channel width and no DFS (108 plus)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht160_no_dfs_108_plus 1.368689 2019-02-18 03:53:06.085228
passed all 1 test case(s)
2019-02-18 03:53:06 	./run-tests.py ap_vht160_no_dfs_112_minus 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht160_no_dfs_112_minus 1/1
Test: VHT with 160 MHz channel width and no DFS (112 minus)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht160_no_dfs_112_minus 1.308186 2019-02-18 03:53:08.216280
passed all 1 test case(s)
2019-02-18 03:53:08 	./run-tests.py ap_vht160_no_dfs_116_plus 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht160_no_dfs_116_plus 1/1
Test: VHT with 160 MHz channel width and no DFS (116 plus)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht160_no_dfs_116_plus 1.319312 2019-02-18 03:53:10.347411
passed all 1 test case(s)
2019-02-18 03:53:10 	./run-tests.py ap_vht160_no_dfs_120_minus 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht160_no_dfs_120_minus 1/1
Test: VHT with 160 MHz channel width and no DFS (120 minus)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht160_no_dfs_120_minus 1.265689 2019-02-18 03:53:12.308748
passed all 1 test case(s)
2019-02-18 03:53:12 	./run-tests.py ap_vht160_no_dfs_124_plus 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht160_no_dfs_124_plus 1/1
Test: VHT with 160 MHz channel width and no DFS (124 plus)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht160_no_dfs_124_plus 1.289689 2019-02-18 03:53:14.594918
passed all 1 test case(s)
2019-02-18 03:53:14 	./run-tests.py ap_vht160_no_dfs_128_minus 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht160_no_dfs_128_minus 1/1
Test: VHT with 160 MHz channel width and no DFS (128 minus)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht160_no_dfs_128_minus 1.26795 2019-02-18 03:53:16.726790
passed all 1 test case(s)
2019-02-18 03:53:16 	./run-tests.py ap_vht160_no_ht40 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht160_no_ht40 1/1
Test: VHT with 160 MHz channel width and HT40 disabled
Starting AP wlan3
PASS ap_vht160_no_ht40 0.298702 2019-02-18 03:53:17.937075
passed all 1 test case(s)
2019-02-18 03:53:18 	./run-tests.py ap_vht160b 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht160b 1/1
Test: VHT with 160 MHz channel width (2)
Starting AP wlan4
Waiting for CAC to complete
Connect STA wlan0 to AP
PASS ap_vht160b 63.447712 2019-02-18 03:54:22.289042
passed all 1 test case(s)
2019-02-18 03:54:22 	./run-tests.py ap_vht80 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80 1/1
Test: VHT with 80 MHz channel width
Starting AP wlan3
Connect STA wlan0 to AP
hostapd STATUS: {'olbc_ht': '0', 'cac_time_left_seconds': 'N/A', 'num_sta_no_short_slot_time': '1', 'vht_caps_info': '00000000', 'olbc': '0', 'vht_oper_centr_freq_seg0_idx': '42', 'num_sta_non_erp': '0', 'supported_rates': '0c 12 18 24 30 48 60 6c', 'ht_op_mode': '0x0', 'tx_vht_mcs_map': 'aaaa', 'state': 'ENABLED', 'vht_oper_centr_freq_seg1_idx': '0', 'num_sta_ht40_intolerant': '0', 'channel': '36', 'ht_mcs_bitmask': 'ffff0000000000000000', 'vht_oper_chwidth': '1', 'bssid[0]': '02:00:00:00:03:00', 'ieee80211n': '1', 'cac_time_seconds': '0', 'num_sta[0]': '1', 'ieee80211ac': '1', 'phy': 'phy3', 'max_txpower': '23', 'num_sta_ht_no_gf': '0', 'freq': '5180', 'num_sta_ht_20_mhz': '0', 'num_sta_no_short_preamble': '1', 'secondary_channel': '1', 'rx_vht_mcs_map': 'aaaa', 'ssid[0]': 'vht', 'dtim_period': '2', 'beacon_int': '100', 'num_sta_no_ht': '0', 'bss[0]': 'wlan3', 'ht_caps_info': '000e'}
hostapd STA: {'connected_time': '0', 'vht_caps_info': '0x038004fa', 'capability': '0x1', 'addr': '02:00:00:00:00:00', 'rx_vht_mcs_map': 'aaaa', 'supp_op_classes': '73515354737475767778797a7b808182', 'supported_rates': '0c 12 18 24 30 48 60 6c', 'tx_vht_mcs_map': 'aaaa', 'tx_packets': '6', 'ht_mcs_bitmask': 'ffff0000000000000000', 'rx_packets': '10', 'ext_capab': '04000a02014000400001', 'rx_rate_info': '1300 vhtmcs 7 vhtnss 2', 'tx_bytes': '1797', 'tx_rate_info': '65 mcs 0', 'timeout_next': 'NULLFUNC POLL', 'rx_bytes': '3367', 'signal': '-30', 'inactive_msec': '15', 'listen_interval': '5', 'flags': '[AUTH][ASSOC][AUTHORIZED][WMM][HT][VHT]', 'aid': '1', 'ht_caps_info': '0x1076'}
PASS ap_vht80 0.827731 2019-02-18 03:54:23.642805
passed all 1 test case(s)
2019-02-18 03:54:23 	./run-tests.py ap_vht80_csa 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80_csa 1/1
Test: VHT with 80 MHz channel width and CSA
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht80_csa 3.670639 2019-02-18 03:54:27.866965
passed all 1 test case(s)
2019-02-18 03:54:27 	./run-tests.py ap_vht80_invalid 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80_invalid 1/1
Test: VHT with invalid 80 MHz channel configuration (seg1)
Starting AP wlan3
PASS ap_vht80_invalid 0.414459 2019-02-18 03:54:28.658308
passed all 1 test case(s)
2019-02-18 03:54:28 	./run-tests.py ap_vht80_invalid2 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80_invalid2 1/1
Test: VHT with invalid 80 MHz channel configuration (seg0)
Starting AP wlan3
PASS ap_vht80_invalid2 0.407354 2019-02-18 03:54:29.619404
passed all 1 test case(s)
2019-02-18 03:54:29 	./run-tests.py ap_vht80_params 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80_params 1/1
Test: VHT with 80 MHz channel width and number of optional features enabled
Starting AP wlan3
Connect STA wlan1 to AP
Connect STA wlan0 to AP
PASS ap_vht80_params 0.978619 2019-02-18 03:54:31.087551
passed all 1 test case(s)
2019-02-18 03:54:31 	./run-tests.py ap_vht80_pwr_constraint 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80_pwr_constraint 1/1
Test: VHT with 80 MHz channel width and local power constraint
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht80_pwr_constraint 0.760777 2019-02-18 03:54:32.340006
passed all 1 test case(s)
2019-02-18 03:54:32 	./run-tests.py ap_vht80_to_24g_ht 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80_to_24g_ht 1/1
Test: VHT with 80 MHz channel width reconfigured to 2.4 GHz HT
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht80_to_24g_ht 0.956588 2019-02-18 03:54:33.780176
passed all 1 test case(s)
2019-02-18 03:54:33 	./run-tests.py ap_vht80b 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80b 1/1
Test: VHT with 80 MHz channel width (HT40- channel 40)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht80b 0.968629 2019-02-18 03:54:35.292958
passed all 1 test case(s)
2019-02-18 03:54:35 	./run-tests.py ap_vht80c 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80c 1/1
Test: VHT with 80 MHz channel width (HT40+ channel 44)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht80c 0.949574 2019-02-18 03:54:36.726849
passed all 1 test case(s)
2019-02-18 03:54:36 	./run-tests.py ap_vht80d 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80d 1/1
Test: VHT with 80 MHz channel width (HT40- channel 48)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht80d 1.053612 2019-02-18 03:54:38.260818
passed all 1 test case(s)
2019-02-18 03:54:38 	./run-tests.py ap_vht80plus80 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80plus80 1/1
Test: VHT with 80+80 MHz channel width
Starting AP wlan3
Starting AP wlan4
Connect STA wlan1 to AP
PASS ap_vht80plus80 1.194404 2019-02-18 03:54:39.994603
passed all 1 test case(s)
2019-02-18 03:54:40 	./run-tests.py ap_vht80plus80_invalid 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80plus80_invalid 1/1
Test: VHT with invalid 80+80 MHz channel
Starting AP wlan3
PASS ap_vht80plus80_invalid 0.468483 2019-02-18 03:54:40.909884
passed all 1 test case(s)
2019-02-18 03:54:40 	./run-tests.py ap_vht_20 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht_20 1/1
Test: VHT and 20 MHz channel
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht_20 0.616448 2019-02-18 03:54:42.105781
passed all 1 test case(s)
2019-02-18 03:54:42 	./run-tests.py ap_vht_40 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht_40 1/1
Test: VHT and 40 MHz channel
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht_40 0.874736 2019-02-18 03:54:43.468565
passed all 1 test case(s)
2019-02-18 03:54:43 	./run-tests.py ap_vht_40_fallback_to_20 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht_40_fallback_to_20 1/1
Test: VHT and 40 MHz channel configuration falling back to 20 MHz
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht_40_fallback_to_20 0.848963 2019-02-18 03:54:44.783780
passed all 1 test case(s)
2019-02-18 03:54:44 	./run-tests.py ap_vht_capab_not_supported 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht_capab_not_supported 1/1
Test: VHT configuration with driver not supporting all vht_capab entries
Starting AP wlan3
PASS ap_vht_capab_not_supported 0.151441 2019-02-18 03:54:45.378652
passed all 1 test case(s)
2019-02-18 03:54:45 	./run-tests.py ap_vht_csa_vht20 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht_csa_vht20 1/1
Test: VHT CSA with VHT20 getting enabled
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_vht_csa_vht20 2.649841 2019-02-18 03:54:48.507921
passed all 1 test case(s)
2019-02-18 03:54:48 	./run-tests.py ap_vht_csa_vht40 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht_csa_vht40 1/1
Test: VHT CSA with VHT40 getting enabled
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_vht_csa_vht40 3.187669 2019-02-18 03:54:52.404297
passed all 1 test case(s)
2019-02-18 03:54:52 	./run-tests.py ap_vht_csa_vht40_disable 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht_csa_vht40_disable 1/1
Test: VHT CSA with VHT40 getting disabled
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_vht_csa_vht40_disable 3.062347 2019-02-18 03:54:56.469628
passed all 1 test case(s)
2019-02-18 03:54:56 	./run-tests.py ap_vht_on_24ghz 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht_on_24ghz 1/1
Test: Subset of VHT features on 2.4 GHz
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_vht_on_24ghz 1.5841 2019-02-18 03:54:58.908579
passed all 1 test case(s)
2019-02-18 03:54:59 	./run-tests.py ap_vht_tkip 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht_tkip 1/1
Test: VHT and TKIP
Starting AP wlan3
Connect STA wlan0 to AP
hostapd STATUS: {'olbc_ht': '0', 'cac_time_left_seconds': 'N/A', 'num_sta_no_short_slot_time': '1', 'olbc': '0', 'num_sta_non_erp': '0', 'supported_rates': '0c 12 18 24 30 48 60 6c', 'ht_op_mode': '0x13', 'state': 'ENABLED', 'num_sta_ht40_intolerant': '0', 'channel': '36', 'bssid[0]': '02:00:00:00:03:00', 'ieee80211n': '0', 'cac_time_seconds': '0', 'num_sta[0]': '1', 'ieee80211ac': '0', 'phy': 'phy3', 'max_txpower': '23', 'num_sta_ht_no_gf': '0', 'freq': '5180', 'num_sta_ht_20_mhz': '0', 'num_sta_no_short_preamble': '1', 'secondary_channel': '0', 'ssid[0]': 'vht', 'dtim_period': '2', 'beacon_int': '100', 'num_sta_no_ht': '1', 'bss[0]': 'wlan3'}
PASS ap_vht_tkip 1.818004 2019-02-18 03:55:01.709886
passed all 1 test case(s)
2019-02-18 03:55:01 	./run-tests.py ap_vht_use_sta_nsts 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht_use_sta_nsts 1/1
Test: VHT with 80 MHz channel width and use_sta_nsts=1
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vht_use_sta_nsts 1.212397 2019-02-18 03:55:03.824251
passed all 1 test case(s)
2019-02-18 03:55:03 	./run-tests.py ap_vlan_file_open 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_file_open 1/1
Test: AP VLAN with open network and vlan_file mapping
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
PASS ap_vlan_file_open 2.172376 2019-02-18 03:55:06.670709
passed all 1 test case(s)
2019-02-18 03:55:06 	./run-tests.py ap_vlan_file_open2 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_file_open2 1/1
Test: AP VLAN with open network and vlan_file mapping (2)
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
PASS ap_vlan_file_open2 1.834327 2019-02-18 03:55:09.166559
passed all 1 test case(s)
2019-02-18 03:55:09 	./run-tests.py ap_vlan_file_parsing 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_file_parsing 1/1
Test: hostapd vlan_file/mac_file parsing
Starting AP wlan3
PASS ap_vlan_file_parsing 0.617818 2019-02-18 03:55:10.321704
passed all 1 test case(s)
2019-02-18 03:55:10 	./run-tests.py ap_vlan_iface_cleanup_multibss 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_iface_cleanup_multibss 1/1
Test: AP VLAN operation in multi-BSS multi-VLAN case
RTNETLINK answers: File exists
Starting AP wlan4
Starting interface wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
wlan0 -> VLAN 2
test wlan1 == VLAN 1
wlan1 -> VLAN 2
test wlan0 == VLAN 2
PASS ap_vlan_iface_cleanup_multibss 6.159491 2019-02-18 03:55:17.360016
passed all 1 test case(s)
2019-02-18 03:55:17 	./run-tests.py ap_vlan_iface_cleanup_multibss_per_sta_vif 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_iface_cleanup_multibss_per_sta_vif 1/1
Test: AP VLAN operation in multi-BSS multi-VLAN case with per-sta-vif set
Starting AP wlan4
Starting interface wlan3
Connect STA wlan0 to AP
dev1->dev2 unicast data delivery failed
Traceback (most recent call last):
  File "./run-tests.py", line 466, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_ap_vlan.py", line 505, in test_ap_vlan_iface_cleanup_multibss_per_sta_vif
    'multi-bss-iface-per_sta_vif.conf')
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_ap_vlan.py", line 404, in ap_vlan_iface_cleanup_multibss
    hwsim_utils.test_connectivity_iface(dev[0], hapd, "brvlan1")
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 176, in test_connectivity_iface
    max_tries=max_tries, timeout=timeout)
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 169, in test_connectivity
    raise Exception(last_err)
Exception: dev1->dev2 unicast data delivery failed
FAIL ap_vlan_iface_cleanup_multibss_per_sta_vif 7.965708 2019-02-18 03:55:25.909762
passed 0 test case(s)
skipped 0 test case(s)
failed tests: ap_vlan_iface_cleanup_multibss_per_sta_vif
2019-02-18 03:55:26 	./run-tests.py ap_vlan_open 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_open 1/1
Test: AP VLAN with open network
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
PASS ap_vlan_open 2.102242 2019-02-18 03:55:28.763859
passed all 1 test case(s)
2019-02-18 03:55:28 	./run-tests.py ap_vlan_open_per_sta_vif 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_open_per_sta_vif 1/1
Test: AP VLAN (dynamic) with open network
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vlan_open_per_sta_vif 0.847503 2019-02-18 03:55:30.465482
passed all 1 test case(s)
2019-02-18 03:55:30 	./run-tests.py ap_vlan_reconnect 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_reconnect 1/1
Test: AP VLAN with WPA2-PSK connect, disconnect, connect
Starting AP wlan3
connect sta
Connect STA wlan0 to AP
disconnect sta
reconnect sta
Connect STA wlan0 to AP
PASS ap_vlan_reconnect 2.54459 2019-02-18 03:55:33.672956
passed all 1 test case(s)
2019-02-18 03:55:33 	./run-tests.py ap_vlan_tagged 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_tagged 1/1
Test: AP VLAN with tagged interface
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
PASS ap_vlan_tagged 2.285961 2019-02-18 03:55:36.723342
passed all 1 test case(s)
2019-02-18 03:55:36 	./run-tests.py ap_vlan_tagged_wpa2_radius_id_change 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_tagged_wpa2_radius_id_change 1/1
Test: AP tagged VLAN with WPA2-Enterprise and RADIUS attributes changing VLANID
Starting AP wlan4
Starting AP wlan3
Connect STA wlan0 to AP
VLAN-ID -> 2
VLAN-ID -> 1
PASS ap_vlan_tagged_wpa2_radius_id_change 4.797598 2019-02-18 03:55:42.210015
passed all 1 test case(s)
2019-02-18 03:55:42 	./run-tests.py ap_vlan_without_station 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_without_station 1/1
Test: AP VLAN with WPA2-PSK and no station
Starting AP wlan3
Connect STA wlan0 to AP
first frame not observed
second frame not observed
Traceback (most recent call last):
  File "./run-tests.py", line 464, in main
    t(dev, apdev, params)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_ap_vlan.py", line 569, in test_ap_vlan_without_station
    raise Exception("second frame not observed")
Exception: second frame not observed
FAIL ap_vlan_without_station 3.525371 2019-02-18 03:55:46.600545
passed 0 test case(s)
skipped 0 test case(s)
failed tests: ap_vlan_without_station
2019-02-18 03:55:46 	./run-tests.py ap_vlan_wpa2 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_wpa2 1/1
Test: AP VLAN with WPA2-PSK
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
PASS ap_vlan_wpa2 1.968433 2019-02-18 03:55:49.347561
passed all 1 test case(s)
2019-02-18 03:55:49 	./run-tests.py ap_vlan_wpa2_psk_radius_required 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_wpa2_psk_radius_required 1/1
Test: AP VLAN with WPA2-PSK and RADIUS attributes required
Starting AP wlan3
connecting without VLAN
Connect STA wlan0 to AP
Received authentication request
connecting without VLAN failed as expected
connecting without VLAN (CUI/User-Name)
Connect STA wlan1 to AP
Received authentication request
connecting without VLAN failed as expected(2)
connecting with VLAN
Connect STA wlan2 to AP
Received authentication request
connecting with VLAN succeeded as expected
PASS ap_vlan_wpa2_psk_radius_required 6.585046 2019-02-18 03:55:56.784261
passed all 1 test case(s)
2019-02-18 03:55:56 	./run-tests.py ap_vlan_wpa2_radius 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_wpa2_radius 1/1
Test: AP VLAN with WPA2-Enterprise and RADIUS attributes
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
PASS ap_vlan_wpa2_radius 2.196264 2019-02-18 03:55:59.592897
passed all 1 test case(s)
2019-02-18 03:55:59 	./run-tests.py ap_vlan_wpa2_radius_2 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_wpa2_radius_2 1/1
Test: AP VLAN with WPA2-Enterprise and RADIUS EGRESS_VLANID attributes
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vlan_wpa2_radius_2 1.22128 2019-02-18 03:56:01.344570
passed all 1 test case(s)
2019-02-18 03:56:01 	./run-tests.py ap_vlan_wpa2_radius_id_change 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_wpa2_radius_id_change 1/1
Test: AP VLAN with WPA2-Enterprise and RADIUS attributes changing VLANID
Starting AP wlan4
Starting AP wlan3
Connect STA wlan0 to AP
VLAN-ID -> 2
VLAN-ID -> 1
PASS ap_vlan_wpa2_radius_id_change 3.514212 2019-02-18 03:56:05.460140
passed all 1 test case(s)
2019-02-18 03:56:05 	./run-tests.py ap_vlan_wpa2_radius_mixed 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_wpa2_radius_mixed 1/1
Test: AP VLAN with WPA2-Enterprise and tagged+untagged VLANs
Starting AP wlan3
Connect STA wlan0 to AP
Test connectivity in untagged VLAN 2
Test connectivity in tagged VLAN 1
PASS ap_vlan_wpa2_radius_mixed 1.822332 2019-02-18 03:56:08.176305
passed all 1 test case(s)
2019-02-18 03:56:08 	./run-tests.py ap_vlan_wpa2_radius_required 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_wpa2_radius_required 1/1
Test: AP VLAN with WPA2-Enterprise and RADIUS attributes required
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan2 to AP
PASS ap_vlan_wpa2_radius_required 1.20929 2019-02-18 03:56:10.616721
passed all 1 test case(s)
2019-02-18 03:56:10 	./run-tests.py ap_vlan_wpa2_radius_tagged 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_wpa2_radius_tagged 1/1
Test: AP VLAN with WPA2-Enterprise and RADIUS EGRESS_VLANID attributes
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vlan_wpa2_radius_tagged 1.161304 2019-02-18 03:56:12.544577
passed all 1 test case(s)
2019-02-18 03:56:12 	./run-tests.py ap_wds_sta 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wds_sta 1/1
Test: WPA2-PSK AP with STA using 4addr mode
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wds_sta 1.663096 2019-02-18 03:56:15.096223
passed all 1 test case(s)
2019-02-18 03:56:15 	./run-tests.py ap_wds_sta_open 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wds_sta_open 1/1
Test: Open AP with STA using 4addr mode
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wds_sta_open 1.436037 2019-02-18 03:56:17.319670
passed all 1 test case(s)
2019-02-18 03:56:17 	./run-tests.py ap_wds_sta_wep 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wds_sta_wep 1/1
Test: WEP AP with STA using 4addr mode
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wds_sta_wep 1.453279 2019-02-18 03:56:19.754751
passed all 1 test case(s)
2019-02-18 03:56:19 	./run-tests.py ap_wep_tdls 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wep_tdls 1/1
Test: WEP AP and two stations using TDLS
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Setup TDLS
Teardown TDLS
Setup TDLS
PASS ap_wep_tdls 5.21386 2019-02-18 03:56:25.945241
passed all 1 test case(s)
2019-02-18 03:56:26 	./run-tests.py ap_wep_to_wpa 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wep_to_wpa 1/1
Test: WEP to WPA2-PSK configuration change in hostapd
Starting AP wlan3
flush_scan_cache: Could not clear all BSS entries. These remain:
bssid / frequency / signal level / flags / ssid
02:00:00:00:03:00	2412	-30	[WEP][ESS]	wep-to-wpa

Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_wep_to_wpa 1.675087 2019-02-18 03:56:28.817724
passed all 1 test case(s)
2019-02-18 03:56:28 	./run-tests.py ap_wmm_uapsd 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wmm_uapsd 1/1
Test: AP with U-APSD advertisement
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wmm_uapsd 0.680948 2019-02-18 03:56:30.498942
passed all 1 test case(s)
2019-02-18 03:56:30 	./run-tests.py ap_wowlan_triggers 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wowlan_triggers 1/1
Test: AP with wowlan_triggers
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wowlan_triggers 0.628063 2019-02-18 03:56:31.928285
passed all 1 test case(s)
2019-02-18 03:56:32 	./run-tests.py ap_wpa2_already_in_bridge 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_already_in_bridge 1/1
Test: hostapd behavior with interface already in bridge
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_already_in_bridge 1.060688 2019-02-18 03:56:33.867243
passed all 1 test case(s)
2019-02-18 03:56:33 	./run-tests.py ap_wpa2_bridge_fdb 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_bridge_fdb 1/1
Test: Bridge FDB entry removal
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_wpa2_bridge_fdb 2.373252 2019-02-18 03:56:37.070589
passed all 1 test case(s)
ignored_by_lkp ap_wpa2_delayed_group_m1_retransmission
ignored_by_lkp ap_wpa2_delayed_m1_m3_retransmission
ignored_by_lkp ap_wpa2_delayed_m1_m3_retransmission2
2019-02-18 03:56:37 	./run-tests.py ap_wpa2_delayed_m1_m3_zero_tk 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_delayed_m1_m3_zero_tk 1/1
Test: Delayed M1+M3 retransmission and zero TK
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_delayed_m1_m3_zero_tk 1.980082 2019-02-18 03:56:40.026558
passed all 1 test case(s)
ignored_by_lkp ap_wpa2_delayed_m3_retransmission
2019-02-18 03:56:40 	./run-tests.py ap_wpa2_disable_eapol_retry 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_disable_eapol_retry 1/1
Test: WPA2-PSK disable EAPOL-Key retry
Starting AP wlan3
Verify working 4-way handshake without retries
Connect STA wlan0 to AP
Verify no retransmission of message 3/4
Connect STA wlan0 to AP
PASS ap_wpa2_disable_eapol_retry 5.06931 2019-02-18 03:56:45.674770
passed all 1 test case(s)
2019-02-18 03:56:45 	./run-tests.py ap_wpa2_disable_eapol_retry_group 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_disable_eapol_retry_group 1/1
Test: WPA2-PSK disable EAPOL-Key retry for group handshake
Starting AP wlan3
Connect STA wlan1 to AP
Connect STA wlan0 to AP
PASS ap_wpa2_disable_eapol_retry_group 6.40001 2019-02-18 03:56:52.860652
passed all 1 test case(s)
2019-02-18 03:56:52 	./run-tests.py ap_wpa2_eap_aka 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_aka 1/1
Test: WPA2-Enterprise connection using EAP-AKA
Starting AP wlan3
Connect STA wlan0 to AP
Negative test with incorrect key
Connect STA wlan0 to AP
Invalid Milenage key
Connect STA wlan0 to AP
Invalid Milenage key(2)
Connect STA wlan0 to AP
Invalid Milenage key(3)
Connect STA wlan0 to AP
Invalid Milenage key(4)
Connect STA wlan0 to AP
Invalid Milenage key(5)
Connect STA wlan0 to AP
Invalid Milenage key(6)
Connect STA wlan0 to AP
Missing key configuration
Connect STA wlan0 to AP
PASS ap_wpa2_eap_aka 3.102522 2019-02-18 03:56:56.708046
passed all 1 test case(s)
2019-02-18 03:56:56 	./run-tests.py ap_wpa2_eap_aka_config 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_aka_config 1/1
Test: EAP-AKA configuration options
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_aka_config 0.768344 2019-02-18 03:56:58.087304
passed all 1 test case(s)
2019-02-18 03:56:58 	./run-tests.py ap_wpa2_eap_aka_ext 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_aka_ext 1/1
Test: WPA2-Enterprise connection using EAP-AKA and external UMTS auth
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_aka_ext 3.556318 2019-02-18 03:57:02.400173
passed all 1 test case(s)
2019-02-18 03:57:02 	./run-tests.py ap_wpa2_eap_aka_ext_auth_fail 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_aka_ext_auth_fail 1/1
Test: EAP-AKA with external UMTS auth and auth failing
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_aka_ext_auth_fail 0.611019 2019-02-18 03:57:03.830989
passed all 1 test case(s)
2019-02-18 03:57:03 	./run-tests.py ap_wpa2_eap_aka_prime 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_aka_prime 1/1
Test: WPA2-Enterprise connection using EAP-AKA'
Starting AP wlan3
Connect STA wlan0 to AP
EAP-AKA' bidding protection when EAP-AKA enabled as well
Connect STA wlan1 to AP
Negative test with incorrect key
Connect STA wlan0 to AP
PASS ap_wpa2_eap_aka_prime 1.632476 2019-02-18 03:57:06.456149
passed all 1 test case(s)
2019-02-18 03:57:06 	./run-tests.py ap_wpa2_eap_aka_prime_ext 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_aka_prime_ext 1/1
Test: EAP-AKA' with external UMTS auth to hit Synchronization-Failure
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_aka_prime_ext 0.855597 2019-02-18 03:57:08.394548
passed all 1 test case(s)
2019-02-18 03:57:08 	./run-tests.py ap_wpa2_eap_aka_prime_ext_auth_fail 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_aka_prime_ext_auth_fail 1/1
Test: EAP-AKA' with external UMTS auth and auth failing
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_aka_prime_ext_auth_fail 0.687723 2019-02-18 03:57:09.967309
passed all 1 test case(s)
ignored_by_lkp ap_wpa2_eap_aka_prime_sql
2019-02-18 03:57:10 	./run-tests.py ap_wpa2_eap_aka_sql 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_aka_sql 1/1
Test: WPA2-Enterprise connection using EAP-AKA (SQL)
Starting AP wlan3
Connect STA wlan0 to AP
AKA fast re-authentication
AKA full auth with pseudonym
AKA full auth with permanent identity
AKA reauth with mismatching MK
Connect STA wlan0 to AP
AKA reauth with mismatching counter
Connect STA wlan0 to AP
AKA reauth with max reauth count reached
PASS ap_wpa2_eap_aka_sql 1.67753 2019-02-18 03:57:12.590868
passed all 1 test case(s)
2019-02-18 03:57:12 	./run-tests.py ap_wpa2_eap_assoc_rsn 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_assoc_rsn 1/1
Test: WPA2-Enterprise AP and association request RSN IE differences
Starting AP wlan3
Starting AP wlan4
Normal wpa_supplicant assoc req RSN IE
Connect STA wlan0 to AP
Extra PMKIDCount field in RSN IE
Connect STA wlan0 to AP
Extra Group Management Cipher Suite in RSN IE
Connect STA wlan0 to AP
Extra undefined extension field in RSN IE
Connect STA wlan0 to AP
RSN IE without RSN Capabilities
Connect STA wlan0 to AP
RSN IE without AKM
Connect STA wlan0 to AP
RSN IE without pairwise
Connect STA wlan0 to AP
RSN IE without group
Connect STA wlan0 to AP
Normal wpa_supplicant assoc req RSN IE
Connect STA wlan0 to AP
Group management cipher included in assoc req RSN IE
Connect STA wlan0 to AP
Invalid group cipher
Connect STA wlan0 to AP
Invalid pairwise cipher
Connect STA wlan0 to AP
Management frame protection not enabled
Connect STA wlan0 to AP
Unsupported management group cipher
Connect STA wlan0 to AP
PASS ap_wpa2_eap_assoc_rsn 3.983073 2019-02-18 03:57:17.522490
passed all 1 test case(s)
2019-02-18 03:57:17 	./run-tests.py ap_wpa2_eap_eke 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_eke 1/1
Test: WPA2-Enterprise connection using EAP-EKE
Starting AP wlan3
Connect STA wlan0 to AP
Test forced algorithm selection
Test failed algorithm negotiation
Negative test with incorrect password
Connect STA wlan0 to AP
PASS ap_wpa2_eap_eke 4.163842 2019-02-18 03:57:22.940469
passed all 1 test case(s)
2019-02-18 03:57:23 	./run-tests.py ap_wpa2_eap_eke_many --long
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_eke_many 1/1
Test: WPA2-Enterprise connection using EAP-EKE (many connections) [long]
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Total success=300 failure=0
PASS ap_wpa2_eap_eke_many 74.35472 2019-02-18 03:58:38.380717
passed all 1 test case(s)
ignored_by_lkp ap_wpa2_eap_eke_server_oom
ignored_by_lkp ap_wpa2_eap_eke_serverid_nai
2019-02-18 03:58:38 	./run-tests.py ap_wpa2_eap_expanded_nak 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_expanded_nak 1/1
Test: WPA2-Enterprise connection with EAP resulting in expanded NAK
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_expanded_nak 4.44168 2019-02-18 03:58:43.325725
passed all 1 test case(s)
2019-02-18 03:58:43 	./run-tests.py ap_wpa2_eap_ext_enable_network_while_connected 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_ext_enable_network_while_connected 1/1
Test: WPA2-Enterprise interactive identity entry and ENABLE_NETWORK
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_wpa2_eap_ext_enable_network_while_connected 1.775412 2019-02-18 03:58:45.717845
passed all 1 test case(s)
2019-02-18 03:58:45 	./run-tests.py ap_wpa2_eap_fast_binary_pac 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_binary_pac 1/1
Test: WPA2-Enterprise connection using EAP-FAST and binary PAC format
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_binary_pac 1.406704 2019-02-18 03:58:47.654618
passed all 1 test case(s)
2019-02-18 03:58:47 	./run-tests.py ap_wpa2_eap_fast_binary_pac_errors 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_binary_pac_errors 1/1
Test: EAP-FAST and binary PAC errors
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_binary_pac_errors 9.403607 2019-02-18 03:58:57.965410
passed all 1 test case(s)
2019-02-18 03:58:58 	./run-tests.py ap_wpa2_eap_fast_cipher_suites 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_cipher_suites 1/1
Test: EAP-FAST and different TLS cipher suites
Starting AP wlan3
Connect STA wlan0 to AP
Testing DHE-RSA-AES128-SHA
Connect STA wlan0 to AP
Testing RC4-SHA
Connect STA wlan0 to AP
Allow failure due to missing TLS library support
Testing AES128-SHA
Connect STA wlan0 to AP
Testing AES256-SHA
Connect STA wlan0 to AP
Testing DHE-RSA-AES256-SHA
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_cipher_suites 2.888002 2019-02-18 03:59:01.960077
passed all 1 test case(s)
2019-02-18 03:59:02 	./run-tests.py ap_wpa2_eap_fast_eap_aka 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_eap_aka 1/1
Test: WPA2-Enterprise connection using EAP-FAST/EAP-AKA
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_eap_aka 0.974931 2019-02-18 03:59:04.076214
passed all 1 test case(s)
2019-02-18 03:59:04 	./run-tests.py ap_wpa2_eap_fast_eap_sim 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_eap_sim 1/1
Test: WPA2-Enterprise connection using EAP-FAST/EAP-SIM
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_eap_sim 0.929913 2019-02-18 03:59:05.862302
passed all 1 test case(s)
2019-02-18 03:59:05 	./run-tests.py ap_wpa2_eap_fast_eap_sim_ext 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_eap_sim_ext 1/1
Test: WPA2-Enterprise connection using EAP-FAST/EAP-SIM and external GSM auth
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_eap_sim_ext 0.852774 2019-02-18 03:59:07.641296
passed all 1 test case(s)
2019-02-18 03:59:07 	./run-tests.py ap_wpa2_eap_fast_gtc_auth_prov 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_gtc_auth_prov 1/1
Test: WPA2-Enterprise connection using EAP-FAST/GTC and authenticated provisioning
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_gtc_auth_prov 1.024947 2019-02-18 03:59:09.578109
passed all 1 test case(s)
2019-02-18 03:59:09 	./run-tests.py ap_wpa2_eap_fast_gtc_identity_change 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_gtc_identity_change 1/1
Test: WPA2-Enterprise connection using EAP-FAST/GTC and identity changing
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_gtc_identity_change 1.320837 2019-02-18 03:59:11.945942
passed all 1 test case(s)
2019-02-18 03:59:12 	./run-tests.py ap_wpa2_eap_fast_missing_pac_config 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_missing_pac_config 1/1
Test: WPA2-Enterprise connection using EAP-FAST and missing PAC config
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_missing_pac_config 0.933775 2019-02-18 03:59:14.222675
passed all 1 test case(s)
2019-02-18 03:59:14 	./run-tests.py ap_wpa2_eap_fast_mschapv2_unauth_prov 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_mschapv2_unauth_prov 1/1
Test: WPA2-Enterprise connection using EAP-FAST/MSCHAPv2 and unauthenticated provisioning
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_mschapv2_unauth_prov 1.424351 2019-02-18 03:59:17.065810
passed all 1 test case(s)
2019-02-18 03:59:17 	./run-tests.py ap_wpa2_eap_fast_pac_file 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_pac_file 1/1
Test: WPA2-Enterprise connection using EAP-FAST/MSCHAPv2 and PAC file
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan1 to AP
PASS ap_wpa2_eap_fast_pac_file 2.923583 2019-02-18 03:59:21.505107
passed all 1 test case(s)
2019-02-18 03:59:21 	./run-tests.py ap_wpa2_eap_fast_pac_lifetime 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_pac_lifetime 1/1
Test: EAP-FAST and PAC lifetime
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_pac_lifetime 4.376031 2019-02-18 03:59:26.943570
passed all 1 test case(s)
2019-02-18 03:59:27 	./run-tests.py ap_wpa2_eap_fast_pac_refresh 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_pac_refresh 1/1
Test: EAP-FAST and PAC refresh
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_pac_refresh 3.517503 2019-02-18 03:59:31.585812
passed all 1 test case(s)
2019-02-18 03:59:31 	./run-tests.py ap_wpa2_eap_fast_pac_truncate 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_pac_truncate 1/1
Test: EAP-FAST and PAC list truncation
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_pac_truncate 5.803978 2019-02-18 03:59:38.146524
passed all 1 test case(s)
2019-02-18 03:59:38 	./run-tests.py ap_wpa2_eap_fast_prf_oom 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_prf_oom 1/1
Test: WPA2-Enterprise connection using EAP-FAST and OOM in PRF
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_prf_oom 0.668612 2019-02-18 03:59:39.763243
passed all 1 test case(s)
2019-02-18 03:59:39 	./run-tests.py ap_wpa2_eap_fast_prov 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_prov 1/1
Test: EAP-FAST and provisioning options
Starting AP wlan3
Provisioning attempt while server has provisioning disabled
Connect STA wlan0 to AP
Authenticated provisioning
Provisioning disabled - using previously provisioned PAC
Drop PAC and verify connection failure
Anonymous provisioning
Provisioning disabled - using previously provisioned PAC
PASS ap_wpa2_eap_fast_prov 3.631459 2019-02-18 03:59:44.247819
passed all 1 test case(s)
2019-02-18 03:59:44 	./run-tests.py ap_wpa2_eap_fast_server_oom 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_server_oom 1/1
Test: EAP-FAST/MSCHAPv2 and server OOM
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_server_oom 1.649876 2019-02-18 03:59:47.585881
passed all 1 test case(s)
2019-02-18 03:59:47 	./run-tests.py ap_wpa2_eap_fast_text_pac_errors 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_text_pac_errors 1/1
Test: EAP-FAST and text PAC errors
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Starting AP wlan4
Connect STA wlan0 to AP
Starting AP wlan4
Connect STA wlan0 to AP
Starting AP wlan4
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_text_pac_errors 8.64542 2019-02-18 03:59:57.312444
passed all 1 test case(s)
2019-02-18 03:59:57 	./run-tests.py ap_wpa2_eap_gpsk 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_gpsk 1/1
Test: WPA2-Enterprise connection using EAP-GPSK
Starting AP wlan3
Connect STA wlan0 to AP
Test forced algorithm selection
Test failed algorithm negotiation
Negative test with incorrect password
Connect STA wlan0 to AP
PASS ap_wpa2_eap_gpsk 2.622526 2019-02-18 04:00:00.917552
passed all 1 test case(s)
2019-02-18 04:00:01 	./run-tests.py ap_wpa2_eap_gpsk_ptk_rekey_ap 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_gpsk_ptk_rekey_ap 1/1
Test: WPA2-Enterprise with EAP-GPSK and PTK rekey enforced by AP
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_gpsk_ptk_rekey_ap 3.047803 2019-02-18 04:00:05.099445
passed all 1 test case(s)
2019-02-18 04:00:05 	./run-tests.py ap_wpa2_eap_ikev2 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_ikev2 1/1
Test: WPA2-Enterprise connection using EAP-IKEv2
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Negative test with incorrect password
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_wpa2_eap_ikev2 1.751638 2019-02-18 04:00:07.941861
passed all 1 test case(s)
2019-02-18 04:00:08 	./run-tests.py ap_wpa2_eap_ikev2_as_frag 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_ikev2_as_frag 1/1
Test: WPA2-Enterprise connection using EAP-IKEv2 with server fragmentation
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_ikev2_as_frag 0.801185 2019-02-18 04:00:09.496354
passed all 1 test case(s)
2019-02-18 04:00:09 	./run-tests.py ap_wpa2_eap_ikev2_oom 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_ikev2_oom 1/1
Test: WPA2-Enterprise connection using EAP-IKEv2 and OOM
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_wpa2_eap_ikev2_oom 1.486708 2019-02-18 04:00:11.674223
passed all 1 test case(s)
ignored_by_lkp ap_wpa2_eap_in_bridge
2019-02-18 04:00:11 	./run-tests.py ap_wpa2_eap_interactive 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_interactive 1/1
Test: WPA2-Enterprise connection using interactive identity/password entry
Starting AP wlan3
Connection with dynamic TTLS/MSCHAPv2 password entry
Connect STA wlan0 to AP
Connection with dynamic TTLS/MSCHAPv2 identity and password entry
Connect STA wlan0 to AP
Connection with dynamic TTLS/EAP-MSCHAPv2 password entry
Connect STA wlan0 to AP
Connection with dynamic TTLS/EAP-MD5 password entry
Connect STA wlan0 to AP
Connection with dynamic PEAP/EAP-MSCHAPv2 password entry
Connect STA wlan0 to AP
Connection with dynamic PEAP/EAP-GTC password entry
Connect STA wlan0 to AP
PASS ap_wpa2_eap_interactive 2.229559 2019-02-18 04:00:14.931981
passed all 1 test case(s)
2019-02-18 04:00:15 	./run-tests.py ap_wpa2_eap_no_workaround 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_no_workaround 1/1
Test: WPA2-Enterprise connection using EAP-TTLS and eap_workaround=0
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_no_workaround 0.748379 2019-02-18 04:00:16.464873
passed all 1 test case(s)
2019-02-18 04:00:16 	./run-tests.py ap_wpa2_eap_non_ascii_identity 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_non_ascii_identity 1/1
Test: WPA2-Enterprise connection attempt using non-ASCII identity
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_wpa2_eap_non_ascii_identity 4.926255 2019-02-18 04:00:22.186021
passed all 1 test case(s)
2019-02-18 04:00:22 	./run-tests.py ap_wpa2_eap_non_ascii_identity2 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_non_ascii_identity2 1/1
Test: WPA2-Enterprise connection attempt using non-ASCII identity
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_wpa2_eap_non_ascii_identity2 4.897567 2019-02-18 04:00:28.131459
passed all 1 test case(s)
2019-02-18 04:00:28 	./run-tests.py ap_wpa2_eap_oom 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_oom 1/1
Test: EAP server and OOM
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_oom 2.9186 2019-02-18 04:00:31.869330
passed all 1 test case(s)
2019-02-18 04:00:31 	./run-tests.py ap_wpa2_eap_pax 
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_pax 1/1
Test: WPA2-Enterprise connection using EAP-PAX
Starting AP wlan3
Connect STA wlan0 to AP
Negative test with incorrect password
Connect STA wlan0 to AP
PASS ap_wpa2_eap_pax 0.988707 2019-02-18 04:00:33.697369
passed all 1 test case(s)
2019-02-18 04:00:33 ./stop.sh
2019-02-18 04:00:35 ./start.sh channels=4
2019-02-18 04:00:36 ./stop.sh

--jL2BoiuKMElzg3CS--
