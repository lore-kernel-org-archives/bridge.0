Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 92F3C83B75
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7C17683B59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIlbLkQ0bN/EkR4QcY14tF5YOM8MTvJ9RBCgar+lCt0=;
 b=kMCivOhJ/He4Qz7kfnUXRxMlmPf+ozpBJ3Ch7/KnNBQ1LWJsr8CcjozxXxmVRd/dhWQ9rewPWp2Y8Lc32888hJ7yx5PAJPc0/0rYiwz0QEdat4LR0Gq7wwbKUGNAy1MfzEfOmFsfs9IB+92WXCMuHEXRSGaPYii2+AHz0pr5dJJznVVVUNIm3h+gyz9/5dD0Hkfo6swEayKvEerSxCSzOM7mhdbvNZEOpuU0q04mJdW6XmLSWoXZQZ6kpNLsSJE9GVl9nvRy0lzEWHXpxBc/z/pgDfjWazt495Kn9O9Y/gYp4T+24Zq8uWwlu+el5yqUv8bc/4DRYX5OOQ8SZQzFEA==
Date: Wed, 12 Apr 2023 19:00:02 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <ZDbVgqV9JT7Ru96j@shredder>
References: <20230410204951.1359485-1-vladimir.oltean@nxp.com>
 <ZDa856x2rhzNrrXa@shredder> <20230412142733.6jhxt7kjf3nwqzsy@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412142733.6jhxt7kjf3nwqzsy@skbuf>
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

On Wed, Apr 12, 2023 at 05:27:33PM +0300, Vladimir Oltean wrote:
> How are extern_learn FDB entries processed by spectrum's
> SWITCHDEV_FDB_ADD_TO_DEVICE handler?

No different than "BR_FDB_STATIC", which is a bug I'm aware of and
intend to fix in net-next when I get the time (together with all the
other combinations enabled by the bridge). Entry has ageing disabled,
but can roam in which case it becomes age-able.

TBH, I think most devices don't handle "BR_FDB_STATIC" correctly. In the
Linux bridge, "BR_FDB_STATIC" only means ageing disabled. The entry can
still roam, but remains "static". I believe that in most devices out
there "static" means no roaming and no ageing which is equivalent to
"BR_FDB_STATIC | BR_FDB_STICKY". Mentioned in your commit message as
well: "As for the hardware FDB entry, that's static, it doesn't move
when the station roams."

As it stands, the situation is far from perfect, but the patch doesn't
solve a regression (always broken) and will introduce one. My suggestion
allows you to move forward and solve the "dynamic" case, so let's
proceed with that unless there's a better alternative.
