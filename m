Return-Path: <hans@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 64C8881F85
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2841E81F7C
From: Hans Schultz <netdev@kapio-technology.com>
In-Reply-To: <20230424122631.d7kwfwmlwvqjo3pz@skbuf>
References: <20230418155902.898627-1-vladimir.oltean@nxp.com>
 <875y9nt27g.fsf@kapio-technology.com>
 <20230424122631.d7kwfwmlwvqjo3pz@skbuf>
Date: Mon, 24 Apr 2023 17:33:44 +0200
Message-ID: <87jzy11ehz.fsf@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH v2 net] net: bridge: switchdev: don't notify
 FDB entries with "master dynamic"
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Ivan Vecera <ivecera@redhat.com>, bridge@lists.linux-foundation.org, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>

On Mon, Apr 24, 2023 at 15:26, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> On Sun, Apr 23, 2023 at 10:47:15AM +0200, Hans Schultz wrote:
>> I do not understand this patch. It seems to me that it basically blocks
>> any future use of dynamic fdb entries from userspace towards drivers.
>> 
>> I would have expected that something would be done in the DSA layer,
>> where (switchcore) drivers would be able to set some flags to indicate
>> which features are supported by the driver, including non-static
>> fdb entries. But as the placement here is earlier in the datapath from
>> userspace towards drivers it's not possible to do any such thing in the
>> DSA layer wrt non-static fdb entries.
>
> As explained too many times already in the thread here:
> https://patchwork.kernel.org/project/netdevbpf/patch/20230318141010.513424-3-netdev@kapio-technology.com/
> the plan is:

Ahh yes thanks, I see the comment you wrote on march the 27th.
