Date: Tue, 11 Jan 2005 10:16:42 +0100
From: Gergely Madarasz <gorgo@broadband.hu>
Message-ID: <20050111091642.GB10074@thunderchild.debian.net>
References: <20050110154506.GJ7529@thunderchild.debian.net>
	<41E2A7A7.3060109@redhat.com>
	<20050110161855.GK7529@thunderchild.debian.net>
	<41E2BE29.8090800@redhat.com>
	<20050110191133.GM7529@thunderchild.debian.net>
	<41E2DA6E.8090703@redhat.com>
	<20050110194914.GN7529@thunderchild.debian.net>
	<41E2DD26.2070301@redhat.com>
	<20050110200922.GO7529@thunderchild.debian.net>
	<41E2E90C.7010307@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E2E90C.7010307@redhat.com>
Subject: [Bridge] Re: tg3 bridge problems
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Neil Horman <nhorman@redhat.com>
Cc: linux-net@vger.kernel.org, bridge@lists.osdl.org

On Mon, Jan 10, 2005 at 03:43:56PM -0500, Neil Horman wrote:
> Gergely Madarasz wrote:
> >On Mon, Jan 10, 2005 at 02:53:10PM -0500, Neil Horman wrote:
> >
> >>Gergely Madarasz wrote:
> >>
> >>>On Mon, Jan 10, 2005 at 02:41:34PM -0500, Neil Horman wrote:
> >>>>Gergely Madarasz wrote:
> >>>>
> >>>>I've got a tg3 card here.  I'll try re-create it as soon as I have 
> >>>>time. 
> >>>
> >>>
> >>>Sounds great, but I expect it will not occur with a random tg3 card,
> >>>explained above... 
> >>>
> >>
> >>Mmmmm....post your lspci -vvv entry for your broken tg3 card?
> >
> >
> >on the ibm x346:
> >
> >0000:05:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5721 
> >Gigabit Ethernet PCI Express (rev 01)
> > ...
> >
> >The other one looks the same, just bus 06 instead of 05 and different
> >Region 0 and Address lines. 
> >
> >Same problem, other machine (ibm x326):
> >
> >0000:02:01.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 
> >Gigabit Ethernet (rev 03)
> > ...
> >
> >Greg
> 
> Crud, you're right, I've got a completely different tg3 card.  I'll 
> still try to get a bridge set up to recreate, but it won't tell us much 
> if the problem doesn't re-create.  Can you put a printk in right before 
> netif_receive_skb in tg3_rx to print out the source mac address of any 
> received frames,  we should be able to search for any MACs == 
> 01-80-C2-00-00-00, and determine for sure if the hardware is eating the 
> frame, or something else is dropping it prematurely.

I went for an easier way (couldn't figure printing macs fast enough :),
I'm just printing out if there is a packet received in tg3_rx, and running
tethereal meanwhile. After checking the output for several minutes I'm
sure that every packet received by tg3_rx is accounted for in tethereal,
which means the incoming bpdu's are eaten by the hardware...

Greg
