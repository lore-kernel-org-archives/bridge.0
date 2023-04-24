Return-Path: <hans@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E15260FD5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 86FB660F08
From: Hans Schultz <netdev@kapio-technology.com>
In-Reply-To: <20230424122631.d7kwfwmlwvqjo3pz@skbuf>
References: <20230418155902.898627-1-vladimir.oltean@nxp.com>
 <875y9nt27g.fsf@kapio-technology.com>
 <20230424122631.d7kwfwmlwvqjo3pz@skbuf>
Date: Mon, 24 Apr 2023 17:37:07 +0200
Message-ID: <87h6t51ecc.fsf@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH v2 net] net: bridge: switchdev: don't notify
 FDB entries with "master dynamic"
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Ivan Vecera <ivecera@redhat.com>, bridge@lists.linux-foundation.org, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>

On Mon, Apr 24, 2023 at 15:26, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
>
> Obviously we have not reached the end of that plan, and net-next is closed now.

Seems to me that net-next is open. Maybe it will close soon.
