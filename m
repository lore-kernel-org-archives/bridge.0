Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 248BC83417
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C19F583415
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+2vMc+urCwl2Sei7QYJVPkYEo3ePjTEdchVm0HaK4I=;
 b=eKVhMwqasjSbU4dzH8v4935OSht3uA/zDjIirDnN9StBCUnuZhUgLgg0F2zmKfdvn0Ih+QP98OX3y5kNU/xu7lrDt6Wz49INbm5+nqJCfEP2vx8C9dDJSW0ul8yMe3G4v78Gldq9fhJI3mtVeistCfZGhKEe+C2UrxBVDpTomBqaDdNshZCU02XL04erCz8o8RtPWv/k46QEu/+GBYd4gdCGP3hGxhBvRVrBVY84YnQEU+t4JcHCQIpazjjR//v4MYwMG2Nt6Atj9F72GaEyDNSIJJRjpbrOFEaQk41d+C7J/GCyWpAFql5RgEzbo7C/KnV2SagDtV2ZFcd9bETXDw==
Date: Thu, 25 Aug 2022 12:36:34 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YwdCovUbVpmHfl39@shredder>
References: <5a4cfc6246f621d006af69d4d1f61ed1@kapio-technology.com>
 <YvkM7UJ0SX+jkts2@shredder>
 <34dd1318a878494e7ab595f8727c7d7d@kapio-technology.com>
 <YwHZ1J9DZW00aJDU@shredder>
 <ce4266571b2b47ae8d56bd1f790cb82a@kapio-technology.com>
 <YwMW4iGccDu6jpaZ@shredder>
 <c2822d6dd66a1239ff8b7bfd06019008@kapio-technology.com>
 <YwR4MQ2xOMlvKocw@shredder>
 <15407e4b247e91fd8326b1013d1a8640@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15407e4b247e91fd8326b1013d1a8640@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v4 net-next 3/6] drivers: net: dsa: add locked
 fdb entry flag to drivers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@kapio-technology.com
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Tue, Aug 23, 2022 at 01:41:51PM +0200, netdev@kapio-technology.com wrote:
> On 2022-08-23 08:48, Ido Schimmel wrote:
> > 
> > I'm not good at naming, but "blackhole" is at least consistent with what
> > we already have for routes and nexthop objects.
> > 
> 
> I have changed it the name "masked", as that is also the term used in the
> documentation for the zero-DPV entries, and I think that it will generally
> be a more accepted term.

"blackhole" is an already accepted term and at least to me it is much
more clear than "masked". Keep in mind that both L2 neighbours (FDB) and
L3 neighbours share the same uAPI and eventually we might want to extend
the use of this flag for L3 neighbours (at least Spectrum supports it),
so it needs to make sense for both.
