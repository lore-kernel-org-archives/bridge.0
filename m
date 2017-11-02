Return-Path: <davem@davemloft.net>
Date: Thu, 02 Nov 2017 15:54:17 +0900 (KST)
Message-Id: <20171102.155417.1598178495654566553.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1509531493-17909-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1509531493-17909-1-git-send-email-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: add notifications for
 the bridge dev on vlan change
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
Date: Wed,  1 Nov 2017 12:18:13 +0200

> Currently the bridge device doesn't generate any notifications upon vlan
> modifications on itself because it doesn't use the generic bridge
> notifications.
> With the recent changes we know if anything was modified in the vlan config
> thus we can generate a notification when necessary for the bridge device
> so add support to br_ifinfo_notify() similar to how other combined
> functions are done - if port is present it takes precedence, otherwise
> notify about the bridge. I've explicitly marked the locations where the
> notification should be always for the port by setting bridge to NULL.
> I've also taken the liberty to rearrange each modified function's local
> variables in reverse xmas tree as well.
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied.
