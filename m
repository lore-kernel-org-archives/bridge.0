Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6753441767
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 76F594171C
MIME-Version: 1.0
Date: Sun, 17 Jul 2022 14:34:22 +0200
From: netdev@kapio-technology.com
In-Reply-To: <20220717004725.ngix64ou2mz566is@skbuf>
References: <20220707152930.1789437-1-netdev@kapio-technology.com>
 <20220707152930.1789437-6-netdev@kapio-technology.com>
 <20220717004725.ngix64ou2mz566is@skbuf>
Message-ID: <3918e3d1a8b78dedc14b950ba1eee8d5@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v4 net-next 5/6] net: dsa: mv88e6xxx:
 mac-auth/MAB implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

> 
> In other words, this patch set makes MAB work and breaks everything 
> else.
> I'm willing to investigate exactly what is it that breaks the other
> selftest, but not today. It may be related to the "RTNETLINK answers:
> File exists"
> messages, which themselves come from the commands
> | bridge fdb add 00:01:02:03:04:01 dev lan2 master static
> 
> If I were to randomly guess at almost 4AM in the morning, it has to do 
> with
> "bridge fdb add" rather than the "bridge fdb replace" that's used for
> the MAB selftest. The fact I pointed out a few revisions ago, that MAB
> needs to be opt-in, is now coming back to bite us. Since it's not
> opt-in, the mv88e6xxx driver always creates locked FDB entries, and 
> when
> we try to "bridge fdb add", the kernel says "hey, the FDB entry is
> already there!". Is that it?

Yes, that sounds like a reasonable explanation, as it adds 'ext learned, 
offloaded' entries. If you try and replace the 'add' with 'replace' in 
those tests, does it work?

> 
> As for how to opt into MAB. Hmm. MAB seems to be essentially CPU
> assisted learning, which creates locked FDB entries. I wonder whether 
> we
> should reconsider the position that address learning makes no sense on
> locked ports, and say that "+locked -learning" means no MAB, and
> "+locked +learning" means MAB? This would make a bunch of things more
> natural to handle in the kernel, and would also give us the opt-in we 
> need.

I have done the one and then the other. We need to have some final 
decision on this point. And remember that this gave rise to an extra 
patch to fix link-local learning if learning is turned on on a locked 
port, which resulted in the decision to allways have learning off on 
locked ports.

> 
> 
> 
> Side note, the VTU and ATU member violation printks annoy me so badly.
> They aren't stating something super useful and they're a DoS attack
> vector in itself, even if they're rate limited. I wonder whether we
> could just turn the prints into a set of ethtool counters and call it a 
> day?

Sounds like a good idea to me. :-)
