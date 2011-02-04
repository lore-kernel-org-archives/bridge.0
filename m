Date: Fri, 04 Feb 2011 13:02:47 -0800 (PST)
Message-Id: <20110204.130247.71096930.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <4D4C2210.8010705@parallels.com>
References: <4D4C2210.8010705@parallels.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: Don't put partly initialized fdb into
	hash
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: xemul@parallels.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Pavel Emelyanov <xemul@parallels.com>
Date: Fri, 04 Feb 2011 18:58:08 +0300

> The fdb_create() puts a new fdb into hash with only addr set. This is
> not good, since there are callers, that search the hash w/o the lock
> and access all the other its fields.
> 
> Applies to current netdev tree.
> 
> Signed-off-by: Pavel Emelyanov <xemul@openvz.org>

Whoa, good catch.  Applied, thanks!
