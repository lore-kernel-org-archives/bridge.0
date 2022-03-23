Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=87E72TCYXIHs+TxIG+l3uw9PKroKBbtdliBk27X7cqU=;
 b=mZuOPUC1JPNEyLejK7a7msjQdh9oyGwx2iT5PQH8gXq9SYl5RA1ogmBF8TJrWyPBsO
 0d4YI6s3it4uHjEO5v9MjyYDck6aKZ2ASjWnL73UagE8pP5Ber56NrCV2wpa23Vg9d7t
 3jooRkr6m/d/Pu8ModCXLY3UP+ZFHuAk+2Z/MgM1meqKYV80Czohn5b+yeiXqWJKvZf6
 9uuVrJvCLgRvgWwjy7ZyscxLwlxsnSdAHYg9NhSmWVULxmAu1KQhafhnjW78XVw0oF1O
 n6XCZZLLGVcODUjD//HRBnnYjzdRyCklW+S1zt+anW3LanIPnNkF7Qt4qihcAZSBv6uX
 69aw==
Date: Wed, 23 Mar 2022 13:21:16 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220323112116.q6shx2g4r23ungtc@skbuf>
References: <20220317172013.rhjvknre5w7mfmlo@skbuf> <86tubvk24r.fsf@gmail.com>
 <20220318121400.sdc4guu5m4auwoej@skbuf> <86pmmjieyl.fsf@gmail.com>
 <20220318131943.hc7z52beztqlzwfq@skbuf> <86a6dixnd2.fsf@gmail.com>
 <20220322110806.kbdb362jf6pbtqaf@skbuf> <86fsn90ye8.fsf@gmail.com>
 <20220323101643.kum3nuqctunakcfo@skbuf> <864k3p5437.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <864k3p5437.fsf@gmail.com>
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
To: Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, davem@davemloft.net

On Wed, Mar 23, 2022 at 11:57:16AM +0100, Hans Schultz wrote:
> >> >> Another issue I see, is that there is a deadlock or similar issue when
> >> >> receiving violations and running 'bridge fdb show' (it seemed that
> >> >> member violations also caused this, but not sure yet...), as the unit
> >> >> freezes, not to return...
> >> >
> >> > Have you enabled lockdep, debug atomic sleep, detect hung tasks, things
> >> > like that?
> >> 
> >> I have now determined that it is the rtnl_lock() that causes the
> >> "deadlock". The doit() in rtnetlink.c is under rtnl_lock() and is what
> >> takes care of getting the fdb entries when running 'bridge fdb show'. In
> >> principle there should be no problem with this, but I don't know if some
> >> interrupt queue is getting jammed as they are blocked from rtnetlink.c?
> >
> > Sorry, I forgot to respond yesterday to this.
> > By any chance do you maybe have an AB/BA lock inversion, where from the
> > ATU interrupt handler you do mv88e6xxx_reg_lock() -> rtnl_lock(), while
> > from the port_fdb_dump() handler you do rtnl_lock() -> mv88e6xxx_reg_lock()?
> 
> If I release the mv88e6xxx_reg_lock() before calling the handler, I need
> to get it again for the mv88e6xxx_g1_atu_loadpurge() call at least. But
> maybe the vtu_walk also needs the mv88e6xxx_reg_lock()?
> I could also just release the mv88e6xxx_reg_lock() before the
> call_switchdev_notifiers() call and reacquire it immediately after?

The cleanest way to go about this would be to have the call_switchdev_notifiers()
portion of the ATU interrupt handling at the very end of mv88e6xxx_g1_atu_prob_irq_thread_fn(),
with no hardware access needed, and therefore no reg_lock() held.
