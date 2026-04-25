Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93B923AB87
	for <bridge@lists.linux.dev>; Sat, 25 Apr 2026 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777112221; cv=none; b=TwDptoSeX3FXDqeaseph6Wmh/6FnyzLZgZvEBWxkNgGW+Ij5H+qYOjGl6ZyJRzvGVkm63IVJcSrIiAH6C9Rg+9TP1L41ZZU7keDVON6QybNAO1jmcRlocOfV4AquSZrceNvBsOXOKbQ9Fy3qGaAJbPOfb5/CjTVLS9znL3dBMik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777112221; c=relaxed/simple;
	bh=tNX+qwy+nTQrdmx+we0M6zUS/XBnFj97S7HY1QMEqGg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AJ1vixR8aT9nsXkZpNC8kfcmXjp99JkrJwtwXzAn4b0uJAEJOx4Km7fuFzllo+1I6GWxW+kzRMmMxrBaQ5V2McJ9LkPuvosU2l56vqdEHf6sc7k38W6F4wZN8YfcWOH7JaHD295P4tkogJKEHhLStlovOqbT97mgLZWuZcs86AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 1C9A99200B3; Sat, 25 Apr 2026 12:16:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 17A9992009D;
	Sat, 25 Apr 2026 11:16:50 +0100 (BST)
Date: Sat, 25 Apr 2026 11:16:50 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jakub Kicinski <kuba@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
    edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
    horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, 
    linux@armlinux.org.uk, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
    chleroy@kernel.org, 3chas3@gmail.com, razor@blackwall.org, 
    idosch@nvidia.com, jani.nikula@intel.com, mchehab+huawei@kernel.org, 
    tytso@mit.edu, herbert@gondor.apana.org.au, 
    Geert Uytterhoeven <geert@linux-m68k.org>, ebiggers@kernel.org, 
    johannes.berg@intel.com, jonathan.cameron@huawei.com, kees@kernel.org, 
    kuniyu@google.com, fourier.thomas@gmail.com, andriy.shevchenko@intel.com, 
    rdunlap@infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
    linux-doc@vger.kernel.org, linux-mips@vger.kernel.org, 
    linuxppc-dev@lists.ozlabs.org, bridge@lists.linux.dev, 
    David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH net-deletions v2] net: remove unused ATM protocols and
 legacy ATM device drivers
In-Reply-To: <20260422041846.2035118-1-kuba@kernel.org>
Message-ID: <alpine.DEB.2.21.2604251104030.28583@angie.orcam.me.uk>
References: <20260422041846.2035118-1-kuba@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 21 Apr 2026, Jakub Kicinski wrote:

> Removed PCI/SBUS ATM device drivers (drivers/atm/):
>  - adummy, atmtcp - software/testing ATM devices
>  - eni - Efficient Networks ENI155P (OC-3, ~1995)

 I have one of those though sadly it broke a couple years back and doesn't 
work anymore.

>  - fore200e - FORE Systems 200E PCI/SBUS (OC-3, ~1999)
>  - he - ForeRunner HE (OC-3/OC-12, ~2000)
>  - idt77105 - IDT 77105 25 Mbps ATM PHY
>  - idt77252 - IDT 77252 NICStAR II (OC-3, ~2000)
>  - iphase - Interphase ATM PCI (OC-3/DS3/E3)
>  - lanai - Efficient Networks Speedstream 3010
>  - nicstar - IDT 77201 NICStAR (155/25 Mbps, ~1999)

 And I have a number of these, both 77201 and 77211 variants, scattered 
across several systems of various architectures in my lab.

>  - solos-pci - Traverse Technologies ADSL2+ PCI
>  - suni - PMC S/UNI SONET PHY library

 Plus a bunch of TURBOchannel ATM interfaces, a couple of LightStream ATM 
switches and some Ethernet switches with LANE ports.  Never found time to 
get this all set up, so I guess I can't complain really to see this stuff 
go.  Still sad to see the continuous trend to strip Linux of features. :(

  Maciej
