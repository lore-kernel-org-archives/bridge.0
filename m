Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8549E41746
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B0C474174B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5DqoWeFdaAExcw/eTh3jUffnj1IxKEYPwBICHQibxi8=;
 b=yyGO3uOFwSeFl/0LFIhGivE9cySVh+QDLHFOBbpJshQh5NA0e5WOKnvYvZbylAdteH
 tqGbfkoQWqfGnv/PTsCvuvYqcxstsUD9jAtWmv2szRrVBHY38RPHDDPaVVT413idzNmG
 NV4Z1bzdDPbfRPZs/v0KeejcJY98o+hy23QjH+tsgDJnHL6ChUK26dEraYjebl4eYsVT
 qVHXLe5j/WosansRRAhQBQvfBlfJbpXBKkuwBi1sPohePvbk3cZTlssXX7mnOvm+s8Wn
 lc9Z+O4hmCElPya/llp7PWaDZ5XlIJVzTTt2rGYknFZUcxJ3Lye4zRdT3KXhy+16ILFk
 3MKA==
Message-ID: <5101f3bc-fc14-b306-15a2-37b66661ba88@blackwall.org>
Date: Sun, 29 Jan 2023 11:11:13 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1674752051.git.petrm@nvidia.com>
 <9d183b709841456456c8a541a963eeb1f6ee2d1f.1674752051.git.petrm@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <9d183b709841456456c8a541a963eeb1f6ee2d1f.1674752051.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 05/16] net: bridge: Change a cleanup
 in br_multicast_new_port_group() to goto
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
> This function is getting more to clean up in the following patches.
> Structuring the cleanups in one labeled block will allow reusing the same
> cleanup from several places.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_multicast.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


