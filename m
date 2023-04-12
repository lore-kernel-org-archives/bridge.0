Return-Path: <vladimir.oltean@nxp.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF3CA4044F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1658840227
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJss1pujW8B+EqfyELKn/tjqPHKDdI33NPirliESpc8=;
 b=SO3qfNbLk+dN0CflObNaLiZm7yaZCUm4cj+sC7zAIIPA3vorNZACpti/T5315nmJyx2jbhX7+hQ9A4vimw97daYtZBPBD/haMKen0f1pq3j0KQpWZsalxsh/7DhhiLmYJsW5b5qFVrDH3wjSWm1+1GB68YPWpcwmBOvjXY7aCJU=
Date: Wed, 12 Apr 2023 20:04:37 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Message-ID: <20230412170437.26nwldbxydm7lgxm@skbuf>
References: <20230410204951.1359485-1-vladimir.oltean@nxp.com>
 <ZDa856x2rhzNrrXa@shredder> <20230412142733.6jhxt7kjf3nwqzsy@skbuf>
 <ZDbVgqV9JT7Ru96j@shredder> <20230412162407.xk3okeiedylv6sqp@skbuf>
 <ZDbhDUDs0RUWVZ4B@shredder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDbhDUDs0RUWVZ4B@shredder>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net] net: bridge: switchdev: don't notify FDB
 entries with "master dynamic"
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Ivan Vecera <ivecera@redhat.com>, bridge@lists.linux-foundation.org, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, Arkadi Sharshevsky <arkadis@mellanox.com>, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>, Eric Dumazet <edumazet@google.com>, "Hans J. Schultz" <netdev@kapio-technology.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Wed, Apr 12, 2023 at 07:49:17PM +0300, Ido Schimmel wrote:
> On Wed, Apr 12, 2023 at 07:24:07PM +0300, Vladimir Oltean wrote:
> > I'll send v2 with BR_FDB_ADDED_BY_EXT_LEARN not prevented from being
> > notified from switchdev.
> > 
> > Unless you have any objection, I won't send v2 like this:
> > 
> > 	if (test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags) &&
> > 	    !test_bit(BR_FDB_STATIC, &fdb->flags) &&
> > 	    !test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags))
> > 		return;
> > 
> > but like this:
> > 
> > 	/* Entries with just the BR_FDB_ADDED_BY_USER flag set were created
> > 	 * using 'bridge fdb add ... master dynamic'
> > 	 */
> > 	if (fdb->flags == BIT(BR_FDB_ADDED_BY_USER))
> > 		return;
> 
> LGTM. Please copy me on v2 and I will run it through regression. Will
> try to report results before tomorrow's PR.

Sorry, I won't send the v2 early; I need to think more about this and
I don't want to rush things. It's likely that the zero-day bug fix will
miss this week's PR.
