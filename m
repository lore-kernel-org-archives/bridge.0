Return-Path: <davem@davemloft.net>
Date: Fri, 26 Aug 2016 11:46:22 -0700 (PDT)
Message-Id: <20160826.114622.1870705372113077932.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1472128071-17235-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1472128071-17235-1-git-send-email-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: export also pvid flag in
 the xstats flags
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
Date: Thu, 25 Aug 2016 14:27:51 +0200

> When I added support to export the vlan entry flags via xstats I forgot to
> add support for the pvid since it is manually matched, so check if the
> entry matches the vlan_group's pvid and set the flag appropriately.
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied.
