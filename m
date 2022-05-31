Return-Path: <idosch@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9gTRopLeEIwgJuGbroSNJ5D82pl7EhcG5yOOG7c2b0=;
 b=Tj3aU1fdb/SIlnMH5WNPTYYJI384Qnn5QKALrejU8AUsXkaEn0cdpyA0Yko5ia+WVpJjpm3CfxHawAxsf5NtBFrcrlboYchvJSYJtOqKRJLh3j1dMWtaKqkqXcLWXwoa0g3CsI6hFiJiTSsdr3YqL+skV84vk68WejLYIrKsbJr6yoMo6uE45qixj1VV3zG6q8Tj4pnbwwEYN7N9oE9MD7kirKutIc1jIDXETEQmhRVc2iiO+WhjyEwhgG+MygE+24QMl7k5gf3yMH7bROyTvnkWXX4eV5SANB8HLZYz6Szd9MPZIgVet87HSiHIVCHSavf317+ri+ooUE6z/4phnQ==
Date: Tue, 31 May 2022 17:23:28 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YpYk4EIeH6sdRl+1@shredder>
References: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
 <20220524152144.40527-2-schultz.hans+netdev@gmail.com>
 <Yo+LAj1vnjq0p36q@shredder> <86sfov2w8k.fsf@gmail.com>
 <YpCgxtJf9Qe7fTFd@shredder> <86sfoqgi5e.fsf@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86sfoqgi5e.fsf@gmail.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH V3 net-next 1/4] net: bridge: add fdb flag to
 extent locked port feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@idosch.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Tue, May 31, 2022 at 11:34:21AM +0200, Hans Schultz wrote:
> > Just to give you another data point about how this works in other
> > devices, I can say that at least in Spectrum this works a bit
> > differently. Packets that ingress via a locked port and incur an FDB
> > miss are trapped to the CPU where they should be injected into the Rx
> > path so that the bridge will create the 'locked' FDB entry and notify it
> > to user space. The packets are obviously rated limited as the CPU cannot
> > handle billions of packets per second, unlike the ASIC. The limit is not
> > per bridge port (or even per bridge), but instead global to the entire
> > device.
> 
> Btw, will the bridge not create a SWITCHDEV_FDB_ADD_TO_DEVICE event
> towards the switchcore in the scheme you mention and thus add an entry
> that opens up for the specified mac address?

It will, but the driver needs to ignore FDB entries that are notified
with locked flag. I see that you extended 'struct
switchdev_notifier_fdb_info' with the locked flag, but it's not
initialized in br_switchdev_fdb_populate(). Can you add it in the next
version?
