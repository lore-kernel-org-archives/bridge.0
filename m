Message-ID: <458ACFAC.6070006@schaus.ca>
Date: Thu, 21 Dec 2006 13:17:16 -0500
From: Cameron Schaus <cam@schaus.ca>
MIME-Version: 1.0
References: <BAY104-F19B0380CB9513341B059CFDCE0@phx.gbl>
In-Reply-To: <BAY104-F19B0380CB9513341B059CFDCE0@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Monitor the status of two ethernet interface
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Jie Chen <cj70286@hotmail.com>, bridge@lists.osdl.org

Jie Chen wrote:
> Hi Stephen,
>
> I've been reading the source code for a few days. I can locate these 
> two files:
> /usr/include/linux/sockios.h
> /usr/include/sys/ioctl.h
> and I want to look at the codes for the function ioctl(), since there 
> are so many files includes ioctl() under /usr/ folder. Do you have any 
> idea which specific one we are using? For example, does the one in 
> following file look the correct one?
> /usr/src/linux-2.6.15_gz/net/socket.c
The bridge ioctls are in net/bridge/br_ioctl.c, but some of the bridge 
functionality is done using the sysfs interface, whose code in is 
br_sys_{br,if}.c.

> Thanks for the nice architecture drawing. What is the relationship 
> between TCP/IP architecture and the architecture you showed me? The 
> bridge driver should be considered as physical layer and IP layer is 
> above that?
You will want to check out the netif_receive_skb function in 
net/core/dev.c and note the bridge hooks used to pass packets to the 
bride code.  This is done prior to IP processing.

> For STP, if there's no Daemon running behind, who's maintaining the 
> STP table and who decide which interface to go with?
This is done by the kernel bridge code, using timers and incoming 
packets to trigger STP state changes.  The code of interest is in 
/usr/src/linux/net/bridge/br_stp.*, with some of the timer creation/init 
done when bridge entities are created.  Search for br_stp_timer_init and 
br_stp_port_timer_init.

All of the bridge code is in net/bridge/ and I would recommend the 
"Understanding Linux Network Internals" book published by O'Reilly 
publishing.  This book has several chapters that explain in detail the 
linux bridge and STP implementation, as well as a chapter that explains 
STP in detail.

Cam

