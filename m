Date: Mon, 13 Oct 2008 11:10:16 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20081013111016.7b0b1ab9@extreme>
In-Reply-To: <200810131805.54024.u.luckas@road.de>
References: <200809182133.59751.luckas@musoft.de>
	<200809241357.28552.u.luckas@road.de>
	<200810131805.54024.u.luckas@road.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] delay in bridge learning when forward delay is 0
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Uli Luckas <u.luckas@road.de>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org

On Mon, 13 Oct 2008 18:04:37 +0200
Uli Luckas <u.luckas@road.de> wrote:

> > Is any one willing to look into this problem? Or even aknowledege it's
> > existence?
> > If the description is not clear, please let me know.
> >
> > Any response would be appreciated.
> >
> > regards,
> > Uli
> >
> > > Hi,
> > > In July 2007 Philip Craig reported the following issue with 'forward
> > > delay'=0 in great detail without receiving an answer. Has Philip's
> > > message got lost or was his analysis wrong?
> > > The problem becomes a real problem if you bridge a fast LAN to a slow
> > > port like a bluetooth pan for example.
> > >
> > >
> > > https://lists.linux-foundation.org/pipermail/bridge/2007-July/005476.html
> > > Philip Craig philipc at snapgear.com
> > >
> > > > Hi,
> > > >
> > > > If you set the bridge forward delay to 0 with:
> > > >         brctl setfd br0 0
> > > > then the bridge does not learn addresses for the first 20 seconds,
> > > > and so it floods everything during this time.
> > > >
> > > > The reason for this is that hold_time() returns 0 after a topology
> > > > change, br_fdb_update() is a no-op if hold_time() is 0 (so that
> > > > 'brctl setmaxage br0 0' can be used to disable learning), and the
> > > > topology change flag isn't cleared for max_age seconds, so nothing
> > > > is learnt during that time.
> > > >
> > > > It seems that the intent of hold_time() is to expire entries that are
> > > > older than forward_delay seconds at the time of the topology change,
> > > > which it does, but then it keeps on checking this expiry again for
> > > > max_age seconds, and bases these checks on the current time rather
> > > > than the time of the change.
> > > >
> > > > A quick fix for the forward delay 0 case would be to skip the
> > > > topology change check if stp is disabled, but if I understand things
> > > > correctly then the expiry isn't right for non-zero cases either.
> > >
> > > _______________________________________________
> > > Bridge mailing list
> > > Bridge@lists.linux-foundation.org
> > > https://lists.linux-foundation.org/mailman/listinfo/bridge
> >
> > _______________________________________________
> > Bridge mailing list
> > Bridge@lists.linux-foundation.org
> > https://lists.linux-foundation.org/mailman/listinfo/bridge
> Hello Stephen,
> you are mentioned in the MAINTAINERS file in the linux kernel tree for 
> "ETHERNET BRIDGE". Could you at least, please acknowledge the reception of 
> this mail? And maybe let us know what you think of the bug report?
> 
> regards,
> Uli
> 
> 

Yes, I saw it but the resulting patches were too messy and was
more concerned about breaking other things. It is on my todo list
to go back and fix the hold and forwarding timers in general for
the non STP case. For example, the hold timer keeps running but
is unused when STP is disabled.
