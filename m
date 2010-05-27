Date: Thu, 27 May 2010 13:35:59 -0700 (PDT)
Message-Id: <20100527.133559.193700421.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100527180545.GA2345@sysclose.org>
References: <20100505081514.5157.83783.sendpatchset@localhost.localdomain>
	<20100527180545.GA2345@sysclose.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
To: fbl@sysclose.org
Cc: fubar@us.ibm.com, amwang@redhat.com, nhorman@tuxdriver.com, netdev@vger.kernel.org, mpm@selenic.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jmoyer@redhat.com, gospo@redhat.com, bonding-devel@lists.sourceforge.net

From: Flavio Leitner <fbl@sysclose.org>
Date: Thu, 27 May 2010 15:05:45 -0300

> I did the following patch to discard the packet if it was IN_NETPOLL
> and the read_lock() fails, so I could go ahead testing it:

This is disgusting, let's just disallow console output from such
locations.  Defer them to a workqueue if their output is so critical.
