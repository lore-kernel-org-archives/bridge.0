Return-Path: <schultz.hans@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0D96A818E6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC005818C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rE1S3qn0emq5PHeyf06ryXxWn9nDP2udjWAGP9EkRNo=;
 b=BMpIS/AaZ9mkwnYvWb3YzxD0SgLPv4RDjO4ZjZ68DxdKRYIPZvX7D1llnsstpspp5y
 QRTl5h6L82kz0B7VA5xK4BMsaNkPKH8zZ2Q22S7x0vimgRfWwyRH/hOjx60fc46asqpi
 p14SJ39A/qE+J0Oy7e2P+OJMI3KnWtoUXuu9XlQLOSk4BNukgDSnrBH8ejE3pxNkraIR
 jQHAp0LvwIoqzVeu7/tusfwe728MogKFHRQaOYEFvothlAGkgK40MrbrVMzOiCblDDew
 gRuQPnTCmis86h5fCBz2Z7CsSNCCDO1W+KAQNudMIWaXMJvSBh/xHpRe9FrdKbS5ySAb
 4t8w==
MIME-Version: 1.0
References: <20220630111634.610320-1-hans@kapio-technology.com>
 <Yr2LFI1dx6Oc7QBo@shredder>
In-Reply-To: <Yr2LFI1dx6Oc7QBo@shredder>
From: Hans S <schultz.hans@gmail.com>
Date: Fri, 1 Jul 2022 09:47:24 +0200
Message-ID: <CAKUejP6LTFuw7d_1C18VvxXDuYaboD-PvSkk_ANSFjjfhyDGkg@mail.gmail.com>
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
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, Hans Schultz <hans@kapio-technology.com>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Hans Schultz <schultz.hans+netdev@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

One question though... wouldn't it be an issue that the mentioned
option setting is bridge wide, while the patch applies a per-port
effect?

On Thu, Jun 30, 2022 at 1:38 PM Ido Schimmel <idosch@nvidia.com> wrote:
>
> On Thu, Jun 30, 2022 at 01:16:34PM +0200, Hans Schultz wrote:
> > This patch is related to the patch set
> > "Add support for locked bridge ports (for 802.1X)"
> > Link: https://lore.kernel.org/netdev/20220223101650.1212814-1-schultz.hans+netdev@gmail.com/
> >
> > This patch makes the locked port feature work with learning turned on,
> > which is enabled with the command:
> >
> > bridge link set dev DEV learning on
> >
> > Without this patch, link local traffic (01:80:c2) like EAPOL packets will
> > create a fdb entry when ingressing on a locked port with learning turned
> > on, thus unintentionally opening up the port for traffic for the said MAC.
> >
> > Some switchcore features like Mac-Auth and refreshing of FDB entries,
> > require learning enables on some switchcores, f.ex. the mv88e6xxx family.
> > Other features may apply too.
> >
> > Since many switchcores trap or mirror various multicast packets to the
> > CPU, link local traffic will unintentionally unlock the port for the
> > SA mac in question unless prevented by this patch.
>
> Why not just teach hostapd to do:
>
> echo 1 > /sys/class/net/br0/bridge/no_linklocal_learn
>
> ?
