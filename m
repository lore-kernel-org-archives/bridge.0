Return-Path: <davem@davemloft.net>
Date: Wed, 07 Oct 2015 04:50:04 -0700 (PDT)
Message-Id: <20151007.045004.1703152532685913386.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1444133522-16907-1-git-send-email-razor@blackwall.org>
References: <1444133522-16907-1-git-send-email-razor@blackwall.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/8] bridge: netlink: complete port
 attribute support
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
Date: Tue,  6 Oct 2015 14:11:54 +0200

> This is the second set that completes the bridge port's netlink support and
> makes everything from sysfs available via netlink. I've used sysfs as a
> guide of what and how to set again. I've tested setting/getting every
> option and also this time tested enabling KASAN. Again there're a few long
> line warnings about the ifla attribute names in br_port_info_size() but
> as the previous set - it's good to know what's been accounted for.

Series applied, thanks Nik.
