Date: Sat, 13 Mar 2010 12:21:11 +0100
From: Michael Guntsche <mike@it-loops.com>
Message-ID: <20100313112111.GA21202@gibson.comsick.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] Kernel Panic when using tcpdump on bridge device
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,

I am currently testing 2.6.34-rc1 on a mikrotik routerboard. I recently installed a
wlan module and am now bridging the wired and wireless network. On the
one side I have a gianfar driver and on the other the ath9k for my Wlan
card. Everything works as it should during normal operation. Today I
wanted to debug a net related problem and started tcpdump on the bridge
interface. This resulted in an immediate kernel panic. 

tcpdump  -i lan
[238687.697927] device lan entered promiscuous mode
[238687.709478] Unable to handle kernel paging request for data at address 0x000040a8
[238687.717151] Faulting instruction address: 0xc9a7d4ec
[238687.722235] Oops: Kernel access of bad area, sig: 11 [#1]
[238687.727735] MikroTik RouterBOARD 600 series
[238687.732015] last sysfs file: /sys/devices/virtual/net/lo/operstate
[238687.738298] Modules linked in: yaffs2 aes_generic bridgJe stp llc emlog nf_nat_rtsp nf_conntrack_rtsp arc4 ecb ath9k ath9k_common mac80211 ath9k_hw ath cfg80211
[238687.752792] NIP: c9a7d4ec LR: c9a7d4dc CTR: c01d3b40
[238687.757860] REGS: c7839ab0 TRAP: 0300   Not tainted  (2.6.34-rc1)
[238687.764055] MSR: 00009032 <EE,ME,IR,DR>  CR: 84008088  XER: 20000000
[238687.770556] DAR: 000040a8, DSISR: 20000000
[238687.774750] TASK = c7829200[5] 'events/0' THREAD: c7838000
[238687.780160] GPR00: c9a7d4dc c7839b60 c7829200 00000000 c7b72900 00000007 00000002 c03a0000
[238687.788672] GPR08: c03a46a0 c9a7c64c 00004050 00000002 44008084 1001ade8 00000000 00000040
[238687.797184] GPR16: c78424b0 00000001 c032d6d8 00000000 c7b20800 00000000 00000001 00000007
[238687.805695] GPR24: c7b72900 00000000 c7842000 c7b72918 c649d2e0 c697e040 c7b72900 c7b72900
[238687.814429] NIP [c9a7d4ec] br_handle_frame_finish+0x13c/0x24c [bridge]   
[238687.821076] LR [c9a7d4dc] br_handle_frame_finish+0x12c/0x24c [bridge]
[238687.827618] Call Trace:
[238687.830173] [c7839b60] [c9a7d4dc] br_handle_frame_finish+0x12c/0x24c [bridge] (unreliable)
[238687.838580] [c7839b80] [c9a82e98] br_nf_pre_routing_finish_ipv6+0x134/0x158 [bridge]
[238687.846454] [c7839b90] [c9a8383c] br_nf_pre_routing+0x610/0x78c [bridge] 
[238687.853289] [c7839bc0] [c01ffea0] nf_iterate+0x90/0xd0
[238687.858537] [c7839bf0] [c02000a0] nf_hook_slow+0x70/0x100
[238687.864058] [c7839c30] [c9a7d788] br_handle_frame+0x18c/0x278 [bridge]   
[238687.870715] [c7839c50] [c01df184] netif_receive_skb+0x184/0x528
[238687.876754] [c7839c90] [c01a75ec] gfar_clean_rx_ring+0xd4/0x420
[238687.882786] [c7839ce0] [c01a7cdc] gfar_poll+0x3a4/0x4e8
[238687.888124] [c7839d80] [c01df90c] net_rx_action+0xf0/0x1b4
[238687.893735] [c7839dc0] [c00266b4] __do_softirq+0xb4/0x134
[238687.899253] [c7839e00] [c00063f8] do_softirq+0x58/0x5c
[238687.904502] [c7839e10] [c00264a4] irq_exit+0x7c/0x9c
[238687.909576] [c7839e20] [c0006498] do_IRQ+0x9c/0xb4
[238687.914490] [c7839e40] [c0011ce0] ret_from_except+0x0/0x14
[238687.920103] --- Exception: 501 at ppp_asynctty_receive+0x160/0x5b8
[238687.920114]     LR = ppp_asynctty_receive+0x4f8/0x5b8
[238687.931540] [c7839f00] [c01b3f4c] ppp_asynctty_receive+0x26c/0x5b8 (unreliable)
[238687.938975] [c7839f50] [c0158584] flush_to_ldisc+0x150/0x1ac
[238687.944747] [c7839f70] [c0033a94] worker_thread+0x11c/0x1a0
[238687.950435] [c7839fc0] [c00379d0] kthread+0x78/0x7c
[238687.955424] [c7839ff0] [c00113a8] kernel_thread+0x4c/0x68
[238687.960927] Instruction dump:
[238687.963994] 912b0078 2f9e0000 419e0018 2f830000 419e00fc 80630008 7fc4f378 4bfff2f1
[238687.971895] 419200e4 815f0018 3ce0c03a 390746a0 <812a0058> 816a0060 39290001 912a0058
[238687.980015] Kernel panic - not syncing: Fatal exception in interrupt
[238687.986496] Rebooting in 180 seconds..

For testing purposes I tried running tcpdump on the devices itself (ppp0, lan_wire,wlan0) and was not able to reproduce this. The only difference to rc1 is a patch from netdev I applied to be able to run tcpdump..

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 031a5e6..1612d41 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1688,6 +1688,8 @@ static int packet_dev_mc(struct net_device *dev, struct packet_mclist *i,
 {
        switch (i->type) {
        case PACKET_MR_MULTICAST:
+               if (i->alen != dev->addr_len)
+                       return -EINVAL;
                if (what > 0)
                        return dev_mc_add(dev, i->addr, i->alen, 0);
                else
@@ -1700,6 +1702,8 @@ static int packet_dev_mc(struct net_device *dev, struct packet_mclist *i,
                return dev_set_allmulti(dev, what);
                break;
        case PACKET_MR_UNICAST:
+               if (i->alen != dev->addr_len)
+                       return -EINVAL;
                if (what > 0)
                        return dev_unicast_add(dev, i->addr);
                else
@@ -1734,7 +1738,7 @@ static int packet_mc_add(struct sock *sk, struct packet_mreq_max *mreq)
                goto done;
 
        err = -EINVAL;
-       if (mreq->mr_alen != dev->addr_len)
+       if (mreq->mr_alen > dev->addr_len)
                goto done;
 
        err = -ENOBUFS;


Since it was working with the devices themself and panicked with the bridge I posted this here.
If you need more information just tell me.
Please CC me on any replies since I am not subscribed to the list.

Kind regards,
Michael
