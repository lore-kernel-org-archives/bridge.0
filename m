Return-Path: <davem@davemloft.net>
Date: Thu, 18 Aug 2016 23:19:00 -0700 (PDT)
Message-Id: <20160818.231900.1546468845417451233.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1471431190-27442-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1471431190-27442-1-git-send-email-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/2] net: bridge: export vlan stats
 per-port with flags
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
Date: Wed, 17 Aug 2016 12:53:08 +0200

> This set adds the ability to export vlan stats per-port. Patch 01 makes
> that possible by consolidating the bridge and port linkxstats calls. Then
> patch 02 allows to dump the vlan entry flags in order to be able to
> distinguish between bridge and port vlan entries when dumping the master
> device vlan stats. That is needed because that call was implemented when
> the stats API didn't have slave dumping capabilities and it dumps all vlan
> stats (for both bridge and port entries). We also need it in order to print
> the vlan flags when dumping the stats.

Series applied.
