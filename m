Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.245.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793472616;
	b=SCOZk/c6I8TXip2ZoEA+I2/5tNoVSXISwYu1SMWs4eErZ6WAPLPnM5TkfRtNN7ljKcnh
	 Vfy7I5SlyGkhsuH7K7/u8j5n1BFCJnZFvOWVlQx3tzAy3HDQGnqEGj1sPhPgEQqOUfkKG
	 LtcRJptO+UHVn0dkXr1y7WQbx3vreLC49YkBfCLaCTFqVU3PN4gTSPUdgguntyzWLkVRJ
	 DfzvpOIDhC//B6/z1Lvxt7CzKnPqcExoxbEehRzJrmtKJzrp4fJ0FEr0nDKBvAUSWK3yk
	 22xOC0mXnn8kiBtWZ1M+oc2FO6YAO+xI7VaiwZ20/h0eVrqwGRqbKPr65S1qvRNBscg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793472616;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mxsr/9eM9IT7x56XlFJqaM4VoKdjWeJUE5kFLUzsU1c=;
	b=ufk/VXs6d/so8oD1fklcvq26GINZO5WcimM+VVQF0tf3dT/a4DvYePvlERJiGuuYfnER
	 UAEmq5e4ZNF1ROq6rgJPe2HwX7ZlJRan0zzCaSgjdK2m5vzTSw9TQ8ucRaAmfJXrecl0E
	 AUKnlMMwkJX6Tk/EqbTkVvY0KxFwjvZYNb/0eAHE5g4rgnShTQj78T9l+mboi5w5i7xt8
	 szBFBpW4b258YXliauyQGPZQNB7qqyWh+YK5Fj7VDeHI140dJAeiHg6arlk5kLJsh25we
	 d/opy5TJDZo87qkAM06HXSfQ65gnFXZrXmjE+OUSb0FI4U2aulrAobY6wcy/v9DasMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=strlen.de;
	spf=pass smtp.mailfrom=strlen.de;
	arc=none smtp.remote-ip=91.216.245.30
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B266606A31A
	for <bridge@lists.linux.dev>; Sat, 31 Oct 2026 18:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B266606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id DE3DA60796; Sat, 31 Oct 2026 19:50:12 +0100 (CET)
Date: Sat, 31 Oct 2026 19:50:12 +0100
From: Florian Westphal <fw@strlen.de>
To: Kyle Zeng <kylebot@openai.com>
Cc: netfilter-devel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>, coreteam@netfilter.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, outbounddisclosures@openai.com
Subject: Re: [PATCH] netfilter: br_netfilter: reject unsafe neighbour devices
 for DNAT
Message-ID: <auY4ZAZWQfQtX3oe@strlen.de>
References: <20261030042155.73844-1-kylebot@openai.com>
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
In-Reply-To: <20261030042155.73844-1-kylebot@openai.com>

Kyle Zeng <kylebot@openai.com> wrote:
> The IPv4 and IPv6 bridge prerouting callbacks classify DNAT traffic using
> the logical input device saved in skb->dev. The physical input port can
> have a different bridge master when prerouting resumes, for example after
> an NFQUEUE verdict. Netfilter reassembly can also combine the first
> fragment's bridge information with a different fragment's input device.
> 
> br_nf_pre_routing_finish_bridge() replaces skb->dev with the port's
> current bridge master, but looks up the neighbour using the existing
> route. This can put an skb with skb->dev pointing to bridge B on an
> unresolved neighbour of bridge A. Deleting B and resolving the neighbour
> on A then causes a use-after-free in __dev_queue_xmit().
> 
> Before calling the neighbour output method, check that the neighbour
> keeps skb->dev alive. A neighbour holds its device, and a VLAN device
> also holds its real device, so allow a VLAN whose real device is the
> bridge. Release the neighbour and drop the skb on a mismatch.
> 
> Doing this in the shared continuation covers both protocol families,
> including a queue in the remaining bridge prerouting hooks. Leave the
> cached-header path unchanged since it does not enqueue the skb.
> 
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
> I have a reproducer for this issue and can share via DM

Please do.  I'd like to understand if that needs to be addressed
from nfqueue side instead, or if we can avoid neigh layer to
begin with.
