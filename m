Message-ID: <BAY104-F10CB67A9A63873CE6CE36DFDB80@phx.gbl>
In-Reply-To: <458ACFAC.6070006@schaus.ca>
From: "Jie Chen" <cj70286@hotmail.com>
Date: Thu, 04 Jan 2007 20:39:12 +0000
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

Hi all,

I hope everybody had a great holiday.

I got a question in applying ethernet bridge in Linux boxes. The scenario 
I'm trying to simulate is like this:  I have 3 linux boxes in total, 
everyone has 2 ethernet ports, one port is connected to Power line modem, 
and the other to wifi modem. The power line modem failed, so it's the same 
as I have just one port for each. I put them apart, Box A is in one end, and 
Box C is in another end, and Box B in the middle, so that Box A can talk to 
B but not C. Box B can talk to A and C. Box C and talk to B but not A. Now I 
set bridge on, the question is am I able to let A and C talk?

The reason I have this question is according to bridge, B get packets from A 
on one port, and suppose to deliver to C from the other port, but the other 
port didn't work. So I would think the packets can't be delivered from A to 
C, is that the case?

Thanks a lot,
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
Fixing up the home? Live Search can help 
http://imagine-windowslive.com/search/kits/default.aspx?kit=improve&locale=en-US&source=hmemailtaglinenov06&FORM=WLMTAG

