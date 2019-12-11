Return-Path: <davem@davemloft.net>
Date: Wed, 11 Dec 2019 14:16:58 -0800 (PST)
Message-Id: <20191211.141658.433012532951670675.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20191211164754.GB1616641@t480s.localdomain>
References: <20191211134133.GB1587652@t480s.localdomain>
 <20191211.120120.991784482938734303.davem@davemloft.net>
 <20191211164754.GB1616641@t480s.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] net: bridge: add STP xstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: vivien.didelot@gmail.com
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, dsahern@gmail.com

From: Vivien Didelot <vivien.didelot@gmail.com>
Date: Wed, 11 Dec 2019 16:47:54 -0500

> I thought the whole point of using enums was to avoid caring about fixed
> numeric values, but well.

I don't get where you got that idea from.

Each and every netlink attribute value is like IPPROTO_TCP in an ipv4
header, the exact values matter, and therefore you cannot make changes
that modify existing values.

Therefore, you must add new attributes to the end of the enumberation,
right before the __MAX value.

> To be more precise, what I don't get is that when
> I move the BRIDGE_XSTATS_STP definition *after* BRIDGE_XSTATS_PAD, the STP
> xstats don't show up anymore in iproute2.

Because you ahve to recompile iproute2 so that it uses the corrected value
in the kernel header, did you do that?
