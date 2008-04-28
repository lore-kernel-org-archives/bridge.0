Date: Mon, 28 Apr 2008 11:10:24 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20080428111024.2ff2fd78@extreme>
In-Reply-To: <20080424134129.GA27496@localhost>
References: <96CF49BD8B56384395D698BA99007FA32FA1E1@exchange.pacwire.local>
	<20080423104340.2416280e@extreme>
	<20080424134129.GA27496@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Getting statistics from a bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jaime Medrano <jaime.medrano@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Thu, 24 Apr 2008 15:41:29 +0200
Jaime Medrano <jaime.medrano@gmail.com> wrote:

> On Wed, Apr 23, 2008 at 10:43:40AM -0700, Stephen Hemminger wrote:
> > On Wed, 23 Apr 2008 10:53:12 +1000
> > "Leigh Sharpe" <lsharpe@pacificwireless.com.au> wrote:
> > 
> > >  Is there any way of getting detailed statistics from a bridge?
> > > Specifically, I need to know how many frames may have been dropped
> > > because they exceed the MTU of the underlying port. I'm having a few
> > > issues with MTUs not agreeing.
> > 
> > It would not be hard to modify kernel to use one of the existing statistics on
> > the bridge interface to keep track of the dropped packets. I'll look into it
> > if no one else gets to it first (hint, hint)
> > 
> 
> I think this change will do it.
> 
> Regards,
> Jaime Medrano.

There is still the possiblity of RCU race during removal. I'll fix it up.
I am adding better statistics as part of other patch.
