Return-Path: <davem@davemloft.net>
Date: Tue, 06 Jun 2017 16:06:01 -0400 (EDT)
Message-Id: <20170606.160601.292169589611249662.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1496701584-26855-1-git-send-email-nikolay@cumulusnetworks.com>
References: <840022de-3d31-4f62-aaaf-ba83d5c78ad7@cumulusnetworks.com>
	<1496701584-26855-1-git-send-email-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: fix a null pointer
 dereference in br_afspec
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, garsilva@embeddedor.com

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue,  6 Jun 2017 01:26:24 +0300

> We might call br_afspec() with p == NULL which is a valid use case if
> the action is on the bridge device itself, but the bridge tunnel code
> dereferences the p pointer without checking, so check if p is null
> first.
> 
> Reported-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> Fixes: efa5356b0d97 ("bridge: per vlan dst_metadata netlink support")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied and queued up for -stable, thanks Nikolay.
