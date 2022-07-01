Return-Path: <schultz.hans@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B589405C2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3249040145
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fHKMope5SWjzop2Rp2Epmmp+QmZit+SL7styTSQamZY=;
 b=cRRLhPkA26KHCS0gtvJXn447hDg4hRDT5oKadmE0G58kf6IdaSYc1buPIirB/Blm+H
 bVU6AvPAFeGP+2Zsv2TIQaeOskpNDYvxUMLd30+e1rWqJK1XxnEmbGkzDOxOchJd/VIH
 xZKWBKD0He04ZcEFAPOhPCvGhYx9w5ONil9zZu148QunDcBxDXctq6HkqU2yqD7GEOs/
 w9ih4spSeU9JtlzmQkpDR0LmtgiswNebBF/A+7yc7I5HAis+v6a4ykAtPgs/V4evTugq
 DJMXJeUJStNwWwyVyBWBuP0lEenR74t52c7fjmNRXvUafpRZbrJ3aLsYHyf1fTU3vAhq
 6D2g==
MIME-Version: 1.0
References: <20220630111634.610320-1-hans@kapio-technology.com>
 <Yr2LFI1dx6Oc7QBo@shredder>
 <CAKUejP6LTFuw7d_1C18VvxXDuYaboD-PvSkk_ANSFjjfhyDGkg@mail.gmail.com>
 <Yr778K/7L7Wqwws2@shredder>
In-Reply-To: <Yr778K/7L7Wqwws2@shredder>
From: Hans S <schultz.hans@gmail.com>
Date: Fri, 1 Jul 2022 18:07:10 +0200
Message-ID: <CAKUejP5w0Dn8y9gyDryNYy7LOUytqZsG+qqqC8JhRcvyC13=hQ@mail.gmail.com>
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

There is several issues when learning is turned off with the mv88e6xxx driver:

Mac-Auth requires learning turned on, otherwise there will be no miss
violation interrupts afair.
Refreshing of ATU entries does not work with learning turn off, as the
PAV is set to zero when learning is turned off.
This then further eliminates the use of the HoldAt1 feature and
age-out interrupts.

With dynamic ATU entries (an upcoming patch set), an authorized unit
gets a dynamic ATU entry, and if it goes quiet for 5 minutes, it's
entry will age out and thus get removed.
That also solves the port relocation issue as if a device relocates to
another port it will be able to get access again after 5 minutes.

On Fri, Jul 1, 2022 at 3:51 PM Ido Schimmel <idosch@nvidia.com> wrote:
>
> On Fri, Jul 01, 2022 at 09:47:24AM +0200, Hans S wrote:
> > One question though... wouldn't it be an issue that the mentioned
> > option setting is bridge wide, while the patch applies a per-port
> > effect?
>
> Why would it be an issue? To me, the bigger issue is changing the
> semantics of "locked" in 5.20 compared to previous kernels.
>
> What is even the use case for enabling learning when the port is locked?
> In current kernels, only SAs from link local traffic will be learned,
> but with this patch, nothing will be learned. So why enable learning in
> the first place? As an administrator, I mark a port as "locked" so that
> only traffic with SAs that I configured will be allowed. Enabling
> learning when the port is locked seems to defeat the purpose?
>
> It would be helpful to explain why mv88e6xxx needs to have learning
> enabled in the first place. IIUC, the software bridge can function
> correctly with learning disabled. It might be better to solve this in
> mv88e6xxx so that user space would not need to enable learning on the SW
> bridge and then work around issues caused by it such as learning from
> link local traffic.
