Message-ID: <5f3f2c610409160928252d34b1@mail.gmail.com>
Date: Thu, 16 Sep 2004 12:28:46 -0400
From: Lionel Litty <llitty@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Setting the interfaces in promiscuous mode
Reply-To: Lionel Litty <llitty@gmail.com>
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

I have been using the bridging facilities provided by Linux (vanilla
2.6.7 SMP with UML skas host patch applied) to bridge a regular
physical ethernet network (on interface eth0) with a virtual network
(on interface tap0, cf uml_switch,
http://user-mode-linux.sourceforge.net/networking.html). A couple of
virtual machines (run using user-mode linux, a tool that enables you
to run linux inside linux) are connected to the virtual network.

This is the script I use to set up the bridge:

brctl addbr br0
ifconfig eth0 0.0.0.0 promisc up
ifconfig tap0 0.0.0.0 promisc up
ifconfig br0 abc.def.ghi.jkl netmask 255.255.255.0 up
brctl stp br0 off #This is to ensure the bridge does not send spanning
tree protocol packets.
brctl setfd br0 1
brctl sethello br0 1
brctl addif br0 eth0
brctl addif br0 tap0

This worked fine. I then tried to set the two interfaces (eth0, tap0)
in non-promiscuous mode. My expectation was that the bridge would not
work anymore. Nevertheless, it kept working and my two networks were
still bridged. Virtual machines on the tap0 side of the bridge were
still able to communicate with physical machines on the eth0 side.
Moreover, network benchmarks showed that performance on the machine I
use as a bridge were better, which indicates that setting the
interfaces in non promiscuous mode had an influence on the behavior of
the network stack (which is not surprising).

I am puzzled by the fact that interfaces do not need to be in
promiscuous mode for the bridge to function properly. Anyone has an
idea why?

Thanks, Lionel.
