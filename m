Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=lq9QE1KWIofg068mXEEQMoq14pdbbzqQ04CPhXSEQps=;
 b=hRJnetFs62TeujbYBDE2pth8Qcemr6044enw4ZiwWQSnwLcsEIbkJvE2swMsi5vQwJ
 0Hci1+s9GQt+QGGAJ0gzHrUvHKG31CjTBPvkswpALm4Y+OM4MaL3QQvaBhDe1r5nghO6
 OXNgudZBE5i0kOiba1KP4zQKDjn1agdvVHeGIK2moRu9T6P7DzXMK9pp0XgsEpwRiHOV
 uJBqrtg8GgaGWzCMss3uRkEqJz7OxfJI2Ui/v/LTAA/QwvAa4qTB0JqxXvs14cBDXq2j
 f93So6dKRWCPZJmtAXL9QOBN2MkfyDi05lvCU6PieqBGlDTGrTr2AeJtagbk/6bxLJnB
 v++w==
Date: Wed, 5 May 2021 19:12:15 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210505161215.xljue7z525znuf3y@skbuf>
References: <20210426170411.1789186-1-tobias@waldekranz.com>
 <20210426170411.1789186-7-tobias@waldekranz.com>
 <20210427101747.n3y6w6o7thl5cz3r@skbuf>
 <878s4uo8xc.fsf@waldekranz.com>
 <20210504152106.oppawchuruapg4sb@skbuf>
 <874kfintzh.fsf@waldekranz.com>
 <20210504205823.j5wg547lgyw776rl@skbuf>
 <87y2cum9mo.fsf@waldekranz.com>
 <20210504230409.kohxoc4cl7sjpkrg@skbuf>
 <87pmy5mu5m.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmy5mu5m.fsf@waldekranz.com>
Subject: Re: [Bridge] [RFC net-next 6/9] net: dsa: Forward offloading
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, idosch@idosch.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

On Wed, May 05, 2021 at 11:01:09AM +0200, Tobias Waldekranz wrote:
> On Wed, May 05, 2021 at 02:04, Vladimir Oltean <olteanv@gmail.com> wrote:
> > On Wed, May 05, 2021 at 12:12:15AM +0200, Tobias Waldekranz wrote:
> >> > and you create a dependency between the tagger and the switch driver
> >> > which was supposed by design to not exist.
> >> 
> >> Sure, but _why_ should it not exist? Many fields in the tag can only be
> >> correctly generated/interpreted in combination with knowledge of the
> >> current configuration, which is the driver's domain. The dependency is
> >> already there, etched in silicon.
> >
> > I'm a bit more of a pragmatic person,
> 
> Excuse me sir, I believe you left your dagger IN MY HEART :)

You might have misinterpreted my words, I did not mean to say "look what
a good quality I have and you don't", in fact I don't view pragmatism as
much of a desirable quality at all. What I meant to say in the context
is that, even though in general I value functionality more than how it
is implemented, I would still like to keep the separation between
taggers and switch drivers at least at the most basic RX/TX level, for
the reasons explained.
