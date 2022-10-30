Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E70F480C0C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F4A680BD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ea2su9kifAvJKGZgu0DuQTwFiXnDPirrJJWIxqaH/U=;
 b=DIY77jURE7mWRPNlFIPYHgaR26dZGVeyzHfux+50+9ZvIIQdCRvX8KIPDA/aGe/rBlLVmgf/6STvqyXK2p9S/XmvEui6IzYuT0ZUAVtFHXyE63dg5qlFacjEkx7iwbJJuN7xX91IHMAN4tsGVQ0VxxJlR3sZYwWFiKRKqjWTJc1SZnZi5J0KSqXxkaKyNYaEhkQM+NIYrTBajWPnQs2pA0afkJlqEND3WRcd6XSEXuvfCD6UWzhXEIjLWR2k8NrkTEgFjuehixWHoPF17bA4/eFQPP+iQFCxBhZ0jRW3qjxGsi/wFsb6EJ7Yw5qUQZ1tSGq3ZSMumvMFDd5y1KWWqw==
Date: Sun, 30 Oct 2022 14:59:45 +0200
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y151QSN4sEbARPjN@shredder>
References: <20221025100024.1287157-1-idosch@nvidia.com>
 <20221025100024.1287157-2-idosch@nvidia.com>
 <20221027225832.2yg4ljivjymuj353@skbuf>
 <1a66212fdb43fb8d03fc1e4c7612ad1b@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a66212fdb43fb8d03fc1e4c7612ad1b@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [RFC PATCH net-next 01/16] bridge: Add MAC
 Authentication Bypass (MAB) support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@kapio-technology.com
Cc: petrm@nvidia.com, ivecera@redhat.com, Vladimir Oltean <vladimir.oltean@nxp.com>, razor@blackwall.org, bridge@lists.linux-foundation.org, roopa@nvidia.com, edumazet@google.com, mlxsw@nvidia.com, jiri@nvidia.com, netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On Fri, Oct 28, 2022 at 09:45:52AM +0200, netdev@kapio-technology.com wrote:
> On 2022-10-28 00:58, Vladimir Oltean wrote:
> 
> > I was going to ask if we should bother to add code to prohibit packets
> > from being forwarded to an FDB entry that was learned as LOCKED, since
> > that FDB entry is more of a "ghost" and not something fully committed?
> 
> I think that it is a security flaw if there is any forwarding to
> BR_FDB_LOCKED
> entries. I can imagine a host behind a locked port with no credentials,
> that gets a BR_FDB_LOCKED entry and has a friend on another non-locked port
> who can now communicate uni-directional to the host with the BR_FDB_LOCKED
> entry. It should not be too hard to create a scheme using UDP packets or
> other for that.

User space knows that the MAC is not authorized (otherwise it would have
cleared the "locked" flag) and can choose to mitigate this corner case
(or not) by shutting down the port, installing flower filters or doing
something else entirely. I think it is best to defer such policy
decisions to user space instead of overloading the "locked" flag with
more meaning which will likely result in more checks in the fast path
for a corner case of a use case that is quite obscure to begin with.
