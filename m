Return-Path: <davem@davemloft.net>
Date: Fri, 11 Sep 2020 14:50:25 -0700 (PDT)
Message-Id: <20200911.145025.2133088801719324101.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200911132447.3158141-1-idosch@idosch.org>
References: <20200911132447.3158141-1-idosch@idosch.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: mcast: Fix incomplete MDB dump
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: idosch@idosch.org
Cc: netdev@vger.kernel.org, idosch@nvidia.com, bridge@lists.linux-foundation.org, nikolay@nvidia.com, jiri@nvidia.com, roopa@nvidia.com, kuba@kernel.org, mlxsw@nvidia.com

From: Ido Schimmel <idosch@idosch.org>
Date: Fri, 11 Sep 2020 16:24:47 +0300

> From: Ido Schimmel <idosch@nvidia.com>
> 
> Each MDB entry is encoded in a nested netlink attribute called
> 'MDBA_MDB_ENTRY'. In turn, this attribute contains another nested
> attributed called 'MDBA_MDB_ENTRY_INFO', which encodes a single port
> group entry within the MDB entry.
> 
> The cited commit added the ability to restart a dump from a specific
> port group entry. However, on failure to add a port group entry to the
> dump the entire MDB entry (stored in 'nest2') is removed, resulting in
> missing port group entries.
> 
> Fix this by finalizing the MDB entry with the partial list of already
> encoded port group entries.
> 
> Fixes: 5205e919c9f0 ("net: bridge: mcast: add support for src list and filter mode dumping")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Applied, thank you.
