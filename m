Return-Path: <kuba@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3B16381DFE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 70CE081DFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1676347893;
 bh=llJZR7pK98/emAvHoO6xCRuI8lj7T3XJRXFwIvfYO9Y=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=W0QU6Meho9pQJ8b8exCiXRy6k20TLCCCZOT3xwU1SC/WBE2Dy8+ZNJz0EG0w3FvAr
 d/p71BdHJBcsl+V14RK0zxshK4SNWDjPM7SnA2C5c7XfFWOe5hKeoWyd8Qzua+Ui9+
 1fGH1WVRkOZ1K5uPR9fXyUBI9D4zyU+goEdGC35VYv52KT+kYNCklVav6JpVGsJUXU
 c6Xj0nd9/yqVgkkVgODVfcj0SGBwPOosODiy9rMM4VMdQRHfQJbvQIhcOClxfkpOY3
 ACkguakfAMrFsgqo+ijiyNbCHl9bLMVbMovPnaIH7oooT9VUaciW/dX4zL57aTeP1o
 iE82zjFxCJWng==
Date: Mon, 13 Feb 2023 20:11:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20230213201131.7ed238f9@kernel.org>
In-Reply-To: <20230211-kobj_type-net-v1-0-e3bdaa5d8a78@weissschuh.net>
References: <20230211-kobj_type-net-v1-0-e3bdaa5d8a78@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH 0/3] net: make kobj_type structures constant
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Trond Myklebust <trond.myklebust@hammerspace.com>

On Sat, 11 Feb 2023 03:32:28 +0000 Thomas Wei=C3=9Fschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
>=20
> Take advantage of this to constify the structure definitions to prevent
> modification at runtime.

Could you resend just the first two with [PATCH net-next] in the
subject? Patch 3 needs to go to a different tree.
