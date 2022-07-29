Return-Path: <schultz.hans@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D8C883EFF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BBE1F83EFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9B+fJLFGx39Gcy7aaco5Kc5jq5xG1Fk7EO3xuRz7x3o=;
 b=WkAkV/6cwsJb4o9WWErAaQfbeC1idvMXn0SMP+MW4GHMxK6PsP/z8boKVsBjRgrBBf
 oTzZu97jc2U65u1P6Aeax1Cx2y/v8P6B2wALgIA+8yV6tLI+duOfE+322vNNfQOQ92nY
 cvi3vuxawepQluJvA0jxIr5J1KlB3sMnlPvRs5kxlw05xLFG5FSx2+qjcfDdHdFbofbo
 G2JACbV2XIdc/DdeSZ93GoESs+YjDo9spRpFHgzvgzntUgtSJ2EfvZPrxQeH9qRlbl0E
 YHUEQ92oO2oiojydFNjNNwKUcQvn5OFQuYSljUJB5OOmZsBc7BmRmeVjJ1btvuhoRknf
 WmdQ==
MIME-Version: 1.0
References: <Yr2LFI1dx6Oc7QBo@shredder>
 <CAKUejP6LTFuw7d_1C18VvxXDuYaboD-PvSkk_ANSFjjfhyDGkg@mail.gmail.com>
 <Yr778K/7L7Wqwws2@shredder>
 <CAKUejP5w0Dn8y9gyDryNYy7LOUytqZsG+qqqC8JhRcvyC13=hQ@mail.gmail.com>
 <20220717134610.k3nw6mam256yxj37@skbuf>
 <20220717140325.p5ox5mhqedbyyiz4@skbuf>
 <CAKUejP6g3HxS=Scj-2yhsQRJApxnq1e31Nkcc995s7gzfMJOew@mail.gmail.com>
 <20220717183852.oi6yg4tgc5vonorp@skbuf>
 <CAKUejP7WyL2r03EiZU4hA63u2e=Wz3KM4X=rDdji5pdZ0ptaZg@mail.gmail.com>
 <20220721114540.ovm22rtnwqs77nfb@skbuf>
 <CAKUejP6xR81p1QeSCnDP_3uh9owafdYr1pifeCzekzUvU3_dPw@mail.gmail.com>
In-Reply-To: <CAKUejP6xR81p1QeSCnDP_3uh9owafdYr1pifeCzekzUvU3_dPw@mail.gmail.com>
From: Hans S <schultz.hans@gmail.com>
Date: Fri, 29 Jul 2022 07:23:19 +0200
Message-ID: <CAKUejP5FGqJZ3HNUANsi4VzM5VRGYmDBRQt3Ohvd90wxyEhEqA@mail.gmail.com>
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
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 10:09 AM Hans S <schultz.hans@gmail.com> wrote:
>
> On Thu, Jul 21, 2022 at 1:45 PM Vladimir Oltean <olteanv@gmail.com> wrote:
> >
> > On Sun, Jul 17, 2022 at 09:20:57PM +0200, Hans S wrote:
> >
> > I'm only pointing out the obvious here, we need an opt in for MAB, and
> > the implemented behavior I've seen here kind of points to mapping this
> > to "+learning +locked", where the learning process creates locked FDB entries.
>
> I can go with the reasoning for the opt in for MAB, but disabling link
> local learning system wide I don't think is a good idea, unless
> someone can ensure me that it does not impact something else.
> In general locked ports should never learn from link local, which is a
> problem if they do, which suggests to me that this patch should
> eventually be accepted as the best solution.

Hi Vladimir,
sorry, I forget myself. We cannot use +learning as an opt in for MAB
with this driver, as there will be no HW refresh and other interrupts
like the age out violation will not occur either, which will be needed
further on.
If we really need an opt in for MAB, I think it will have to be a new flag.
Hans
