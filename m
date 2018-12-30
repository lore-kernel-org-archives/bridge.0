Return-Path: <davem@davemloft.net>
Date: Sun, 30 Dec 2018 11:36:04 -0800 (PST)
Message-Id: <20181230.113604.1094148299347034125.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181230123320.32484-1-nikolay@cumulusnetworks.com>
References: <663bc6d0-f6ec-796d-54bb-b9afa3c0bce1@cumulusnetworks.com>
	<20181230123320.32484-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: rtnetlink: address is mandatory for
 rtnl_fdb_get
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, dsa@cumulusnetworks.com

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Sun, 30 Dec 2018 14:33:20 +0200

> We must have an address to lookup otherwise we'll derefence a null
> pointer in the ndo_fdb_get callbacks.
> 
> CC: Roopa Prabhu <roopa@cumulusnetworks.com>
> CC: David Ahern <dsa@cumulusnetworks.com>
> Reported-by: syzbot+017b1f61c82a1c3e7efd@syzkaller.appspotmail.com
> Fixes: 5b2f94b27622 ("net: rtnetlink: support for fdb get")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied, thanks.
