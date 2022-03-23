Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=OXIgpQewnxlg0QpZCeU/b/t8bzjboH/kCWJvwnGyNJc=;
 b=MMJDo4C5ZsXS02QHJkGPkc2lyI5LXoN+MlgkdrsVMW5SssCeJVW62Hs8mQRF3COpAT
 VoO5NNnXNPCV4rNmVczeMJZdEJK+aGSdrLdzEa/e4kve9X3PhraQJf3lE+5NyF/0sQqD
 MS2xjVtu0Xrt1BF9eRkLSzjEISDF0SDQNKCgEPF/mhGwcW4uoOgOHLtMIEfWVKdS0/17
 4TmHYqPFP1N3VJNhdX7S6rtXZvyW8EH2g+P2iZMreLFP5sL3HUkBfPb8eZy1b3fKu7Gn
 RcXSB1t5eFFxEuRKGIynxbt7uuw1MSFaG0Y2wRLVCmncp7cHrBFYKq7TvBKJtC5cHXXE
 zP5g==
From: Hans Schultz <schultz.hans@gmail.com>
In-Reply-To: <20220323101643.kum3nuqctunakcfo@skbuf>
References: <20220317161808.psftauoz5iaecduy@skbuf>
 <8635jg5xe5.fsf@gmail.com> <20220317172013.rhjvknre5w7mfmlo@skbuf>
 <86tubvk24r.fsf@gmail.com> <20220318121400.sdc4guu5m4auwoej@skbuf>
 <86pmmjieyl.fsf@gmail.com> <20220318131943.hc7z52beztqlzwfq@skbuf>
 <86a6dixnd2.fsf@gmail.com> <20220322110806.kbdb362jf6pbtqaf@skbuf>
 <86fsn90ye8.fsf@gmail.com> <20220323101643.kum3nuqctunakcfo@skbuf>
Date: Wed, 23 Mar 2022 11:57:16 +0100
Message-ID: <864k3p5437.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next 3/3] net: dsa: mv88e6xxx: mac-auth/MAB
 implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>, Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, davem@davemloft.net

On ons, mar 23, 2022 at 12:16, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Wed, Mar 23, 2022 at 11:13:51AM +0100, Hans Schultz wrote:
>> On tis, mar 22, 2022 at 13:08, Vladimir Oltean <olteanv@gmail.com> wrote:
>> > On Tue, Mar 22, 2022 at 12:01:13PM +0100, Hans Schultz wrote:
>> >> On fre, mar 18, 2022 at 15:19, Vladimir Oltean <olteanv@gmail.com> wrote:
>> >> > On Fri, Mar 18, 2022 at 02:10:26PM +0100, Hans Schultz wrote:
>> >> >> In the offloaded case there is no difference between static and dynamic
>> >> >> flags, which I see as a general issue. (The resulting ATU entry is static
>> >> >> in either case.)
>> >> >
>> >> > It _is_ a problem. We had the same problem with the is_local bit.
>> >> > Independently of this series, you can add the dynamic bit to struct
>> >> > switchdev_notifier_fdb_info and make drivers reject it.
>> >> >
>> >> >> These FDB entries are removed when link goes down (soft or hard). The
>> >> >> zero DPV entries that the new code introduces age out after 5 minutes,
>> >> >> while the locked flagged FDB entries are removed by link down (thus the
>> >> >> FDB and the ATU are not in sync in this case).
>> >> >
>> >> > Ok, so don't let them disappear from hardware, refresh them from the
>> >> > driver, since user space and the bridge driver expect that they are
>> >> > still there.
>> >> 
>> >> I have now tested with two extra unmanaged switches (each connected to a
>> >> seperate port on our managed switch, and when migrating from one port to
>> >> another, there is member violations, but as the initial entry ages out,
>> >> a new miss violation occurs and the new port adds the locked entry. In
>> >> this case I only see one locked entry, either on the initial port or
>> >> later on the port the host migrated to (via switch).
>> >> 
>> >> If I refresh the ATU entries indefinitly, then this migration will for
>> >> sure not work, and with the member violation suppressed, it will be
>> >> silent about it.
>> >
>> > Manual says that migrations should trigger miss violations if configured
>> > adequately, is this not the case?
>> >
>> >> So I don't think it is a good idea to refresh the ATU entries
>> >> indefinitely.
>> >> 
>> >> Another issue I see, is that there is a deadlock or similar issue when
>> >> receiving violations and running 'bridge fdb show' (it seemed that
>> >> member violations also caused this, but not sure yet...), as the unit
>> >> freezes, not to return...
>> >
>> > Have you enabled lockdep, debug atomic sleep, detect hung tasks, things
>> > like that?
>> 
>> I have now determined that it is the rtnl_lock() that causes the
>> "deadlock". The doit() in rtnetlink.c is under rtnl_lock() and is what
>> takes care of getting the fdb entries when running 'bridge fdb show'. In
>> principle there should be no problem with this, but I don't know if some
>> interrupt queue is getting jammed as they are blocked from rtnetlink.c?
>
> Sorry, I forgot to respond yesterday to this.
> By any chance do you maybe have an AB/BA lock inversion, where from the
> ATU interrupt handler you do mv88e6xxx_reg_lock() -> rtnl_lock(), while
> from the port_fdb_dump() handler you do rtnl_lock() -> mv88e6xxx_reg_lock()?

If I release the mv88e6xxx_reg_lock() before calling the handler, I need
to get it again for the mv88e6xxx_g1_atu_loadpurge() call at least. But
maybe the vtu_walk also needs the mv88e6xxx_reg_lock()?
I could also just release the mv88e6xxx_reg_lock() before the
call_switchdev_notifiers() call and reacquire it immediately after?
