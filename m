Date: Mon, 13 Oct 2003 13:16:47 +0200
From: Gergely Madarasz <gorgo@thunderchild.debian.net>
Message-ID: <20031013111647.GK8160@thunderchild.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] hw checksum problems
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello,

I'm trying to make a bridge between a Broadcom BCM5703 gigabit ethernet
and a sun happy meal fastethernet interface. The sunhme card supports hw
checksums (and cannot be turned off in the driver). I applied the patch
(to set CHECKSUM_NONE on forwarded packets), but I still get kernel oopses
(though it seems less often than before). I cannot tell exactly what
triggers it, sometimes it seems a large ping, sometimes a broadcast ping,
sometimes just normal network traffic. Any ideas?

kernel BUG at dev.c:984!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c0201b97>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 0000002a   ebx: f72c4d80   ecx: f24b6700   edx: 0055401e
esi: f72c4d80   edi: f24b66a8   ebp: c02c1b94   esp: c02c1b88
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 0, stackpage=c02c1000)
Stack: f74b080c f72c4d80 f24b66a8 c02c1bac c0201ce1 f72c4d80 f72c4d80 f74b088a
       f24b66a8 c02c1bc8 c0230ef9 f72c4d80 f74b080c f735cd00 0eb4b8c3 f24b66a2
       c02c1c08 c02309c7 00000001 00000806 05b4b8c3 f74b080c 0eb4b8c3 f74b087c
Call Trace:    [<c0201ce1>] [<c0230ef9>] [<c02309c7>] [<c020593d>] [<c0206173>]
  [<c02146b0>] [<c0208c33>] [<c0213225>] [<c02145d4>] [<c02145cf>] [<c0208c33>]
  [<c0213e8d>] [<c02145c0>] [<c023221c>] [<c0232034>] [<c02328f1>] [<c01ff272>]
  [<c0232b9e>] [<c0232c57>] [<c0210921>] [<c0208c33>] [<c021049d>] [<c0210864>]
  [<c0210b31>] [<c0208c33>] [<c021081b>] [<c0210998>] [<c0202463>] [<c0202511>]
  [<c020264b>] [<c011cfad>] [<c010903e>] [<c01052c0>] [<c01052c0>] [<c01052c0>]
  [<c01052c0>] [<c01052ec>] [<c0105362>] [<c0105000>] [<c010504f>]
Code: 0f 0b d8 03 a3 cc 28 c0 6a 00 29 d0 50 52 53 e8 85 d6 ff ff


>>EIP; c0201b97 <skb_checksum_help+1b/84>   <=====

>>ebx; f72c4d80 <END_OF_CODE+36f47570/????>
>>ecx; f24b6700 <END_OF_CODE+32138ef0/????>
>>edx; 0055401e Before first symbol
>>esi; f72c4d80 <END_OF_CODE+36f47570/????>
>>edi; f24b66a8 <END_OF_CODE+32138e98/????>
>>ebp; c02c1b94 <init_task_union+1b94/2000>
>>esp; c02c1b88 <init_task_union+1b88/2000>

Trace; c0201ce1 <dev_queue_xmit+e1/318>
Trace; c0230ef9 <arp_send+1d9/21c>
Trace; c02309c7 <arp_solicit+c7/10c>
Trace; c020593d <__neigh_event_send+c1/280>
Trace; c0206173 <neigh_resolve_output+6f/238>
Trace; c02146b0 <ip_finish_output2+dc/124>
Trace; c0208c33 <nf_hook_slow+103/180>
Trace; c0213225 <ip_output+175/180>
Trace; c02145d4 <ip_finish_output2+0/124>
Trace; c02145cf <output_maybe_reroute+f/14>
Trace; c0208c33 <nf_hook_slow+103/180>
Trace; c0213e8d <ip_build_xmit+2b1/338>
Trace; c02145c0 <output_maybe_reroute+0/14>
Trace; c023221c <icmp_reply+160/180>
Trace; c0232034 <icmp_glue_bits+0/88>
Trace; c02328f1 <icmp_echo+45/4c>
Trace; c01ff272 <skb_checksum+42/2ac>
Trace; c0232b9e <icmp_rcv+6e/16a>
Trace; c0232c57 <icmp_rcv+127/16a>
Trace; c0210921 <ip_local_deliver_finish+bd/134>
Trace; c0208c33 <nf_hook_slow+103/180>
Trace; c021049d <ip_local_deliver+175/180>
Trace; c0210864 <ip_local_deliver_finish+0/134>
Trace; c0210b31 <ip_rcv_finish+199/1d6>
Trace; c0208c33 <nf_hook_slow+103/180>
Trace; c021081b <ip_rcv+373/3bc>
Trace; c0210998 <ip_rcv_finish+0/1d6>
Trace; c0202463 <netif_receive_skb+163/190>
Trace; c0202511 <process_backlog+81/12c>
Trace; c020264b <net_rx_action+8f/148>
Trace; c011cfad <do_softirq+7d/e0>
Trace; c010903e <do_IRQ+da/ec>
Trace; c01052c0 <default_idle+0/38>
Trace; c01052c0 <default_idle+0/38>
Trace; c01052c0 <default_idle+0/38>
Trace; c01052c0 <default_idle+0/38>
Trace; c01052ec <default_idle+2c/38>
Trace; c0105362 <cpu_idle+42/58>
Trace; c0105000 <_stext+0/0>
Trace; c010504f <rest_init+4f/54>

Code;  c0201b97 <skb_checksum_help+1b/84>
00000000 <_EIP>:
Code;  c0201b97 <skb_checksum_help+1b/84>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0201b99 <skb_checksum_help+1d/84>
   2:   d8 03                     fadds  (%ebx)
Code;  c0201b9b <skb_checksum_help+1f/84>
   4:   a3 cc 28 c0 6a            mov    %eax,0x6ac028cc
Code;  c0201ba0 <skb_checksum_help+24/84>
   9:   00 29                     add    %ch,(%ecx)
Code;  c0201ba2 <skb_checksum_help+26/84>
   b:   d0 50 52                  rclb   0x52(%eax)
Code;  c0201ba5 <skb_checksum_help+29/84>
   e:   53                        push   %ebx
Code;  c0201ba6 <skb_checksum_help+2a/84>
   f:   e8 85 d6 ff ff            call   ffffd699 <_EIP+0xffffd699>

Kernel panic: Aiee, killing interrupt handler!


-- 
Madarasz Gergely   gorgo@thunderchild.debian.net   gorgo@linux.rulez.org
    It's practically impossible to look at a penguin and feel angry.
        Egy pingvinre gyakorlatilag lehetetlen haragosan nezni.
