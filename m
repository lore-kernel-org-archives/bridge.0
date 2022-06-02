Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l8W+7tcFTmWgcZkmqtvEAURZZKd0U2SDl09JGSg/xJY=;
 b=EqF2c9DqGwXxEBxvnMScQ+ELXNccLj4Uv/g2mPawAj6APVYuwRlURI25YdBdFtNhb2
 hm5s4r8nxVxYtjk7B4r8ZAQ4vzbuC2C1ydfNdoH5WwtOfWly2jlVVtP9j8BfvaCSs1zY
 nqmTz20aaOy0p3CIvz4sk1WFXq5uP46hqsPKSW8g/jpwQ3zA1fVMgwKOmTVsQKYqRUoz
 R6xSU+xTqa6fVeRBfNS8XUZ1bYaAXHpbc8DlW9jiaEO+GeOPURDfDYYBl0TOUayMWdkn
 TdY+VKI1tfIWc9GfRq+WeG2qxLiGye2M4PXQ7ChXlB00w0wKbPA2c1U4iANB/s/HIAbj
 C0+Q==
MIME-Version: 1.0
References: <86sfov2w8k.fsf@gmail.com> <YpCgxtJf9Qe7fTFd@shredder>
 <86sfoqgi5e.fsf@gmail.com> <YpYk4EIeH6sdRl+1@shredder>
 <86y1yfzap3.fsf@gmail.com>
 <d88b6090-2ac8-0664-0e38-bb2860be7f6e@blackwall.org>
 <86sfonjroi.fsf@gmail.com>
 <3d93d46d-c484-da0a-c12c-80e83eba31c9@blackwall.org>
 <YpiTbOsh0HBMwiTE@shredder>
 <86mtevjmie.fsf@gmail.com> <YpiqlziXDCg/1FJH@shredder>
In-Reply-To: <YpiqlziXDCg/1FJH@shredder>
From: Hans S <schultz.hans@gmail.com>
Date: Thu, 2 Jun 2022 15:27:19 +0200
Message-ID: <CAKUejP5NiPYre8qAJKqJ0SOxQ_DtXHt6q6ze6gr=Xx6VGc8xsA@mail.gmail.com>
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
To: Ido Schimmel <idosch@nvidia.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@idosch.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>

Yes, that sounds much like the case. So the replace of course just
modifies the SW fdb entry, and then it just uses port_fdb_add() to
replace HW entry I assume, which then in my case triggers
SWITCHDEV_FDB_DEL_TO_BRIDGE as the locked entry is removed.
So I should not send the SWITCHDEV_FDB_DEL_TO_BRIDGE message when
removing the locked entry from port_fdb_add() function...

(note: having problems with smtp.gmail.com...)


On Thu, Jun 2, 2022 at 2:18 PM Ido Schimmel <idosch@nvidia.com> wrote:
>
> On Thu, Jun 02, 2022 at 02:08:41PM +0200, Hans Schultz wrote:
> > >
> > > I think Hans is testing with mv88e6xxx which dumps entries directly from
> > > HW via ndo_fdb_dump(). See dsa_slave_port_fdb_do_dump() which sets
> > > NTF_SELF.
> > >
> > > Hans, are you seeing the entry twice? Once with 'master' and once with
> > > 'self'?
> > >
> >
> > When replacing a locked entry it looks like this:
> >
> > # bridge fdb show dev eth6 | grep 4c
> > 00:4c:4c:4c:4c:4c vlan 1 master br0 extern_learn offload locked
> >
> > # bridge fdb replace 00:4c:4c:4c:4c:4c dev eth6 vlan 1 master static ; bridge fdb show dev eth6 | grep 4c
> > 00:4c:4c:4c:4c:4c vlan 1 self static
>
> This output means that the FDB entry was deleted from the bridge driver
> FDB.
>
> >
> > The problem is then that the function
> > br_fdb_find_rcu(br,eth_hdr(skb)->h_source, vid);
> > , where the h_source and vid is the entry above, does not find the entry.
> > My hypothesis was then that this is because of the 'self' flag that I
> > see.
>
> br_fdb_find_rcu() does a lookup in the bridge driver FDB, but per the
> output above, the entry isn't there for some reason. It's only in HW.
>
> Can it be that you driver is deleting these entries from the bridge
> driver FDB via SWITCHDEV_FDB_DEL_TO_BRIDGE for some reason?
>
> >
> > I am thinking that the function dsa_slave_port_fdb_do_dump() is only for
> > debug, and thus does not really set any flags in the bridge modules FDB,
> > but then I don't understand why the above find function does not find
> > the entry?
