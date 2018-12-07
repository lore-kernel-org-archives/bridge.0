Return-Path: <davem@davemloft.net>
Date: Fri, 07 Dec 2018 13:05:54 -0800 (PST)
Message-Id: <20181207.130554.518420400722936900.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181207195433.22540-1-idosch@mellanox.com>
References: <20181207195433.22540-1-idosch@mellanox.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 00/12] mlxsw: Un/offload FDB on NVE
 detach/attach
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: idosch@mellanox.com
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, jiri@mellanox.com, petrm@mellanox.com

From: Ido Schimmel <idosch@mellanox.com>
Date: Fri, 7 Dec 2018 19:55:01 +0000

> Petr says:
> 
> When a VXLAN device is attached to a bridge of a driver capable of
> offloading such, or upped, the FDB entries already present at the device
> need to be offloaded. Similarly when an offloaded VXLAN device ceases
> being interesting (it is downed, or detached, or a front-panel port
> netdevice is detached from the bridge that the VXLAN device is attached
> to), any offloaded FDB entries need to be unoffloaded and unmarked. This
> attach / detach processing is implemented in this patchset.
> 
> In patch #1, a code pattern is extracted into a named function for
> easier reuse.
> 
> In patch #2, vxlan_fdb_replay() is added to send
> SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE for each FDB entry with a given VNI.
> The intention is that the offloading driver will interpret these events
> like any other and thus offload the FDB entries that existed prior to
> VXLAN attach.
> 
> In patches #3 and #4, the functions vxlan_fdb_clear_offload() resp.
> br_fdb_clear_offload() are added. These clear the offloaded flag at
> matching FDB entries.
> 
> In patches #5-#9, we introduce FID-type-specific and NVE-type-specific
> ops necessary to properly abstract invocations of the replay/clear
> functions.
> 
> Finally patch #10 implements the FDB management.
> 
> In patch #11, the mlxsw-specific test case is extended to check that the
> management of offload marks under the newly-supported situations is
> correct. Patch #12, from Ido, exercises the new code paths in actual
> functional test.
 ...

Series applied, thanks.
