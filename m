Return-Path: <vivien.didelot@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:message-id:from:to:cc:subject:in-reply-to:references
 :mime-version:content-disposition:content-transfer-encoding;
 bh=RaAE7sjaNd1lnPk57Cwl+t3wgCFYj7SYpv6MvMoqfZM=;
 b=TyBKqC7aMmrh+M6LP64NE4QW7xWQKWLDifFe4gpI7ZIaVzF4igUoNCdI6aw++uiE2w
 a2kHcrZ8EAdWJIDY54CrtgKsgAEjnSjG48BIbTqGWKmy66OUQYLEYGD476TScP+HmOIy
 /W9rmUeuAa87/A/TiMhuZVPWNXUQQUOe55G1llrZKFLXgUJiub0lIPNPmvGfNSg29efN
 nDUBa53Qtp0pOdxrRxHdIYa2ml8eAcIJFfsvY9IHqmdTN1iNFcqm+G/f2yPZWxxFRgyQ
 pSpz2RhqqpUZq9qXDtPSlqKGUvjgGsQIW44dcxSJy0ft0abuO6po6ZTTg46d48PieaZo
 OUqQ==
Date: Wed, 11 Dec 2019 16:47:54 -0500
Message-ID: <20191211164754.GB1616641@t480s.localdomain>
From: Vivien Didelot <vivien.didelot@gmail.com>
In-Reply-To: <20191211.120120.991784482938734303.davem@davemloft.net>
References: <0e45fd22-c31b-a9c2-bf87-22c16a60aeb4@gmail.com>
 <9f978ee1-08ee-aa57-6e3d-9b68657eeb14@cumulusnetworks.com>
 <20191211134133.GB1587652@t480s.localdomain>
 <20191211.120120.991784482938734303.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next v2] net: bridge: add STP xstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, dsahern@gmail.com

Hi David,

On Wed, 11 Dec 2019 12:01:20 -0800 (PST), David Miller <davem@davemloft.net> wrote:
> >> >>  /* Bridge multicast database attributes
> >> >>   * [MDBA_MDB] = {
> >> >>   *     [MDBA_MDB_ENTRY] = {
> >> >> @@ -261,6 +270,7 @@ enum {
> >> >>  	BRIDGE_XSTATS_UNSPEC,
> >> >>  	BRIDGE_XSTATS_VLAN,
> >> >>  	BRIDGE_XSTATS_MCAST,
> >> >> +	BRIDGE_XSTATS_STP,
> >> >>  	BRIDGE_XSTATS_PAD,
> >> >>  	__BRIDGE_XSTATS_MAX
> >> >>  };
> >> > 
> >> > Shouldn't the new entry be appended to the end - after BRIDGE_XSTATS_PAD
> >> > 
> >> 
> >> Oh yes, good catch. That has to be fixed, too.
> >> 
> > 
> > This I don't get. Why new attributes must come between BRIDGE_XSTATS_PAD
> > and __BRIDGE_XSTATS_MAX?
> 
> Because, just like any other attribute value, BRIDGE_XSTATS_PAD is an
> API and fixed in stone.  You can't add things before it which change
> it's value.

I thought the whole point of using enums was to avoid caring about fixed
numeric values, but well. To be more precise, what I don't get is that when
I move the BRIDGE_XSTATS_STP definition *after* BRIDGE_XSTATS_PAD, the STP
xstats don't show up anymore in iproute2.


Thanks,

	Vivien
