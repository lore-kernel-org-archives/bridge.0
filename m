Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 82C5A405D2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 93368400D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jNzg2CMoVd1I4LouGMN20H+N7eFasZcE1vbuzP9T/xs=;
 b=jGsALBlOoX8f5qbY1dWPMgFbqX+TDJEuFICi8yi8v6ey26All+ybVMGus3u4o7CjtB
 2MlnTxAcMRNfrsJedjfk/cuF/95qZGp4fH+fJXWDNJozR5YTGoA10Lc9vs3BOIr2lmMI
 dxTsF38Tb8LG0uhRUly/piC5DxyLD8p/1KuWo8oLhwv7A3K8/GykppxaQsk8JSb+9BAA
 wNpb5AxxxGQlOKS4/adV7zfUH6dG8tJdUg8eyCGmIbl0tA3XCun6GVm7+XnY1YWsmZpG
 Kl/yNyKO6CH+FIURbM45H9nWjE6K3Ad/kHxcMcsi7kjVibiY8S1pBQQAlaEaeYR2oKp3
 6ghw==
Date: Fri, 21 Oct 2022 02:57:50 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221020235750.ql5v55y3knnxofna@skbuf>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-6-netdev@kapio-technology.com>
 <20221018165619.134535-6-netdev@kapio-technology.com>
 <20221020130224.6ralzvteoxfdwseb@skbuf> <Y1FMAI9BzDRUPi5Y@shredder>
 <20221020133506.76wroc7owpwjzrkg@skbuf>
 <8456155b8e0f6327e4fb595c7a08399b@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8456155b8e0f6327e4fb595c7a08399b@kapio-technology.com>
Subject: Re: [Bridge] [PATCH v8 net-next 05/12] net: dsa: propagate the
 locked flag down through the DSA layer
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@kapio-technology.com
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Ido Schimmel <idosch@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, davem@davemloft.net

On Thu, Oct 20, 2022 at 08:47:39PM +0200, netdev@kapio-technology.com wrote:
> Just to add to it, now that there is a u16 for flags in the bridge->driver
> direction, making it easier to add such flags, I expect that for the
> mv88e6xxx driver there shall be a 'IS_DYNAMIC' flag also, as authorized
> hosts will have their authorized FDB entries added with dynamic entries...

With what is implemented in this patchset, the MAB daemon uses static
FDB entries for authorizations, just like the selftests, right? That's
the only thing that works.

> Now as the bridge will not be able to refresh such authorized FDB entries
> based on unicast incoming traffic on the locked port in the offloaded case,
> besides we don't want the CPU to do such in this case anyway,

..because the software bridge refreshes the FDB entry based on the traffic
it sees, and the hardware port refreshes the corresponding ATU entry
based on the traffic *it* sees, and the 2 are not in sync because most
of the traffic is autonomously forwarded, causing the FDB to be
refreshed more often in hardware than in software..

> to keep the authorized line alive without having to reauthorize in
> like every 5 minutes, the driver needs to do the ageing (and refreshing)
> of the dynamic entry added from userspace.

You're saying "now [...] to keep the authorized line alive [...], the
driver needs to do the [...] refreshing of the dynamic [FDB] entry".

Can you point me to the code where that is done now?

Or perhaps I'm misunderstanding and it is a "future now"...

> When the entry "ages" out, there is the HoldAt1 feature and Age Out
> Violations that should be used to tell userspace (plus bridge) that
> this authorization has been removed by the driver as the host has gone
> quiet.

So this is your proposal for how a dynamic FDB entry could be offloaded.

Have you given any thought to how can we prevent the software FDB entry
from ageing out first, and causing the hardware FDB entry to be removed
too, through the ensuing switchdev notification?

> So all in all, there is the need of another flag from
> userspace->bridge->driver, telling that we want a dynamic ATU entry (with
> mv88e6xxx it will start at age 7).

Sorry for the elementary question, but what is gained from making the
authorized FDB entries dynamic in the bridge? You don't have to
reauthorize every 5 minutes even with the current implementation; you
could make the FDB entries static. The ability for authorized stations
to roam? This is why the authorizations are removed every 5 minutes,
to see if anybody is still there? Who removes the authorizations in the
implementation with the currently proposed patch set? The MAB daemon,
right?


Could you please present a high level overview of how you want things to
look in the end and how far you are along that line? Maybe a set of user
space + kernel repos where everything is implemented and works?
