Mime-Version: 1.0 (Apple Message framework v734)
Content-Transfer-Encoding: 7bit
Message-Id: <8189B9F5-DF6E-4032-8D2D-D5301A02A081@axentra.net>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
From: Robert Scott <rbscott@axentra.net>
Date: Wed, 31 Aug 2005 19:04:01 -0700
Subject: [Bridge] unregister_netdevice: waiting for br0 to become free.
	Usage count = 1 (2.6.12.3)
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello,

I know that this bug has been discussed before at length on this  
mailing list, but previous post seemed to indicate that it was fixed  
before kernel 2.6.12.  I am still seeing this occasionally in kernel  
2.6.12.3.  The system is running knoppix, and IPV6 is not compiled  
into the kernel(other posts mentioned numerous problems with the IPV6  
code).  But every so often, when bringing down the bridge (it doesn't  
happen every time), the process hangs, and the following message  
appears in dmesg repeatedly:

'unregister_netdevice: waiting for br0 to become free. Usage count = 1'

None of the processes involved can be killed, and an attempt to run  
an ifconfig results in a process that is also waiting forever.  At  
this point the box must be rebooted forcefully.

Two questions.
1. In a previous post, someone mentioned one solution was to  
commenting out the check that is hanging in the kernel.   Does this  
check preventing something terrible from happening(i assumed that it  
does), or is it safe to remove it.
2. Any ideas of something to try in order to make this repeatable?

thanks,
--robert scott


