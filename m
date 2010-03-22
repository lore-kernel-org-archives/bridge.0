From: Matt Mackall <mpm@selenic.com>
In-Reply-To: <20100322082112.4967.5504.sendpatchset@localhost.localdomain>
References: <20100322082059.4967.63492.sendpatchset@localhost.localdomain>
	<20100322082112.4967.5504.sendpatchset@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 22 Mar 2010 17:35:07 -0500
Message-ID: <1269297307.3552.23.camel@calx>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC Patch 2/3] bridge: make bridge support netpoll
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Amerigo Wang <amwang@redhat.com>
Cc: Jay Vosburgh <fubar@us.ibm.com>, Neil Horman <nhorman@tuxdriver.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Andy Gospodarek <gospo@redhat.com>, bonding-devel@lists.sourceforge.net

On Mon, 2010-03-22 at 04:17 -0400, Amerigo Wang wrote:
> Based on the previous patch, make bridge support netpoll by:
> 
> 1) implement the 4 methods to support netpoll for bridge;
> 
> 2) modify netpoll during forwarding packets in bridge;
> 
> 3) disable netpoll support of bridge when a netpoll-unabled device
>    is added to bridge;

Not sure if this is the right thing to do. Shouldn't we simply enable
polling on all devices that support it and warn about the others (aka
best effort)?

-- 
http://selenic.com : development and support for Mercurial and Linux


