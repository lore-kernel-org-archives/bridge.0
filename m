Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0DE2860E78
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5ACF160E72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KkhJszckOgi9i3ykTlFdmdnbfURMFjaDRKTo2ouL/8I=;
 b=KQXdpTO2l7eflMDTxAo+OqiIZRIGgjFFrJno0xVwoM6PhpKu+vMsdsibjIlsLOmwNw
 iLrmb2UnWHBAQwLRemvpmJHK5kdP99o8HNaTeuY2NHjfRueldoCDuqIj8stOiiwTlyzE
 DYVRkAumts29JRRiOm1A1wGQwYkLAJ+F0sWPvKrOK3JyIGXhidPCgW+zQ+fcCWZaSXiC
 CLBgAtaBYxcK/Jl9Ol1nOt4bpu949Ek31+R0lO7fk1uoavkAB9pL+lJ5pIV04QwNyare
 Ed321hNXlsq2KYWQF/6TI6thPnWMJvoNF7yNcQtMu6W3Qtg/1R+OJzp2IhanG9YXymcc
 ugYw==
Message-ID: <3e057185-b978-efa8-b2cd-c53e65796d3e@blackwall.org>
Date: Sun, 29 Jan 2023 11:09:58 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1674752051.git.petrm@nvidia.com>
 <16e6b1f664e053bd5c057b7c5b0bd23e3d7652f9.1674752051.git.petrm@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <16e6b1f664e053bd5c057b7c5b0bd23e3d7652f9.1674752051.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 03/16] net: bridge: Move
 extack-setting to br_multicast_new_port_group()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org

On 26/01/2023 19:01, Petr Machata wrote:
> Now that br_multicast_new_port_group() takes an extack argument, move
> setting the extack there. The downside is that the error messages end
> up being less specific (the function cannot distinguish between (S,G)
> and (*,G) groups). However, the alternative is to check in the caller
> whether the callee set the extack, and if it didn't, set it. But that
> is only done when the callee is not exactly known. (E.g. in case of a
> notifier invocation.)
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_mdb.c       | 9 +++------
>  net/bridge/br_multicast.c | 5 ++++-
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


