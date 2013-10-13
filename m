Return-Path: <nedco@unacs.bg>
Message-ID: <525AA75F.5080602@unacs.bg>
Date: Sun, 13 Oct 2013 16:59:59 +0300
From: "nedco@unacs.bg" <nedco@unacs.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] linux bridge performance tests and problems ebtables 100%
	cpu
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

I make some networking performance tests for Linux 3.10.13 #1 SMP
is that normal

Linux (pktget) ----> Linux (router) ----> Linux (Sink)

eth0:            0.00 P/s        652024.78 P/s        652024.78 P/s
eth1:       652175.58 P/s             2.98 P/s        652178.55 P/s

with echo 0 >/proc/sys/net/bridge/bridge-nf-call-iptables CPU is about 2%
with echo 1 >/proc/sys/net/bridge/bridge-nf-call-iptables 1 CPU is 100% 
si no rules in iptables is that normal ?

ok lets get back to

with echo 0 >/proc/sys/net/bridge/bridge-nf-call-iptables CPU is about 2%

ebtables -A FORWARD -d 00:0D:BD:A4:E1:C8 -j mark --set-mark 1 
--mark-target ACCEPT

i get 7-20% CPU usage on all 4 CPUs
adding another rule make this 20-40%

what I'm doing wrong?

Thanks for Your help



Current configuration:

CPU: Intel(R) Xeon(R) CPU           E5430  @ 2.66GHz

03:00.0 Ethernet controller: Broadcom Corporation NetXtreme II BCM5708 
Gigabit Ethernet (rev 12)
05:00.0 Ethernet controller: Broadcom Corporation NetXtreme II BCM5708 
Gigabit Ethernet (rev 12)

brctl addbr br0
brctl stp br0 off
brctl addif br0 eth1
brctl addif br0 eth0

modinfo bnx2
filename: /lib/modules/3.10.13/kernel/drivers/net/ethernet/broadcom/bnx2.ko
firmware:       bnx2/bnx2-rv2p-09ax-6.0.17.fw
firmware:       bnx2/bnx2-rv2p-09-6.0.17.fw
firmware:       bnx2/bnx2-mips-09-6.2.1b.fw
firmware:       bnx2/bnx2-rv2p-06-6.0.15.fw
firmware:       bnx2/bnx2-mips-06-6.2.3.fw
version:        2.2.3
license:        GPL
description:    Broadcom NetXtreme II BCM5706/5708/5709/5716 Driver
author:         Michael Chan <mchan@broadcom.com>
srcversion:     EF31CD21E25CA48B686B9B7
alias:          pci:v000014E4d0000163Csv*sd*bc*sc*i*
alias:          pci:v000014E4d0000163Bsv*sd*bc*sc*i*
alias:          pci:v000014E4d0000163Asv*sd*bc*sc*i*
alias:          pci:v000014E4d00001639sv*sd*bc*sc*i*
alias:          pci:v000014E4d000016ACsv*sd*bc*sc*i*
alias:          pci:v000014E4d000016AAsv*sd*bc*sc*i*
alias:          pci:v000014E4d000016AAsv0000103Csd00003102bc*sc*i*
alias:          pci:v000014E4d0000164Csv*sd*bc*sc*i*
alias:          pci:v000014E4d0000164Asv*sd*bc*sc*i*
alias:          pci:v000014E4d0000164Asv0000103Csd00003106bc*sc*i*
alias:          pci:v000014E4d0000164Asv0000103Csd00003101bc*sc*i*
depends:
intree:         Y
vermagic:       3.10.13 SMP mod_unload modversions
parm:           disable_msi:Disable Message Signaled Interrupt (MSI) (int)


pktgen config:
clone_skb 32
pkt_size 64
delay 0
pgset "count 0"

pgset "delay 0"
pgset "flows 256"
pgset "flowlen 8"


grep . /proc/sys/net/bridge/bridge-nf-*
/proc/sys/net/bridge/bridge-nf-call-arptables:1
/proc/sys/net/bridge/bridge-nf-call-ip6tables:0
/proc/sys/net/bridge/bridge-nf-call-iptables:0
/proc/sys/net/bridge/bridge-nf-filter-pppoe-tagged:0
/proc/sys/net/bridge/bridge-nf-filter-vlan-tagged:0
/proc/sys/net/bridge/bridge-nf-pass-vlan-input-dev:0

  ethtool -c eth0
Coalesce parameters for eth0:
Adaptive RX: off  TX: off
stats-block-usecs: 999936
sample-interval: 0
pkt-rate-low: 0
pkt-rate-high: 0

rx-usecs: 18
rx-frames: 12
rx-usecs-irq: 18
rx-frames-irq: 2

tx-usecs: 80
tx-frames: 20
tx-usecs-irq: 18
tx-frames-irq: 2

rx-usecs-low: 0
rx-frame-low: 0
tx-usecs-low: 0
tx-frame-low: 0

rx-usecs-high: 0
rx-frame-high: 0
tx-usecs-high: 0
tx-frame-high: 0

  ethtool -k eth0
Features for eth0:
rx-checksumming: on
tx-checksumming: on
         tx-checksum-ipv4: on
         tx-checksum-ip-generic: off [fixed]
         tx-checksum-ipv6: off [fixed]
         tx-checksum-fcoe-crc: off [fixed]
         tx-checksum-sctp: off [fixed]
scatter-gather: on
         tx-scatter-gather: on
         tx-scatter-gather-fraglist: off [fixed]
tcp-segmentation-offload: on
         tx-tcp-segmentation: on
         tx-tcp-ecn-segmentation: on
         tx-tcp6-segmentation: off [fixed]
udp-fragmentation-offload: off [fixed]
generic-segmentation-offload: on
generic-receive-offload: on
large-receive-offload: off [fixed]
rx-vlan-offload: on
tx-vlan-offload: on
ntuple-filters: off [fixed]
receive-hashing: on
highdma: on [fixed]
rx-vlan-filter: off [fixed]
vlan-challenged: off [fixed]
tx-lockless: off [fixed]
netns-local: off [fixed]
tx-gso-robust: off [fixed]
tx-fcoe-segmentation: off [fixed]
tx-gre-segmentation: off [fixed]
tx-udp_tnl-segmentation: off [fixed]
fcoe-mtu: off [fixed]
tx-nocache-copy: on
loopback: off [fixed]
rx-fcs: off [fixed]
rx-all: off [fixed]
tx-vlan-stag-hw-insert: off [fixed]
rx-vlan-stag-hw-parse: off [fixed]
rx-vlan-stag-filter: off [fixed]

