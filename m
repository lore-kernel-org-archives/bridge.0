Date: Wed, 30 Jun 2004 11:15:59 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] MTU Question
Message-Id: <20040630111559.4e2a36b1@dell_ss3.pdx.osdl.net>
In-Reply-To: <C0170D0AF1277849A4B4518034F855DD0CFBFD@aiexchange.ai.aiinet.com>
References: <C0170D0AF1277849A4B4518034F855DD0CFBFD@aiexchange.ai.aiinet.com>
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
To: "Eble, Dan" <DanE@aiinet.com>
Cc: Chris Shaw <chriss@watertech.com>, bridge@osdl.org

On Wed, 30 Jun 2004 14:03:28 -0400
"Eble, Dan" <DanE@aiinet.com> wrote:

> What if someone (or something) attempts to change the MTU on the port after
> it has been added to the bridge?  Perhaps SIOCSIFMTU should do something
> special for bridge ports, such as return -EBUSY, or maybe ask the bridge
> whether or not the new MTU is acceptable?  If a port's MTU changes, the
> bridge may have to adjust its own MTU to maintain consistency.  It could get
> hairy.

That can be handled by a notifier callback.

> I faced this question recently when trying to implement bridging over Cisco
> HDLC.  I finally decided not to try to maintain consistency of MTUs between
> two devices, but rather to drop *all* transmitted packets when the MTU of
> the lower-layer device was insufficient to handle the largest possible
> packets from the upper-layer device.  I decided that would be enough to
> prevent someone from wrongly thinking they had configured it properly, since
> not even a cheap a 64-byte ping would work.

Probably a good idea as well.

Also, we could check when adding interface to a bridge that the MTU is big
enough for the existing ports in the bridge.
