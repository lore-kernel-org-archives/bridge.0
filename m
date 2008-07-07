Date: Mon, 07 Jul 2008 14:52:59 -0700 (PDT)
Message-Id: <20080707.145259.103902820.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20080707213420.GA20089@nostromo.devel.redhat.com>
References: <20080707205342.GA19710@nostromo.devel.redhat.com>
	<4872838B.1060603@trash.net>
	<20080707213420.GA20089@nostromo.devel.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
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
To: notting@redhat.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

From: Bill Nottingham <notting@redhat.com>
Date: Mon, 7 Jul 2008 17:34:20 -0400

> I could look at wireless network configuration, but I doubt that's going to
> help your argument.

Just like any system with age, we have a lot of legacy to
convert over.  But it will happen.

> That being said, how is moving from adding a bonding slave from:
>   echo "+eth0" >  /sys/class/net/bond0/bonding/slaves to:
> to:
>   http://www.linuxfoundation.org/en/Net:Generic_Netlink_HOWTO
> 
> a worthwhile improvement for the admin? Let's see, a kernel-userspace
> protocol with magic message formats. Hey, we reinvented ioctl!
> 
> Why, if netlink is the standard (and it's been around for a long
> damn time), was sysfs configuration for bonding added in 2005? Why
> was bridge configuration added in 2005, and *extended* in 2006 and
> 2007? Why were the user-space tools such as brctl ported from ioctl
> to sysfs?

Because often a lot of shit slips in when someone who understands
the ramifications is too busy or on vacation.

We do want everything to be netlink based.

Why?

Because it means that you can run one monitoring tool to listen
for netlink events and report them to the user for diagnosis.

It means that network configuration events can be sent over
the wire and used remotely at some point.

The latter can never happen as long as we keep adding ad-hoc
config stuff.

