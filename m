Return-Path: <davem@davemloft.net>
Date: Mon, 01 Jun 2020 11:09:41 -0700 (PDT)
Message-Id: <20200601.110941.803066444820067254.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200601125855.1751343-1-idosch@idosch.org>
References: <20200601125855.1751343-1-idosch@idosch.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net 0/2] Fix infinite loop in bridge and vxlan
	modules
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: idosch@idosch.org
Cc: mlxsw@mellanox.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, dlstevens@us.ibm.com, idosch@mellanox.com, allas@mellanox.com, kuba@kernel.org

From: Ido Schimmel <idosch@idosch.org>
Date: Mon,  1 Jun 2020 15:58:53 +0300

> From: Ido Schimmel <idosch@mellanox.com>
> 
> When suppressing invalid IPv6 Neighbour Solicitation messages, it is
> possible for the bridge and vxlan modules to get stuck in an infinite
> loop. See the individual changelogs for detailed explanation of the
> problem and solution.
> 
> The bug was originally reported against the bridge module, but after
> auditing the code base I found that the buggy code was copied from the
> vxlan module. This patch set fixes both modules. Could not find more
> instances of the problem.
> 
> Please consider both patches for stable releases.

Series applied and queued up for -stable, thank you.
