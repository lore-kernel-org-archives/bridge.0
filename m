Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZknEdyZ1T4tCO8tHmRX93ivSc3EBe24oWP4BwRhJ2Q0=;
	b=TYEN0hMZKShpozJvjr/W9Y1Srn
	iaaqJaCW3jncpzHmm3Y+Dogy7v6DYmTCxq2ob5wMgxdl8KTfwzyiDXnN/xjBCAMvqUVit5pkeskg4
	6vRmtmlc5vthbW7UyxuzRgsUekvcAeeRi2JwIK9aUBoeijunwkNHXb+mHSewJgugPPaA=; 
Date: Tue, 2 Jul 2019 23:35:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20190702213540.GD28471@lunn.ch>
References: <20190702204705.GC28471@lunn.ch>
	<55f24bfb-4239-dda8-24f8-26b6b2fa9f9e@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55f24bfb-4239-dda8-24f8-26b6b2fa9f9e@cumulusnetworks.com>
Subject: Re: [Bridge] Validation of forward_delay seems wrong...
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org

> Hi Andrew,
> The man page is wrong, these have been in USER_HZ scaled clock_t format from the beginning.
> TBH a lot of the time/delay bridge config options are messed up like that.

Hi Nikola

Yes, that is a mess.

arch/alpha/include/asm/param.h:# define USER_HZ						1024
arch/ia64/include/asm/param.h:# define USER_HZ						HZ
include/asm-generic/param.h:# define USER_HZ						100

And ia64 does
# define HZ             CONFIG_HZ

So it seems pretty hard for user space to get this right in a generic
fashion.

	Andrew
