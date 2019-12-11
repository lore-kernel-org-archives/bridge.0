Return-Path: <vivien.didelot@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:message-id:from:to:cc:subject:in-reply-to:references
 :mime-version:content-disposition:content-transfer-encoding;
 bh=QUS5BKSH61f4lKv1hrX3EZ1prXDNxY1nxacn7O67xGg=;
 b=KAxl3K1I5FzMh3XKViZcFfB9EeCf3AgNLlq9zOTdVMCwrHjKa7EWCjZJ+bBwcajfMA
 UIWclJQTkfpLMoXQjHaXmUIA51uhLaq4auOr/EDiJfvYUainah0ecJuFQ0t1S4UiKEDD
 n897e8jEBLwH2TvQcyyLL0fYeEYDI42XMcHJ3IDhsXrDiTFRf8g9LxE/i2Ffqgo9Lz30
 93gZJOPNJHOw01l40eSFt9OZVjLyAQmTZp1p23R4EVVvPkS7uJeNPlvoFly1SsRTv7sl
 CvhlaFCUXI7k5+6R4FeNWHIiGuye+9q0cx02WnxFAKmdQZG+BuMmsMxysutPykgIhTem
 BrbQ==
Date: Wed, 11 Dec 2019 13:41:33 -0500
Message-ID: <20191211134133.GB1587652@t480s.localdomain>
From: Vivien Didelot <vivien.didelot@gmail.com>
In-Reply-To: <9f978ee1-08ee-aa57-6e3d-9b68657eeb14@cumulusnetworks.com>
References: <20191210212050.1470909-1-vivien.didelot@gmail.com>
 <0e45fd22-c31b-a9c2-bf87-22c16a60aeb4@gmail.com>
 <9f978ee1-08ee-aa57-6e3d-9b68657eeb14@cumulusnetworks.com>
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
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, David Ahern <dsahern@gmail.com>, "David S. Miller" <davem@davemloft.net>

Hi David, Nikolay,

On Wed, 11 Dec 2019 17:42:33 +0200, Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
> >>  /* Bridge multicast database attributes
> >>   * [MDBA_MDB] = {
> >>   *     [MDBA_MDB_ENTRY] = {
> >> @@ -261,6 +270,7 @@ enum {
> >>  	BRIDGE_XSTATS_UNSPEC,
> >>  	BRIDGE_XSTATS_VLAN,
> >>  	BRIDGE_XSTATS_MCAST,
> >> +	BRIDGE_XSTATS_STP,
> >>  	BRIDGE_XSTATS_PAD,
> >>  	__BRIDGE_XSTATS_MAX
> >>  };
> > 
> > Shouldn't the new entry be appended to the end - after BRIDGE_XSTATS_PAD
> > 
> 
> Oh yes, good catch. That has to be fixed, too.
> 

This I don't get. Why new attributes must come between BRIDGE_XSTATS_PAD
and __BRIDGE_XSTATS_MAX?


Thanks,

	Vivien
