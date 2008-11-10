Date: Mon, 10 Nov 2008 08:35:01 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20081110083501.55aa10fd@extreme>
In-Reply-To: <BLU149-W34C4000F51A9F3DBDA06EC8B1A0@phx.gbl>
References: <BAY119-W404011B5F297F6E9D47DAA8B180@phx.gbl>
	<fed120860811081044k52dbd99fs174d10cd2df33d34@mail.gmail.com>
	<BLU149-W2552C09A3C56CF923B077E8B1A0@phx.gbl>
	<fed120860811100228x3fbff600l4e672635d4c260e3@mail.gmail.com>
	<BLU149-W34C4000F51A9F3DBDA06EC8B1A0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Modifying All Packets passing through the bridge!
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Fahim Akhter <akhter.fahim@hotmail.com>
Cc: bridge@lists.linux-foundation.org

On Mon, 10 Nov 2008 17:02:34 +0500
Fahim Akhter <akhter.fahim@hotmail.com> wrote:

> 
> Thanks a lot for the quick replies. 
>  
> I tried doing it with Bridging Hooks. Rather in the Bridge. I wrote a script with was used to modify the packets if not already modified which was placed in /net/bridge/br_forward.c  br_forward() and the packets were listened and encrypted in /net/bridge/br_forward.c should_deliver(). The enmcryption keys and status were travelling fine. But upon analyzing the packet. On the receiving end using a Windows Based packet Analyzer. I got to know that only ARP broadcast packets were being modified.
>  
> I found an old code which used kernel 2.4 used for encryption. The encryption was done in /net/bridge/br_input.c br_handle_frame().  I did all the usual stuff there but still now effect its still only modifying the ARP packets.
>  
> The ethernets are running in promiscous mode, the settings are default and the bridge works fine. Except for the fact it doesn't encrypt. 
>  
> It's taken me a while to get to this point. This being my first linux project. Hope I get a solution which takes me forward from this instead of starting from the start...> Date: Mon, 10 Nov 2008 15:58:05 +0530> From: srinivas.aji@gmail.com> To: akhter.fahim@hotmail.com> Subject: Re: [Bridge] Modifying All Packets passing through the bridge!> CC: bridge@lists.linux-foundation.org> > On Mon, Nov 10, 2008 at 11:57 AM, Fahim Akhter <akhter.fahim@hotmail.com> wrote:> > The Link> > https://lists.linux-foundation.org/pipermail/bridge/2008-October/006074.html> > , is about capturing packets and sending to user space. Speed is important> > in my current scenario. Is there anyway I can do everything in kernel> > specially by hacking or tweaking the already kernel space. Instead of socket> > programming and capturing packets at ethernet?> > That message also talks about the case where userspace will not give> you enough performance. The thing to do then would be to write a> network d
 river which sits on top of a real network device and> processes the packets before passing it on in either direction. Look> for the vlan and bonding drivers for examples. Or maybe you could use> the netfilter hooks in bridging, if your use of this encrypted link is> restricted to being between bridges.
> _________________________________________________________________
> Explore the seven wonders of the world
> http://search.msn.com/results.aspx?q=7+wonders+world&mkt=en-US&form=QBRE


Use ebtables, and write a netfilter module to do what you want.
There is no reason to mess wit the bridging infrastructure to do this.

Netfilter is the way to do all the kinds of analysis, filtering, and packet
mangling you might want.
