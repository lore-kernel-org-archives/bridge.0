Message-Id: <200501280417.j0S4HjTV020778@fire-1.osdl.org>
From: <dan-linuxbridge@unpossible.com>
Sender: "Dan Grigsby" <dan@unpossible.com>
Subject: RE: [Bridge] Benchmarking bridging vs. routing on same
	hardware/network
Date: Thu, 27 Jan 2005 22:17:43 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050126130903.02aaea4a@dxpl.pdx.osdl.net>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: 'Stephen Hemminger' <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

>> I can send 459,000pps through this hardware when it is configured as a
>> router.  I only get  252,000pps through the hardware when configured as
>> a bridge.
>>
>> Any ideas why the performance of the bridge is so bad?  

>No, but perhaps oprofile would help.

Ah, good point.  Sorry.  I tried to be a good citizen but forgot the data.
Oprofile is new to me, so be gentle: 

# opreport 

...
    15834 68.2147 bridge
     6537 28.1622 e1000
...

# opreport -p /lib/modules/2.6.9-1.667smp/kernel/  --symbols |grep bridge

2908     12.5285  bridge.ko      bridge             fdb_insert
2731     11.7660  bridge.ko      bridge             __br_fdb_get
2502     10.7794  bridge.ko      bridge             br_nf_pre_routing
1400      6.0316  bridge.ko      bridge             br_nf_post_routing
1113      4.7951  bridge.ko      bridge             br_handle_frame
731       3.1494  bridge.ko      bridge             br_handle_frame_finish
677       2.9167  bridge.ko      bridge             br_nf_forward_ip
651       2.8047  bridge.ko      bridge             ip_sabotage_out
625       2.6927  bridge.ko      bridge             br_nf_forward_finish
597       2.5721  bridge.ko      bridge             br_nf_pre_routing_finish
452       1.9474  bridge.ko      bridge             br_dev_queue_push_xmit
436       1.8784  bridge.ko      bridge             br_fdb_insert
276       1.1891  bridge.ko      bridge             __br_forward
249       1.0728  bridge.ko      bridge             br_forward_finish
234       1.0081  bridge.ko      bridge             ip_sabotage_in
201       0.8660  bridge.ko      bridge             setup_pre_routing
51        0.2197  bridge.ko      bridge             br_forward

# opreport -p /lib/modules/2.6.9-1.667smp/kernel/  --symbols |grep e1000
2797     12.0503  e1000.ko       e1000              e1000_xmit_frame
1317      5.6740  e1000.ko       e1000              e1000_clean_rx_irq
835       3.5974  e1000.ko       e1000              e1000_clean_tx_irq
575       2.4773  e1000.ko       e1000              e1000_alloc_rx_buffers
527       2.2705  e1000.ko       e1000              e1000_intr
397       1.7104  e1000.ko       e1000              e1000_rx_checksum
78        0.3360  e1000.ko       e1000              e1000_clean
7         0.0302  e1000.ko       e1000              e1000_update_stats
4         0.0172  e1000.ko       e1000              e1000_irq_enable

I'll start looking at the bridge code, something I do frequently, but
thought that I would post these results as a starting point.

