Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1814A60C12
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C7EA960D9D
MIME-Version: 1.0
Date: Thu, 25 Aug 2022 17:14:59 +0200
From: netdev@kapio-technology.com
In-Reply-To: <YwdCovUbVpmHfl39@shredder>
References: <5a4cfc6246f621d006af69d4d1f61ed1@kapio-technology.com>
 <YvkM7UJ0SX+jkts2@shredder>
 <34dd1318a878494e7ab595f8727c7d7d@kapio-technology.com>
 <YwHZ1J9DZW00aJDU@shredder>
 <ce4266571b2b47ae8d56bd1f790cb82a@kapio-technology.com>
 <YwMW4iGccDu6jpaZ@shredder>
 <c2822d6dd66a1239ff8b7bfd06019008@kapio-technology.com>
 <YwR4MQ2xOMlvKocw@shredder>
 <15407e4b247e91fd8326b1013d1a8640@kapio-technology.com>
 <YwdCovUbVpmHfl39@shredder>
Message-ID: <824eda8a76f36c8e211289e4ed3d2118@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
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
To: Ido Schimmel <idosch@nvidia.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On 2022-08-25 11:36, Ido Schimmel wrote:
> On Tue, Aug 23, 2022 at 01:41:51PM +0200, netdev@kapio-technology.com 
> wrote:
>> On 2022-08-23 08:48, Ido Schimmel wrote:
>> >
>> > I'm not good at naming, but "blackhole" is at least consistent with what
>> > we already have for routes and nexthop objects.
>> >
>> 
>> I have changed it the name "masked", as that is also the term used in 
>> the
>> documentation for the zero-DPV entries, and I think that it will 
>> generally
>> be a more accepted term.
> 
> "blackhole" is an already accepted term and at least to me it is much
> more clear than "masked". Keep in mind that both L2 neighbours (FDB) 
> and
> L3 neighbours share the same uAPI and eventually we might want to 
> extend
> the use of this flag for L3 neighbours (at least Spectrum supports it),
> so it needs to make sense for both.

I have changed the name of the flag to 'blackhole', but the struct entry 
in switchdev_notifier_fdb_info and a function input parameter is still 
named 'masked'. If that should be changed before I send out V5, please 
let me know as I hope to get this patch set accepted.
