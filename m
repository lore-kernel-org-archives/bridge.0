Date: Tue, 12 Oct 2010 09:37:47 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20101012093747.30a82cb2@nehalam>
In-Reply-To: <loom.20101012T145743-585@post.gmane.org>
References: <loom.20101011T131053-288@post.gmane.org>
	<loom.20101012T145743-585@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] About local delivery of bridged packets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Aijaz Baig <aijazbaig1@gmail.com>
Cc: bridge@linux-foundation.org

On Tue, 12 Oct 2010 13:01:08 +0000 (UTC)
Aijaz Baig <aijazbaig1@gmail.com> wrote:

> Aijaz Baig <aijazbaig1 <at> gmail.com> writes:
> 
> > 
> > Hello,
> > 
> > I am trying to understand how does the bridging code determine if the packet 
> is 
> > to be delivered locally or is it to be forwarded. Before being delivered 
> > locally, I mean the packet is to be delivered either to br0 or to a non 
> enslaved 
> > interface. If I am wrong here, please do correct me..................
> 
> Hello,
> 
> Heres answering my own question partially. Since the bridge which is after all a 
> virtual interface takes one of the L2 addresses of its interfaces (is it the 
> first real interface which is enslaved?), any packet which is destined with this 
> L2 dest address in its eth header, will be considered locally destined.
> 
> This simple fact solves my issue.
> 
> Regards,
> Aijaz

You have it almost right!
The bridge keeps a forwarding database that contains:

      Ethernet-address   Port-device  flags
    11:22:33:44:55        eth0          local
    01:20:30:40:50        eth0

When eth0 is added to bridge, the address for eth0 is added
to forwarding table with local flag set.  The local flag indicates
during receive that the packet should be received locally.

If multiple devices are in bridge, then the bridge will locally
receive all those addresses.

The logic for this is in br_input.c:br_handle_frame_finish function.
