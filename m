Return-Path: <davem@davemloft.net>
Date: Fri, 30 Nov 2018 17:08:47 -0800 (PST)
Message-Id: <20181130.170847.1004374658783509972.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181128200558.31343-1-idosch@mellanox.com>
References: <20181128200558.31343-1-idosch@mellanox.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/8] mlxsw: Add VxLAN support with
 VLAN-aware bridges
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: idosch@mellanox.com
Cc: mlxsw@mellanox.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, jiri@mellanox.com, petrm@mellanox.com

From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 28 Nov 2018 20:06:56 +0000

> Commit 53e50a6ec24d ("Merge branch 'mlxsw-Add-VxLAN-support'") added
> mlxsw support for VxLAN when the VxLAN device was enslaved to
> VLAN-unaware bridges. This patchset extends mlxsw to also support VxLAN
> with VLAN-aware bridges.
> 
> With VLAN-aware bridges, the VxLAN device's VNI is mapped to the VLAN
> that is configured as 'pvid untagged' on the corresponding bridge port.
> To prevent ambiguity, mlxsw forbids configurations in which the same
> VLAN is configured as 'pvid untagged' on multiple VxLAN devices.
> 
> Patches #1-#2 add the necessary APIs in mlxsw and the bridge driver.
> 
> Patches #3-#4 perform small refactoring in order to prepare mlxsw for
> VLAN-aware support.
> 
> Patch #5 finally enables the enslavement of VxLAN devices to a
> VLAN-aware bridge. Among other things, it extends mlxsw to handle
> switchdev notifications about VLAN add / delete on a VxLAN device
> enslaved to an offloaded VLAN-aware bridge.
> 
> Patches #6-#8 add selftests to test the new functionality.

Nice clean changes, nice test cases, series applied.

Thanks!
