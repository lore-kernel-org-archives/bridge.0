Date: Mon, 1 Mar 2004 19:15:46 +0100
From: Software-team <software-team@wp.pl>
Message-Id: <20040301191546.7f0731fa@localhost.localdomain>
In-Reply-To: <200402282000.i1SK06E28411@mail.osdl.org>
References: <200402282000.i1SK06E28411@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] problems with compiling kernel modules
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org


I finally found a solution to compile kernel module "bridge" with the same (!) kernel headers I once compiled my kernel with success. Makefile contains the same version of kernel (2.4.20, event the same extraersion -8). But when I try to insert that module into a kernel with insmod I get a lot of errors.
Could anyone tell me whats wrong? What am I doing wrong? I guess there is some way to compile only a module, not the whole kernel, which is very useful for developers. Does anyone know how to do so?
Thanks, there comes my errors....


[root@localhost linux-2.4.20]# insmod net/bridge/bridge.o
net/bridge/bridge.o: unresolved symbol __dev_get_by_name_Rsmp_dff2466c
net/bridge/bridge.o: unresolved symbol register_netdev_Rsmp_807e44f8
net/bridge/bridge.o: unresolved symbol ether_setup_Rsmp_66797dc6
net/bridge/bridge.o: unresolved symbol eth_type_trans_Rsmp_697fcdb3
net/bridge/bridge.o: unresolved symbol netif_rx_Rsmp_c5346eca
net/bridge/bridge.o: unresolved symbol __write_lock_failed
net/bridge/bridge.o: unresolved symbol add_timer_Rsmp_a19eacf8
net/bridge/bridge.o: unresolved symbol del_timer_Rsmp_fc62f16d
net/bridge/bridge.o: unresolved symbol __out_of_line_bug_Rsmp_8b0fd3c5
net/bridge/bridge.o: unresolved symbol dev_get_by_index_Rsmp_604eff36
net/bridge/bridge.o: unresolved symbol dev_set_promiscuity_Rsmp_c4ed559b
net/bridge/bridge.o: unresolved symbol unregister_netdevice_notifier_Rsmp_fe769456
net/bridge/bridge.o: unresolved symbol __generic_copy_to_user_Rsmp_d523fdd3
net/bridge/bridge.o: unresolved symbol skb_over_panic_Rsmp_8f714d09
net/bridge/bridge.o: unresolved symbol skb_under_panic_Rsmp_26d771ad
net/bridge/bridge.o: unresolved symbol br_ioctl_hook_Rsmp_1fb9705f
net/bridge/bridge.o: unresolved symbol __br_write_unlock_Rsmp_702da97e
net/bridge/bridge.o: unresolved symbol __read_lock_failed
net/bridge/bridge.o: unresolved symbol __kfree_skb_Rsmp_fb8e515b
net/bridge/bridge.o: unresolved symbol printk_Rsmp_1b7d4074
net/bridge/bridge.o: unresolved symbol kfree_Rsmp_037a0cba
net/bridge/bridge.o: unresolved symbol unregister_netdev_Rsmp_091a1ac4
net/bridge/bridge.o: unresolved symbol kmalloc_Rsmp_93d4cfe6
net/bridge/bridge.o: unresolved symbol register_netdevice_notifier_Rsmp_63ecad53
net/bridge/bridge.o: unresolved symbol netdev_finish_unregister_Rsmp_d29730a1
net/bridge/bridge.o: unresolved symbol alloc_skb_Rsmp_6505afe0
net/bridge/bridge.o: unresolved symbol do_softirq_Rsmp_f0a529b7
net/bridge/bridge.o: unresolved symbol br_handle_frame_hook_Rsmp_aed5cfaa
net/bridge/bridge.o: unresolved symbol irq_stat_Rsmp_ed7388c8
net/bridge/bridge.o: unresolved symbol dev_queue_xmit_Rsmp_38e4c261
net/bridge/bridge.o: unresolved symbol __br_write_lock_Rsmp_13836e40
net/bridge/bridge.o: unresolved symbol jiffies_Rsmp_0da02d67
net/bridge/bridge.o: unresolved symbol skb_clone_Rsmp_b0b1927a
