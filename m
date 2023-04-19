Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2155B40608
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BD85A4049A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfvsBaIqWwoqOvoXo00aYLq0SVQd4NSeURZBvjDErCc=;
 b=gGKDHrt49O5Jxk0akclaptH306cBEtbWKExwC7ju5XEn8cF6zVojgXRV7Dck0SR6RyNtuXqAHvJKehDSaSNaanBImpZw8teAfrhVj5ORD0Pjl2cMBJlMfMp/hocU5i+o5LP41GucGZzsmKJ2tHCXKIDXOiBL3ealksMtjLHD61dMZumccDSeNowSRbjqnEMfU7CeHLCb1YYacSHwPLyYGGrLo+GOnra/IpBtHLI09o+bTsXPowQ2K0qCNSt+A/8vjm9apWZKRiFxlxe4RrOLCm6Qs4V8Y+i0SKanc+wEVndEXwmVfoaYTazwds5qE1stKhhFyb8IZRs1rhC1BBcm4A==
Date: Wed, 19 Apr 2023 18:04:11 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <ZEAC6y6vIL37Gk2Q@shredder>
References: <20230413095830.2182382-1-idosch@nvidia.com>
 <95a773f6-5f88-712e-c494-9414d7090144@blackwall.org>
 <ZD/z2vI5ab0zPdRf@shredder> <20230419145124.5z47v2p62nbskqr2@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419145124.5z47v2p62nbskqr2@skbuf>
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
To: Vladimir Oltean <olteanv@gmail.com>
Cc: petrm@nvidia.com, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, edumazet@google.com, mlxsw@nvidia.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On Wed, Apr 19, 2023 at 05:51:24PM +0300, Vladimir Oltean wrote:
> On Wed, Apr 19, 2023 at 04:59:54PM +0300, Ido Schimmel wrote:
> > On Wed, Apr 19, 2023 at 03:30:07PM +0300, Nikolay Aleksandrov wrote:
> > > For the set:
> > > Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
> > 
> > Thanks! Will rebase, retest and submit v1
> 
> Shouldn't the version numbers be independent of the RFC/PATCH
> designation (and thus this would be a v2)? I know I was extremely
> confused when I had to review a series by Colin Foster which jumped back
> and forth between PATCH v6, RFC v3, PATCH v7, etc.

Makes sense. Will mark it v2
