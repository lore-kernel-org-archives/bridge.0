Message-ID: <408D36CC.10903@candelatech.com>
Date: Mon, 26 Apr 2004 09:20:28 -0700
From: Ben Greear <greearb@candelatech.com>
MIME-Version: 1.0
Subject: Re: [Bridge] br: memory squeeze!
References: <4086A897.50305@austin.rr.com>
	<20040426085941.0cb17f53@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040426085941.0cb17f53@dell_ss3.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Cc: bridge@lists.osdl.org

Stephen Hemminger wrote:
> On Wed, 21 Apr 2004 12:00:07 -0500
> TC Hough <tchough@austin.rr.com> wrote:
> 
> 
>>I set up a bridge for my network and I'm having some trouble.  At first 
>>everything worked great, but after about 3 days of continuous bridging, 
>>my bridge machine died.  Approximately once a second, the message: "br: 
>>memory squeeze!" would appear on the console.  Keyboard input was mostly 
>>frozen, as well.  I could switch virtual consoles, but I couldn't type.  
>>No traffic would pass through the bridge.  When I rebooted, everything 
>>seemed fine.
> 
> 
> 
> You have a memory leak in the kernel. What kernel and distro are you
> using.  Also, what kind of NIC's and other interfaces (tun, ppp, etc).
> 
> Also, what is the state of the bridge?	br showstp br0
> and the forwarding table?	br showmacs br0

I agree it is probably a memory leak, but it is *possible* to get this
error if you just run out of available memory.  I have been able to
reproduce this type of error by setting my send/receive packet socket
buffers very high and then flooding 200 connections with traffic, for example.
(I had a 256MB RAM machine)

You might want to make sure that your netdev-backlog settings are not too
big, for example.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

