Date: Wed, 31 Aug 2005 21:37:49 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] unregister_netdevice: waiting for br0 to become free.
	Usage count = 1 (2.6.12.3)
Message-ID: <20050831213749.6bc8dd50@localhost.localdomain>
In-Reply-To: <8189B9F5-DF6E-4032-8D2D-D5301A02A081@axentra.net>
References: <8189B9F5-DF6E-4032-8D2D-D5301A02A081@axentra.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Robert Scott <rbscott@axentra.net>
Cc: bridge@lists.osdl.org

On Wed, 31 Aug 2005 19:04:01 -0700
Robert Scott <rbscott@axentra.net> wrote:

> Hello,
> 
> I know that this bug has been discussed before at length on this  
> mailing list, but previous post seemed to indicate that it was fixed  
> before kernel 2.6.12.  I am still seeing this occasionally in kernel  
> 2.6.12.3.  The system is running knoppix, and IPV6 is not compiled  
> into the kernel(other posts mentioned numerous problems with the IPV6  
> code).  But every so often, when bringing down the bridge (it doesn't  
> happen every time), the process hangs, and the following message  
> appears in dmesg repeatedly:
> 
> 'unregister_netdevice: waiting for br0 to become free. Usage count = 1'
> 
> None of the processes involved can be killed, and an attempt to run  
> an ifconfig results in a process that is also waiting forever.  At  
> this point the box must be rebooted forcefully.
> 
> Two questions.
> 1. In a previous post, someone mentioned one solution was to  
> commenting out the check that is hanging in the kernel.   Does this  
> check preventing something terrible from happening(i assumed that it  
> does), or is it safe to remove it

Really bad idea, because if the thing that is holding the reference
like packets stuck in some dead queue, ever get processed the kernel
will die.

> 2. Any ideas of something to try in order to make this repeatable?

Two other recent reports are:
1. Buggy applications that hold packets in their input queue forever,
   and/or netfilters.  The socket buffer's contain a reference for
   packets in flight.

2. The VLAN code had a number of reference bugs, if you look through
   recent netdev mailing list you will see the discussion.
