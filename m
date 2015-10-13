Return-Path: <idosch@mellanox.com>
Date: Tue, 13 Oct 2015 10:21:01 +0300
From: Ido Schimmel <idosch@mellanox.com>
Message-ID: <20151013072101.GE28618@colbert.mtl.com>
References: <1444679225-7354-1-git-send-email-razor@blackwall.org>
	<1444679225-7354-5-git-send-email-razor@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1444679225-7354-5-git-send-email-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next v2 4/4] bridge: vlan: move back
	vlan_flush
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, roopa@cumulusnetworks.com, shm@cumulusnetworks.com, davem@davemloft.net

Mon, Oct 12, 2015 at 10:47:05PM IDT, razor@blackwall.org wrote:
>From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>
>Ido Schimmel reported a problem with switchdev devices because of the
>order change of del_nbp operations, more specifically the move of
>nbp_vlan_flush() which deletes all vlans and frees vlgrp after the
>rx_handler has been unregistered. So in order to fix this move
>vlan_flush back where it was and make it destroy the rhtable after
>NULLing vlgrp and waiting a grace period to make sure noone can see it.
>
>Reported-by: Ido Schimmel <idosch@mellanox.com>
>Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Reviewed-by: Ido Schimmel <idosch@mellanox.com>

Thanks Nikolay!
