Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-sender
	:x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=mpWXZ6H51Bs9L9tJt5
	BlNtu7gnESQdydYxe9CgludT0=; b=n5SQUU7SC+SpYwLJduJoBE00XM+hyP9Ynw
	dTx5cvsf/ZLuJ4V96WDmJtn1ukWJ/vLq96brL9KEglQpyKyDf+cEy+Bb0IblaUun
	aaPGhMMGD7Is+Foxt5FLwcXVNj+103LNV6glXGgQqXrzzXiyq0BhlT4z0deXZMVi
	2w3x4CubAFjYmAaj7mFhgOx/M5RcXarzui89PAXYvuAj08oUV4NDrQzHG+nTIM2r
	/5dhjiuKBjtx+t8r/W5mzM0jAaeuIsprkwoYI5r3zVGcyLySNIFQZpSJjT5jXAVF
	zAFA5sGmM83E1qLxTJnmGiRmqIVFkpf3r7teJs33fGPKGoYI6RCg==
Date: Thu, 23 Mar 2017 21:47:57 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20170323194757.GB25688@splinter.mtl.com>
References: <1490264833-28867-1-git-send-email-nikolay@cumulusnetworks.com>
	<1490264833-28867-3-git-send-email-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490264833-28867-3-git-send-email-nikolay@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net-next 2/2] net: bridge: allow to add
 externally learned entries from user-space
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: jiri@resnulli.us, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, idosch@mellanox.com, davem@davemloft.net

On Thu, Mar 23, 2017 at 12:27:13PM +0200, Nikolay Aleksandrov wrote:
> The NTF_EXT_LEARNED flag was added for switchdev and externally learned
> entries, but it can also be used for entries learned via a software
> in user-space which requires dynamic entries that do not expire.
> One such case that we have is with quagga and evpn which need dynamic
> entries but also require to age them themselves.
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
