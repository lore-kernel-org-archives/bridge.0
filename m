Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BbGAlf0EmAgXlRj+2JMlCkobYzhN57bh1dokSTQjOWs=;
 b=fM3jgWv5DnT+6qxziTK3Gafb23V5t7n+p+sS6PKhT8QpL5WGP6pQyoyOfHO6/EzmgN
 4KsyNYpY8aUwzmq6/30Sf/mTZLJq3Fyq7SvOloc4fM6H9Ny0a4wZx95jL8CQiUJOfojK
 zO/UPrFcSUDBX0sVWitdzrQP6mLcocW3U7BYJiVsZ6L80so3BrUp5lx2QPVFW0BsEP7T
 JwQoDSmEZPMNjtTvL6YHq9XcFtRt1Y+sTAWAJxPlxgqO5nPE5IVieworafUO41RSvMqr
 togJQxerUnwrXtqEEg/iu9Ea38eo+oFP20XDYKRwNc4NhaRpHRkcjuX21XPmexWpUFG2
 brJQ==
Date: Fri, 18 Mar 2022 15:19:43 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220318131943.hc7z52beztqlzwfq@skbuf>
References: <86lex9hsg0.fsf@gmail.com> <YjNDgnrYaYfviNTi@lunn.ch>
 <20220317153625.2ld5zgtuhoxbcgvo@skbuf> <86ilscr2a4.fsf@gmail.com>
 <20220317161808.psftauoz5iaecduy@skbuf> <8635jg5xe5.fsf@gmail.com>
 <20220317172013.rhjvknre5w7mfmlo@skbuf> <86tubvk24r.fsf@gmail.com>
 <20220318121400.sdc4guu5m4auwoej@skbuf> <86pmmjieyl.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86pmmjieyl.fsf@gmail.com>
Subject: Re: [Bridge] [PATCH net-next 3/3] net: dsa: mv88e6xxx: mac-auth/MAB
 implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, davem@davemloft.net

On Fri, Mar 18, 2022 at 02:10:26PM +0100, Hans Schultz wrote:
> In the offloaded case there is no difference between static and dynamic
> flags, which I see as a general issue. (The resulting ATU entry is static
> in either case.)

It _is_ a problem. We had the same problem with the is_local bit.
Independently of this series, you can add the dynamic bit to struct
switchdev_notifier_fdb_info and make drivers reject it.

> These FDB entries are removed when link goes down (soft or hard). The
> zero DPV entries that the new code introduces age out after 5 minutes,
> while the locked flagged FDB entries are removed by link down (thus the
> FDB and the ATU are not in sync in this case).

Ok, so don't let them disappear from hardware, refresh them from the
driver, since user space and the bridge driver expect that they are
still there.
