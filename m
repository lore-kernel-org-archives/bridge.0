Return-Path: <davem@davemloft.net>
Date: Fri, 20 Mar 2020 08:52:40 -0700 (PDT)
Message-Id: <20200320.085240.1137730407369663617.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200320112303.81904-1-nikolay@cumulusnetworks.com>
References: <20200320112303.81904-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/2] net: bridge: vlan options: nest
 the tunnel options
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
Date: Fri, 20 Mar 2020 13:23:01 +0200

> After a discussion with Roopa about the new tunnel vlan option, she
> suggested that we'll be adding more tunnel options and attributes, so
> it'd be better to have them all grouped together under one main vlan
> entry tunnel attribute instead of making them all main attributes. Since
> the tunnel code was added in this net-next cycle and still hasn't been
> released we can easily nest the BRIDGE_VLANDB_ENTRY_TUNNEL_ID attribute
> in BRIDGE_VLANDB_ENTRY_TUNNEL_INFO and allow for any new tunnel
> attributes to be added there. In addition one positive side-effect is
> that we can remove the outside vlan info flag which controlled the
> operation (setlink/dellink) and move it under a new nested attribute so
> user-space can specify it explicitly.
> 
> Thus the vlan tunnel format becomes:
>  [BRIDGE_VLANDB_ENTRY]
>      [BRIDGE_VLANDB_ENTRY_TUNNEL_INFO]
>          [BRIDGE_VLANDB_TINFO_ID]
>          [BRIDGE_VLANDB_TINFO_CMD]
>          ...

Makes sense, series applied, thanks.
