Date: Fri, 14 Jan 2005 10:19:57 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Packet loss / performance
Message-ID: <20050114101957.2404d01c@dxpl.pdx.osdl.net>
In-Reply-To: <200501132155.j0DLtk7r012114@fire-1.osdl.org>
References: <200501132155.j0DLtk7r012114@fire-1.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: dan-linuxbridge@unpossible.com
Cc: bridge@lists.osdl.org

On Thu, 13 Jan 2005 15:55:37 -0600
<dan-linuxbridge@unpossible.com> wrote:

> Hello,
> 
> I am attempting to build a bridge capable of functioning as near to gigabit
> speeds as possible, with as many hundreds of thousands of packets per second
> capabilities as possible.
> 
> My bridge system is a dual Opteron 246 (2.0Ghz); Tyan 2882 motherboard; 2 GB
> PC3200 memory (1 GB in each CPU's bank; 128bit configuration); dual e1000
> based NIC; 2.6.9 Kernel; NAPI enabled in the kernel and the NIC drivers; CPU
> affinity ties each eth to a specific CPU; system otherwise idle.

I assume this is 64-bit/66Mhz PCI.
Did you try affiniting both eth's to same CPU. If you are bridging, it 
could be a win otherwise memory ends up bouncing between CPU's which
can be a bandwidth hog.

> Two test systems are connected, one to each interface in the Opteron.  Each
> has a custom kernel with the Linux packet generator pktgen compiled as a
> module.  Each test system can generate approximately 300,000 packets per
> second.
> 
> Before testing the bridge, I tested each eth interface separately.  I
> brought up one interface on the Opteron, configured pktgen on the test
> machine attached to that interface (set the IP address and destination mac
> address) and sent the packets.  Using /proc/net/dev I could see the packets
> being received at the Opteron and zero errors.  I repeated this test on the
> other interface with the same results.  Results the same regardless of
> number of packets sent.  It was able to handle the 300,000pps without issue.
> 
> Next I brought up the bridge.  I reconfigured pktgen on one test machine to
> send packets to the IP and MAC address on the other test machine (across the
> bridge).  When I run pktgen I have about 20% packet loss.
> 
> I sent 100,000 packets;
> eth4 received ~80,000 packets; dropper/errs of ~70,000; ~20,000 fifo
> eth3 sent ~77,000 packets
> 
> Somewhere I lost 20,000 packets at the receiving interface and another three
> thousand before transmitting to the other side of the bridge.

Are you always forwarding from/to same MAC address.
Then figure out where they are being dropped (in board, e1000 driver ring, 
or bridge).


> I built this system based on specs that should do better.  If this were
> running netfilter then I'd expect a capacity of around 700Kpps.  What's
> happening is fairly opaque to me, so I'm not sure what to tune or where to
> look.  Any assistance will be greatly appreciated.

oprofile output might help to identify CPU hot spots.


-- 
Stephen Hemminger	<shemminger@osdl.org>
