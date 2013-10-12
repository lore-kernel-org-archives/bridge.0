Return-Path: <josh@joshtriplett.org>
Date: Fri, 11 Oct 2013 23:53:27 -0700
From: Josh Triplett <josh@joshtriplett.org>
Message-ID: <20131012065326.GG15339@leaf>
References: <20131011231659.GA28062@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131011231659.GA28062@linux.vnet.ibm.com>
Subject: Re: [Bridge] [PATCH v3 tip/core/rcu 0/14] Sparse-related updates
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

On Fri, Oct 11, 2013 at 04:16:59PM -0700, Paul E. McKenney wrote:
> Changes from v2:
> 
> o	Switch from rcu_assign_pointer() to ACCESS_ONCE() given that
> 	the pointers are all --rcu and already visible to readers,
> 	as suggested by Eric Dumazet and Josh Triplett.

Hang on a moment.  Do *none* of these cases need write memory barriers?

- Josh Triplet
