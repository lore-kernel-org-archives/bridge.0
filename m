Return-Path: <jwboyer@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:date:message-id:subject:from:to:cc:content-type; 
	bh=yEjdc7Z1lmafUk7UDJxgHKyw1WPzidHqUjTP3m2ecHk=;
	b=UQw+OROp15BhQk0tzFIYKjnU699UVN7ScINU/pXzGGzWL/UhrsUtJG76qng4d6Gkd6
	2id+EyG4Ei3owWStRa+T2isIV17v44Y3fIU08fSsb0LTwmV1iaoeNyayBXFDA7DFoV5H
	VC5z7z431jXFNPX7LWRyRpZCwyZf4UA5FdDuH+a5TkYCwKzcysrQH+5S57BIxzVW4rJ/
	Dd1VGe5LmL0RBJ1SAvcxEMT05AtUj2/iZNiP6Mh3OU4BGubZITfEIzirArBS/eN29v0S
	Eu2MXPZkQh7df2O/WJnyBfBn/lepbLhHwadP69tUrnz93N5zVFtEvPfeIUIMTfj7KuGv
	17/g==
MIME-Version: 1.0
Sender: jwboyer@gmail.com
Date: Thu, 23 Apr 2015 13:07:45 -0400
Message-ID: <CA+5PVA5gE_pG5iPKBgugsEjLsOYvq9bWKfB+2OeEujjdOb+URg@mail.gmail.com>
From: Josh Boyer <jwboyer@fedoraproject.org>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bridge] Suspicious RCU usage in bridge with Linux
	v4.0-9362-g1fc149933fd4
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, dac.override@gmail.com, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>

Hi All,

We've had a user report the following backtrace from the bridge module
with a recent Linus' tree.  Has anything like this been reported yet?
If you have any questions on setup, the user is CC'd.

josh

[   29.382235] br0: port 1(tap0) entered forwarding state

[   29.382286] ===============================
[   29.382315] [ INFO: suspicious RCU usage. ]
[   29.382344] 4.1.0-0.rc0.git11.1.fc23.x86_64 #1 Not tainted
[   29.382380] -------------------------------
[   29.382409] net/bridge/br_private.h:626 suspicious
rcu_dereference_check() usage!
[   29.382455]
               other info that might help us debug this:

[   29.382507]
               rcu_scheduler_active = 1, debug_locks = 0
[   29.382549] 2 locks held by swapper/0/0:
[   29.382576]  #0:  (((&p->forward_delay_timer))){+.-...}, at:
[<ffffffff81139f75>] call_timer_fn+0x5/0x4f0
[   29.382660]  #1:  (&(&br->lock)->rlock){+.-...}, at:
[<ffffffffa0450dc1>] br_forward_delay_timer_expired+0x31/0x140
[bridge]
[   29.382754]
               stack backtrace:
[   29.382787] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
4.1.0-0.rc0.git11.1.fc23.x86_64 #1
[   29.382838] Hardware name: LENOVO 422916G/LENOVO, BIOS A1KT53AUS 04/07/2015
[   29.382882]  0000000000000000 3ebfc20364115825 ffff880666603c48
ffffffff81892d4b
[   29.382943]  0000000000000000 ffffffff81e124e0 ffff880666603c78
ffffffff8110bcd7
[   29.383004]  ffff8800785c9d00 ffff88065485ac58 ffff880c62002800
ffff880c5fc88ac0
[   29.383065] Call Trace:
[   29.383084]  <IRQ>  [<ffffffff81892d4b>] dump_stack+0x4c/0x65
[   29.383130]  [<ffffffff8110bcd7>] lockdep_rcu_suspicious+0xe7/0x120
[   29.383178]  [<ffffffffa04520f9>] br_fill_ifinfo+0x4a9/0x6a0 [bridge]
[   29.383225]  [<ffffffffa045266b>] br_ifinfo_notify+0x11b/0x4b0 [bridge]
[   29.383271]  [<ffffffffa0450d90>] ? br_hold_timer_expired+0x70/0x70 [bridge]
[   29.383320]  [<ffffffffa0450de8>]
br_forward_delay_timer_expired+0x58/0x140 [bridge]
[   29.383371]  [<ffffffffa0450d90>] ? br_hold_timer_expired+0x70/0x70 [bridge]
[   29.383416]  [<ffffffff8113a033>] call_timer_fn+0xc3/0x4f0
[   29.383454]  [<ffffffff81139f75>] ? call_timer_fn+0x5/0x4f0
[   29.383493]  [<ffffffff8110a90f>] ? lock_release_holdtime.part.29+0xf/0x200
[   29.383541]  [<ffffffffa0450d90>] ? br_hold_timer_expired+0x70/0x70 [bridge]
[   29.383587]  [<ffffffff8113a6a4>] run_timer_softirq+0x244/0x490
[   29.383629]  [<ffffffff810b68cc>] __do_softirq+0xec/0x670
[   29.383666]  [<ffffffff810b70d5>] irq_exit+0x145/0x150
[   29.383703]  [<ffffffff8189f506>] smp_apic_timer_interrupt+0x46/0x60
[   29.383744]  [<ffffffff8189d523>] apic_timer_interrupt+0x73/0x80
[   29.383782]  <EOI>  [<ffffffff816f131f>] ? cpuidle_enter_state+0x5f/0x2f0
[   29.383832]  [<ffffffff816f131b>] ? cpuidle_enter_state+0x5b/0x2f0
[   29.383873]  [<ffffffff816f15e7>] cpuidle_enter+0x17/0x20
[   29.383908]  [<ffffffff81103c6f>] cpu_startup_entry+0x36f/0x5f0
[   29.383949]  [<ffffffff81887cbd>] rest_init+0x13d/0x150
[   29.383986]  [<ffffffff821c905b>] start_kernel+0x4d2/0x4f3
[   29.384023]  [<ffffffff821c8120>] ? early_idt_handlers+0x120/0x120
[   29.384064]  [<ffffffff821c8339>] x86_64_start_reservations+0x2a/0x2c
[   29.384105]  [<ffffffff821c8485>] x86_64_start_kernel+0x14a/0x16d
[   36.100347] IN=br0 OUT=
MAC=33:33:00:00:00:02:52:54:00:12:01:00:86:dd
SRC=fe80:0000:0000:0000:5054:00ff:fe12:0100
DST=ff02:0000:0000:0000:0000:0000:0000:0002 LEN=56 TC=0 HOPLIMIT=255
FLOWLBL=0 PROTO=ICMPv6 TYPE=133 CODE=0
[   40.113744] IN=br0 OUT=
MAC=33:33:00:00:00:02:52:54:00:12:01:00:86:dd
SRC=fe80:0000:0000:0000:5054:00ff:fe12:0100
DST=ff02:0000:0000:0000:0000:0000:0000:0002 LEN=56 TC=0 HOPLIMIT=255
FLOWLBL=0 PROTO=ICMPv6 TYPE=133 CODE=0
[   44.119727] IN=br0 OUT=
MAC=33:33:00:00:00:02:52:54:00:12:01:00:86:dd
SRC=fe80:0000:0000:0000:5054:00ff:fe12:0100
DST=ff02:0000:0000:0000:0000:0000:0000:0002 LEN=56 TC=0 HOPLIMIT=255
FLOWLBL=0 PROTO=ICMPv6 TYPE=133 CODE=0
