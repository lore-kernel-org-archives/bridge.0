Return-Path: <davem@davemloft.net>
Date: Thu, 04 Apr 2019 17:40:55 -0700 (PDT)
Message-Id: <20190404.174055.1070774187116102708.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190403104924.32695-1-nikolay@cumulusnetworks.com>
References: <20190403104924.32695-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: optimize backup_port fdb
 convergence
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
Date: Wed,  3 Apr 2019 13:49:24 +0300

> We can optimize the fdb convergence when a backup_port is present by not
> immediately flushing the entries of the stopped port since traffic for
> those entries will flow towards the backup_port.
> 
> There are 2 cases specifically that benefit most:
> - when the stopped port comes up before the entries expire by themselves
> - when there's an external entry refresh and they're kept while the
>   backup_port is operating (e.g. mlag)
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied.
