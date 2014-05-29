Return-Path: <pneira@us.es>
Date: Thu, 29 May 2014 11:00:32 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20140529090032.GA14999@localhost>
References: <20140527083359.GA4342@localhost>
	<CAHo-OoxDb6rREH1kZNKSGWzVL6pwwuzgEgYbHWA-NAUX9fRJqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHo-OoxDb6rREH1kZNKSGWzVL6pwwuzgEgYbHWA-NAUX9fRJqg@mail.gmail.com>
Subject: Re: [Bridge] [HEADS UP] Migrating ebtables and arptables to
	netfilter.org
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc: bridge@lists.linux-foundation.org, "netfilter@vger.kernel.org" <netfilter@vger.kernel.org>, Netfilter Development Mailinglist <netfilter-devel@vger.kernel.org>, Bart De Schuymer <bdschuym@pandora.be>

On Thu, May 29, 2014 at 01:37:43AM -0700, Maciej Żenczykowski wrote:
> Missing tags if there were any previously.

It seems there is no tags, according to what I see in
ebtables.old-history which is a copy of the original tree.

BTW, please, stop top posting.

These are the mailing list rules:

http://www.netfilter.org/mailinglists.html#list-rules

Thank you.

> On Tue, May 27, 2014 at 1:33 AM, Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > Hi!
> >
> > We're migrating arptables and ebtables to git.netfilter.org. The new
> > location for the repositories are:
> >
> > 1) arptables:
> >
> >         git://git.netfilter.org/arptables
> >         http://git.netfilter.org/arptables/
> >
> > 2) ebtables:
> >
> >         git://git.netfilter.org/ebtables
> >         http://git.netfilter.org/ebtables/
> >
> > Originally, these two applications were located in the same repository
> > which has been kept at:
> >
> >         http://git.netfilter.org/ebtables.old-history/
> >
> > just for the record.
> >
> > I have git-filter-branch the original repository to separate the
> > ebtables and the arptables in two independent repositories.
> >
> > Let me know if you experience any problem in this migration,
> > Thanks.
> > --
> > To unsubscribe from this list: send the line "unsubscribe netfilter-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
