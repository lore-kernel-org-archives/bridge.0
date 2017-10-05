Return-Path: <davem@davemloft.net>
Date: Wed, 04 Oct 2017 21:42:17 -0700 (PDT)
Message-Id: <20171004.214217.633098016702209791.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1507164531-17732-1-git-send-email-dsahern@gmail.com>
References: <1507164531-17732-1-git-send-email-dsahern@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 net-next 0/7] net: Plumb extack error
 reporting to enslavements
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: dsahern@gmail.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, vfalico@gmail.com, j.vosburgh@gmail.com

From: David Ahern <dsahern@gmail.com>
Date: Wed,  4 Oct 2017 17:48:44 -0700

> Another round of extending extack error reporting, this time for
> enslavements through ndo_add_slave and notifiers.
> 
> v2
> - changed how the messages are added to bonding driver per Jiri's request
> - fixed spectrum message for LAG overflow per Ido's comment

Series applied, thanks David.
