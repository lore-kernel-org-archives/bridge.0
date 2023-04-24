Return-Path: <kuba@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A9FA0410E5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8DCA340973
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682371681;
 bh=TbcvORIahzTgLz3kHT93WfnWCDehULA/wN2t4cFpWu0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=fKCN800jVi4eb9DDyPNBVyG1nVaxWg8SobzwUe9FY691TiFhtJm9hkMxHEOwlgTZU
 35O9gfDi7RRePr3N4hRuha7B/lmVQcNLeuptx760LJpoegnA5n6pK5fP1I4pCK2aBo
 QNIxAZtIcbS3y+HLydEkj0I1KxVtezePqGZBStrLJMlN6BS1b0aXb84pfim3R5eiUO
 +XElV9jbuHXzvV4LDKB7de7f23Cz5bGWIq3BhwbtEYfrfoFfyXPv31ex57QzA7RD+e
 HNxFZ+iVjRRdY8iJ7yao0pi4NhQh1IbP/2X7jdCxhPw+LhhSzn3afLHGu1XXrHVU97
 5972nIC3ZEwdQ==
Date: Mon, 24 Apr 2023 14:28:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20230424142800.3d519650@kernel.org>
In-Reply-To: <ZEZK9AkChoOF3Lys@Laptop-X1>
References: <ZEZK9AkChoOF3Lys@Laptop-X1>
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: bridge@lists.linux-foundation.org, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>

On Mon, 24 Apr 2023 17:25:08 +0800 Hangbin Liu wrote:
> Maybe someone already has asked. The only official Linux bridge document I
> got is a very ancient wiki page[1] or the ip link man page[2][3]. As there are
> many bridge stp/vlan/multicast paramegers. Should we add a detailed kernel
> document about each parameter? The parameter showed in ip link page seems
> a little brief.
> 
> I'd like to help do this work. But apparently neither my English nor my
> understanding of the code is good enough. Anyway, if you want, I can help
> write a draft version first and you (bridge maintainers) keep working on this.
> 
> [1] https://wiki.linuxfoundation.org/networking/bridge
> [2] https://man7.org/linux/man-pages/man8/bridge.8.html
> [3] https://man7.org/linux/man-pages/man8/ip-link.8.html

Sounds like we have 2 votes for the CLI man pages but I'd like to
register a vote for in-kernel documentation.

I work at a large company so my perspective may differ but from what 
I see:

 - users who want to call the kernel API should not have to look at 
   the CLI's man
 - man pages use archaic and arcane markup, I'd like to know how many
   people actually know how it works and how many copy / paste / look;
   ReST is prevalent, simple and commonly understood
 - in-kernel docs are rendered on the web as soon as they hit linux-next
 - we can make sure documentation is provided with the kernel changes,
   in an ideal world it doesn't matter but in practice the CLI support
   may never happen (no to mention that iproute does not hold all CLI)

Obviously if Stephen and Ido prefer to document the bridge CLI that's
perfectly fine, it's their call :) For new sections of uAPI, however,
I personally find in-kernel docs superior.
