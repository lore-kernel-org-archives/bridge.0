Return-Path: <davem@davemloft.net>
Date: Thu, 19 Mar 2020 20:22:06 -0700 (PDT)
Message-Id: <20200319.202206.1844889598253272050.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200319101414.201391-1-nikolay@cumulusnetworks.com>
References: <20200319101414.201391-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] net: bridge: vlan: include stats
 in dumps if requested
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
Date: Thu, 19 Mar 2020 12:14:14 +0200

> This patch adds support for vlan stats to be included when dumping vlan
> information. We have to dump them only when explicitly requested (thus the
> flag below) because that disables the vlan range compression and will make
> the dump significantly larger. In order to request the stats to be
> included we add a new dump attribute called BRIDGE_VLANDB_DUMP_FLAGS which
> can affect dumps with the following first flag:
>   - BRIDGE_VLANDB_DUMPF_STATS
> The stats are intentionally nested and put into separate attributes to make
> it easier for extending later since we plan to add per-vlan mcast stats,
> drop stats and possibly STP stats. This is the last missing piece from the
> new vlan API which makes the dumped vlan information complete.
> 
> A dump request which should include stats looks like:
>  [BRIDGE_VLANDB_DUMP_FLAGS] |= BRIDGE_VLANDB_DUMPF_STATS
> 
> A vlandb entry attribute with stats looks like:
>  [BRIDGE_VLANDB_ENTRY] = {
>      [BRIDGE_VLANDB_ENTRY_STATS] = {
>          [BRIDGE_VLANDB_STATS_RX_BYTES]
>          [BRIDGE_VLANDB_STATS_RX_PACKETS]
>          ...
>      }
>  }
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
> v2: Use a separate dump attribute for the flags instead of a reserved
>     field to avoid uapi breakage as noted by DaveM.
>     Rebased and retested on the latest net-next.

Thanks for reworking UAPI.

Applied, thanks.
