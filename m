Return-Path: <davem@davemloft.net>
Date: Tue, 11 Apr 2017 22:23:03 -0400 (EDT)
Message-Id: <20170411.222303.1239914373445400319.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170410115928.9344-1-idosch@idosch.org>
References: <20170410115928.9344-1-idosch@idosch.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v3 0/2] bridge: Fix kernel oops during
 bridge creation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: idosch@idosch.org
Cc: idosch@mellanox.com, mlxsw@mellanox.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, peter@svinota.eu, bridge@lists.linux-foundation.org

From: idosch@idosch.org
Date: Mon, 10 Apr 2017 14:59:26 +0300

> From: Ido Schimmel <idosch@mellanox.com>
> 
> First patch adds a missing ndo_uninit() in the bridge driver, which is a
> prerequisite for the second patch that actually fixes the oops.
> 
> Please consider both patches for 4.4.y, 4.9.y and 4.10.y

Series applied and queued up for -stable, thank you.
