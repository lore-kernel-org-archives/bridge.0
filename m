Return-Path: <davem@davemloft.net>
Date: Wed, 09 May 2012 21:21:10 -0400 (EDT)
Message-Id: <20120509.212110.437114897180819434.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1336538937.git.joe@perches.com>
References: <cover.1336538937.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 00/13] net: Add and use ether_addr_equal
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: joe@perches.com
Cc: coreteam@netfilter.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, netfilter@vger.kernel.org, netfilter-devel@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Tue,  8 May 2012 21:56:44 -0700

> Add a boolean function to test 2 ethernet addresses for equality
> Convert compare_ether_addr uses to ether_addr_equal

This series looks great, I'll apply all of it.

Thanks Joe.

That case you didn't convert in mac80211 is probably the
bug Johannes was talking about which started this whole
discussion.
