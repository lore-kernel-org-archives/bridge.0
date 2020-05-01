Return-Path: <davem@davemloft.net>
Date: Thu, 30 Apr 2020 17:46:29 -0700 (PDT)
Message-Id: <20200430.174629.548555772744348705.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200430193845.4087868-1-idosch@idosch.org>
References: <20200430193845.4087868-1-idosch@idosch.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: vlan: Add a schedule point
 during VLAN processing
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: idosch@idosch.org
Cc: mlxsw@mellanox.com, s.priebe@profihost.ag, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, idosch@mellanox.com, kuba@kernel.org

From: Ido Schimmel <idosch@idosch.org>
Date: Thu, 30 Apr 2020 22:38:45 +0300

> From: Ido Schimmel <idosch@mellanox.com>
> 
> User space can request to delete a range of VLANs from a bridge slave in
> one netlink request. For each deleted VLAN the FDB needs to be traversed
> in order to flush all the affected entries.
> 
> If a large range of VLANs is deleted and the number of FDB entries is
> large or the FDB lock is contented, it is possible for the kernel to
> loop through the deleted VLANs for a long time. In case preemption is
> disabled, this can result in a soft lockup.
> 
> Fix this by adding a schedule point after each VLAN is deleted to yield
> the CPU, if needed. This is safe because the VLANs are traversed in
> process context.
> 
> Fixes: bdced7ef7838 ("bridge: support for multiple vlans and vlan ranges in setlink and dellink requests")
> Signed-off-by: Ido Schimmel <idosch@mellanox.com>
> Reported-by: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
> Tested-by: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>

Applied and queued up for -stable.
