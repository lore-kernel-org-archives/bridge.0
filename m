Date: Tue, 2 Sep 2003 10:45:45 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20030902104545.3c321c24.shemminger@osdl.org>
In-Reply-To: <20030830190100.4eac4504.davem@redhat.com>
References: <p05111b01bb728bc8972e@[10.96.96.13]>
	<20030827132810.65010eac.shemminger@osdl.org>
	<p05111b00bb740b63506b@[10.96.96.13]>
	<20030830190100.4eac4504.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [more info] Re: [2.4.22] bad interaction between e100 and
 bridge: BUG at dev.c:991!
Sender: bridge-admin@lists.osdl.org
Errors-To: bridge-admin@lists.osdl.org
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge/>
To: "David S. Miller" <davem@redhat.com>
Cc: Hannes Schulz <schulz@schwaar.com>, scott.feldman@intel.com, jgarzik@pobox.com, bridge@osdl.org

On Sat, 30 Aug 2003 19:01:00 -0700
"David S. Miller" <davem@redhat.com> wrote:

> On Thu, 28 Aug 2003 22:24:52 +0200
> Hannes Schulz <schulz@schwaar.com> wrote:
> 
> > >Could the problem be that the e100 can do IP receive checksumming on 
> > >the board,
> > >but the eepro driver doesn't enable it.  When the board is doing checksum
> > >offload, then the csum field isn't set.
> > >
> > >Please try disabling receive checksumming on the e100 driver
> > >
> > >	modprobe e100 XsumRX=0
> > >
> > >If this is the problem, it exists both 2.4 and 2.6.
> > 
> > Indeed: with  XsumRX=0,0 the BUG doesn't happen. I put some debugging 
> > code in dev.c:
> 
> Looks like bridging is taking an input packet, transmitting it but not
> initializing skb->csum, skb->ip_summed, and other fields before doing
> so.
> 
> Definitely a bridging bug.

It is actually a bridging-filter bug, since the bridge layer is at level 2 it
doesn't know anything about IP.
