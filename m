Return-Path: <davem@davemloft.net>
Date: Wed, 02 Sep 2020 12:58:46 -0700 (PDT)
Message-Id: <20200902.125846.1328960907241014780.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200902112529.1570040-1-nikolay@cumulusnetworks.com>
References: <20200902112529.1570040-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 00/15] net: bridge: mcast: initial
 IGMPv3 support (part 1)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed,  2 Sep 2020 14:25:14 +0300

> Here're the sets that will come next (in order):
>  - Fast path patch-set which adds support for (S, G) mdb entries needed
>    for IGMPv3 forwarding, entry add source (kernel, user-space etc)
>    needed for IGMPv3 entry management, entry block mode needed for
>    IGMPv3 exclude mode. This set will also add iproute2 support for
>    manipulating and showing all the new state.
>  - Selftests patch-set which will verify all IGMPv3 state transitions
>    and forwarding
>  - Explicit host tracking patch-set, needed for proper fast leave and
>    with it fast leave will be enabled for IGMPv3
> 
> Not implemented yet:
>  - Host IGMPv3 support (currently we handle only join/leave as before)
>  - Proper other querier source timer and value updates
>  - IGMPv3/v2 compat (I have a few rough patches for this one)

What about ipv6 support?  The first thing I notice when reading these
patches is the source filter code only supports ipv4.
