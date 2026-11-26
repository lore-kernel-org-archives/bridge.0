Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704462;
	b=We7wGOS5LcxFXjq+Ft2z+Y9TwWaTzrteocTH+HBcP4rlM4Mmb3GF0z7C1RK5TxuyBb7E
	 O3u2P8Ri/m39nM/l9n49eQIWb4OYOynIwD/dA15Uqbx5wW7fkMfQi8fF5+C2P8BO5ggms
	 cYMNMP2sDr4CnwSXyakLxgHhs2ZwhYXXH+Ck6udMeFi6Hv6cBong4bO8Mr5aAtl8oEQJv
	 v+aJHCQcjH3hB3CcZJh/PD6x4Xg2PeVM5msreyU2MKCLxizneCdnUv4EvlfB7U3QNKG80
	 LU+zFiOpPKYz3aOpzLfDN7mxAgElUV25H4Kxh24jznnHN2ulaby7Cm4i7uMwA0hCleQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704462;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=hRrMixad2qJyrlzNp3Oeqpd4ndyNXjwG6ZWgC5iOE5I=;
	b=CN6WkTO0KKOSYYyqyj7BytTBnGXe4VJ7ip+dEk+EMc6SrHkCMX2DV3k5uIZq4MY5nOJg
	 vbs/9KfEGY4CgbDdtkKJGP9OYjMrxPUCaU7yMCLVq6Psftt6TQW6pfbdC8qjiRPusSguB
	 MhSBx8NYEwo20tBm3o5emcul6EXpIpR3RDe0t/shxW9U4KLWPpDOZiq7V00qgrlzARHhG
	 tareN3QG+wvl8k86FX9n0rIFjWQUWz9t5wp4crFyMBP2q2WB37sLTHtiRrv8d1ZBQkct0
	 cWVCZDy3RKF3SZBcjYSwf6I8+d26u1iyfJVQVpgYlnI9yXfPEa19ZzAz0Uv/FspTzKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=YjN7FVqf;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE03606A321;
	Thu, 26 Nov 2026 14:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAE03606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=YjN7FVqf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hRrMixad2qJyrlzNp3Oeqpd4ndyNXjwG6ZWgC5iOE5I=; b=YjN7FVqfAOF8mbC1Q5Qcnk/Up9
	yoLg+sWJXfKJe4rG5umBfRrBaCidJh5rpnOQTrQxMJRw9bE27Mi/feTh3GlmWaE6ecPvpOH9a5d5p
	SnHFkXw613IHkNyWeIiJ13Fu298KNomClSkUxBmipih52W5X72RbyCyN++E1Z7e1lvx0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xWal0-001abR-AO; Thu, 26 Nov 2026 15:47:30 +0100
Date: Thu, 26 Nov 2026 15:47:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	bridge@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH net-next 1/5] net: dsa: tag_ksz: do not mark trapped
 link-local frames as forwarded
Message-ID: <f2bf2333-8cbe-45d7-ae63-1cb0a15f9eb4@lunn.ch>
References: <20261126-ksz-stp-link-local-v1-0-39aed15f6271@pengutronix.de>
 <20261126-ksz-stp-link-local-v1-1-39aed15f6271@pengutronix.de>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126-ksz-stp-link-local-v1-1-39aed15f6271@pengutronix.de>

> +	/* The switch driver reports which link-local groups the switch sends
> +	 * to the CPU only. The switch did not forward frames to these groups,
> +	 * so do not mark them, and let the bridge apply its own rules
> +	 * (group_fwd_mask, STP state).
> +	 */
> +	if (!ksz_link_local_trapped(skb->dev, eth_hdr(skb)->h_dest))
> +		dsa_default_offload_fwd_mark(skb);

There is a bit of a common pattern in tag drivers:

        if (likely(!is_link_local_ether_addr(eth_hdr(skb)->h_dest)))
                dsa_default_offload_fwd_mark(skb);

Your variant is more specific, but does it need to be?

Should we consider adding a variant of dsa_default_offload_fwd_mark()
which combines this into one? And then change the tag drivers to use
it?

	Andrew
