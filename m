Date: Fri, 30 Nov 2007 22:00:58 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20071201060058.GA4734@linux.vnet.ibm.com>
References: <20071201003721.GA22726@linux.vnet.ibm.com>
	<20071201010752.GA26621@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071201010752.GA26621@gondor.apana.org.au>
Subject: [Bridge] Re: [PATCH] Remove rcu_assign_pointer() penalty for NULL
	pointers
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: ego@in.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dipankar@in.ibm.com, akpm@linux-foundation.org, bridge@lists.osdl.org, devel@openvz.org, xemul@openvz.org

On Sat, Dec 01, 2007 at 12:07:52PM +1100, Herbert Xu wrote:
> On Fri, Nov 30, 2007 at 04:37:21PM -0800, Paul E. McKenney wrote:
> > 
> > The rcu_assign_pointer() primitive currently unconditionally executes
> > a memory barrier, even when a NULL pointer is being assigned.  This
> > has lead some to avoid using rcu_assign_pointer() for NULL pointers,
> > which loses the self-documenting advantages of rcu_assign_pointer()
> > This patch uses __builtin_const_p() to omit needless memory barriers
> > for NULL-pointer assignments at compile time with no runtime penalty,
> > as discussed in the following thread:
> > 
> > 	http://www.mail-archive.com/netdev@vger.kernel.org/msg54852.html
> > 
> > Tested on x86_64 and ppc64, also compiled the four cases (NULL/non-NULL
> > and const/non-const) with gcc version 4.1.2, and hand-checked the
> > assembly output.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> Thanks a lot for following through with this Paul!

No problem -- after all, it is not every day that one gets the opportunity
to make a simple change that speeds things up and makes kernel hackers
lives a bit simpler.  ;-)

						Thanx, Paul
