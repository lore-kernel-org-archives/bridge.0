Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C34D416E9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 36839416B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3snnUZxZCWHMhOcKHlOWclrI7YiFMnqf91pq4umLDns=;
 b=eRc4tc5JtUvdUWPkURoFV8ez0+p3D+QqcBJWlyuztniK9aVQ5p/exfDXy4rZ7kX00B
 OBbIn+33j4UdZ/3Ce0/Zxvyfq8yic3QaCQlbYYwuc8RGTkAYvZ+PAa0vHlvlGwXsBULL
 07tsJIqkMWlgkO4I4C3pNkKYUgvpKS2WmrGBqekKyFh6l+AKIFY0aNgl4Y4cE2gCTInw
 KwAQZ3IH604GUPeVM02HXQFY3c1rCd10i/1BOfrYvy6t/SVAyyuiHddolM1H3Ex2KBRt
 PX6/ThilnY/EBfhO9wPGVEUWRnsHzxe/p/m0QiErcuZaQKUoobeCeIWBNFOZRMTHorH2
 9vtQ==
Date: Sun, 17 Jul 2022 16:46:10 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220717134610.k3nw6mam256yxj37@skbuf>
References: <20220630111634.610320-1-hans@kapio-technology.com>
 <Yr2LFI1dx6Oc7QBo@shredder>
 <CAKUejP6LTFuw7d_1C18VvxXDuYaboD-PvSkk_ANSFjjfhyDGkg@mail.gmail.com>
 <Yr778K/7L7Wqwws2@shredder>
 <CAKUejP5w0Dn8y9gyDryNYy7LOUytqZsG+qqqC8JhRcvyC13=hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKUejP5w0Dn8y9gyDryNYy7LOUytqZsG+qqqC8JhRcvyC13=hQ@mail.gmail.com>
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
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

Hi Hans,

On Fri, Jul 01, 2022 at 06:07:10PM +0200, Hans S wrote:
> On Fri, Jul 1, 2022 at 3:51 PM Ido Schimmel <idosch@nvidia.com> wrote:
> >
> > On Fri, Jul 01, 2022 at 09:47:24AM +0200, Hans S wrote:
> > > One question though... wouldn't it be an issue that the mentioned
> > > option setting is bridge wide, while the patch applies a per-port
> > > effect?
> >
> > Why would it be an issue? To me, the bigger issue is changing the
> > semantics of "locked" in 5.20 compared to previous kernels.
> >
> > What is even the use case for enabling learning when the port is locked?
> > In current kernels, only SAs from link local traffic will be learned,
> > but with this patch, nothing will be learned. So why enable learning in
> > the first place? As an administrator, I mark a port as "locked" so that
> > only traffic with SAs that I configured will be allowed. Enabling
> > learning when the port is locked seems to defeat the purpose?
> >
> > It would be helpful to explain why mv88e6xxx needs to have learning
> > enabled in the first place. IIUC, the software bridge can function
> > correctly with learning disabled. It might be better to solve this in
> > mv88e6xxx so that user space would not need to enable learning on the SW
> > bridge and then work around issues caused by it such as learning from
> > link local traffic.
> 
> There is several issues when learning is turned off with the mv88e6xxx driver:
> 
> Mac-Auth requires learning turned on, otherwise there will be no miss
> violation interrupts afair.
> Refreshing of ATU entries does not work with learning turn off, as the
> PAV is set to zero when learning is turned off.
> This then further eliminates the use of the HoldAt1 feature and
> age-out interrupts.
> 
> With dynamic ATU entries (an upcoming patch set), an authorized unit
> gets a dynamic ATU entry, and if it goes quiet for 5 minutes, it's
> entry will age out and thus get removed.
> That also solves the port relocation issue as if a device relocates to
> another port it will be able to get access again after 5 minutes.

I think the discussion derailed at this exact point, when you responded
that "Mac-Auth requires learning turned on".

What precise feature do you describe when you say "Mac-Auth"? Do you
mean 802.1X MAC-based authentication in general (where data plane
packets on a locked port are dropped unless their MAC SA is in the FDB,
and populating the FDB is *entirely* up to user space, there aren't any
locked FDB entries on locked ports), or MAC authentication *bypass*
(where the kernel auto-adds locked FDB entries on locked ports)?

I *think* it's just the bypass that requires learning in mv88e6xxx.
But the bypass (the feature where the kernel auto-adds locked FDB
entries on locked ports) doesn't exist in net-next.

Here, what happens is that a locked port learns the MAC SA from the
traffic it didn't drop, i.e. link-local. In other words, the bridge
behaves as expected and instructed: +locked +learning will cause just
that. It's the administrator's fault for not disabling learning.
It's also the mv88e6xxx driver's fault for not validating the "locked" +
"learning" brport flag *combination* until it properly supports "+locked
+learning" (the feature you are currently working on).

I'm still confused why we don't just say that "+locked -learning" means
plain 802.1X, "+locked +learning" means MAB where we learn locked FDB entries.
