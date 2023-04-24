Return-Path: <stephen@networkplumber.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C0BF780D18
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5BD6880BD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1682374108;
 x=1684966108; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zh/fMVXEy/p80NSjVlrYa0mXRDr2h0FO6hsq5CtXg2M=;
 b=U8WDTr5sOlNki+xImOiBT+SbmEbKLNcSJOjygVaEWZeUJGOtSuCtLZFnT6TR90jW8a
 DVF7QEGW32zuyR4Nw7uVKP5H+pN9+Xv18FvnKNRBsae31njlZgMot10OOi3m2++3CTqM
 AdnixvthVDI9MRyeGYNgsF5nu4rPJKaqCb1Ph5PP7Kfeh5creb47rVyuzZOx+qvY2fZj
 N8zrbQJXWFM5IV3lG1c03Asowtpoqxm/iMXbsa0p55ciJJ4m/D0bkvZkRpTai5C5nEBt
 OOibxE3Yk7B67mpoZPvrpQyIahwcvWbv8mmvZz/bO+nBPLXpnKm8E/3OiCsEdFxGVmZR
 kz9A==
Date: Mon, 24 Apr 2023 15:08:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20230424150825.051f4b4a@hermes.local>
In-Reply-To: <20230424142800.3d519650@kernel.org>
References: <ZEZK9AkChoOF3Lys@Laptop-X1> <20230424142800.3d519650@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [Question] Any plan to write/update the bridge doc?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>, Roopa Prabhu <roopa@nvidia.com>

On Mon, 24 Apr 2023 14:28:00 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 24 Apr 2023 17:25:08 +0800 Hangbin Liu wrote:
> > Maybe someone already has asked. The only official Linux bridge document I
> > got is a very ancient wiki page[1] or the ip link man page[2][3]. As there are
> > many bridge stp/vlan/multicast paramegers. Should we add a detailed kernel
> > document about each parameter? The parameter showed in ip link page seems
> > a little brief.
> > 
> > I'd like to help do this work. But apparently neither my English nor my
> > understanding of the code is good enough. Anyway, if you want, I can help
> > write a draft version first and you (bridge maintainers) keep working on this.
> > 
> > [1] https://wiki.linuxfoundation.org/networking/bridge
> > [2] https://man7.org/linux/man-pages/man8/bridge.8.html
> > [3] https://man7.org/linux/man-pages/man8/ip-link.8.html  
> 
> Sounds like we have 2 votes for the CLI man pages but I'd like to
> register a vote for in-kernel documentation.
> 
> I work at a large company so my perspective may differ but from what 
> I see:
> 
>  - users who want to call the kernel API should not have to look at 
>    the CLI's man

Internal Kernel API's are not stable. So documentation is only the auto
generated kernel docs.

There is an effort to cover netlink API's with YAML. Bridge could/should
be part of that.

>  - man pages use archaic and arcane markup, I'd like to know how many
>    people actually know how it works and how many copy / paste / look;
>    ReST is prevalent, simple and commonly understood

Yes, but that is what distributions want.

>  - in-kernel docs are rendered on the web as soon as they hit linux-next
>  - we can make sure documentation is provided with the kernel changes,
>    in an ideal world it doesn't matter but in practice the CLI support
>    may never happen (no to mention that iproute does not hold all CLI)
> 
> Obviously if Stephen and Ido prefer to document the bridge CLI that's
> perfectly fine, it's their call :) For new sections of uAPI, however,
> I personally find in-kernel docs superior.


The in-kernel documents usually only cover the architecture and motivation.
What/why/how... Not the user visible public API's.

