Return-Path: <schultz.hans@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5CE68418C0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A3AE418B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+btLS9OBdLthxpmSH7aEjgmKx+CA2SmFIV+Z3Abyo6M=;
 b=QznS/Ul5921zyvr7SGAdAjWJPyFl2OnDgcIfaLZLbgOj5P3FmBayBT22F3dC904OxK
 2LjBN65VV3yNIjbw5IVk6bLyPQF3quWXEWK4rthqK8dAUMoF7eJGlDt3Na9FpJ03fuAD
 sbLkUpDNaVWpQbRENJBqM0Lyc4wPR6XeqsVqauKwh2OFzPBYXIee1Td2qPbLEiQBnAXd
 WOI51HHCnxygVHYRg99A4rnOoakY7Hkrbl/Y+I/TJ5Sl7i60mprbdEw7lKwTG6kiSNA2
 kBfY29HpCxd/Dv8acARD/L4jA36kimazdLCiJZZ0NXdhUx/3tkX5WY9eN6l/YFeW4x8s
 7SUA==
MIME-Version: 1.0
References: <20220630111634.610320-1-hans@kapio-technology.com>
 <Yr2LFI1dx6Oc7QBo@shredder>
 <CAKUejP6LTFuw7d_1C18VvxXDuYaboD-PvSkk_ANSFjjfhyDGkg@mail.gmail.com>
 <Yr778K/7L7Wqwws2@shredder>
 <CAKUejP5w0Dn8y9gyDryNYy7LOUytqZsG+qqqC8JhRcvyC13=hQ@mail.gmail.com>
 <Yr8oPba83rpJE3GV@shredder>
In-Reply-To: <Yr8oPba83rpJE3GV@shredder>
From: Hans S <schultz.hans@gmail.com>
Date: Fri, 1 Jul 2022 21:17:27 +0200
Message-ID: <CAKUejP4_05E0hfFp-ceXLgPuid=MwrAoHyQ-nYE3qx3Tisb4uA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH net-next v1 1/1] net: bridge: ensure that
 link-local traffic cannot unlock a locked port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Hans Schultz <schultz.hans+netdev@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On Fri, Jul 1, 2022 at 7:00 PM Ido Schimmel <idosch@nvidia.com> wrote:
>
> On Fri, Jul 01, 2022 at 06:07:10PM +0200, Hans S wrote:
> > There is several issues when learning is turned off with the mv88e6xxx driver:
>
> Please don't top-post...

Sorry, I am using gmails own web interface for a short while now as my
other options are not supported anymore by Google (not secure apps)

>
> >
> > Mac-Auth requires learning turned on, otherwise there will be no miss
> > violation interrupts afair.
> > Refreshing of ATU entries does not work with learning turn off, as the
> > PAV is set to zero when learning is turned off.
> > This then further eliminates the use of the HoldAt1 feature and
> > age-out interrupts.
> >
> > With dynamic ATU entries (an upcoming patch set), an authorized unit
> > gets a dynamic ATU entry, and if it goes quiet for 5 minutes, it's
> > entry will age out and thus get removed.
> > That also solves the port relocation issue as if a device relocates to
> > another port it will be able to get access again after 5 minutes.
>
> You assume I'm familiar with mv88e6xxx, when in fact I'm not. Here is
> what I think you are saying:
>
> 1. When a port is locked and a packet is received with a SA that is not
> in the FDB, it will only generate a miss violation if learning is
> enabled. In which case, you will notify the bridge driver about this
> entry as externally learned and locked entry.

Right.

> 2. When a port is locked and a packet is received with a SA that matches
> a different port, it will be dropped regardless if learning is enabled
> or not.

I would think so.

> 3. From the above I conclude that the HW will not auto-populate its FDB
> when a port is locked.

Right, and it should not as the locked port feature is basically CPU
controlled learning.
(yes it is an irony to have CPU controlled learning and learning
turned on, but that is just how it is with the mv88e6xxx series :-) )

> 4. FDB entries that point to a port that does not have learning enabled
> are not subject to ageing (why?).

Sorry if I said so. Dynamic ATU entries will age I am sure, but they
will not refresh unless there is a match between the ingress port and
the Port Association Vector (PAV).
But an age out violation will not occur, and the HoldAt1 (entries age
from 7 -> 0) feature will not work either as it is related to the
refresh mechanism.

>
> Assuming the above is correct, in order for mv88e6xxx to work correctly,
> it needs to enable learning on all locked ports, but it should happen
> regardless of the bridge driver learning configuration let alone impose
> any limitations on it. In fact, hostapd must disable learning for all
> locked ports.

To have hardware induced refreshing I would say learning should be on
also for 802.1X (hostapd). This relies of course on user added dynamic
ATU entries, which is what my follow-up patch set is about. Besides it
is perfectly feasible to have both 802.1X and Mac-Auth on the same
port.
