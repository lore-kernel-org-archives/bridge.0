Return-Path: <davem@davemloft.net>
Date: Fri, 25 Sep 2020 16:50:37 -0700 (PDT)
Message-Id: <20200925.165037.78422409470029269.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200925102549.1704905-1-razor@blackwall.org>
References: <20200925102549.1704905-1-razor@blackwall.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: mcast: remove only S,
 G port groups from sg_port hash
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: razor@blackwall.org
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, nikolay@nvidia.com, roopa@nvidia.com

From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Fri, 25 Sep 2020 13:25:49 +0300

> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> We should remove a group from the sg_port hash only if it's an S,G
> entry. This makes it correct and more symmetric with group add. Also
> since *,G groups are not added to that hash we can hide a bug.
> 
> Fixes: 085b53c8beab ("net: bridge: mcast: add sg_port rhashtable")
> Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>

Applied, thanks.
