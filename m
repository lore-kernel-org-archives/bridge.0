Return-Path: <schultz.hans@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 36A844161B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 15AFE41612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rwSneiH5xSNmTYynHVLLuzHsfAWoKgKKKN3H7FS7rMk=;
 b=Aa/n1738ntBuPAWlhWhRZjFLdhg8myxMR8iZ6ftlyCeOiQ/9YT8wiSQDcg0c7UVHIb
 2Zf+Xsi8VkZXPDEp01hK59xKVY+ZeOj4PS2UxKfYEv4K3yTRf9K2tX6EMzePC9j4jIKH
 KqE0qziR4v/rSbMbLc6LQsa3oLHRC90c3EkGtQFBzwWt46gIvb/hbxlvPS5EVjBA8Y6A
 oA+BKnFpc7syZFnPPTRyec4XOuVWoPrd0uyUJ4vobAUIhE09YyViry6TZxnnzAauydiz
 qsFW/1eGnCix7ZOzsUHc/RXx+Lpk23JF/BP9ido13S6OxIOCNapP3PBFdxuYeYy9NFdW
 2UuQ==
MIME-Version: 1.0
References: <20220630111634.610320-1-hans@kapio-technology.com>
 <Yr2LFI1dx6Oc7QBo@shredder>
 <CAKUejP6LTFuw7d_1C18VvxXDuYaboD-PvSkk_ANSFjjfhyDGkg@mail.gmail.com>
 <Yr778K/7L7Wqwws2@shredder>
 <CAKUejP5w0Dn8y9gyDryNYy7LOUytqZsG+qqqC8JhRcvyC13=hQ@mail.gmail.com>
 <20220717134610.k3nw6mam256yxj37@skbuf>
 <20220717140325.p5ox5mhqedbyyiz4@skbuf>
In-Reply-To: <20220717140325.p5ox5mhqedbyyiz4@skbuf>
From: Hans S <schultz.hans@gmail.com>
Date: Sun, 17 Jul 2022 18:22:57 +0200
Message-ID: <CAKUejP6g3HxS=Scj-2yhsQRJApxnq1e31Nkcc995s7gzfMJOew@mail.gmail.com>
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

On Sun, Jul 17, 2022 at 4:03 PM Vladimir Oltean <olteanv@gmail.com> wrote:
>
> On Sun, Jul 17, 2022 at 04:46:10PM +0300, Vladimir Oltean wrote:
> > Here, what happens is that a locked port learns the MAC SA from the
> > traffic it didn't drop, i.e. link-local. In other words, the bridge
> > behaves as expected and instructed: +locked +learning will cause just
> > that. It's the administrator's fault for not disabling learning.
> > It's also the mv88e6xxx driver's fault for not validating the "locked" +
> > "learning" brport flag *combination* until it properly supports "+locked
> > +learning" (the feature you are currently working on).
> >
> > I'm still confused why we don't just say that "+locked -learning" means
> > plain 802.1X, "+locked +learning" means MAB where we learn locked FDB entries.
>
> Or is it the problem that a "+locked +learning" bridge port will learn
> MAC SA from link-local traffic, but it will create FDB entries without
> the locked flag while doing so? The mv88e6xxx driver should react to the
> 'locked' flag from both directions (ADD_TO_DEVICE too, not just ADD_TO_BRIDGE).

Yes, it creates an FDB entry in the bridge without the locked flag
set, and sends an ADD_TO_DEVICE notice with it.
And furthermore link-local packets include of course EAPOL packets, so
that's why +learning is a problem.
