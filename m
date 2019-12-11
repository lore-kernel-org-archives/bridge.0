Return-Path: <davem@davemloft.net>
Date: Wed, 11 Dec 2019 12:01:20 -0800 (PST)
Message-Id: <20191211.120120.991784482938734303.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20191211134133.GB1587652@t480s.localdomain>
References: <0e45fd22-c31b-a9c2-bf87-22c16a60aeb4@gmail.com>
 <9f978ee1-08ee-aa57-6e3d-9b68657eeb14@cumulusnetworks.com>
 <20191211134133.GB1587652@t480s.localdomain>
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
Date: Wed, 11 Dec 2019 13:41:33 -0500

> Hi David, Nikolay,
> 
> On Wed, 11 Dec 2019 17:42:33 +0200, Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
>> >>  /* Bridge multicast database attributes
>> >>   * [MDBA_MDB] = {
>> >>   *     [MDBA_MDB_ENTRY] = {
>> >> @@ -261,6 +270,7 @@ enum {
>> >>  	BRIDGE_XSTATS_UNSPEC,
>> >>  	BRIDGE_XSTATS_VLAN,
>> >>  	BRIDGE_XSTATS_MCAST,
>> >> +	BRIDGE_XSTATS_STP,
>> >>  	BRIDGE_XSTATS_PAD,
>> >>  	__BRIDGE_XSTATS_MAX
>> >>  };
>> > 
>> > Shouldn't the new entry be appended to the end - after BRIDGE_XSTATS_PAD
>> > 
>> 
>> Oh yes, good catch. That has to be fixed, too.
>> 
> 
> This I don't get. Why new attributes must come between BRIDGE_XSTATS_PAD
> and __BRIDGE_XSTATS_MAX?

Because, just like any other attribute value, BRIDGE_XSTATS_PAD is an
API and fixed in stone.  You can't add things before it which change
it's value.

