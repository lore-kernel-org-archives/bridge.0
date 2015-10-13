Return-Path: <idosch@mellanox.com>
Date: Tue, 13 Oct 2015 10:19:02 +0300
From: Ido Schimmel <idosch@mellanox.com>
Message-ID: <20151013071902.GB28618@colbert.mtl.com>
References: <1444679225-7354-1-git-send-email-razor@blackwall.org>
	<1444679225-7354-2-git-send-email-razor@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1444679225-7354-2-git-send-email-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next v2 1/4] bridge: vlan: use proper rcu
 for the vlgrp member
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

Mon, Oct 12, 2015 at 10:47:02PM IDT, razor@blackwall.org wrote:
>From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>
>The bridge and port's vlgrp member is already used in RCU way, currently
>we rely on the fact that it cannot disappear while the port exists but
>that is error-prone and we might miss places with improper locking
>(either RCU or RTNL must be held to walk the vlan_list). So make it
>official and use RCU for vlgrp to catch offenders. Introduce proper vlgrp
>accessors and use them consistently throughout the code.
>
>Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
