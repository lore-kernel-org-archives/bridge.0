Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D5fcBmctUqkWRaCAlEquaCo151xfdRO5uLvWNbrg/T4=;
 b=lneLGurgH4ESLltEQrI6RKR+MKIH5cMowieW6nb3PawBpUTe8dVgXXy8oMVUK4D+zC
 61WQaa5yJ1WzosFIDyQOD1CeZNhfkijfHCaT6mJAdif+JAeN342vfOojjhY8ewmYPOzq
 I4kosKQDArhuQ2/XphencidtJupidiJX+nZ5H6E7oaqCqRewZQ3U+4o3EzmxXdA3Rr7j
 4qmsbilXgqZ0HMl8Ur1ZL0mPzVIuxqRV1viDITxeKOkGQl11bsqz6AevPORWx6Bp15Vr
 TjnOlBl9Mn2pzwKcOnHs6/3+0411yKC2rOwo5wP78mP9XfNzXPI6N131Rmc32t+nTZth
 gmeg==
MIME-Version: 1.0
References: <20200623090541.2964760-1-horatiu.vultur@microchip.com>
 <20200623.143821.491798381160245817.davem@davemloft.net>
 <20200624113156.hsutqewk4xntmkld@soft-dev3.localdomain>
In-Reply-To: <20200624113156.hsutqewk4xntmkld@soft-dev3.localdomain>
From: Vladimir Oltean <olteanv@gmail.com>
Date: Wed, 24 Jun 2020 18:24:07 +0300
Message-ID: <CA+h21hogZsJZUksYY66_=-qkdG3kDA+byfX0tV=C-80M6mfYMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH net v2 0/2] bridge: mrp: Update MRP_PORT_ROLE
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, lkml <linux-kernel@vger.kernel.org>, Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>, Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>

Hi Horatiu,

On Wed, 24 Jun 2020 at 14:34, Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:
>
> The 06/23/2020 14:38, David Miller wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > From: Horatiu Vultur <horatiu.vultur@microchip.com>
> > Date: Tue, 23 Jun 2020 11:05:39 +0200
> >
> > > This patch series does the following:
> > > - fixes the enum br_mrp_port_role_type. It removes the port role none(0x2)
> > >   because this is in conflict with the standard. The standard defines the
> > >   interconnect port role as value 0x2.
> > > - adds checks regarding current defined port roles: primary(0x0) and
> > >   secondary(0x1).
> > >
> > > v2:
> > >  - add the validation code when setting the port role.
> >
> > Series applied, thank you.
>
> Thanks. Will these patches be applied also on net-next?
> Because if I start now to add support for the interconnect port, these
> patches are needed on net-next. Or do I need to add these patches to the
> patch series for the interconnect port?
> What is the correct way of doing this?
>
> --
> /Horatiu

The "net" tree is merged weekly (or so) by David into "net-next". So,
your patches should be available at the beginning of the next week.

Cheers,
-Vladimir
