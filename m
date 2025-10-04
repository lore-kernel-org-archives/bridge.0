Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5382F4A
	for <bridge@lists.linux.dev>; Sat,  4 Oct 2025 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759584496; cv=none; b=huR+H9LgRxOV6j6oFrXNsZyXmtee308E2NJDVFqjPJ9/yhOTFHT1H7yQC0IswjYgqnXHOxvmQd7qefdjO/KKqhzMjJdstB3f07qH3RI/xTcgunI+XxQdfbw/TWMk9joPzkdXJR18QDJMqLiQQ1TtCQgvCdjdb4lDhQSs5yhbhNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759584496; c=relaxed/simple;
	bh=DG417uOmbSeOEv11e+wf4CXIeOQy8X5vMNAmGfW5IYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQWh37Lvsfyct7iy71d/K2cyHEUm3siKtuMI+IvGXEWR4fiXsKDaX+h+k3T1n+OKBNzYSRQXZ7voqEfIa5OdZ9rkcSDuFGXarDnHrS+6PGfvjTqEFIypanZFzgNEIrbQpj2nkr4r//Sf5WGhqcAgpDeeBuF+o2sFdooi5EI3FNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A643C54CDA9;
	Sat,  4 Oct 2025 15:19:26 +0200 (CEST)
Date: Sat, 4 Oct 2025 15:19:25 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev,
	mlxsw@nvidia.com, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next 00/10] bridge: Allow keeping local FDB entries
 only on VLAN 0
Message-ID: <aOEe3XKr25GNGZpr@sellars>
References: <cover.1757004393.git.petrm@nvidia.com>
 <20250908192753.7bdb8d21@kernel.org>
 <3213449c-57bd-4243-ac8f-5c72071dfee5@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3213449c-57bd-4243-ac8f-5c72071dfee5@blackwall.org>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, Sep 09, 2025 at 12:07:43PM +0300, Nikolay Aleksandrov wrote:
> My 2c, it is ok to special case vlan 0 as it is illegal to use, so it can be used
> to match on "special" entries like this.

I'm probably missing some context, but why would VLAN 0 be illegal
to use? Isn't VLAN 0 used for untagged frames with priorities? A
priority tagged frame?

Regards, Linus
