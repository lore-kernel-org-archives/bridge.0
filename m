From: Morten K <mkrakvik@online.no>
Content-Type: text/plain
Date: Mon, 16 Jan 2006 13:25:14 +0100
Message-Id: <1137414314.9429.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Bridge kernel panic
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hi,

I'm having some problems with kernel panic with the bridge. I have the
following network setup:

      |
      |
 +----+----+
 |  (eth0) |                 +---------+
 | Bridge  |                 |         |            
 |   (eth1)|<-- Mirror of ---+ Switch  |            +---------+
 +- - - - -+   1000SX link   |         |<--1000SX-->| Switch  |
 |         |                 |    A    |            |    B    |
 |   (eth2)|<--------------->|         |            +----+----+
 |10.0.0.15|                 +---------+                 |
 +---------+                                             |
                                                    +----+----+
                                                    |   Host  |
                                                    |    A    |
                                                    |10.0.0.12|
                                                    +---------+

The bridge forwards mirror traffic from eth1 to eth0. On
eth1, traffic from the link between Switch A and Switch B is
mirrored/copied to the interface. The bridge will then DNAT this
traffic and send it out on the eth0 interface to some IDS sensors.

br0, eth0 and eth1 has no IP addresses.

Now, this works fine until I send _many_ packets from Host A (10.0.0.12)
to eth2 (management interface) on the bridge, like;

root@HostA# yes foo | nc -u 10.0.0.15 3333

The traffic will then be seen on both eth1 and eth2.

Then I get this kernel panic on the bridge:

Unable to handle kernel NULL pointer dereference at virtual address 00000010
 printing eip:
c035d28e
*pde = 36ca6001
*pte = 00000000
Oops: 0000 [#1]
Modules linked in:
CPU:    0
EIP:    0060:[<c035d28e>]    Not tainted VLI
EFLAGS: 00010282   (2.6.15)
EIP is at br_nf_pre_routing_finish+0x1a/0x34e
eax: f7b0b380   ebx: 00000000   ecx: 00000001   edx: f7b0b380
esi: f7b11820   edi: c0496da0   ebp: f7287800   esp: c044fd40
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c044e000 task=c03e9b00)
Stack: a91f2f0a 00000000 f7bcc55c 00000002 c03470c7 f7bcc55c 00000002 00000000
       c044fe30 f7bcc55c f7bcc5d8 f8806080 c0499300 c044fdfc 101f2f0a c044fe30
       a91f2f0a c034727a 00000000 c044fe30 f7287800 00000000 c035d274 c044fdfc
Call Trace:
 [<c03470c7>] ip_nat_fn+0x7b/0x1e4
 [<c034727a>] ip_nat_in+0x4a/0xc1
 [<c035d274>] br_nf_pre_routing_finish+0x0/0x34e
 [<c035d274>] br_nf_pre_routing_finish+0x0/0x34e
 [<c0302017>] nf_iterate+0x6f/0x87
 [<c035d274>] br_nf_pre_routing_finish+0x0/0x34e
 [<c035d274>] br_nf_pre_routing_finish+0x0/0x34e
 [<c030209a>] nf_hook_slow+0x6b/0x102
 [<c035d274>] br_nf_pre_routing_finish+0x0/0x34e
 [<c035958e>] br_handle_frame_finish+0x0/0x109
 [<c035db86>] br_nf_pre_routing+0x276/0x449
 [<c035d274>] br_nf_pre_routing_finish+0x0/0x34e
 [<c0302017>] nf_iterate+0x6f/0x87
 [<c035958e>] br_handle_frame_finish+0x0/0x109
 [<c035958e>] br_handle_frame_finish+0x0/0x109
 [<c030209a>] nf_hook_slow+0x6b/0x102
 [<c035958e>] br_handle_frame_finish+0x0/0x109
 [<c035986d>] br_handle_frame+0x1d6/0x23d
 [<c035958e>] br_handle_frame_finish+0x0/0x109
 [<c02f2e94>] netif_receive_skb+0xf7/0x22d
 [<c028fdcc>] tg3_rx+0x2f1/0x3d8
 [<c028ff12>] tg3_poll+0x5f/0x13b
 [<c02f3124>] net_rx_action+0x6a/0xe5
 [<c011a8f2>] __do_softirq+0x7e/0x8a
 [<c011a924>] do_softirq+0x26/0x28
 [<c01048b1>] do_IRQ+0x1e/0x24
 [<c0102fb2>] common_interrupt+0x1a/0x20
 [<c010116a>] mwait_idle+0x29/0x2e
 [<c01010d1>] cpu_idle+0x4f/0x58
 [<c045070e>] start_kernel+0x14d/0x166
 [<c04502f7>] unknown_bootoption+0x0/0x1ab
Code: eb e9 80 e2 f8 8b 41 7c 88 51 6d 83 48 10 01 eb 98 55 57 56 53 81 ec c0 00
 00 00 8b 94 24 d4 00 00 00 8b 5a 7c 8b 6a 14 8b 72 20 <8b> 43 10 a8 01 74 14 0f
 b6 42 6d 24 f8 0c 03 88 42 6d 8b 43 10
 <0>Kernel panic - not syncing: Fatal exception in interrupt

I've tested this on a dual Xeon with two Broadcom 1000SX fibre nics
(tg3), kernel 2.6.12.6 and 2.6.15, with and without SMP support. I
also tried flushing nat's PREROUTING for ebtables. However, If I send
the packets "one by one", I do not get the kernel panic.


Kind regards,
Morten K.

