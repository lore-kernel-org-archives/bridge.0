Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; 
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=eKcopGm4rF/1KRUKlbK3KXfGGM6nPBiGMQFYqP4r+y4=; 
	b=F6QtMsIbphyqO62q9dUgwVXGz+Uh0ocWqxx2uvohj8RFmyo6QqklrTLdoYAmgieXkMJxxiwcD8owGMjTPxk/7Sy00OVlJ9FXNPHuh/sfpPNTLbzCusC8u/+iah9AOg7kqurE53aV6TBj3n7S24WW2sEuIOseqmVmreR4LiGaTdo=;
Date: Sat, 24 Nov 2018 17:27:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20181124162721.GE24681@lunn.ch>
References: <20181124023422.13908-1-nikolay@cumulusnetworks.com>
	<20181124023422.13908-3-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181124023422.13908-3-nikolay@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net-next v2 2/3] net: bridge: add
 no_linklocal_learn bool option
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

On Sat, Nov 24, 2018 at 04:34:21AM +0200, Nikolay Aleksandrov wrote:
> Use the new boolopt API to add an option which disables learning from
> link-local packets. The default is kept as before and learning is
> enabled. This is a simple map from a boolopt bit to a bridge private
> flag that is tested before learning.
> 
> v2: pass NULL for extack via sysfs
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
