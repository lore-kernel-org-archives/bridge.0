Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=A44GayFxXseGVVD0HVJY3qkIMetyjm2M3KFYhOBPZao=;
 b=Lc2SkHq0n+vROccbAbpL/H+0Dgf53+UBnImyq5CgM9VVRWDpx10kq2qoKeRy5CiiNv
 FpYqx7RLrPfzOXP1dLFMNnKOMJjfs0j3CllR2+GJRAa+xeBU5+JbMkHbXZorezgexw5d
 HGgZ4udmYbVkujDnMOIolsGQ7yZ9Um0MhApXuj0MmHNdk/aseo7VgnbONDaDGCgKVE3c
 FuTyGFUkXda1QvJT4RQyWKfbQAi8S/iBAKCnvKjFKVSRdK55tF/42d80eLGIxnVHMeV9
 i67I3EIzPReqjqpeR0xbzcuj79b5DdwnddziDXHyUbsQumSonS/xMlSxLAb4ToZY3hR+
 QdzA==
From: Hans Schultz <schultz.hans@gmail.com>
In-Reply-To: <YpYk4EIeH6sdRl+1@shredder>
References: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
 <20220524152144.40527-2-schultz.hans+netdev@gmail.com>
 <Yo+LAj1vnjq0p36q@shredder> <86sfov2w8k.fsf@gmail.com>
 <YpCgxtJf9Qe7fTFd@shredder> <86sfoqgi5e.fsf@gmail.com>
 <YpYk4EIeH6sdRl+1@shredder>
Date: Tue, 31 May 2022 17:49:32 +0200
Message-ID: <868rqh3do3.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Ido Schimmel <idosch@nvidia.com>, Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@idosch.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On tis, maj 31, 2022 at 17:23, Ido Schimmel <idosch@nvidia.com> wrote:
> On Tue, May 31, 2022 at 11:34:21AM +0200, Hans Schultz wrote:
>> > Just to give you another data point about how this works in other
>> > devices, I can say that at least in Spectrum this works a bit
>> > differently. Packets that ingress via a locked port and incur an FDB
>> > miss are trapped to the CPU where they should be injected into the Rx
>> > path so that the bridge will create the 'locked' FDB entry and notify it
>> > to user space. The packets are obviously rated limited as the CPU cannot
>> > handle billions of packets per second, unlike the ASIC. The limit is not
>> > per bridge port (or even per bridge), but instead global to the entire
>> > device.
>> 
>> Btw, will the bridge not create a SWITCHDEV_FDB_ADD_TO_DEVICE event
>> towards the switchcore in the scheme you mention and thus add an entry
>> that opens up for the specified mac address?
>
> It will, but the driver needs to ignore FDB entries that are notified
> with locked flag. I see that you extended 'struct
> switchdev_notifier_fdb_info' with the locked flag, but it's not
> initialized in br_switchdev_fdb_populate(). Can you add it in the next
> version?

Yes, definitely. I have only had focus on it in the messages coming up
from the driver, and neglected it the other way.
