Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098723A6EFC;
	Tue,  2 Jun 2026 23:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444557; cv=none; b=SqWdHsbk8YBVFoa+58+u1bQVrMl+LTClOWLtC9lcXD4hH942MN7QqDh1HsXSFRuGtdlwaS8tiWFAClO1KcWLtWABooMV3uMfc4Hg7awGsYSJhhG33fKdF4VQzkbs4CcbqBq/ExFz7OnzsuhSm1ZTaBDPGIB8rZhJskFbo3Guntc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444557; c=relaxed/simple;
	bh=VPAANNqyziR79jvlGIePnAgWsUA35uUVD0Zsgafhrx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOYz6DyvAT5K7B+ZDJJxyCtVBJpLQhH37Yx+kjDd47+k7X8lFfZ+nbJ0IMiq6f6FgNjmgN7Z418OmRywTDN8sYIXJRxN80EjkJlibgiR/yq8O1AA9CNEpvB5uAXJRHmmALmWk1CeUlz9r5Olr77e0Cy5C10VaRADKZBTEv58Za4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EPdn2N+6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EPdn2N+6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=K5RpInmC/cVt88OvKJqSiXvkHkuec9+/dvR94AXGMcI=; b=EP
	dn2N+6PEfRBN3/myNcZiESif4Fu39GHTfIwU6zZ/fl/Q4bYBdX5rCGEDNZpkN4vIJ86E7Cfx19jfP
	qlkg54xdo4J2oljBF8YhKK8K/KarXscbX5KhwbwHHiGMloQHpO8T1YiH7xDSvRGNNA3wEMXKjUC5M
	lAB9yuI8ueAEOlo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUYxO-005m6a-QY; Wed, 03 Jun 2026 01:55:38 +0200
Date: Wed, 3 Jun 2026 01:55:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luke Howard <lukeh@padl.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org, Max Hunter <max@huntershome.org>,
	Kieran Tyrrell <kieran@sienda.com>
Subject: Re: [PATCH net-next v2 5/6] net: dsa: mv88e6xxx: MQPRIO support
Message-ID: <29c09316-c911-456e-acc5-e18402da4bd4@lunn.ch>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-5-72be14522e7c@padl.com>
 <t44kmhk6gqxnwhdvo7svouexwelwsya7zgukpbv3cxpfsmutqa@y3rjoj3tvqce>
 <A662D3F9-18DD-43C9-A43D-912E5A8A4360@padl.com>
 <8C6AD966-2C28-4BEF-95C4-1B2AC3751513@padl.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8C6AD966-2C28-4BEF-95C4-1B2AC3751513@padl.com>

> But there’s an alternative, more invasive, solution where the MQPRIO
> configuration is attached to the bridge itself.

What about ports which are not attached to a bridge? They are just
standalone, have an IP address of their own, etc.

	    Andrew
