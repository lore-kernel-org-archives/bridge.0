Return-Path: <davem@davemloft.net>
Date: Sun, 12 Jul 2020 15:18:41 -0700 (PDT)
Message-Id: <20200712.151841.665763672459551082.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200711150504.885831-1-nikolay@cumulusnetworks.com>
References: <20200711150504.885831-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: notify on vlan tunnel
 changes done via the old api
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
Date: Sat, 11 Jul 2020 18:05:04 +0300

> If someone uses the old vlan API to configure tunnel mappings we'll only
> generate the old-style full port notification. That would be a problem
> if we are monitoring the new vlan notifications for changes. The patch
> resolves the issue by adding vlan notifications to the old tunnel netlink
> code. As usual we try to compress the notifications for as many vlans
> in a range as possible, thus a vlan tunnel change is considered able
> to enter the "current" vlan notification range if:
>  1. vlan exists
>  2. it has actually changed (curr_change == true)
>  3. it passes all standard vlan notification range checks done by
>     br_vlan_can_enter_range() such as option equality, id continuity etc
> 
> Note that vlan tunnel changes (add/del) are considered a part of vlan
> options so only RTM_NEWVLAN notification is generated with the relevant
> information inside.
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied, thank you.
