Return-Path: <schultz.hans@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 05A8F61346
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A09C61343
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6MNY7diHJ+MnWxKcDHqJkKosV/mr66iz8oydZliBRmQ=;
 b=Y+HfLILvoGNJKQwKFAtwItKF+nCU+J9436rxhfgzKj8LxGXYwEyhG9L5pC/GGnKcdD
 OakYQ5yA1HWawR+S2zFE2a6CJG4WW0xpCZKA5ZEAV9jE47k/LUyRUKiGiG3uKwijbCKU
 NV4KIyrtkEqVcSyMJch5SBJa58tVqjxP7xToKLhCOPnCSfhpg/F4B2xs7hIpHmVkommW
 Zt5rqJZpPIpwTgHyjxaWFhu27gs5QHkOPa6NnNwBF2l0y4vu0P+y0lmOKc7ZRKyjNWMK
 XqtyfkLnqIfI219BNbG+a7HAZwfByoQoCrQ64uSG9r8XWGu9IW0ObRyJKSPD5Zg8lGq9
 iG2Q==
MIME-Version: 1.0
References: <20220524152144.40527-2-schultz.hans+netdev@gmail.com>
 <01e6e35c-f5c9-9776-1263-058f84014ed9@blackwall.org>
 <86zgj6oqa9.fsf@gmail.com>
 <b78fb006-04c4-5a25-7ba5-94428cc9591a@blackwall.org>
 <86fskyggdo.fsf@gmail.com>
 <040a1551-2a9f-18d0-9987-f196bb429c1b@blackwall.org>
 <86v8tu7za3.fsf@gmail.com>
 <4bf1c80d-0f18-f444-3005-59a45797bcfd@blackwall.org>
 <20220706181316.r5l5rzjysxow2j7l@skbuf>
 <7cf30a3e-a562-d582-4391-072a2c98ab05@blackwall.org>
 <20220706202130.ehzxnnqnduaq3rmt@skbuf>
 <fe456fb0-4f68-f93e-d4a9-66e3bc56d547@blackwall.org>
 <37d59561-6ce8-6c5f-5d31-5c37a0a3d231@blackwall.org>
In-Reply-To: <37d59561-6ce8-6c5f-5d31-5c37a0a3d231@blackwall.org>
From: Hans S <schultz.hans@gmail.com>
Date: Fri, 8 Jul 2022 08:38:31 +0200
Message-ID: <CAKUejP4P6-5gYg2owdbcNLKwYvsimg6L-Y_izUxfq=Uz=K_JDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Thu, Jul 7, 2022 at 4:08 PM Nikolay Aleksandrov <razor@blackwall.org> wrote:
>
> On 07/07/2022 00:01, Nikolay Aleksandrov wrote:
> > On 06/07/2022 23:21, Vladimir Oltean wrote:
> >> On Wed, Jul 06, 2022 at 10:38:04PM +0300, Nikolay Aleksandrov wrote:
> [snip]
> > I already said it's ok to add hard configurable limits if they're done properly performance-wise.
> > Any distribution can choose to set some default limits after the option exists.
> >
>
> Just fyi, and to avoid duplicate efforts, I already have patches for global and per-port software
> fdb limits that I'll polish and submit soon (depending on time availability, of course). If I find
> more time I might add per-vlan limits as well to the set. They use embedded netlink attributes
> to config and dump, so we can easily extend them later (e.g. different action on limit hit, limit
> statistics etc).
>

Sounds good, I will just limit the number of locked entries in the
driver as they are not controllable from the bridge. :-)
