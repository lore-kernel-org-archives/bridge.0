Message-Id: <s0adece8.043@EMAIL>
Date: Fri, 21 May 2004 11:49:33 +0530
From: "Kishore A K" <kishoreak@myw.ltindia.com>
Subject: Re: [Bluez-devel] Re: [Bridge] bridging bluetooth bnep
	deviceswith kernel 2.6.6-*
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: dwmw2@infradead.org, shemminger@osdl.org
Cc: bluez-devel@lists.sourceforge.net, bridge@lists.osdl.org, liziero.diego@unimore.it

The ifreq structure to br_dev_do_ioctl() gives you the interface index
(rq->ifr_ifindex) which is currently not being used.

May be it can help..

-Kishore

>>> David Woodhouse <dwmw2@infradead.org> 05/19/04 10:30PM >>>

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



