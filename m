Return-Path: <davem@davemloft.net>
Date: Fri, 12 Oct 2018 10:20:25 -0700 (PDT)
Message-Id: <20181012.102025.2235133411976941650.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181012104116.12751-1-nikolay@cumulusnetworks.com>
References: <20181012104116.12751-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: add support for per-port
 vlan stats
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
Date: Fri, 12 Oct 2018 13:41:16 +0300

> This patch adds an option to have per-port vlan stats instead of the
> default global stats. The option can be set only when there are no port
> vlans in the bridge since we need to allocate the stats if it is set
> when vlans are being added to ports (and respectively free them
> when being deleted). Also bump RTNL_MAX_TYPE as the bridge is the
> largest user of options. The current stats design allows us to add
> these without any changes to the fast-path, it all comes down to
> the per-vlan stats pointer which, if this option is enabled, will
> be allocated for each port vlan instead of using the global bridge-wide
> one.
> 
> CC: bridge@lists.linux-foundation.org
> CC: Roopa Prabhu <roopa@cumulusnetworks.com>
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied, thanks.
