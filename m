Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 82C5281331
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B71ED81329
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LikPI4qJ7Br1MN8Tnf7BmohotzDbh1kjQvCKDEv7DNY=;
 b=tq9BPVBYfDO1DVTsbhh9U2LXUHmt6fD7gSALe9+kjdSDGjmdsTMfeRdwqRyO9Lji3l3KO4oJTe9nMz8+idi/s589CXU/giT4vmXJwXSoSdTpOLFy0y1Ic6K/iO8bYIe1/q6M4LygYi/eOwBR9Ct/Fn1Ev7r44mHLhATawHfowT1VMLR9VzgzE0Rj4iC8H/UjW5KY+/XMlcfZ/9Bguxe66fpFEd5wst+vVTG8JZ153h/GzOPSMK6nL0KoTZQgFDY7JYwqi9RrHica0NT4saV1FAvRyWNmjsL8+3ZsiXbSSZe/2yMO2IY0lLYRMi5CJBb9vBbMOivZmc1wiVhR67aStA==
Date: Tue, 6 Dec 2022 11:58:09 +0200
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y48SMdAuQx5OK7Id@shredder>
References: <20221205074251.4049275-1-idosch@nvidia.com>
 <73405dec-e1ec-e581-ba8e-83bb8343d2b0@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73405dec-e1ec-e581-ba8e-83bb8343d2b0@blackwall.org>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 0/8] bridge: mcast: Preparations for
 EVPN extensions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, edumazet@google.com, mlxsw@nvidia.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On Mon, Dec 05, 2022 at 01:55:05PM +0200, Nikolay Aleksandrov wrote:
> One thought (not a big deal) but it would've been ideal if we could initialize the config
> struct once when parsing and then pass it around as a const argument. I know that its
> arguments are currently passed to functions that don't expect const, but I *think* it
> could be a small change.

OK, I've made the change. It was quite painful to rebase my next
patchset on top of it, but it's done now :)

As a result of this change, I've appended one small patch to v2 of this
patchset. It is constifying the 'group' argument of
br_multicast_new_port_group(). It is a dependency of the next patchset
which is already close to the limit in terms of size (most patches are
small).

Thanks!
