Subject: Re: [Bluez-devel] Re: [Bridge] bridging bluetooth bnep devices
	with kernel 2.6.6-*
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20040518153608.707e1f81@dell_ss3.pdx.osdl.net>
References: <1084467136.3083.27.camel@igno>
	<20040513102829.5d5e1484@dell_ss3.pdx.osdl.net>
	<1084472140.3354.9.camel@igno> <1084788177.21864.54.camel@igno>
	<20040518153608.707e1f81@dell_ss3.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1084986055.28151.263.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Wed, 19 May 2004 18:00:56 +0100
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bluez-devel@lists.sourceforge.net, bridge@lists.osdl.org, Diego Liziero <liziero.diego@unimore.it>

On Tue, 2004-05-18 at 15:36 -0700, Stephen Hemminger wrote:
> Hmm, since all the blue tooth devices have the same address.
> Deleting the first one will cause the entry in the forwarding table
> to be deleted, that might cause your problem.  Perhaps we need a
> reference count on the number of interfaces with the same address (yuck).

That seems like a reasonable answer. I believe there's also some
workstation hardware with multiple Ethernet devices, all sharing the
same MAC address (== hostid). It's not just Bluetooth. How does this
work with VLAN bridging?

Precisely what is it that's indexed on the interface's MAC address,
rather than the (index of the) physical interface itself?

-- 
dwmw2

