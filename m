Message-ID: <a9a0929d0605221737r17af6c16sd32d5f6717d274c0@mail.gmail.com>
Date: Tue, 23 May 2006 10:07:13 +0930
From: "Mark Zipp" <mark.r.zipp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Problem bridging frames with bridge and real interface MTU
	> 1527
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

I'm doing some fault finding where we suspect that the (non-linux)
device with the fault is generating frames with an MTU / maximum size
greater than 1500 / 1518 bytes. This device is performing GRE
tunneling, and it seems that it isn't performing fragmentation or
PMTUD before it attempts to send a normal, 1500 byte IP packet with
the GRE header out a GigE interface with a 1500 byte MTU.

I've been asked by the vendor of this device to perform some packet
captures. As I have a Linux box with a couple of interfaces that
support > 1500 byte MTUs (an Intel GigE, and a Netgear FA311 (that
supports an MTU up to 2024 bytes)), I figured I could bridge this
traffic through this Linux box, and then perform some packet captures
on the bridge virtual interface.

I set that all up, and it seemed to all be ok. I set both the real
interface MTUs to 2024 bytes, and when I added them into a bridge, the
bridge inherited this MTU.

Unfortunately I found that when I attempted to forward frames through
this bridge configuration, certain sized ones were silently dropped.
As the devices attached to the bridge shouldn't be generating frames
with an MTU larger than 1500 (this is our work around solution as a
reference), it seems that with this 2024 bridge MTU, even normal 1500
byte MTU frames are dropped.

Through experimentation, by sending packets  and changing the MTU of
the real and bridge interfaces, it seems that the bridge will only
forward frames up to 1527 bytes MTU. Fortunately I think this will be
enough to diagnose the fault we are having.

Is this expected behaviour ? A maximum of 1527 bytes seems to be an
unsual value for the maxiumum supported bridge MTU.

The kernel in question is the Arch Linux 2.6.16.17 kernel. Having a
brief look at the package details
(http://cvs.archlinux.org/cgi-bin/viewcvs.cgi/kernels/kernel26/PKGBUILD.diff?r1=text&tr1=1.129&r2=text&tr2=1.128&diff_format=h),
 it doesn't seem that there have been any bridge patches, so I'd guess
that the bridge code is vanilla kernel.org.

Thanks,
Mark.

