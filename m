Date: Mon, 10 Jan 2005 11:34:54 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Re: tg3 bridge problems
Message-ID: <20050110113454.086ec0e2@dxpl.pdx.osdl.net>
In-Reply-To: <20050110154506.GJ7529@thunderchild.debian.net>
References: <20050110140638.GH7529@thunderchild.debian.net>
	<41E299D4.2010605@redhat.com>
	<20050110154506.GJ7529@thunderchild.debian.net>
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
To: Gergely Madarasz <gorgo@broadband.hu>
Cc: linux-net@vger.kernel.org, Neil Horman <nhorman@redhat.com>, bridge@lists.osdl.org

On Mon, 10 Jan 2005 16:45:06 +0100
Gergely Madarasz <gorgo@broadband.hu> wrote:

> On Mon, Jan 10, 2005 at 10:05:56AM -0500, Neil Horman wrote:
> > Gergely Madarasz wrote:
> > >Hello,
> > >
> > >I've got a very strange problem. Lately I've been setting up my linux
> > >servers for network (layer2) redundancy with a bridge interface containing
> > >two ethernet interfaces connecting to two switches. So far I didn't have
> > >any problems with it, but now a very strange thing happens with a new
> > >server I'm installing. The server is an ibm x346 having two onboard
> > >BCM5721 cards, the switches are cisco 3550, and I've tested with kernel
> > >versions 2.6.10 and 2.4.28.

It could be the switch? Some switches require configuring the port as monitor
mode (othewise they do MAC filtering).

I have a machine with:
03:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5703X Gigabit Ethernet (rev 02)
        Subsystem: IBM: Unknown device 026f
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 28
        Memory at c0200000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable

but haven't tried bridging with it.
