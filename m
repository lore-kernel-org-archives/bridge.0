Date: Mon, 7 Jul 2008 15:04:54 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20080707150454.2a02a217@extreme>
In-Reply-To: <20080707.145259.103902820.davem@davemloft.net>
References: <20080707205342.GA19710@nostromo.devel.redhat.com>
	<4872838B.1060603@trash.net>
	<20080707213420.GA20089@nostromo.devel.redhat.com>
	<20080707.145259.103902820.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH 0/2] Allow full bridge configuration via
 sysfs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, notting@redhat.com

On Mon, 07 Jul 2008 14:52:59 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Bill Nottingham <notting@redhat.com>
> Date: Mon, 7 Jul 2008 17:34:20 -0400
> 
> > I could look at wireless network configuration, but I doubt that's going to
> > help your argument.
> 
> Just like any system with age, we have a lot of legacy to
> convert over.  But it will happen.
> 
> > That being said, how is moving from adding a bonding slave from:
> >   echo "+eth0" >  /sys/class/net/bond0/bonding/slaves to:
> > to:
> >   http://www.linuxfoundation.org/en/Net:Generic_Netlink_HOWTO
> > 
> > a worthwhile improvement for the admin? Let's see, a kernel-userspace
> > protocol with magic message formats. Hey, we reinvented ioctl!
> > 
> > Why, if netlink is the standard (and it's been around for a long
> > damn time), was sysfs configuration for bonding added in 2005? Why
> > was bridge configuration added in 2005, and *extended* in 2006 and
> > 2007? Why were the user-space tools such as brctl ported from ioctl
> > to sysfs?
> 
> Because often a lot of shit slips in when someone who understands
> the ramifications is too busy or on vacation.
> 
> We do want everything to be netlink based.
> 
> Why?
> 
> Because it means that you can run one monitoring tool to listen
> for netlink events and report them to the user for diagnosis.
> 
> It means that network configuration events can be sent over
> the wire and used remotely at some point.
> 
> The latter can never happen as long as we keep adding ad-hoc
> config stuff.

There are always historical reasons. In this case it was because I knew
more about sysfs than netlink, and there was no netlink interface for managing
interfaces back in 2005.  Sysfs is okay for simple stuff (set forward-delay to 10seconds),
but it falls down when anything interesting and transactional happens. Think of
sysfs as more an extension of per-device sysctl's or module parameters, rather
than a good configuration interface.
