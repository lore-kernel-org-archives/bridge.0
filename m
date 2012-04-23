Return-Path: <feldmann_markus@gmx.de>
Message-ID: <4F95550B.6010409@gmx.de>
Date: Mon, 23 Apr 2012 15:11:39 +0200
From: Markus Feldmann <feldmann_markus@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] wlan0 will not be automatically  added to br0
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi All,

i want my wlan0 added automatically to br0 on my Debian Squeeze Server. 
At the moment the ports eth[1-3] are running over br0. I am using kernel 
3.2.9. The port eth0 is only for internet. eth[1-3] are for my local 
network at home. When i manually add wlan0 to br0 i can built up a 
communication between my laptop and my server. Therfore i execute the 
command <brctl addif br0 wlan0> on my server.

Here are some configs:
/etc/network/interfaces
auto lo
iface lo inet loopback

auto br0
iface br0 inet static
     address 192.168.0.186
     netmask 255.255.255.0
     broadcast 192.168.0.255
     bridge_ports eth1 eth2 eth3 wlan0
     bridge_ageing 300
     bridge_fd 1

# Mapping to DSL- oder DHCP-Router
mapping eth0
     ...

/etc/default/hostapd
DAEMON_CONF="/etc/hostapd.conf"

/etc/hostapd.conf
         interface=wlan0
         bridge=br0
         driver=nl80211
         logger_syslog=-1
         logger_syslog_level=1
         logger_stdout=-1
         logger_stdout_level=1
         dump_file=/tmp/hostapd.dump
         ctrl_interface=/var/run/hostapd
         ctrl_interface_group=0
         ssid=fortress
         country_code=DE
         hw_mode=g
         channel=1
         beacon_int=100
         dtim_period=2
         max_num_sta=255
         rts_threshold=2347
         fragm_threshold=2346
         macaddr_acl=0
         auth_algs=3
         ignore_broadcast_ssid=0
         wmm_enabled=1
         wmm_ac_bk_cwmin=4
         wmm_ac_bk_cwmax=10
         wmm_ac_bk_aifs=7
         wmm_ac_bk_txop_limit=0
         wmm_ac_bk_acm=0
         wmm_ac_be_aifs=3
         wmm_ac_be_cwmin=4
         wmm_ac_be_cwmax=10
         wmm_ac_be_txop_limit=0
         wmm_ac_be_acm=0
         wmm_ac_vi_aifs=2
         wmm_ac_vi_cwmin=3
         wmm_ac_vi_cwmax=4
         wmm_ac_vi_txop_limit=94
         wmm_ac_vi_acm=0
         wmm_ac_vo_aifs=2
         wmm_ac_vo_cwmin=2
         wmm_ac_vo_cwmax=3
         wmm_ac_vo_txop_limit=47
         wmm_ac_vo_acm=0
         eapol_key_index_workaround=0
         eap_server=0
         own_ip_addr=127.0.0.1
         wpa=2
         wpa_passphrase=PASSWORT
         wpa_key_mgmt=WPA-PSK WPA-EAP
         wpa_pairwise=TKIP CCMP
         rsn_pairwise=CCMP

<brctl showstp br0> only shows the ports eth[1-3] when i try to add 
wlan0 with </etc/network/interfaces> start-script. Any idea?

regards Markus
