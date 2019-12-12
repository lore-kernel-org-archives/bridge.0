Return-Path: <vivien.didelot@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:message-id:from:to:cc:subject:in-reply-to:references
 :mime-version:content-disposition:content-transfer-encoding;
 bh=bDu6UlocVr8yC7RA+vB1bpLyWumODdkZotQceKQnYYs=;
 b=PoAXSiR2m6vRgvmrW+eo5ZjFm9n+6JKutN/xPdn5nri69rqF2gXfNVdSKp8TSmP0KG
 JnbNf1p1O1h8zpGmbGqEvPJmfpXvzyVS9DJ0UEr5VJueIHMa4RGgilrOEJLk69h+acuO
 LzvHDaHEVqlECvwxqZdEB8eW1PNjcJUVFKwL41E3a15548vgzTjXmj8ex78fGMjckvSe
 6pe8yBrm4fxDLiv9Fmr6iPPvvzk2gcB95t/WJqlaF6zHFQZ0wFPO6jXVpAxPKEpociLW
 PerRrj3HU0IoR9tvgfXATdMgzVOBlNuroTITvomGkzRmZrNqubBwfrbJlLyC1PZtvvxj
 tjGg==
Date: Wed, 11 Dec 2019 20:02:37 -0500
Message-ID: <20191211200237.GB1661911@t480s.localdomain>
From: Vivien Didelot <vivien.didelot@gmail.com>
In-Reply-To: <20191211.141658.433012532951670675.davem@davemloft.net>
References: <20191211134133.GB1587652@t480s.localdomain>
 <20191211.120120.991784482938734303.davem@davemloft.net>
 <20191211164754.GB1616641@t480s.localdomain>
 <20191211.141658.433012532951670675.davem@davemloft.net>
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

On Wed, 11 Dec 2019 14:16:58 -0800 (PST), David Miller <davem@davemloft.net> wrote:
> > To be more precise, what I don't get is that when
> > I move the BRIDGE_XSTATS_STP definition *after* BRIDGE_XSTATS_PAD, the STP
> > xstats don't show up anymore in iproute2.
> 
> Because you ahve to recompile iproute2 so that it uses the corrected value
> in the kernel header, did you do that?

Meh you were correct, my rebuild didn't pick up the header change :-/

I also moved the STP xstats copy below the mcast xstats copy to be consistent
with the order. I'll respin right away.


Thanks,

	Vivien
