Return-Path: <davem@davemloft.net>
Date: Wed, 29 Jun 2016 05:40:01 -0400 (EDT)
Message-Id: <20160629.054001.1335885793021861692.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1467045282-21612-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1467045282-21612-1-git-send-email-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: fix vlan stats continue
	counter
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
Date: Mon, 27 Jun 2016 18:34:42 +0200

> I made a dumb off-by-one mistake when I added the vlan stats counter
> dumping code. The increment should happen before the check, not after
> otherwise we miss one entry when we continue dumping.
> 
> Fixes: a60c090361ea ("bridge: netlink: export per-vlan stats")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied.
