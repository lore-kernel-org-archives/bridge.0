Return-Path: <davem@davemloft.net>
Date: Mon, 13 Jul 2015 14:41:40 -0700 (PDT)
Message-Id: <20150713.144140.2082284542914664511.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1436540528-42334-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1436540528-42334-1-git-send-email-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: mdb: add vlan support for
	user entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri, 10 Jul 2015 08:02:08 -0700

> Until now all user mdb entries were added in vlan 0, this patch adds
> support to allow the user to specify the vlan for the entry.
> About the uapi change a hole in struct br_mdb_entry is used so the size
> and offsets are kept the same (verified with pahole and tested with older
> iproute2).
> 
> Example:
> $ bridge mdb
> dev br0 port eth1 grp 239.0.0.1 permanent vlan 2000
> dev br0 port eth1 grp 239.0.0.1 permanent vlan 200
> dev br0 port eth1 grp 239.0.0.1 permanent
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

This looks ok, applied thanks Nikolay.
