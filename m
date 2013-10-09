Return-Path: <josh@joshtriplett.org>
Date: Wed, 9 Oct 2013 15:30:37 -0700
From: Josh Triplett <josh@joshtriplett.org>
Message-ID: <20131009223036.GE11709@jtriplet-mobl1>
References: <20131009212920.GA15413@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131009212920.GA15413@linux.vnet.ibm.com>
Subject: Re: [Bridge] [PATCH v2 tip/core/rcu 0/13] Sparse-related updates
	for 3.13
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: peterz@infradead.org, fweisbec@gmail.com, dhowells@redhat.com, edumazet@google.com, gaofeng@cn.fujitsu.com, mingo@kernel.org, bridge@lists.linux-foundation.org, jmorris@namei.org, dipankar@in.ibm.com, darren@dvhart.com, rostedt@goodmis.org, niv@us.ibm.com, mathieu.desnoyers@efficios.com, kuznet@ms2.inr.ac.ru, tglx@linutronix.de, johannes@sipsolutions.net, laijs@cn.fujitsu.com, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, kaber@trash.net, stephen@networkplumber.org, sbw@mit.edu, tgraf@suug.ch, akpm@linux-foundation.org, fengguang.wu@intel.com, davem@davemloft.net

On Wed, Oct 09, 2013 at 02:29:20PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> This series features updates to allow sparse to do a better job of
> statically analyzing RCU usage:
> 
> 1.	Apply ACCESS_ONCE() to rcu_assign_pointer()'s target to prevent
> 	comiler mischief.  Also require that the source pointer be from
> 	the kernel address space.  Sometimes it can be from the RCU address
> 	space, which necessitates the remaining patches in this series.
> 	Which, it must be admitted, apply to a very small fraction of
> 	the rcu_assign_pointer() invocations in the kernel.  This commit
> 	courtesy of Josh Triplett.
> 
> 2-13.	Apply rcu_access_pointer() to avoid a number of false positives.

I posted one minor nit in response to one of these patches, but in any
case, for 2-13:

Reviewed-by: Josh Triplett <josh@joshtriplett.org>

I'm obviously OK with patch 1 as well, but it should move to the end of
the series, and you need a new patch 1 that adds a comment constraining
rcu_assign_pointer to evaluate its argument exactly once.

- Josh Triplett
