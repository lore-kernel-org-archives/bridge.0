Date: Mon, 22 Mar 2010 21:58:22 -0700 (PDT)
Message-Id: <20100322.215822.123414773.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <4BA847EB.9040808@redhat.com>
References: <4BA823D7.4010106@redhat.com>
	<20100322.204939.146100390.davem@davemloft.net>
	<4BA847EB.9040808@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC Patch 1/3] netpoll: add generic support for
 bridge and bonding devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: amwang@redhat.com
Cc: fubar@us.ibm.com, nhorman@tuxdriver.com, netdev@vger.kernel.org, mpm@selenic.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jmoyer@redhat.com, gospo@redhat.com, bonding-devel@lists.sourceforge.net

From: Cong Wang <amwang@redhat.com>
Date: Tue, 23 Mar 2010 12:47:39 +0800

> Yeah, for bonding case, probably. But for bridge case, I think
> we still need to check all, right?

Why?  Who cares?

If it goes out one port and reaches it's destination
the objective has been achieved.

Sending it out N more times achieves nothing.
