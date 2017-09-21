Return-Path: <davem@davemloft.net>
Date: Thu, 21 Sep 2017 15:45:32 -0700 (PDT)
Message-Id: <20170921.154532.1965889647748557919.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170921100525.20395-1-vincent@bernat.im>
References: <20170920162140.369bb198@xeon-e3>
	<20170921100525.20395-1-vincent@bernat.im>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [net-next v3] bridge: trigger RTM_NEWLINK when
 interface is modified by bridge ioctl
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: vincent@bernat.im
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, dsahern@gmail.com

From: Vincent Bernat <vincent@bernat.im>
Date: Thu, 21 Sep 2017 12:05:25 +0200

> Currently, there is a difference in netlink events received when an
> interface is modified through bridge ioctl() or through netlink. This
> patch generates additional events when an interface is added to or
> removed from a bridge via ioctl().
...
> Signed-off-by: Vincent Bernat <vincent@bernat.im>

Applied.
