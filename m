Date: Thu, 27 May 2010 18:25:23 -0300
From: Flavio Leitner <fbl@sysclose.org>
Message-ID: <20100527212523.GB2345@sysclose.org>
References: <20100505081514.5157.83783.sendpatchset@localhost.localdomain>
	<20100527180545.GA2345@sysclose.org>
	<20100527.133559.193700421.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100527.133559.193700421.davem@davemloft.net>
Subject: Re: [Bridge] [v5 Patch 1/3] netpoll: add generic support for bridge
 and bonding devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: fubar@us.ibm.com, amwang@redhat.com, nhorman@tuxdriver.com, netdev@vger.kernel.org, mpm@selenic.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jmoyer@redhat.com, gospo@redhat.com, bonding-devel@lists.sourceforge.net

On Thu, May 27, 2010 at 01:35:59PM -0700, David Miller wrote:
> From: Flavio Leitner <fbl@sysclose.org>
> Date: Thu, 27 May 2010 15:05:45 -0300
> 
> > I did the following patch to discard the packet if it was IN_NETPOLL
> > and the read_lock() fails, so I could go ahead testing it:
> 
> This is disgusting, let's just disallow console output from such
> locations.  Defer them to a workqueue if their output is so critical.

I did that patch just to see the backtrace in the serial console
and to keep testing it. It's not a solution at all.

Just to be clear, the second problem isn't related to that patch
and the console message is already in a workqueue.

-- 
Flavio
