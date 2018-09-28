Return-Path: <davem@davemloft.net>
Date: Fri, 28 Sep 2018 10:43:31 -0700 (PDT)
Message-Id: <20180928.104331.1377446639278505418.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180927120510.7314-1-nikolay@cumulusnetworks.com>
References: <20180927120510.7314-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: explicitly zero
 is_sticky in fdb_create
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Thu, 27 Sep 2018 15:05:10 +0300

> We need to explicitly zero is_sticky when creating a new fdb, otherwise
> we might get a stale value for a new entry.
> 
> Fixes: 435f2e7cc0b7 ("net: bridge: add support for sticky fdb entries")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied, thanks Nikolay.
