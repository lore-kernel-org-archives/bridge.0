Message-ID: <431682F3.2030103@candelatech.com>
Date: Wed, 31 Aug 2005 21:26:27 -0700
From: Ben Greear <greearb@candelatech.com>
MIME-Version: 1.0
Subject: Re: [Bridge] unregister_netdevice: waiting for br0 to become free.
	Usage count = 1 (2.6.12.3)
References: <8189B9F5-DF6E-4032-8D2D-D5301A02A081@axentra.net>
In-Reply-To: <8189B9F5-DF6E-4032-8D2D-D5301A02A081@axentra.net>
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
To: Robert Scott <rbscott@axentra.net>
Cc: bridge@lists.osdl.org

Robert Scott wrote:
> Hello,
> 
> I know that this bug has been discussed before at length on this  
> mailing list, but previous post seemed to indicate that it was fixed  
> before kernel 2.6.12.  I am still seeing this occasionally in kernel  
> 2.6.12.3.  The system is running knoppix, and IPV6 is not compiled  into 
> the kernel(other posts mentioned numerous problems with the IPV6  
> code).  But every so often, when bringing down the bridge (it doesn't  
> happen every time), the process hangs, and the following message  
> appears in dmesg repeatedly:
> 
> 'unregister_netdevice: waiting for br0 to become free. Usage count = 1'

I have found an appearant leak of a route object, which holds a reference
to a device.  I reproduced in both 2.6.11 and 2.6.13 using 802.1Q VLANs.
I have a patch that will print out the place of the leaked reference
against 2.6.13.

http://www.candelatech.com/oss/rfcnt.patch

Enable the feature in the Networking section of Kconfig.

If you can reproduce with this patch in place, you will get a file and line number
for the leak..please CC me.  I'm going to try to debug the leak, but I
could definately use some help...

> None of the processes involved can be killed, and an attempt to run  an 
> ifconfig results in a process that is also waiting forever.  At  this 
> point the box must be rebooted forcefully.
> 
> Two questions.
> 1. In a previous post, someone mentioned one solution was to  commenting 
> out the check that is hanging in the kernel.   Does this  check 
> preventing something terrible from happening(i assumed that it  does), 
> or is it safe to remove it.

This would be bad...could lead to memory corruption.

> 2. Any ideas of something to try in order to make this repeatable?

I have a complex application with a complex script to drive it that reproduces
the problem within an hour...I haven't found a simpler way....

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

