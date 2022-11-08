Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA189605AE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A367560D8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FpLiGaXhotQZ8b2nqHMo2ysie9FYsoam/Xs2nB2FQwI=;
 b=DSqKxORe+HHRIvWQTmqEOWX7uJ+Bog3bxbKTF2CX1y3k0sLtXjrT49HSo8EnDml9yz
 Cql1c9yQozM1lmZCl9QgxvGYpEk43cOuUi7piWpWCKc7VjEEBUZa9ooamxw2bD0xYtE8
 jSnU+wg3G58OTskD78IJllcxnpQmVJ9Z0F5cAHnOrNUFly4Y4X6OlhUzgeZJ4HHZcaiS
 Ea5TNEcVOHU/al1AS96Gqy3pQwPK88njNFhLLFmQIo/XYcD7CHAhH7kyJZPtxJlllvRn
 9GeoY4dr7BOfM4EXDHpQt/lJZ5mPdWI6uRSHfqg/5F6dDwZCfExSBMCB+/uUBDQzWWjk
 Zzug==
Date: Tue, 8 Nov 2022 17:30:06 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221108153006.githtup7oisty4qb@skbuf>
References: <cover.1667902754.git.petrm@nvidia.com>
 <cover.1667902754.git.petrm@nvidia.com>
 <61b030c0932726657eff1ac545d1904a2ee930ea.1667902754.git.petrm@nvidia.com>
 <61b030c0932726657eff1ac545d1904a2ee930ea.1667902754.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61b030c0932726657eff1ac545d1904a2ee930ea.1667902754.git.petrm@nvidia.com>
 <61b030c0932726657eff1ac545d1904a2ee930ea.1667902754.git.petrm@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next 14/15] selftests: mlxsw: Add a test
 for locked port trap
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@nvidia.com>
Cc: Ivan Vecera <ivecera@redhat.com>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, Jiri Pirko <jiri@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, "Hans J . Schultz" <netdev@kapio-technology.com>, Eric Dumazet <edumazet@google.com>, mlxsw@nvidia.com, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Tue, Nov 08, 2022 at 11:47:20AM +0100, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Test that packets received via a locked bridge port whose {SMAC, VID}
> does not appear in the bridge's FDB or appears with a different port,
> trigger the "locked_port" packet trap.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---

Pretty impressively designed. I liked the extensive checks (for example
that traps stop counting after port security is disabled).

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
