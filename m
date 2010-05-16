Date: Sat, 15 May 2010 23:12:29 -0700 (PDT)
Message-Id: <20100515.231229.186295968.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100510193321.020451781@vyatta.com>
References: <20100510193107.722574297@vyatta.com>
	<20100510193321.020451781@vyatta.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 4/4] bridge: update sysfs link names if port
 device names have changed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@vyatta.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, simon@fire.lp0.eu

From: Stephen Hemminger <shemminger@vyatta.com>
Date: Mon, 10 May 2010 12:31:11 -0700

> From: Simon Arlott <simon@fire.lp0.eu>
> 
> Links for each port are created in sysfs using the device
> name, but this could be changed after being added to the
> bridge.
> 
> As well as being unable to remove interfaces after this
> occurs (because userspace tools don't recognise the new
> name, and the kernel won't recognise the old name), adding
> another interface with the old name to the bridge will
> cause an error trying to create the sysfs link.
> 
> This fixes the problem by listening for NETDEV_CHANGENAME
> notifications and renaming the link.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=12743
> 
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> Acked-by: Stephen Hemminger <shemminger@vyatta.com>

Applied.
