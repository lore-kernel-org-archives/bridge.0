Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 32A174055D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AD63740544
MIME-Version: 1.0
Date: Wed, 24 Aug 2022 09:07:23 +0200
From: netdev@kapio-technology.com
In-Reply-To: <YwTJ5f5RzkC/DSdi@shredder>
References: <YvkM7UJ0SX+jkts2@shredder>
 <34dd1318a878494e7ab595f8727c7d7d@kapio-technology.com>
 <YwHZ1J9DZW00aJDU@shredder>
 <ce4266571b2b47ae8d56bd1f790cb82a@kapio-technology.com>
 <YwMW4iGccDu6jpaZ@shredder>
 <c2822d6dd66a1239ff8b7bfd06019008@kapio-technology.com>
 <YwR4MQ2xOMlvKocw@shredder>
 <9dcb4db4a77811308c56fe5b9b7c5257@kapio-technology.com>
 <YwSAtgS7fgHNLMEy@shredder>
 <553c573ad6a2ddfccfc47c7847cc5fb7@kapio-technology.com>
 <YwTJ5f5RzkC/DSdi@shredder>
Message-ID: <5390cb1d1485db40a71bb3fbf674b67a@kapio-technology.com>
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

On 2022-08-23 14:36, Ido Schimmel wrote:
> On Tue, Aug 23, 2022 at 09:37:54AM +0200, netdev@kapio-technology.com 
> wrote:
> 
> "learning on locked on" is really a misconfiguration, but it can also
> happen today and entries do not roam with the "locked" flag for the
> simple reason that it does not exist. I see two options:
> 
> 1. Do not clear / set "locked" flag during roaming. Given learning
> should be disabled on locked ports, then the only half interesting case
> is roaming to an unlocked port. Keeping the "locked" flag basically
> means "if you were to lock the port, then the presence of this entry is
> not enough to let traffic with the SA be forwarded by the bridge".
> Unlikely that anyone will do that.
> 
> 2. Always set "locked" flag for learned entries (new & roamed) on 
> locked
> ports and clear it for learned entries on unlocked ports.
> 
> Both options are consistent in how they treat the "locked" flag (either
> always do nothing or always set/clear) and both do not impact the
> integrity of the solution when configured correctly (disabling learning
> on locked ports). I guess users will find option 2 easier to understand
> / work with.

Roaming to a locked port with an entry without the locked bit set would 
open the port for said MAC without necessary authorization. Thus I think 
that the only real option is the 2. case.
