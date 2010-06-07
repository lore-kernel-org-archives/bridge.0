Date: Mon, 07 Jun 2010 03:01:08 -0700 (PDT)
Message-Id: <20100607.030108.235696592.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <4C0CC29D.9070507@redhat.com>
References: <4C062CBD.7090906@redhat.com>
	<20100604191841.GM7497@gospo.rdu.redhat.com>
	<4C0CC29D.9070507@redhat.com>
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
To: amwang@redhat.com
Cc: bridge@lists.linux-foundation.org, nhorman@tuxdriver.com, netdev@vger.kernel.org, gospo@redhat.com, fubar@us.ibm.com, linux-kernel@vger.kernel.org, fbl@sysclose.org, jmoyer@redhat.com, mpm@selenic.com, bonding-devel@lists.sourceforge.net

From: Cong Wang <amwang@redhat.com>
Date: Mon, 07 Jun 2010 17:57:49 +0800

> Hmm, I still feel like this way is ugly, although it may work.
> I guess David doesn't like it either.

Of course I don't like it. :-)

I suspect the locking scheme will need to be changed.

Besides, if we're going to hack this up and do write lock attempts in
the read locking paths, there is no point in using a rwlock any more.
And I'm personally in disfavor of all rwlock usage anyways (it dirties
the cacheline for readers just as equally for writers, and if the
critically protected code path is short enough, that shared cache
line atomic operation will be the predominant cost).

So I'd say, 1) make this a spinlock and 2) try to use RCU for the
read path.

That would fix everything.
