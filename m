Return-Path: <menglong8.dong@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S4tBycIgGpMbcu0VMkG4KdXUec3BMb9c9CGZHnWqcbY=;
 b=Uby3FcRKI9yEd+t292wdoGg6qfKgNlGfPsu1x0mVGxqu4Y47S9/9jU5Vxln+Ev3Qhx
 QbyLO4xbXEt4pFY2a6mKUgkwVQd8WgbDmCqx2kIdEjJ02R7HeuRwxSJPlT7xxEDIDXuB
 BWexSWV6ahCPrWKjTIXgATLahYkMiPwplw5+TyHp2UIwyIXwY1U2G6kx/jypkG/dWjJI
 3rXYCOA7tQeqDXObwuVj2T52B7EBFN44hOsCOKfkH06qOtYgOvqf/oqzYihC2vhVVubS
 DDE+VGcMLLIizqcQ+bRTmv8Bc3vRrrV/Ij/sPzOUEo6F3pc2QmtXHDqPP9GtETPHGBy5
 Bodg==
MIME-Version: 1.0
References: <20201102143828.5286-1-menglong8.dong@gmail.com>
 <067c94269abed15f777ac078a216be314c935fd5.camel@nvidia.com>
In-Reply-To: <067c94269abed15f777ac078a216be314c935fd5.camel@nvidia.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 4 Nov 2020 22:14:35 +0800
Message-ID: <CADxym3bWqziz1-rHEZXC10JBgfO0Jc5S9nWEW2s3G09VvWioTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH] net: bridge: disable multicast while delete
	bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: "dong.menglong@zte.com.cn" <dong.menglong@zte.com.cn>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Roopa Prabhu <roopa@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>

Dear Nik,

On Wed, Nov 4, 2020 at 12:26 AM Nikolay Aleksandrov <nikolay@nvidia.com> wrote:
>
> On Mon, 2020-11-02 at 22:38 +0800, Menglong Dong wrote:
> > From: Menglong Dong <dong.menglong@zte.com.cn>
> >
> > This commit seems make no sense, as bridge is destroyed when
> > br_multicast_dev_del is called.
> >
> > In commit b1b9d366028f
> > ("bridge: move bridge multicast cleanup to ndo_uninit"), Xin Long
> > fixed the use-after-free panic in br_multicast_group_expired by
> > moving br_multicast_dev_del to ndo_uninit. However, that patch is
> > not applied to 4.4.X, and the bug exists.
> >
> > Fix that bug by disabling multicast in br_multicast_dev_del for
> > 4.4.X, and there is no harm for other branches.
> >
> > Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
> > ---
> >  net/bridge/br_multicast.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> > index eae898c3cff7..9992fdff2951 100644
> > --- a/net/bridge/br_multicast.c
> > +++ b/net/bridge/br_multicast.c
> > @@ -3369,6 +3369,7 @@ void br_multicast_dev_del(struct net_bridge *br)
> >       hlist_for_each_entry_safe(mp, tmp, &br->mdb_list, mdb_node)
> >               br_multicast_del_mdb_entry(mp);
> >       hlist_move_list(&br->mcast_gc_list, &deleted_head);
> > +     br_opt_toggle(br, BROPT_MULTICAST_ENABLED, false);
> >       spin_unlock_bh(&br->multicast_lock);
> >
> >       br_multicast_gc(&deleted_head);
>
> This doesn't make any sense. It doesn't fix anything.
> If 4.4 has a problem then the relevant patches should get backported to it.
> We don't add random changes to fix older releases.
>
> Cheers,
>  Nik
>
> Nacked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

Thanks for your patient explanation, and I see it now~

Cheers,
Menglong Dong
