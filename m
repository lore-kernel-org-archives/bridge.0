Return-Path: <lkml20120218@newton.leun.net>
From: Michael Leun <lkml20120218@newton.leun.net>
Message-ID: <20120723091504.2d035d28@xenia.leun.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [3.5 regression / bridge] constantly toggeling between
 disabled and forwarding
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Mon, 23 Jul 2012 07:42:30 -0000
To: bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: shemminger@vyatta.com, linux-kernel@vger.kernel.org

Hi,

when I use my usb ethernet adapter

# > lsusb
[...]
Bus 002 Device 009: ID 9710:7830 MosChip Semiconductor MCS7830 10/100 Mbps Ethernet adapter
[...]

as port of an bridge

> # brctl addbr br0
> # brctl addif br0 eth0
> # brctl addif br0 ue5
> # ifconfig ue5 up
> # ifconfig br0 up

(Also does happen when eth0 is not part of the bridge, but the logs I
had available were from that situation...)

I constantly get messages showing the interface toggeling between
disabled and forwarding state:

Jul 23 07:40:50 elektra kernel: [ 1539.497337] br0: port 2(ue5) entered disabled state
Jul 23 07:40:50 elektra kernel: [ 1539.554992] br0: port 2(ue5) entered forwarding state
Jul 23 07:40:50 elektra kernel: [ 1539.555005] br0: port 2(ue5) entered forwarding state
Jul 23 07:40:51 elektra kernel: [ 1540.496242] br0: port 2(ue5) entered disabled state
Jul 23 07:40:51 elektra kernel: [ 1540.552534] br0: port 2(ue5) entered forwarding state
Jul 23 07:40:51 elektra kernel: [ 1540.552548] br0: port 2(ue5) entered forwarding state
Jul 23 07:40:52 elektra kernel: [ 1541.550413] br0: port 2(ue5) entered forwarding state
Jul 23 07:40:53 elektra kernel: [ 1542.529672] br0: port 2(ue5) entered disabled state
Jul 23 07:40:53 elektra kernel: [ 1542.587162] br0: port 2(ue5) entered forwarding state
Jul 23 07:40:53 elektra kernel: [ 1542.587175] br0: port 2(ue5) entered forwarding state
Jul 23 07:40:54 elektra kernel: [ 1543.585309] br0: port 2(ue5) entered forwarding state
Jul 23 07:41:00 elektra kernel: [ 1549.360600] br0: port 2(ue5) entered disabled state
Jul 23 07:41:00 elektra kernel: [ 1549.442998] br0: port 2(ue5) entered forwarding state
Jul 23 07:41:00 elektra kernel: [ 1549.443011] br0: port 2(ue5) entered forwarding state
Jul 23 07:41:01 elektra kernel: [ 1550.357686] br0: port 2(ue5) entered disabled state
Jul 23 07:41:01 elektra kernel: [ 1550.408208] br0: port 2(ue5) entered forwarding state
Jul 23 07:41:01 elektra kernel: [ 1550.408222] br0: port 2(ue5) entered forwarding state
Jul 23 07:41:02 elektra kernel: [ 1551.407656] br0: port 2(ue5) entered forwarding state
Jul 23 07:41:03 elektra kernel: [ 1552.401578] br0: port 2(ue5) entered disabled state
Jul 23 07:41:03 elektra kernel: [ 1552.474773] br0: port 2(ue5) entered forwarding state
Jul 23 07:41:03 elektra kernel: [ 1552.474786] br0: port 2(ue5) entered forwarding state
Jul 23 07:41:04 elektra kernel: [ 1553.472487] br0: port 2(ue5) entered forwarding state
Jul 23 07:41:05 elektra kernel: [ 1554.356138] br0: port 2(ue5) entered disabled state
[...]

This does (in the same situation, nothing else than the kernel changed)
not happen with 3.4.5.

Does anybody have an idea what the issue might be or do I need to bisect?

-- 
MfG,

Michael Leun

