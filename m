Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; 
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=hfpYu+Nno+MChyZ1otnuc6Oit6kYmDDhpHNcgmtwn+Y=; 
	b=TLqwQaq+cFKQdLaLvKkYbDTZj6iNh+xfoztlmZ+r3NEs0e59wpM0Tqm72g7MDBBoT2Jw62qzaAvBuJ8AgYps7tCDYQWKWlk9D4Icir9EMopUD5ydETEuCsyMjM0ByNeXDWQiTSTM+FEwcqr4DdBMFhm/oicmtdcKrxTzWNJ1OcY=;
Date: Sat, 24 Nov 2018 17:26:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20181124162642.GD24681@lunn.ch>
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
> v2: new patch
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
