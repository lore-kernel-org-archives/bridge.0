Return-Path: <baruch@tkos.co.il>
Date: Tue, 1 Nov 2016 21:16:31 +0200
From: Baruch Siach <baruch@tkos.co.il>
Message-ID: <20161101191631.kgignzthax2h5wqv@tarshish>
References: <d60077689fd40b84fade5c23ee2d3b2c0b2cfe98.1477850310.git.baruch@tkos.co.il>
	<CAOaVG14nMiAXkXWG4byqP=o5Z_ToZVsxHrwHHKsBTdA0ZdoLJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOaVG14nMiAXkXWG4byqP=o5Z_ToZVsxHrwHHKsBTdA0ZdoLJA@mail.gmail.com>
Subject: Re: [Bridge] [PATCH v2] libbridge: fix headers conflict with musl
	libc
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: bridge <bridge@lists.linux-foundation.org>

Hi Stephen,

On Tue, Nov 01, 2016 at 11:42:29AM -0600, Stephen Hemminger wrote:
> I understand that musl requires some changes, but copying data is not the
> correct way to handle this. Lots of work went into making Glibc and kernel
> headers compatiable. It looks like MUSL needs to follow the same agreement.

I surely don't get all the relevant details here. A recent discussion with the 
musl libc maintainer, Rich Felker, indicates that part of that compatibility 
work is glibc specific[1], since it depends on __GLIBC__ being defined. Denys 
Vlasenko proposed[2] a different solution. The entire thread is at [3].

[1] http://lists.landley.net/pipermail/aboriginal-landley.net/2015-October/002459.html 
[2] http://lists.landley.net/pipermail/aboriginal-landley.net/2015-October/002469.html 
[3] http://lists.landley.net/pipermail/aboriginal-landley.net/2015-October/thread.html

baruch

> On Sun, Oct 30, 2016 at 11:58 AM, Baruch Siach <baruch@tkos.co.il> wrote:
> > Don't including kernel headers directly to avoid headers conflict like:
> >
> > In file included from .../sysroot/usr/include/linux/if_bridge.h:18:0,
> >                  from libbridge.h:26,
> >                  from libbridge_if.c:26:
> > .../sysroot/usr/include/linux/in6.h:32:8: error: redefinition of ‘struct
> > in6_addr’
> >  struct in6_addr {
> >         ^
> > In file included from libbridge.h:24:0,
> >                  from libbridge_if.c:26:
> > .../sysroot/usr/include/netinet/in.h:23:8: note: originally defined here
> >  struct in6_addr {
> >         ^
> >
> > Instead copy the required linux/if_bridge.h definitions into
> > libbridge_private.h.
> >
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
