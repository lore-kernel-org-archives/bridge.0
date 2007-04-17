Date: Mon, 16 Apr 2007 17:17:09 -0700 (PDT)
From: Ravi Ramamirtham <rrshanks@yahoo.com>
In-Reply-To: <20070416224002.GC5695@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <421393.35482.qm@web50409.mail.re2.yahoo.com>
Subject: Re: [Bridge] Bridging over a bonded interface?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, Ravi Ramamirtham <rrshanks@gmail.com>

Thanks Axel and Stephen. I am planning to use Linux at
both ends. I didn't get a chance to verify the setup
today but will try and get something going tomorrow.


--- Axel Thimm <Axel.Thimm@atrpms.net> wrote:

> On Mon, Apr 16, 2007 at 05:10:37PM -0400, Ravi
> Ramamirtham wrote:
> > Hi,
> >  This may sound crazy but I will go ahead anyway.
> Here's my scenario:
> > 
> > ifconfig bond0 10.10.10.1 netmask 255.0.0.0
> > ifenslave bond0 eth0
> > ifenslave bond0 eth1
> > 
> > brctl addbr stp0
> > brctl addif stp0 bond0
> > brctl stp stp0 on
> > 
> > Is this a valid scenario? I am trying to bond two
> interfaces and run STP
> > over the bonded interface..The problem I am trying
> to solve is to run STP
> > over aggregated links between two nodes. Any
> suggestions/pointers would be
> > much appreciated.
> 
> Just happened that I asked the same 9 days ago:
> 
>
http://lists.linux-foundation.org/pipermail/bridge/2007-April/001764.html
> 
> Depending on the switch on the other side of the
> wire, you will get
> the arp packets you send out on the other link of
> the bond. This will
> make an outgoing arp packet register on the internal
> port of the
> bridge and reregister a couple of ms later on the
> outer port.
> 
> This leads to packets loss of > 99%, e.g. a 2x1GB
> bond degarded to
> 70kB/sec.
> 
> It would be nice if the bridging code could prevent
> this. Either by
> identifying the outgoing arp packet that immediately
> returns and not
> updating the forwarding database, or allowing to
> hardcode some static
> arp entries into the forwarding database.
> -- 
> Axel.Thimm at ATrpms.net
> > _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
>
https://lists.linux-foundation.org/mailman/listinfo/bridge
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
