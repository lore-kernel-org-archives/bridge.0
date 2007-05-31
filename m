Date: Thu, 31 May 2007 01:21:52 -0700 (PDT)
Message-Id: <20070531.012152.11957542.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070530121422.0cdd90eb@freepuppy>
References: <20070519224605.GG14235@galon.ev-en.org>
	<20070530121252.1248f506@freepuppy>
	<20070530121422.0cdd90eb@freepuppy>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH 2/2] bridge: round off STP perodic timers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@linux-foundation.org
Cc: netdev@vger.kernel.org, baruch@ev-en.org, power@bughost.org, bridge@linux-foundation.org

From: Stephen Hemminger <shemminger@linux-foundation.org>
Date: Wed, 30 May 2007 12:14:22 -0700

> Peroidic STP timers don't have to be exact.
> The hold timer runs at 1HZ, and the hello timer normally runs
> at 2HZ; save power by aligning it them to next second.
> 
> Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>

Applied, thanks Stephen.
