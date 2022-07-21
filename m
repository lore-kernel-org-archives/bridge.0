Return-Path: <schultz.hans@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 16C5641BA6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BAEE541B91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AO1GlvcSPQHdOPNES0k1UPLRvC6PrOllsEsT128vMLI=;
 b=pehk5KzD58O/08ENd7lSRD4mx7T9HMiPOXsm6nLxCxgGJzKWLxnOuWb9/36V2baHhC
 jdOihHICyJYRsw386pYSSlQhr7jbegBgeaigTEOSl+oV16j7x62rM4lY1XO6vHv1X4PA
 Bee6VGr8GyjQOv4NL2KxJmBXWJFiRgmH0k/o27hOdUjYwUeRRWJfr+iPlybacat0VmQF
 iybUQWFJGRd38Us9mVSQkHfNq1AhNaHLM3Ug8K2I9xBzjsYZAQBNMPK1oZu29p2BsNp2
 1x6Q3Ojh/zNVWIbIngRkNrRoLL4FCWDNEtPRTk99Aos+HoeUsmWsKAO/lAMR7D/Vs4n1
 UT5w==
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
In-Reply-To: <20220721114540.ovm22rtnwqs77nfb@skbuf>
From: Hans S <schultz.hans@gmail.com>
Date: Thu, 21 Jul 2022 16:06:27 +0200
Message-ID: <CAKUejP6wCaOKiafvbxYqQs0-RibC0FMKtvkiG=R2Ts0Xfa3-tg@mail.gmail.com>
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

On Thu, Jul 21, 2022 at 1:45 PM Vladimir Oltean <olteanv@gmail.com> wrote:
>
> Why is it "not really so nice" to "trigger MAB" (in fact only to learn a
> locked entry on a locked port) when initiating the 802.1X session?

The consideration is mostly to limit (not eliminate) double
actrivation, e.g. activation of 802.1X and MAB at roughly the same
time, so that the daemons will have more to do coordinating which has
the session.

> You can disable link-local learning via the bridge option if you're

The issue here is that you can only disable it bridge wide and not per port.

> really bothered by that. When you have MAB enabled on an 802.1X port,
> I think it's reasonable to expect that there will be some locked entries
> which user space won't ever unlock via MAB. If those entries happen to
> be created as a side effect of the normal EAPOL authentication process,
> I don't exactly see where is the functional problem. This shouldn't
> block EAPOL from proceeding any further, because this protocol uses
> link-local packets which are classified as control traffic, and that
> isn't subject to FDB lookups but rather always trapped to CPU, so locked
> or not, it should still be received.
>
> I'm only pointing out the obvious here, we need an opt in for MAB, and
> the implemented behavior I've seen here kind of points to mapping this
> to "+learning +locked", where the learning process creates locked FDB entries.

If we need an opt in for MAB, you are right. Only then I think that we
need to solve the link-local learning issue so that it is disabled per
port?
