Date: Fri, 30 May 2008 08:14:21 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20080530081421.49fd010d@extreme>
In-Reply-To: <312380.52171.qm@web35603.mail.mud.yahoo.com>
References: <alpine.DEB.1.00.0805200009020.6633@pandora.retrosnub.co.uk>
	<312380.52171.qm@web35603.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] New Custom Protocol on Ethernet Layer
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Zoran s <s_zoran@yahoo.com>
Cc: bridge@lists.linux-foundation.org

On Fri, 30 May 2008 06:32:41 -0700 (PDT)
Zoran s <s_zoran@yahoo.com> wrote:

> Hi everyone,
> 
> I need a help. I started recently investigating
> ethernet layer. I have specific problem to solve. I'll
> try to describe this problem, so you can see what is
> all about. I do not know if this problem belongs to
> bridging, certainly by its definition it is close to
> it.
> 
> I have some ideas how to do this. But I would
> appreciate any thought you might have, any direction.
> 
> The problem: there are number of workstations (up to
> 200) connected by LAN - ethernet, and they all are
> running an application which is in need of real-time
> updates. Within every timer tick defined (2
> miliseconds) every workstation needs to communicate
> certain data (broadcast) so all others can take these
> data, compute data via algorithm and store such data
> in their own proprietary database. The round time is
> the same time (all 200 stations need to communicate
> their data in this time frame).
> 
> One of the solutions to the problem will be to write
> specific application in user space (choose some spare
> ports, make UDP datagram and send it over as IP
> broadcast). But I am affraid the turnaround time might
> change from 2 miliseconds to 0.5 miliseconds, even
> less. Then the Real Time processing could become an
> issue.
> 
> Instead using user space, I think the better way to
> handle this problem is to keep data inside the
> ethernet layer itself. Saying this, the solution to
> this problem will be to create specific customised
> vendor destination address which will act similar to
> broadcast (well known all ones) mechanismus, so each
> workstation receiving this packet will be delivering
> data to the specific for this case database cash,
> embedded in ethernet layer, same way ARP works. The
> application can access the data through driver
> mechanismus (bypassing higher layers of IP protocol
> stack), specificaly written for this case.

You don't need to do it in kernel to get real time performance.
You do need to have all nodes using something like the Linux-rt
kernel (http://rt.wiki.kernel.org/index.php/Main_Page) and use
appropriate QoS (see IP_TOS), and make sure all your infrastructure
is capable.

> I start looking and exploring /net/core/dev.c, but I
> don't see ARP entry code in there. Could anybody,
> please, give me an advice where to look for ARP
> resolution so I can explore further implementation
> changes inside the kernel protocol stack (I need to
> add entry which will do similar things).

ARP is handled by the dst (route cache), not a recommended
place.

> The reason I sent this @ is that I think the bridging
> implementation is in the same set of files (very close
> to ARP), as a different option, so somebody might know
> where to fit the entry for the idea I just described.

No bridging is handled by br_hook.

> If there are misconceptions in my @ I appologise for
> my ignorance related to this matter.
> 
> Best Regards,
> Zoran
> 
> 
> 
>       
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
