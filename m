Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4FF4B83403
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 14AB5833A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FNcxlcjmRlhNk+bv6B7cAEGwdM5R0LeaFhjoH03CG4E=;
 b=V9pZGPntNZAfrt4tMjcaBvXFuvvPLtmeJTcdaWDR7LnKHyBKe+xcoKmr9zwywSRmL2
 rDnJ/X3kqlYKBPsPVcK0RUBTFKGgoWRJyq1A1S847kwjwcR657PUZiIaZRRYB5CIVp5v
 Hh2av0UR0oVek9j3FPR/CLfnU1mxF+vPLWccqkzVntDy4MKHodTfdcyFbQrTjdNKQ5ak
 pQO/ToUnoRapcVvJ2ZaCb759vqW+gPUneB6/UAyC4hls31hnD48Ilxq1V584B1G5y0Ka
 08AnrQXLvIhyZ4ingsiHj+lHef6L4OPiMoAzZno/Jjwl6kQEJCAITgI8+BL8UlDBktb9
 ALjw==
Date: Sat, 22 Oct 2022 14:32:38 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221022113238.beo5zhufl2x645lf@skbuf>
References: <20221020225719.l5iw6vndmm7gvjo3@skbuf>
 <82d23b100b8d2c9e4647b8a134d5cbbf@kapio-technology.com>
 <20221021112216.6bw6sjrieh2znlti@skbuf>
 <7bfaae46b1913fe81654a4cd257d98b1@kapio-technology.com>
 <20221021163005.xljk2j3fkikr6uge@skbuf>
 <d1fb07de4b55d64f98425fe66156c4e4@kapio-technology.com>
 <20221021173014.oit3qmpkrsjwzbgu@skbuf>
 <b88e331e016ad3801f1bf1a0dec507f3@kapio-technology.com>
 <20221021181411.sv52q4yxr5r7urab@skbuf>
 <GV1P190MB2019CFA0EB9B5E717F39B621E42C9@GV1P190MB2019.EURP190.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV1P190MB2019CFA0EB9B5E717F39B621E42C9@GV1P190MB2019.EURP190.PROD.OUTLOOK.COM>
Subject: Re: [Bridge] [PATCH v8 net-next 10/12] net: dsa: mv88e6xxx:
 mac-auth/MAB implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Oleksandr Mazur <oleksandr.mazur@plvision.eu>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "netdev@kapio-technology.com" <netdev@kapio-technology.com>, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Ido Schimmel <idosch@nvidia.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Russell King <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Roopa Prabhu <roopa@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Florent Fourcot <florent.fourcot@wifirst.fr>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, "davem@davemloft.net" <davem@davemloft.net>

Hi Oleksandr,

On Sat, Oct 22, 2022 at 08:50:20AM +0000, Oleksandr Mazur wrote:
> >The essence of my proposal was to send a bug fix now which denies
> >BR_LEARNING to be set together with BR_PORT_LOCKED. The fact that
> >link-local traffic is learned by the software bridge is something
> >unintended as far as I understand.
> 
> >You tried to fix it here, and as far as I could search in my inbox, that
> >didn't go anywhere:
> >https://lore.kernel.org/netdev/47d8d747-54ef-df52-3b9c-acb9a77fa14a@blackwall.org/T/#u
> 
> >I thought only mv88e6xxx offloads BR_PORT_LOCKED, but now, after
> >searching, I also see prestera has support for it, so let me add
> >Oleksandr Mazur to the discussion as well. I wonder how they deal with
> >this? Has somebody come to rely on learning being enabled on a locked
> >port?
> 
> Hello,
> 
> >The fact that
> >link-local traffic is learned by the software bridge is something
> >unintended as far as I understand.
> 
> In prestera driver, if port is in blocked state only the PAE frames
> can be trapped, so i'm not sure where other traffic might come from
> that you are talking. Or maybe i didn't get the issue here right,
> sorry?

I hope the following script will exemplify what I mean.

#!/bin/bash

ip netns add ns0
ip -n ns0 link add br0 type bridge
ip -n ns0 link add veth0 type veth peer name veth1
ip -n ns0 link set veth1 master br0
ip -n ns0 link set veth1 type bridge_slave locked on learning on
ip -n ns0 link set veth0 up
ip -n ns0 link set veth1 up
ip -n ns0 link set br0 up
addr=$(ip -j -n ns0 link show dev veth0 | jq -r '.[]["address"]')
ip netns exec ns0 mausezahn veth0 -q -c 1 -p 64 -b 01:80:c2:00:00:0e -t ip
sleep 1
ip netns exec ns0 bridge fdb show dev veth1 master | grep ${addr}
ip netns del ns0

It will print:

6e:71:0a:8d:85:9e master br0

or in other words, the brport veth1 has learned the MAC SA of veth0 as a
dynamic FDB entry even with no user space daemon to handle the
authentication protocol.

In turn, having this MAC SA present in the bridge FDB means that
communication with this station is now allowed. As far as I can tell,
this is *not* intended. Only the authentication protocol should create
the FDB entry.

Compare this with the same script, but with "locked on learning off".
No FDB entry will be printed.

> 
> Also, basically, prestera driver does not rely on the learning flag if
> the port's flag BR_PORT_LOCKED is set. What this means, is that we
> discard any learning changes on the port if LOCKED is still set (done
> inside firmware, if i recall correctly). E.g. learning is always off,
> if port is in BR_PORT_LOCKED state, or in a block state but also has a
> static fdb entry (aka mac-auth entry).

So I take this as meaning that we could deny BR_LEARNING on ports with
BR_PORT_LOCKED set, and prestera wouldn't be adversely affected. Ok.

> The concept we follow is basically:
>   - some userspace daemon blocks the port;
>   - speaks with the <auth-center> (PAE traffic);
>   - the daemon itself populates the FDB with authenticated MACs (adding static FDB MACs);
>   - forces learning flag disable, disables the PORT_LOCKED flag. At
>   this point switch can basically receive only the traffic from
>   authorized addresses (fdb still has static entries; learning
>   disabled).

I don't understand the last step. Why is the BR_PORT_LOCKED flag disabled?
If disabled, the port will receive frames with any unknown MAC SA,
not just the authorized ones.
