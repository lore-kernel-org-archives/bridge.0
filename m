Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 552CA84056
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 33FBB83FF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqIbGP6mp/ZxQk4giRd1XBT/jy3pHfCXDuDgWYQGelA=;
 b=bZ9q5saUMvEjxT8Za0JVYHL3SOsjMoWEYhVG64sW9G/fhX8Wdzl4X0wmxlBEgVj5mCqTKBuLWYQRbT82e/Z2rnzK+7e+eumDNPCECLH+DwYOi1+WDHYy2z+7yDnKmXj5H3FavtLWfIi12Uu+bNeuZTrdQN/O+QqItEZ7SSRyBpp/fXgmSlldEkdgCWH2mrHCiv7bmVWb0ABdJv+HUlfzNcQYyn4TTHmOY1gYAPXKHtBEDD4FZPyMsZX+Be7L0J2Mr0vwhT1r1HA9MVM3xrM8jB7VRFE6wE4NwxREnyNZApYS4IjykYXCZux8/+EiyeJBj2mVK05USkgI0TKe3B4MkA==
Date: Wed, 19 Apr 2023 16:59:54 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <ZD/z2vI5ab0zPdRf@shredder>
References: <20230413095830.2182382-1-idosch@nvidia.com>
 <95a773f6-5f88-712e-c494-9414d7090144@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95a773f6-5f88-712e-c494-9414d7090144@blackwall.org>
MIME-Version: 1.0
Subject: Re: [Bridge] [RFC PATCH net-next 0/9] bridge: Add per-{Port,
 VLAN} neighbor suppression
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: petrm@nvidia.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, edumazet@google.com, mlxsw@nvidia.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On Wed, Apr 19, 2023 at 03:30:07PM +0300, Nikolay Aleksandrov wrote:
> For the set:
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

Thanks! Will rebase, retest and submit v1
