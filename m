Return-Path: <davem@davemloft.net>
Date: Tue, 17 Mar 2020 22:47:32 -0700 (PDT)
Message-Id: <20200317.224732.583644832239870673.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200317120836.1765164-1-nikolay@cumulusnetworks.com>
References: <20200317120836.1765164-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/4] net: bridge: vlan options: add
 support for tunnel mapping
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
Date: Tue, 17 Mar 2020 14:08:32 +0200

> In order to bring the new vlan API on par with the old one and be able
> to completely migrate to the new one we need to support vlan tunnel mapping
> and statistics. This patch-set takes care of the former by making it a
> vlan option. There are two notable issues to deal with:
>  - vlan range to tunnel range mapping
>    * The tunnel ids are globally unique for the vlan code and a vlan can
>      be mapped to one tunnel, so the old API took care of ranges by
>      taking the starting tunnel id value and incrementally mapping
>      vlan id(i) -> tunnel id(i). This set takes the same approach and
>      uses one new attribute - BRIDGE_VLANDB_ENTRY_TUNNEL_ID. If used
>      with a vlan range then it's the starting tunnel id to map.
> 
>  - tunnel mapping removal
>    * Since there are no reserved/special tunnel ids defined, we can't
>      encode mapping removal within the new attribute, in order to be
>      able to remove a mapping we add a vlan flag which makes the new
>      tunnel option remove the mapping
> 
> The rest is pretty straight-forward, in fact we directly re-use the old
> code for manipulating tunnels by just mapping the command (set/del). In
> order to be able to keep detecting vlan ranges we check that the current
> vlan has a tunnel and it's extending the current vlan range end's tunnel
> id.

Looks good, series applied, thank you.
