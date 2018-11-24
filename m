Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; 
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=gzrb2/9ZuAh2gS4Zj6soeFaHj7GumICUWiOJWraUBqA=; 
	b=Hr9U1Lw/A2eViUBLmjoGTuc09Fmw/PRZNrRlrBz2o0/95PelEfvx/bLY8hz9KmZ/5id7HPnw6hONUV8rV/ICfQl7vBVE/DJH6K9rWI4RvNB9tXNEEfkYlRJAHAhAnsoQQtVlaYpT/rUy7rqsGbxlu8aOSlOagdDoFcvxfXMbdw0=;
Date: Sat, 24 Nov 2018 17:16:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20181124161647.GB24681@lunn.ch>
References: <20181124023422.13908-1-nikolay@cumulusnetworks.com>
	<20181124023422.13908-4-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181124023422.13908-4-nikolay@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net-next v2 3/3] net: bridge: export supported
	boolopts
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On Sat, Nov 24, 2018 at 04:34:22AM +0200, Nikolay Aleksandrov wrote:
> Now that we have at least one bool option, we can export all of the
> supported bool options via optmask when dumping them.
> 
Hi Nik

That answers my question then...

I'm assuming this means there is no easy way to generate a bitmask of
0? So you waited until there was at least one bit.

(1 << 2) - 1 = 3
(1 << 1) - 1 = 1
(1 << 0) - 1 = 0

So does 

GENMASK((BR_BOOLOPT_MAX - 1), 0);

really not do the right thing when BR_BOOLOPT_MAX = 1?

       Andrew
