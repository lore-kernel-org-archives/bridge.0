Return-Path: <davem@davemloft.net>
Date: Sun, 25 Jan 2015 23:33:16 -0800 (PST)
Message-Id: <20150125.233316.1272794874104313977.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20150121092235.GA19206@mwanda>
References: <20150121092235.GA19206@mwanda>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [patch] bridge: simplify br_getlink() a bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: dan.carpenter@oracle.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 21 Jan 2015 12:22:35 +0300

> Static checkers complain that we should maybe set "ret" before we do the
> "goto out;".  They interpret the NULL return from br_port_get_rtnl() as
> a failure and forgetting to set the error code is a common bug in this
> situation.
> 
> The code is confusing but it's actually correct.  We are returning zero
> deliberately.  Let's re-write it a bit to be more clear.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied to net-next, thanks.
