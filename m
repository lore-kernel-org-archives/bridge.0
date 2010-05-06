From: Matt Mackall <mpm@selenic.com>
In-Reply-To: <20100505081514.5157.83783.sendpatchset@localhost.localdomain>
References: <20100505081514.5157.83783.sendpatchset@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 05 May 2010 21:05:30 -0500
Message-ID: <1273111530.21962.2753.camel@calx>
Mime-Version: 1.0
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
To: Amerigo Wang <amwang@redhat.com>
Cc: Jay Vosburgh <fubar@us.ibm.com>, Neil Horman <nhorman@tuxdriver.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Jeff Moyer <jmoyer@redhat.com>, Andy Gospodarek <gospo@redhat.com>, bonding-devel@lists.sourceforge.net

On Wed, 2010-05-05 at 04:11 -0400, Amerigo Wang wrote:
> V5:
> Fix coding style problems pointed by David.

Aside from my concern about the policy of disabling netpoll on
bridges/bonds with only partial netpoll support, I don't have any
remaining issues with this. But I'll leave it to other folks to ack the
underlying driver bits for this series.

-- 
Mathematics is the supreme nostalgia of our time.


