Return-Path: <davem@davemloft.net>
Date: Wed, 04 Oct 2017 15:52:55 -0700 (PDT)
Message-Id: <20171004.155255.2208423870631197976.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1507093953-59929-2-git-send-email-roopa@cumulusnetworks.com>
References: <1507093953-59929-1-git-send-email-roopa@cumulusnetworks.com>
	<1507093953-59929-2-git-send-email-roopa@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 1/3] bridge: add new
 BR_NEIGH_SUPPRESS port flag to suppress arp and nd flood
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: roopa@cumulusnetworks.com
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Tue,  3 Oct 2017 22:12:31 -0700

> BR_ARP_PROXY flag but has a few semantic differences to conform

This should be "BR_PROXYARP".

Otherwise this series looks fine to me, but I see there will be
a v5 respin.
