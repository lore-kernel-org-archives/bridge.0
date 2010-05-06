Date: Thu, 06 May 2010 00:44:57 -0700 (PDT)
Message-Id: <20100506.004457.71584133.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1273111530.21962.2753.camel@calx>
References: <20100505081514.5157.83783.sendpatchset@localhost.localdomain>
	<1273111530.21962.2753.camel@calx>
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
To: mpm@selenic.com
Cc: fubar@us.ibm.com, amwang@redhat.com, nhorman@tuxdriver.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jmoyer@redhat.com, gospo@redhat.com, bonding-devel@lists.sourceforge.net

From: Matt Mackall <mpm@selenic.com>
Date: Wed, 05 May 2010 21:05:30 -0500

> On Wed, 2010-05-05 at 04:11 -0400, Amerigo Wang wrote:
>> V5:
>> Fix coding style problems pointed by David.
> 
> Aside from my concern about the policy of disabling netpoll on
> bridges/bonds with only partial netpoll support, I don't have any
> remaining issues with this. But I'll leave it to other folks to ack the
> underlying driver bits for this series.

Yes the partial support handling is a thorny issue.

But this patch set makes things better than they were before, because
support over such devices didn't work at all previously.

So I'll toss these patches into net-next-2.6, thanks everyone!
