Message-ID: <43168DC1.6010806@candelatech.com>
Date: Wed, 31 Aug 2005 22:12:33 -0700
From: Ben Greear <greearb@candelatech.com>
MIME-Version: 1.0
Subject: Re: [Bridge] unregister_netdevice: waiting for br0 to become free.
	Usage count = 1 (2.6.12.3)
References: <8189B9F5-DF6E-4032-8D2D-D5301A02A081@axentra.net>
	<20050831213749.6bc8dd50@localhost.localdomain>
In-Reply-To: <20050831213749.6bc8dd50@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Robert Scott <rbscott@axentra.net>, bridge@lists.osdl.org

Stephen Hemminger wrote:

> Two other recent reports are:
> 1. Buggy applications that hold packets in their input queue forever,
>    and/or netfilters.  The socket buffer's contain a reference for
>    packets in flight.

Surely the sockets listen for the net-unregister event and clean
themselves up???  An app shouldn't be able to hang the kernel
like this...

> 2. The VLAN code had a number of reference bugs, if you look through
>    recent netdev mailing list you will see the discussion.

Could be VLAN code, but my debug patch seems to implicate the ref
leaks in neighbor.c....  I also reproduced with another type of VLANs
other than 802.1q...

Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

