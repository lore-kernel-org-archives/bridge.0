Return-Path: <vladimir.oltean@nxp.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A4FC611B5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CA8CB61186
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4U6qoEfxleUCxl/RZqErz7yrOeHCXjEJoAV2m75F6g=;
 b=MZvMy8DiBNbBRZDOKv++EempcPvp3DnDXG9oFhodc/b1acyTx2V1+qOl7LXAl4NtAk3DOzjWU8enFFNOHX4sDf0taAWdXLyLcTZeDTg/Etrs5dfY2oo4HEjCjoI2T3N5hjsOFF4yE40Y24aDP0xO//80hnIko1Lfg2nAw2zMI84=
Date: Wed, 12 Apr 2023 19:24:07 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Message-ID: <20230412162407.xk3okeiedylv6sqp@skbuf>
References: <20230410204951.1359485-1-vladimir.oltean@nxp.com>
 <ZDa856x2rhzNrrXa@shredder> <20230412142733.6jhxt7kjf3nwqzsy@skbuf>
 <ZDbVgqV9JT7Ru96j@shredder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDbVgqV9JT7Ru96j@shredder>
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

On Wed, Apr 12, 2023 at 07:00:02PM +0300, Ido Schimmel wrote:
> On Wed, Apr 12, 2023 at 05:27:33PM +0300, Vladimir Oltean wrote:
> > How are extern_learn FDB entries processed by spectrum's
> > SWITCHDEV_FDB_ADD_TO_DEVICE handler?
> 
> No different than "BR_FDB_STATIC", which is a bug I'm aware of and
> intend to fix in net-next when I get the time (together with all the
> other combinations enabled by the bridge). Entry has ageing disabled,
> but can roam in which case it becomes age-able.
> 
> TBH, I think most devices don't handle "BR_FDB_STATIC" correctly. In the
> Linux bridge, "BR_FDB_STATIC" only means ageing disabled. The entry can
> still roam, but remains "static". I believe that in most devices out
> there "static" means no roaming and no ageing which is equivalent to
> "BR_FDB_STATIC | BR_FDB_STICKY". Mentioned in your commit message as
> well: "As for the hardware FDB entry, that's static, it doesn't move
> when the station roams."
> 
> As it stands, the situation is far from perfect, but the patch doesn't
> solve a regression (always broken) and will introduce one. My suggestion
> allows you to move forward and solve the "dynamic" case, so let's
> proceed with that unless there's a better alternative.

I'm not trying to accuse anybody, I just wanted to make sure I'm not
missing something (and surprise, I was).

The comment regarding BR_FDB_STATIC vs BR_FDB_STATIC | BR_FDB_STICKY
is interesting. This whole "hey, did you know you were never using the
bridge fdb flags correctly?" is starting to become a bit of a meme.

I'll send v2 with BR_FDB_ADDED_BY_EXT_LEARN not prevented from being
notified from switchdev.

Unless you have any objection, I won't send v2 like this:

	if (test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags) &&
	    !test_bit(BR_FDB_STATIC, &fdb->flags) &&
	    !test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags))
		return;

but like this:

	/* Entries with just the BR_FDB_ADDED_BY_USER flag set were created
	 * using 'bridge fdb add ... master dynamic'
	 */
	if (fdb->flags == BIT(BR_FDB_ADDED_BY_USER))
		return;

Thanks for the review and for pointing out the regression early.
