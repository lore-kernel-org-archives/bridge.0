Date: Wed, 2 Feb 2005 18:56:52 +0100
Message-ID: <20050202175652.GA1531@stilzchen.informatik.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: Mirko Parthey <mirko.parthey@informatik.tu-chemnitz.de>
Subject: [Bridge] recent 2.6 kernels hang on bridge shutdown
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

With recent 2.6 kernels, the command
  brctl delbr br0
hangs during shutdown, and the kernel prints this message again and again:
  unregister_netdevice: waiting for br0 to become free. Usage count = 1

I was able to reproduce this problem with several kernels between 
(and including) 2.6.9-rc1 and 2.6.11-rc2-bk9.
I haven't tried later versions than 2.6.11-rc2-bk9 yet.
2.6.8.1-bk2 still works fine.

My .config was taken from the Debian kernel-image-2.6.10-1-686 package,
adapted to the kernel.org kernels and the processor type set to Pentium
Classic. I can email it on request.

This script should reproduce the problem reliably:
#!/bin/bash
set -x
mount proc -t proc /proc
ifconfig lo 127.0.0.1
brctl addbr br0
modprobe e100   # also works with 3c5x9
brctl addif br0 eth0
ifconfig br0 192.168.1.1
ifconfig eth0 up
sleep 5
ifconfig lo down
lsmod | grep bridge
brctl delif br0 eth0
ifconfig br0 down
brctl delbr br0

To run it, I booted with init=/bin/bash to make sure the distribution's 
startup scripts don't interfere (although it might work anyway).

I already reported this to the linux-kernel list, since I couldn't tell
whether this is a bug in the bridging code or somewhere else.  On second
reading of REPORTING-BUGS, I probably should have sent it here first.

For reference, these are my postings to linux-kernel:
http://www.ussg.iu.edu/hypermail/linux/kernel/0501.3/2222.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0502.0/0139.html

Please let me know if you need any further information,
and please Cc me on replies, since I am not subscribed to the bridge list.

Mirko
