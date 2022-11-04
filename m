Return-Path: <vladimir.oltean@nxp.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A6843418CF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0AC62418BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LT1/+dZKzYfztIxqlQ1kLxlfG7NwIKOnBvdUFXrDWo=;
 b=hzX5/x9zGgJ6g1ddKyZG3VzAQSWAheTr3qtLViLKpauAzRh1rZDBiVTD4wrySUYg3BCuQQTu8p4VRZOOvS1RGH7J4IyXhhCLEHlDBKJiKY8a27jdLcftakuG8HOTq3Hj0lZ50l//BGy6YcC+Mq7V5TiLL7V8vheuXO+u/s4UsZA=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Fri, 4 Nov 2022 13:11:05 +0000
Message-ID: <20221104131104.4qvnx5rarvsyrpe4@skbuf>
References: <20221101193922.2125323-1-idosch@nvidia.com>
 <20221101193922.2125323-1-idosch@nvidia.com>
 <20221101193922.2125323-2-idosch@nvidia.com>
 <20221101193922.2125323-2-idosch@nvidia.com>
 <20221103231838.fp5nh5g3kv7cz2d2@skbuf>
 <ce9f4095b216187c1dd5c14cdf4ae9cc@kapio-technology.com>
In-Reply-To: <ce9f4095b216187c1dd5c14cdf4ae9cc@kapio-technology.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DEEEE89226DE2F4DB60A9CF020EB9A10@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 1/2] bridge: Add MAC Authentication
 Bypass (MAB) support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@kapio-technology.com" <netdev@kapio-technology.com>
Cc: Ido Schimmel <idosch@nvidia.com>, "razor@blackwall.org" <razor@blackwall.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "roopa@nvidia.com" <roopa@nvidia.com>, "edumazet@google.com" <edumazet@google.com>, "mlxsw@nvidia.com" <mlxsw@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>

On Fri, Nov 04, 2022 at 12:23:07PM +0100, netdev@kapio-technology.com wrote=
:
> On 2022-11-04 00:18, Vladimir Oltean wrote:
> > > 3. Forwarding: Locked FDB entries forward traffic like regular entrie=
s.
> > >    If user space detects an unauthorized MAC behind a locked port and
> > >    wishes to prevent traffic with this MAC DA from reaching the host,=
 it
> > >    can do so using tc or a different mechanism.
> >=20
> > In other words, a user space MAB daemon has a lot of extra work to do.
> > I'm willing to bet it's going to cut 90% of those corners ;) anyway...
>=20
> I would like to know your (Vladimir) take on the approach of the
> implementation for the mv88e6xxx that I have made and which will also be
> the basis for how the WesterMo hostapd fork will be afaik...
>=20
> Is it in general a good idea to use TC filters for specific MACs instead
> of having the driver installing blocking entries, which I know the Marvel=
l
> XCat switchcore will also have (switchcore installed blockig entries)?

Well, the mv88e6xxx driver does not offload tc filters in general, so
let's keep that in mind.

Achieving the behavior of not forwarding traffic to a BR_FDB_LOCKED
entry can be done in a variety of ways using tc. Simplest would be to
put an "action drop" filter on the egress chain of the port where the
BR_FDB_LOCKED entry is located. Although that's probably least amenable
to offloading. I think "action drop" is more popular as an offload
action on ingress chains, which means you'd either have to (a) put an
"action drop" on the ingress chain of every other bridge port, or
(b) create a shared tc block and put all bridge ports in that. The
problem with (b) is that it doesn't play all that well with bridge ports
belonging to different hardware blocks.

All in all, I think the yet-to-be-introduced 'blackhole' FDB flag makes
the most sense for this behavior. Its scope is the entire bridge
forwarding domain by definition (no need to attach it as filter to the
egress or ingress block of one/multiple bridge ports), and it's also
easily offloadable.

I think it could make a lot of sense for the MAB daemon to do one of 2
things: replace the BR_FDB_LOCKED entry with a static/dynamic FDB entry
if it's going to authorize it, or with a blackhole entry on br0 if it's
going to deny it. So you wouldn't have to manually add the blackhole
entry from the mv88e6xxx driver; user space would do it.=
