Return-Path: <davem@davemloft.net>
Date: Thu, 04 Apr 2019 17:53:26 -0700 (PDT)
Message-Id: <20190404.175326.553696775953316967.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190403202724.9123-1-nikolay@cumulusnetworks.com>
References: <a1c19a63-a37e-2903-335a-0a4a73efb6b2@cumulusnetworks.com>
	<20190403202724.9123-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: always clear mcast matching
 struct on reports and leaves
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, liam.mcbirnie@boeing.com

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed,  3 Apr 2019 23:27:24 +0300

> We need to be careful and always zero the whole br_ip struct when it is
> used for matching since the rhashtable change. This patch fixes all the
> places which didn't properly clear it which in turn might've caused
> mismatches.
> 
> Thanks for the great bug report with reproducing steps and bisection.
 ...
> Reported-by: liam.mcbirnie@boeing.com
> Fixes: 19e3a9c90c53 ("net: bridge: convert multicast to generic rhashtable")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied and queued up for -stable.

> I will cook a selftest for this as well.

Thanks in advance for this, that's great.
