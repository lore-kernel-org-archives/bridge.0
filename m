Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6C615607EC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C6C1607AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKujan2IbH/dDqQkS1tM31TozdGPb8fajbOCPRIL1q4=;
 b=BiNzjnGL14vJE6QnbJ5LymQDSqNPZMIEwenj54sE2rgl8Z0H1w/7e4kMAR/bQ4oXq7cmeaDe3nkvDkOGjmUy80qHPJuknPKUKf+i2ci+w/6IbyGt0iYHi4CJ2Sm8Kg4GSj0zJ8PEv0VpLIKiwSl8ajH4RPhtHDoH8jbffesCgePzdaSgx1ovJD55W2HPcdaltHpwUGmbPhWl9VGHGuqM1PDp/jPUlFkrmutlGO9VMoz2Q4vkHJidZjjDk4LJV7vB8ujeiYfx/efTZww+phK0TFrq2T9zFoig+RKwxQ5+0iXUM3vxXPBusncg81bquthq/XTUiKVciau1+gMQ88NMWQ==
Date: Thu, 30 Jun 2022 14:37:56 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Yr2LFI1dx6Oc7QBo@shredder>
References: <20220630111634.610320-1-hans@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630111634.610320-1-hans@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v1 1/1] net: bridge: ensure that
 link-local traffic cannot unlock a locked port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <hans@kapio-technology.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Hans Schultz <schultz.hans+netdev@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 01:16:34PM +0200, Hans Schultz wrote:
> This patch is related to the patch set
> "Add support for locked bridge ports (for 802.1X)"
> Link: https://lore.kernel.org/netdev/20220223101650.1212814-1-schultz.hans+netdev@gmail.com/
> 
> This patch makes the locked port feature work with learning turned on,
> which is enabled with the command:
> 
> bridge link set dev DEV learning on
> 
> Without this patch, link local traffic (01:80:c2) like EAPOL packets will
> create a fdb entry when ingressing on a locked port with learning turned
> on, thus unintentionally opening up the port for traffic for the said MAC.
> 
> Some switchcore features like Mac-Auth and refreshing of FDB entries,
> require learning enables on some switchcores, f.ex. the mv88e6xxx family.
> Other features may apply too.
> 
> Since many switchcores trap or mirror various multicast packets to the
> CPU, link local traffic will unintentionally unlock the port for the
> SA mac in question unless prevented by this patch.

Why not just teach hostapd to do:

echo 1 > /sys/class/net/br0/bridge/no_linklocal_learn

?
