Return-Path: <liuhangbin@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 16066600B8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0ADC160035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682395100; x=1684987100;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aj/TYDUJRlrqPOA0+J0bQEIspJpBt9nW1sYPtelJAvQ=;
 b=Th15uvckqAatnYxVOPiD4IGUahLD40jdeFM9kN0v99oMmRdan/fLbY+gJ5Ou4v0yrS
 11irrM2uiCBdXKvAPDZllZNBGk82tmVLuFPQLN8+GXJSUUPARshgTemtOtdsIvLDwA95
 JF2bUzC3y9Epvg2auNz06xI0NPW2qxALOcw7O1tDKnj0QEojJXVi4vxXbfWBdkFTncLJ
 JoHZbzn4pj5dvDePjhmvPrpke+asK9YpBMfw/8OJ8cKP+iZ1V+U66Tjs7FNuB4lOHvfK
 Y6f1MBGXy4iDZhFKm7RZhrEhCuLv4YcLVHnwjKdZzo67nwVhDKlYJtB1ridyJBBr0XVQ
 kT0w==
Date: Tue, 25 Apr 2023 11:58:14 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
Message-ID: <ZEdP1tSiGAgvy7s8@Laptop-X1>
References: <ZEZK9AkChoOF3Lys@Laptop-X1> <20230424142800.3d519650@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424142800.3d519650@kernel.org>
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
Cc: bridge@lists.linux-foundation.org, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>

On Mon, Apr 24, 2023 at 02:28:00PM -0700, Jakub Kicinski wrote:
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
>  - man pages use archaic and arcane markup, I'd like to know how many
>    people actually know how it works and how many copy / paste / look;
>    ReST is prevalent, simple and commonly understood

+1 for the obscure man page syntax. I can only do copy/paste when update it..

>  - in-kernel docs are rendered on the web as soon as they hit linux-next
>  - we can make sure documentation is provided with the kernel changes,
>    in an ideal world it doesn't matter but in practice the CLI support
>    may never happen (no to mention that iproute does not hold all CLI)

Yes. I saw bpf code add the doc in the header file (include/uapi/linux/bpf.h)
and generate to syscall page[1] or man page[2] directly. Another example is the
statistics.rst document, which takes *struct rtnl_link_stats64* description
drectly from the if_link.h. This should save a lot works to maintain another
file in Documentation. Maybe we can strive in this direction?

For example, we can just add descriptions for the enum in if_bridge.h and
if_link.h when add new features.
> 
> Obviously if Stephen and Ido prefer to document the bridge CLI that's
> perfectly fine, it's their call :) For new sections of uAPI, however,
> I personally find in-kernel docs superior.

I understand the hard work to maintain docs in 3 different places with
different syntax (ip-link, bridge, in-kernel). Since we will sync the uapi
headers from kernel to iproute2. Can we use the similar way like kernel does
in iproute2. i.e. Link the header file's description in a document and
convert it to man page via rst2man? With this way we only need to maintain
the doc in 1 place, the kernel uapi headers.

NOTE: there may still need some adjustment in the iproute2 man page when add
new arguments.

[1] https://docs.kernel.org/userspace-api/ebpf/syscall.html
[2] https://man7.org/linux/man-pages/man7/bpf-helpers.7.html
[3] https://docs.kernel.org/networking/statistics.html

Thanks
Hangbin
