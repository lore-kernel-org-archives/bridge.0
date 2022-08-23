Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC5DE408FC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A3C41408F2
MIME-Version: 1.0
Date: Tue, 23 Aug 2022 09:37:54 +0200
From: netdev@kapio-technology.com
In-Reply-To: <YwSAtgS7fgHNLMEy@shredder>
References: <5a4cfc6246f621d006af69d4d1f61ed1@kapio-technology.com>
 <YvkM7UJ0SX+jkts2@shredder>
 <34dd1318a878494e7ab595f8727c7d7d@kapio-technology.com>
 <YwHZ1J9DZW00aJDU@shredder>
 <ce4266571b2b47ae8d56bd1f790cb82a@kapio-technology.com>
 <YwMW4iGccDu6jpaZ@shredder>
 <c2822d6dd66a1239ff8b7bfd06019008@kapio-technology.com>
 <YwR4MQ2xOMlvKocw@shredder>
 <9dcb4db4a77811308c56fe5b9b7c5257@kapio-technology.com>
 <YwSAtgS7fgHNLMEy@shredder>
Message-ID: <553c573ad6a2ddfccfc47c7847cc5fb7@kapio-technology.com>
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

On 2022-08-23 09:24, Ido Schimmel wrote:
> On Tue, Aug 23, 2022 at 09:13:54AM +0200, netdev@kapio-technology.com 
> wrote:
>> On 2022-08-23 08:48, Ido Schimmel wrote:
>> > On Mon, Aug 22, 2022 at 09:49:28AM +0200, netdev@kapio-technology.com
>> > wrote:
>> 
>> > > As I am not familiar with roaming in this context, I need to know
>> > > how the SW
>> > > bridge should behave in this case.
>> >
>> 
>> > > In this case, is the roaming only between locked ports or does the
>> > > roaming include that the entry can move to a unlocked port, resulting
>> > > in the locked flag getting removed?
>> >
>> > Any two ports. If the "locked" entry in mv88e6xxx cannot move once
>> > installed, then the "sticky" flag accurately describes it.
>> >
>> 
>> But since I am also doing the SW bridge implementation without 
>> mv88e6xxx I
>> need it to function according to needs.
>> Thus the locked entries created in the bridge I shall not put the 
>> sticky
>> flag on, but there will be the situation where a locked entry can move 
>> to an
>> unlocked port, which we regarded as a bug.
> 
> I do not regard this as a bug. It makes sense to me that an authorized
> port can cause an entry pointing to an unauthorized port to roam to
> itself. Just like normal learned entries. What I considered as a bug is
> the fact that the "locked" flag is not cleared when roaming to an
> authorized port.
> 
>> In that case there is two possibilities, the locked entry can move to
>> an unlocked port with the locked flag being removed or the locked
>> entry can only move to another locked port?
> 
> My suggestion is to allow roaming and maintain / clear the "locked" 
> flag
> based on whether the new destination port is locked or not.

Thus I understand it as saying that the "locked" flag can also be set 
when roaming from an unlocked port to a locked port?
