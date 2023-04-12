Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EB38E60BA2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 10DDC60B7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLXSBSLsetB2YF3He7oC8MV6s4/DAZJyzaY3E+Qx+Xk=;
 b=oq2oGS/kyAdoGQQm2BXSfMRl8rEnWlZrziT8HQXCq2giI0bc25eCiwyWr9OQMH4bjsy8HOnvfc7VIgKSNUg8MKPoyaVC7c0SkLIjlpyKprRyU+v4e/GXsEuua0OGDmDhkYFetEPX67f4WmyTRDuZ9yc8XeF7bOEN1Gi1Ia+GlFcgb6v39JFI4KDOfUpx8K5YErF7KIHBxBdqhkA3secsnh8TDlVKEumap4hJXOA4lawwXJbIshYZA1G+9eVf3xbUf8a5Uc7kVR4qo8vcSK2VuYJIzkax2+LosJCo6c8r3B2hlFjXZKJ37phHyP0qCY8RrVnVavxbN1Sp1Fbz85627A==
Date: Wed, 12 Apr 2023 19:49:17 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <ZDbhDUDs0RUWVZ4B@shredder>
References: <20230410204951.1359485-1-vladimir.oltean@nxp.com>
 <ZDa856x2rhzNrrXa@shredder> <20230412142733.6jhxt7kjf3nwqzsy@skbuf>
 <ZDbVgqV9JT7Ru96j@shredder> <20230412162407.xk3okeiedylv6sqp@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412162407.xk3okeiedylv6sqp@skbuf>
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
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Ivan Vecera <ivecera@redhat.com>, bridge@lists.linux-foundation.org, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, Arkadi Sharshevsky <arkadis@mellanox.com>, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>, Eric Dumazet <edumazet@google.com>, "Hans J. Schultz" <netdev@kapio-technology.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Wed, Apr 12, 2023 at 07:24:07PM +0300, Vladimir Oltean wrote:
> I'll send v2 with BR_FDB_ADDED_BY_EXT_LEARN not prevented from being
> notified from switchdev.
> 
> Unless you have any objection, I won't send v2 like this:
> 
> 	if (test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags) &&
> 	    !test_bit(BR_FDB_STATIC, &fdb->flags) &&
> 	    !test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags))
> 		return;
> 
> but like this:
> 
> 	/* Entries with just the BR_FDB_ADDED_BY_USER flag set were created
> 	 * using 'bridge fdb add ... master dynamic'
> 	 */
> 	if (fdb->flags == BIT(BR_FDB_ADDED_BY_USER))
> 		return;

LGTM. Please copy me on v2 and I will run it through regression. Will
try to report results before tomorrow's PR.

Thanks!
