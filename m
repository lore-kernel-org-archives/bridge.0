Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEBE3F484F;
	Fri,  5 Jun 2026 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670667; cv=none; b=OX66Y8xf98ZQkwc5lBTGq9TzoBI2QuWi/q0rbv/Lq4f1WgeZ7Lca6NRAX/mZUrfRjwaQyB4UwBLNLJcagmXAWETgezWFz1zwFA21bLc3dd2QCQMgaqyN45I7dwLkPpCNtsJExFCyln0KnnLTnfc4v3/6+sv0qrpXI349QWrLQl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670667; c=relaxed/simple;
	bh=LLk8lAmCSxgIzY9HoplppWLM8UXBZjCgLxPFWBKuVHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piQG9KzlyUZ9FdRulayvS+utVcjmBHwA34Geuea68FRhxb8yE+c4IF32TTICNZ4ZclykbNr5j4l2VepVLYi27dmgGiffxLU2cF90MZguoJm8cB83jkvVfO3oNnM9ti4yXeJ9l1gclFqLHcKZWE8+dX815br7bbq5pzYwLXmMx90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qrrbZZkI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qrrbZZkI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fWHx7+MVsgzwFnsle7wi9uaks6IqoR68tVaYykBpZqY=; b=qrrbZZkIw1cUqdPOjnuUFYjWxO
	zFxfADIZ7HOvb2D9LMoYPmpXGP3W6IoeiIeNo0OOgkeXMMFgDHEbfLyXDAapOyr7NuZGxV3z2EKCg
	nJI5vRe4NpWZxadtqZJLlOtzV+EsO1r9thI7DzruRQI603A40et0F9mDKxvcc1B/ZVQo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVVmL-006FK0-6g; Fri, 05 Jun 2026 16:44:09 +0200
Date: Fri, 5 Jun 2026 16:44:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Cedric Jehasse <cedric.jehasse@gmail.com>
Cc: Luke Howard <lukeh@padl.com>, Nikolay Aleksandrov <razor@blackwall.org>,
	Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org, Max Hunter <max@huntershome.org>,
	Kieran Tyrrell <kieran@sienda.com>
Subject: Re: [PATCH net-next v2 3/6] net: bridge: add 802.1Qat stream
 reservation admission control
Message-ID: <d0e650fb-4011-4d64-9780-a0ddd0ca1cf3@lunn.ch>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-3-72be14522e7c@padl.com>
 <537410c3-ff4e-43fd-834e-775cd1bbe89e@blackwall.org>
 <E1253C6D-F6F0-407A-AABF-FCAB57100A1C@padl.com>
 <n2pi7h5nvxg3xvshtcxqeizpukp6hphqa7kodbe7b3ioc3kcq5@n34fgocvaicm>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2pi7h5nvxg3xvshtcxqeizpukp6hphqa7kodbe7b3ioc3kcq5@n34fgocvaicm>

> The issue here is the Marvell switch has an implementation where we need to
> know if an entry is a Dynamic Reservation Entry. But the linux bridge has a
> simplified version of the FDB described in 802.1Q.
> By adding a way to distinguish between the type of FDB entries, it's possible
> to program a Marvell which has this distinction between Dynamic Reservation
> Entries (or AVB entries) and other entries.

So it sounds like you first need to work on the software
implementation and expand the simplified version with the features you
need. You can then add support to accelerate this by offloading it to
the hardware.

    Andrew
