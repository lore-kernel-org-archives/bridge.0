Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8563B27EA;
	Sun, 27 Sep 2026 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790526657; cv=none; b=jSE8JD24VsHE49cwHi7/oE8HRboq4fqrmimWMJTFWoabQD8HYJAQNizyYGTghlg5v2XZPvPG/L0YtV204BPukZNlag+pxNpe5CjeyD/Rk4Cu/zbf/D945Kk1A90vOioZxmnqufxuvaT50EeXoGQPNCOfNuQnBM+hXgOq1JtOIys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790526657; c=relaxed/simple;
	bh=cz219Ueq6Jevfex7jh3M5pkgbuS9YfxgWT+/6fGTzFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k302jYNjUO+116AwCrdNAw1rd9MZw0eAyPz1Ej3HlRkX/qJC7gcoJTK1Knw7fcoCwcJSx37Kxczw3snvjPH1YpQLQHsMnig8S1G/EuXI4f+TzcdYAZYHclE1azIcGqHk4g8DP0Dcqfw8bufpv6kh++qEBfkNgY5Fh29Z1S6gaiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VdpUEwc1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VdpUEwc1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SqnfWlcUIbsU5xlr2zjxeGqUi1yl8oUH2J4t/jjj8ec=; b=VdpUEwc1v8u0oxVYV2LXo+Ijow
	emJ2DDzl9cw4wUrEaKXGUBqdJeOnNAqVRZ5BNhWVX6NxLvjH+MeX8rF4H2R2OB6+qqZPmSYDyTJgP
	ANxq9324QsSTH2LXhnuH/JhPLZW3s3RzMwG6VRr7i63UCHXOKQXLfcC+RVCBTDhfSWR0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xArm7-007XfC-2h; Sun, 27 Sep 2026 18:30:51 +0200
Date: Sun, 27 Sep 2026 18:30:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ren Wei <weir@nebusec.ai>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org, razor@blackwall.org,
	idosch@nvidia.com, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	vega@nebusec.ai, petalzu987@gmail.com
Subject: Re: [PATCH net 0/1] net: bridge: avoid recursive multicast cleanup
Message-ID: <156c41b1-fc86-4ecf-8181-461944734be9@lunn.ch>
References: <cover.1790323012.git.petalzu987@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1790323012.git.petalzu987@gmail.com>

On Sun, Sep 27, 2026 at 01:04:38AM +0800, Ren Wei wrote:
> From: Zixuan Chai <petalzu987@gmail.com>
> 
> Hi Linux kernel maintainers,
> 
> We found and validated an issue in net/bridge/br_multicast.c. The bug is
> reachable by a non-root user via user and network namespaces. We've tested
> it, and it should not affect any other bridge multicast functionality.
> 
> This bug is tracked at: https://bugtracker.nebusec.ai/f/4342
> 
> We will provide detailed information about the bug in this email, along
> with a PoC to trigger it.
> 
> ---- details below ----
> 
> Bug details:
> 
> When an EXCLUDE (*,G) port is deleted, br_multicast_star_g_handle_mode()
> removes its corresponding temporary STAR_EXCL (S,G) port. For an (S,G)
> entry, br_multicast_del_pg() then calls
> br_multicast_sg_del_exclude_ports() to remove the remaining automatically
> added ports. That helper also calls br_multicast_del_pg() for each port,
> which re-enters the same cleanup and adds another stack frame per port.
> With enough ports, the task hits the kernel stack guard page.

What is the value of "enough"?

We get lots of bug reports for theoretical issues which in practice
will never happen. And we get some reports for real issues which can
happen. You are more likely to get your reported looked at if you make
it clear the issues really can happen, give todays systems.

> The PoC uses unshare -Urn, creates 256 temporary EXCLUDE ports and a
> permanent INCLUDE source entry with IGMPv3 enabled, then deletes one
> EXCLUDE port.

So a hardware switch with 256 ports is on the high side, but this
could happen in an SDN setup.

      Andrew
