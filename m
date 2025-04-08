Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E4722E40E
	for <bridge@lists.linux.dev>; Tue,  8 Apr 2025 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744130446; cv=none; b=hRrjVlKGEAmooQ/JgFTE4EslLSyrZTDMNm0x3rXsxMsj0u1la+8SqwePKtYQN/FDv8+0UVbFwpi6EitKn1dH8ZW3hr69dhG0mcWreWXMdlA308WSgbLXH9xwmZFDl7jnEWWUk4BTC3IASyvZCvMt4lp7nHb0ZMdgqt6SmWqBmSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744130446; c=relaxed/simple;
	bh=I8vlLpjHcKixlNnee9qQYRSKIq0vzo3OM9ZYXwQvMo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pb8wbeAAyeO/P9KmdrbKO/Drpt49e7l1ExsRAs7cWejMoxoRhaP52iBrcis8jezJDsCPKgDQSUHHrpkhfTYF7K0uf0igqnV+IicENpD5N1ku/FEorGnnH0YlzcOfwLN60RT6AENMtP94PSvQeTLxVzFzeLejl7liMlHawvTTzM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=Vo31pSTX; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=f3vPUZfS; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="Vo31pSTX";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="f3vPUZfS"
Received: by mail.netfilter.org (Postfix, from userid 109)
	id BD980603C6; Tue,  8 Apr 2025 18:40:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1744130442;
	bh=E6bo8R1g3j8fQftb7Htfmeaods5Ry60+30dXgh8MLco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vo31pSTXy3pgm+85NdiLgdhN1rRVO5m+zfzC9Jrrg8c3y8eBi8MjnfICCGQpYALgD
	 FyGk0UKAaptnfC5PyzROSN6/SZfVhF24W+N1gooBJ+zWFJu6ANcqP9t6/bVJZgK7ME
	 0Nuc4HCYOoa+T14Il2AL5trIZ40oYaQaC4Izt9gUYsRoUTwkLV++1dfzHirMpkZHFy
	 9qWtRjwL/guZvEYJvoh907w4Fz+i3R9WO5MMJlIy9HHZdtQ1XGS/JPMYuCexO+7am4
	 rIi6xvTgMlffxiX9v4FvIYfukaejaYj+MjSy1oKRB5JYeUgzyW0HcqBBsOOR+jOjqk
	 e/spXBLH1hNnQ==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 96862603AC;
	Tue,  8 Apr 2025 18:40:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1744130440;
	bh=E6bo8R1g3j8fQftb7Htfmeaods5Ry60+30dXgh8MLco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3vPUZfSQv+MMCu/Ce5THBljmzldxHs9c1xRZyAQVWIl2hG9Mq3Jv1uY+ZNPrVyQX
	 LVhJsAz/pFMfqitWf5QIFKfMvUGZWfUxcD30shPH/i0/a+tMYKp1KyCy3RSbIHI4xt
	 dI55GfI1NUF1+eDJHbmhBy+3aI5jv5QmPyqRjHtVPPlo8P4Y3bA2bEPF0n6NyXbK6F
	 qaAJOonklSXM9Yzgyz266k9rhHQE1jUumme/DXggXFtTdJflTi0YpjO5+CEYkZTpbX
	 +mt3r4QqnpkNp84lUxuo09LK5PWfmEVeA0g3Q5jEYcj/puWCEz6/E0NOLmhv4V/dsX
	 Nigc4gJ9h5U2w==
Date: Tue, 8 Apr 2025 18:40:38 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v11 nf-next 1/2] netfilter: bridge: Add conntrack double
 vlan and pppoe
Message-ID: <Z_VRhgHY4KEgbg92@calendula>
References: <20250408142619.95619-1-ericwouds@gmail.com>
 <20250408142619.95619-2-ericwouds@gmail.com>
 <20250408163931.GA11581@breakpoint.cc>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250408163931.GA11581@breakpoint.cc>

On Tue, Apr 08, 2025 at 06:39:31PM +0200, Florian Westphal wrote:
> Eric Woudstra <ericwouds@gmail.com> wrote:
> > This adds the capability to conntrack 802.1ad, QinQ, PPPoE and PPPoE-in-Q
> > packets that are passing a bridge.
> 
> Conntrack is l2 agnostic, so this either requires distinct
> ip addresses in the vlans/pppoe tunneled traffic or users
> need to configure connection tracking zones manually to
> ensure there are no collisions or traffic merges (i.e.,
> packet x from PPPoE won't be merged with frag from a vlan).

There are conntrack zones.
