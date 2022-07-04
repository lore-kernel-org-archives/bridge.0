Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 502B9404CF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 025D64042B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXWeMDzGZMD5k9QEdKbeaMDKulx9A8NNCN+tUfbNMT0=;
 b=UGYmOp/l4iwHK2BXkLpxGI4Px8ehAAK08Z+bWKhmTh09mAFMOeHZSQRnDdZaYaIQAsRqxCmYroxhPFi9RUQw/DKfD+mQmnIW59fvP83+em1p80NlKfubVeDs9aG+pIVyD+PUxqjvK13X8/B+QCgrKTS5cvHdT/Lq1x8vp0sP/8FV9v5IB/vRf0IUM+/jwyOAJmw4x4uF1qctH7PfYpatG6PIesWIw3XRWTGm3joq3VOzx11QnVzSv1sZPgfbfdP3lKlUDYEbye65M5FyLi7GnPSKR2aOE4jRdNslskDrEIeZ1cKpm9qw9wR9syCGz7+HT0RtZjTC50JVBERPHfqMCg==
Date: Mon, 4 Jul 2022 13:59:56 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YsLILMpLI3alAj+1@shredder>
References: <20220630111634.610320-1-hans@kapio-technology.com>
 <Yr2LFI1dx6Oc7QBo@shredder>
 <CAKUejP6LTFuw7d_1C18VvxXDuYaboD-PvSkk_ANSFjjfhyDGkg@mail.gmail.com>
 <Yr778K/7L7Wqwws2@shredder>
 <CAKUejP5w0Dn8y9gyDryNYy7LOUytqZsG+qqqC8JhRcvyC13=hQ@mail.gmail.com>
 <Yr8oPba83rpJE3GV@shredder>
 <CAKUejP4_05E0hfFp-ceXLgPuid=MwrAoHyQ-nYE3qx3Tisb4uA@mail.gmail.com>
 <YsE+hreRa0REAG3g@shredder>
 <CAKUejP4H4yKu6LaLUUUWypt7EPuYDK-5UdUDHPF8F2U5hGnzOQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKUejP4H4yKu6LaLUUUWypt7EPuYDK-5UdUDHPF8F2U5hGnzOQ@mail.gmail.com>
MIME-Version: 1.0
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
To: Hans S <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Hans Schultz <schultz.hans+netdev@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 09:54:31AM +0200, Hans S wrote:
> >
> > IIUC, with mv88e6xxx, when the port is locked and learning is disabled:
> >
> > 1. You do not get miss violation interrupts. Meaning, you can't report
> > 'locked' entries to the bridge driver.
> >
> > 2. You do not get aged-out interrupts. Meaning, you can't tell the
> > bridge driver to remove aged-out entries.
> >
> > My point is that this should happen regardless if learning is enabled on
> > the bridge driver or not. Just make sure it is always enabled in
> > mv88e6xxx when the port is locked. Learning in the bridge driver itself
> > can be off, thereby eliminating the need to disable learning from
> > link-local packets.
> 
> So you suggest that we enable learning in the driver when locking the
> port and document that learning should be turned off from user space
> before locking the port?

Yes. Ideally, the bridge driver would reject configurations where
learning is enabled and the port is locked, but it might be too late for
that. It would be good to add a note in the man page that learning
should be disabled when the port is locked to avoid "unlocking" the port
by accident.
