Return-Path: <paulmck@linux.vnet.ibm.com>
Date: Fri, 6 Jun 2014 10:22:51 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20140606172250.GN4581@linux.vnet.ibm.com>
References: <1402047743-3391-1-git-send-email-kenhelias@firemail.de>
	<063D6719AE5E284EB5DD2968C1650D6D17258AEA@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D17258AEA@AcuExch.aculab.com>
Subject: Re: [Bridge] [PATCH] list: Fix order of arguments for
	hlist_add_after(_rcu)
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Laight <David.Laight@aculab.com>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 'Ken Helias' <kenhelias@firemail.de>, lkml <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>

On Fri, Jun 06, 2014 at 03:56:52PM +0000, David Laight wrote:
> From: Behalf Of Ken Helias
> > All other add functions for lists have the new item as first argument and the
> > position where it is added as second argument. This was changed for no good
> > reason in this function and makes using it unnecessary confusing.
> > 
> > Also the naming of the arguments in hlist_add_after was confusing. It was
> > changed to use the same names as hlist_add_after_rcu.
> ...
> > -static inline void hlist_add_after_rcu(struct hlist_node *prev,
> > -				       struct hlist_node *n)
> > +static inline void hlist_add_after_rcu(struct hlist_node *n,
> > +				       struct hlist_node *prev)
> 
> It is rather a shame that the change doesn't generate a compilation
> error for old source files.

I am also a bit concerned by this.

							Thanx, Paul

