Date: Mon, 13 Oct 2003 17:14:54 +0200
From: Gergely Madarasz <gorgo@thunderchild.debian.net>
Subject: Re: [Bridge] hw checksum problems
Message-ID: <20031013151454.GN8160@thunderchild.debian.net>
References: <20031013111647.GK8160@thunderchild.debian.net>
	<20031013121901.GM8160@thunderchild.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031013121901.GM8160@thunderchild.debian.net>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

On Mon, Oct 13, 2003 at 02:19:01PM +0200, Gergely Madarasz wrote:
> On Mon, Oct 13, 2003 at 01:16:47PM +0200, Gergely Madarasz wrote:
> > Hello,
> > 
> > I'm trying to make a bridge between a Broadcom BCM5703 gigabit ethernet
> > and a sun happy meal fastethernet interface. The sunhme card supports hw
> > checksums (and cannot be turned off in the driver). I applied the patch
> > (to set CHECKSUM_NONE on forwarded packets), but I still get kernel oopses
> > (though it seems less often than before). I cannot tell exactly what
> > triggers it, sometimes it seems a large ping, sometimes a broadcast ping,
> > sometimes just normal network traffic. Any ideas?
> 
> Oh, I forgot :) The kernel is 2.4.22 with the execshield patch. The cards
> work nicely when there is no bridge. One more specific info: when bridged,
> under normal circumstances the hme port is in blocking state (it should
> start forwarding only if the tg3 link is down). 

Further investigation shows that the oopses can happen at different places
for different reasons, with different codepaths. This shows locally
generated skb's which also fail at skb_checksum_help.

kernel BUG at dev.c:991!
...
>>EIP; c0201c80 <skb_checksum_help+104/140>   <=====
...
Trace; c0201da1 <dev_queue_xmit+e5/31c>
Trace; c024ac3c <br_send_bpdu+15c/180>
Trace; c024adc5 <br_send_config_bpdu+165/170>
Trace; c024a4ab <br_transmit_config+d7/f4>
Trace; c024a799 <br_config_bpdu_generation+29/3c>
Trace; c024aa2d <br_received_config_bpdu+bd/f4>
Trace; c024b002 <br_stp_handle_bpdu+1fa/221>
Trace; c0249826 <br_handle_frame+13a/184>
Trace; c02024a9 <netif_receive_skb+e9/190>
Trace; c02025d1 <process_backlog+81/12c>
Trace; c020270b <net_rx_action+8f/148>
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

kernel BUG at dev.c:984
... 
>>EIP; c0201bcd <skb_checksum_help+51/140>   <=====
...
Trace; c0201da1 <dev_queue_xmit+e5/31c>
Trace; c024ac3c <br_send_bpdu+15c/180>
Trace; c024adc5 <br_send_config_bpdu+165/170>
Trace; c024a4ab <br_transmit_config+d7/f4>
Trace; c0248001 <Letext+11/20>
Trace; c024b6fa <br_hold_timer_expired+12/18>
Trace; c024b7b4 <br_check_port_timers+b4/c0>
Trace; c024b8fc <br_tick+0/39>
Trace; c024b8ec <br_check_timers+12c/13c>
Trace; c024b912 <br_tick+16/39>
Trace; c012074b <timer_bh+27f/3b4>
Trace; c011d366 <bh_action+4e/88>
Trace; c011d233 <tasklet_hi_action+63/a0>
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

-- 
Madarasz Gergely   gorgo@thunderchild.debian.net   gorgo@linux.rulez.org
    It's practically impossible to look at a penguin and feel angry.
        Egy pingvinre gyakorlatilag lehetetlen haragosan nezni.
