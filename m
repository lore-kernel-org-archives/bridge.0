Date: Mon, 26 Apr 2004 08:59:41 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] br: memory squeeze!
Message-Id: <20040426085941.0cb17f53@dell_ss3.pdx.osdl.net>
In-Reply-To: <4086A897.50305@austin.rr.com>
References: <4086A897.50305@austin.rr.com>
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
To: TC Hough <tchough@austin.rr.com>
Cc: bridge@lists.osdl.org

On Wed, 21 Apr 2004 12:00:07 -0500
TC Hough <tchough@austin.rr.com> wrote:

> I set up a bridge for my network and I'm having some trouble.  At first 
> everything worked great, but after about 3 days of continuous bridging, 
> my bridge machine died.  Approximately once a second, the message: "br: 
> memory squeeze!" would appear on the console.  Keyboard input was mostly 
> frozen, as well.  I could switch virtual consoles, but I couldn't type.  
> No traffic would pass through the bridge.  When I rebooted, everything 
> seemed fine.


You have a memory leak in the kernel. What kernel and distro are you
using.  Also, what kind of NIC's and other interfaces (tun, ppp, etc).

Also, what is the state of the bridge?	br showstp br0
and the forwarding table?	br showmacs br0

> I don't have a whole lot of memory on the bridge machine, but I feel 
> like it should be sufficient, since bridging is all it ever does and I 
> have plenty of swap space.  The system log doesn't should anything I 
> thought to be abnormal.  The memory squeeze messages were not logged.  
> Here's the output of /proc/meminfo:
> 
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  29655040 28917760   737280        0 13750272  6123520
> Swap: 67104768   434176 66670592
> MemTotal:        28960 kB
> MemFree:           720 kB
> MemShared:           0 kB
> Buffers:         13428 kB
> Cached:           5700 kB
> SwapCached:        280 kB
> Active:           4344 kB
> Inactive:        18036 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:        28960 kB
> LowFree:           720 kB
> SwapTotal:       65532 kB
> SwapFree:        65108 kB
> 
> Any suggestions?
> 
> TC
> 
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/bridge
