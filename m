Return-Path: <schultz.hans@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6DF9B81751
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A932816F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JMkhE15DqUuUYsqdeVw0YV5US1cbKTxDmN+AZSpDcP0=;
 b=h0RUdzs/T1fLlIR1/zIfcZGTBTOxi0NalXvCnyBA3PGTv2E7elyVjIS0kcS62w7C9w
 kdGiI6r4eCjtXJcrM3R8GaNCejm6jR3xF/0YbyuR7hgwhhYbFxlKfl6qs6JQpV6/zT54
 nAKGvxumCU2NoVQn9kpTtB8CCDUCHlzQQvvtLOHvk63ZigC9CbUFSxdui5ZR7BL7hy1n
 Qi0H15xrkblODPN/Nx5fwtrO+ikBEKHoMCTKgDuDJrLL2HgUiPP85P19d6arDE65G/tL
 UqPyRYAtkryAZe99Mf98zV+2YvRoTCF15jc48N8OMDFVmtoHJZu2YS2UMdifPdRKr1ru
 JWwQ==
MIME-Version: 1.0
References: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
 <20220524152144.40527-4-schultz.hans+netdev@gmail.com>
In-Reply-To: <20220524152144.40527-4-schultz.hans+netdev@gmail.com>
From: Hans S <schultz.hans@gmail.com>
Date: Mon, 27 Jun 2022 14:58:13 +0200
Message-ID: <CAKUejP7xPByVP2Qe0fFCxhU_vX84qp2i_7RFnL9ZYMVr0xH=jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH V3 net-next 3/4] net: dsa: mv88e6xxx:
	mac-auth/MAB implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, linux-kernel@vger.kernel.org, Hans Schultz <schultz.hans+netdev@gmail.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>

Hi Vladimir,
maybe you have missed my upstreaming of this patch set...

According to our earlier discussions I have now implemented the
feature, so that the ATU locked entries are owned by the driver, so to
make the entries dynamic I add the entries to a list and use kernel
timers to age out the entries as they should be 'dynamic'. See
mv88e6xxx_switchdev.c.

Hans

On Tue, May 24, 2022 at 5:22 PM Hans Schultz <schultz.hans@gmail.com> wrote:
>
> This implementation for the Marvell mv88e6xxx chip series, is
> based on handling ATU miss violations occurring when packets
> ingress on a port that is locked. The mac address triggering
> the ATU miss violation is communicated through switchdev to
> the bridge module, which adds a fdb entry with the fdb locked
> flag set. The entry is kept according to the bridges ageing
> time, thus simulating a dynamic entry.
>
> Note: The locked port must have learning enabled for the ATU
> miss violation to occur.
>
> Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
> ---
>  drivers/net/dsa/mv88e6xxx/Makefile            |   1 +
>  drivers/net/dsa/mv88e6xxx/chip.c              |  40 ++-
>  drivers/net/dsa/mv88e6xxx/chip.h              |   5 +
>  drivers/net/dsa/mv88e6xxx/global1.h           |   1 +
>  drivers/net/dsa/mv88e6xxx/global1_atu.c       |  35 ++-
>  .../net/dsa/mv88e6xxx/mv88e6xxx_switchdev.c   | 249 ++++++++++++++++++
>  .../net/dsa/mv88e6xxx/mv88e6xxx_switchdev.h   |  40 +++
>  drivers/net/dsa/mv88e6xxx/port.c              |  32 ++-
>  drivers/net/dsa/mv88e6xxx/port.h              |   2 +
>  9 files changed, 389 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/net/dsa/mv88e6xxx/mv88e6xxx_switchdev.c
>  create mode 100644 drivers/net/dsa/mv88e6xxx/mv88e6xxx_switchdev.h
>
