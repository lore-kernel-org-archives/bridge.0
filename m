Return-Path: <liuhangbin@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A846E40292
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A7BC640025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682328314; x=1684920314;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=35DRhB75q3wRkebp9DrJb+2dw6nrBa1EQoLcH9Em600=;
 b=BNlwlnuVqgfas/so+5JH2OtAppwOpVA0nv/LhzX7waApxmjwkXkMMACaqFrsKr8PVt
 SLuuW2laKLiaSz4ka3ixztRuwnK5TL+k7M3agtcAHQa0t6ZaVvcX82pfQUPQZQMj7avT
 m7Inxi8adG3ZUVueGfkNz54K1k13bX1230IrX+itNmrOeHzFQAWzf9A19ESD14X3MM9w
 s0JPHVLwHSagHe+ShaZxv7LDLYKZFjlrChKbTYHr+GIJhBnthxZxDJXmOjV4zq4tQcZi
 8TqG2AI2UTNke3z3TgbKer65jqecPvmN42yER8jBrI+c3/gnF9f+YTSIjf0cvD0GNEOz
 wEvw==
Date: Mon, 24 Apr 2023 17:25:08 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
Message-ID: <ZEZK9AkChoOF3Lys@Laptop-X1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] [Question] Any plan to write/update the bridge doc?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>

Hi,

Maybe someone already has asked. The only official Linux bridge document I
got is a very ancient wiki page[1] or the ip link man page[2][3]. As there are
many bridge stp/vlan/multicast paramegers. Should we add a detailed kernel
document about each parameter? The parameter showed in ip link page seems
a little brief.

I'd like to help do this work. But apparently neither my English nor my
understanding of the code is good enough. Anyway, if you want, I can help
write a draft version first and you (bridge maintainers) keep working on this.

[1] https://wiki.linuxfoundation.org/networking/bridge
[2] https://man7.org/linux/man-pages/man8/bridge.8.html
[3] https://man7.org/linux/man-pages/man8/ip-link.8.html

Thanks
Hangbin
