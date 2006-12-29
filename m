Message-ID: <BAY104-F32A17633D3A02378CE13B2FDC60@phx.gbl>
In-Reply-To: <458ACFAC.6070006@schaus.ca>
From: "Jie Chen" <cj70286@hotmail.com>
Date: Fri, 29 Dec 2006 15:59:33 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Subject: Re: [Bridge] Monitor the status of two ethernet interface
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: cam@schaus.ca, bridge@lists.osdl.org

Hi Cam,

Thank you very much. The book is a very good one, it cleared out all 
problems I had in implementation. I also located those source codes, which 
are also very helpful.

For guys who are trying to cross compile v1.2, actually I have the same 
problem, and I just gave up and use v1.1. Anybody can clear it up?

Thanks and have a wonderful long weekend.

Jie


>From: Cameron Schaus <cam@schaus.ca>
>To: Jie Chen <cj70286@hotmail.com>, bridge@lists.osdl.org
>Subject: Re: [Bridge] Monitor the status of two ethernet interface
>Date: Thu, 21 Dec 2006 13:17:16 -0500
>
>Jie Chen wrote:
>>Hi Stephen,
>>
>>I've been reading the source code for a few days. I can locate these two 
>>files:
>>/usr/include/linux/sockios.h
>>/usr/include/sys/ioctl.h
>>and I want to look at the codes for the function ioctl(), since there are 
>>so many files includes ioctl() under /usr/ folder. Do you have any idea 
>>which specific one we are using? For example, does the one in following 
>>file look the correct one?
>>/usr/src/linux-2.6.15_gz/net/socket.c
>The bridge ioctls are in net/bridge/br_ioctl.c, but some of the bridge 
>functionality is done using the sysfs interface, whose code in is 
>br_sys_{br,if}.c.
>
>>Thanks for the nice architecture drawing. What is the relationship between 
>>TCP/IP architecture and the architecture you showed me? The bridge driver 
>>should be considered as physical layer and IP layer is above that?
>You will want to check out the netif_receive_skb function in net/core/dev.c 
>and note the bridge hooks used to pass packets to the bride code.  This is 
>done prior to IP processing.
>
>>For STP, if there's no Daemon running behind, who's maintaining the STP 
>>table and who decide which interface to go with?
>This is done by the kernel bridge code, using timers and incoming packets 
>to trigger STP state changes.  The code of interest is in 
>/usr/src/linux/net/bridge/br_stp.*, with some of the timer creation/init 
>done when bridge entities are created.  Search for br_stp_timer_init and 
>br_stp_port_timer_init.
>
>All of the bridge code is in net/bridge/ and I would recommend the 
>"Understanding Linux Network Internals" book published by O'Reilly 
>publishing.  This book has several chapters that explain in detail the 
>linux bridge and STP implementation, as well as a chapter that explains STP 
>in detail.
>
>Cam
>

_________________________________________________________________
Get FREE Web site and company branded e-mail from Microsoft Office Live 
http://clk.atdmt.com/MRT/go/mcrssaub0050001411mrt/direct/01/

