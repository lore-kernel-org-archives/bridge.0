Return-Path: <davem@davemloft.net>
Date: Mon, 14 Nov 2011 00:39:19 -0500 (EST)
Message-Id: <20111114.003919.1393266325552023244.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1320940083-3719823-1-git-send-email-avagin@openvz.org>
References: <1320940083-3719823-1-git-send-email-avagin@openvz.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: Fix potential deadlock on
	br->multicast_lock
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: avagin@openvz.org
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, shemminger@linux-foundation.org, linux-kernel@vger.kernel.org, devel@openvz.org

From: Andrew Vagin <avagin@openvz.org>
Date: Thu, 10 Nov 2011 18:48:03 +0300

> multicast_lock is taken in softirq context, so we should use
> spin_lock_bh() in userspace.
> 
> call-chain in softirq context:
> run_timer_softirq()
> 	br_multicast_query_expired()
> 
> call-chain in userspace:
> sysfs_write_file()
> 	store_multicast_snooping()
> 		br_multicast_toggle()
> 
> Signed-off-by: Andrew Vagin <avagin@openvz.org>

Applied, thanks.
