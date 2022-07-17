Return-Path: <schultz.hans@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B799881D73
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E95DD81D0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qR5n9WUGINQgKnZyU5jQ5QNhAVmTXkoQM4VlFrsXDgk=;
 b=ROVMbcMOPv+gSbm3EJ0AYvQs8xJipm3EB1VIKbnQn0ywYyjAGUA0Sburuurfmr9fUI
 rXNM9c07v1017JK3vINOTZx/AP9ykov02Jip4XVZnRtdWqGlyYt0b7KURU1CVr5wzdhp
 1lvZdqtbFjtmc7jGXNELiIePVrkhIL++Y0v1Aq7AwuWe0ansFrJW49xDHVWY7rdOoYVC
 7Wsn78PS/3tFE8TP6FafTmxr6V3M3z9c7hZSHZVILX6qzAVgd+KXlezcymqZVSCDuiVV
 SHKpRhuds0LZqUWv1a1DfGN/NCy+t8089iHEj92aJDiFrtNMqN/wlagxvmDCmnfmd39k
 fK7A==
MIME-Version: 1.0
References: <20220630111634.610320-1-hans@kapio-technology.com>
 <Yr2LFI1dx6Oc7QBo@shredder>
 <CAKUejP6LTFuw7d_1C18VvxXDuYaboD-PvSkk_ANSFjjfhyDGkg@mail.gmail.com>
 <Yr778K/7L7Wqwws2@shredder>
 <CAKUejP5w0Dn8y9gyDryNYy7LOUytqZsG+qqqC8JhRcvyC13=hQ@mail.gmail.com>
 <20220717134610.k3nw6mam256yxj37@skbuf>
 <20220717140325.p5ox5mhqedbyyiz4@skbuf>
 <CAKUejP6g3HxS=Scj-2yhsQRJApxnq1e31Nkcc995s7gzfMJOew@mail.gmail.com>
 <20220717183852.oi6yg4tgc5vonorp@skbuf>
In-Reply-To: <20220717183852.oi6yg4tgc5vonorp@skbuf>
From: Hans S <schultz.hans@gmail.com>
Date: Sun, 17 Jul 2022 21:20:57 +0200
Message-ID: <CAKUejP7WyL2r03EiZU4hA63u2e=Wz3KM4X=rDdji5pdZ0ptaZg@mail.gmail.com>
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

On Sun, Jul 17, 2022 at 8:38 PM Vladimir Oltean <olteanv@gmail.com> wrote:
>
> On Sun, Jul 17, 2022 at 06:22:57PM +0200, Hans S wrote:
> > On Sun, Jul 17, 2022 at 4:03 PM Vladimir Oltean <olteanv@gmail.com> wrote:
> >
> > Yes, it creates an FDB entry in the bridge without the locked flag
> > set, and sends an ADD_TO_DEVICE notice with it.
> > And furthermore link-local packets include of course EAPOL packets, so
> > that's why +learning is a problem.
>
> So if we fix that, and make the dynamically learned FDB entry be locked
> because the port is locked (and offload them correctly in mv88e6xxx),
> what would be the problem, exactly? The +learning is what would allow
> these locked FDB entries to be created, and would allow the MAB to work.
> User space may still decide to not authorize this address, and it will
> remain locked.

The alternative is to have -learning and let the driver only enable
the PAV to admit the interrupts, which is what this implementation
does.
The plus side of this is that having EAPOL packets triggering locked
entries from the bridge side is not really so nice IMHO. In a
situation with 802.1X and MAB on the same port, there will then not be
any triggering of MAB when initiating the 802.1X session, which I
think is the best option. It then also lessens the confusion between
hostapd and the daemon that handles MAB sessions.
