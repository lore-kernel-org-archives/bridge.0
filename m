Return-Path: <davem@davemloft.net>
Date: Sun, 04 Oct 2015 16:47:08 -0700 (PDT)
Message-Id: <20151004.164708.1245786027485004311.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1443961427-15085-1-git-send-email-razor@blackwall.org>
References: <1443961427-15085-1-git-send-email-razor@blackwall.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 00/20] bridge: complete netlink support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: razor@blackwall.org
Cc: shm@cumulusnetworks.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Sun,  4 Oct 2015 14:23:27 +0200

> This set completes the bridge device's netlink support and makes it
> possible to view and configure everything that can be configured via
> sysfs. I have tested all of these (setting and getting). There're a few
> longer line warnings about the br_get_size() ifla comments but I think we
> should have them to know what has been accounted for. I have used the sysfs
> interface as a guide of what and how to set. As usual I'll send the
> corresponding iproute2 patches later.
> The bridge port's netlink interface will be completed after this set gets
> applied in some form.
> 
> This patch-set is on top of my last vlan cleanups set:
> http://www.spinics.net/lists/netdev/msg346005.html

Series applied, thanks.
