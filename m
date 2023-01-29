Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96B5E60D68
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3E33360C1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YyZWoCWCuhaAegyJlnJA2n0EhH8BXV78ivTv80i7qUw=;
 b=CY12R16J+6I+jZG/tz3yrqkXZ/R0wQIgZOY+pFvr3txbAGDFftuli6eu0AA8cqi3Sz
 ThrDY7xLGZOu2qCTIQ60FCT/cyzC9IQHBUymuGI/OClE9xMNzwP1tIu4vMcqT3S8zzNb
 cU9+E/Bb8a0SouB9ndb6NQnvJjNWttkPNvH3LrUmzz05tOEkruSVlxauCOQp+3Wa/yTb
 TJ0usyImkssNaezwq4+KBi64Z5nC1r5VG0gPpc5YO51jMq24SdFVs9TG80sDb13JlFW5
 gDWgaLxVfF/XgO0Y9qZqMaTi6XepKRNB05OjU46vZgzLJ6/ekzm+V0czxVWOkyXPA4Ve
 w5EQ==
Message-ID: <c937fe7a-7b63-9b09-7714-3a3536899007@blackwall.org>
Date: Sun, 29 Jan 2023 12:10:53 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1674752051.git.petrm@nvidia.com>
 <a2a17da9f91c3648fbcbc2890c961c9a9b70d61d.1674752051.git.petrm@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <a2a17da9f91c3648fbcbc2890c961c9a9b70d61d.1674752051.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 13/16] selftests: forwarding: lib:
 Parameterize IGMPv3/MLDv2 generation
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
> In order to generate IGMPv3 and MLDv2 packets on the fly, the
> functions that generate these packets need to be able to generate
> packets for different groups and different sources. Generating MLDv2
> packets further needs the source address of the packet for purposes of
> checksum calculation. Add the necessary parameters, and generate the
> payload accordingly by dispatching to helpers added in the previous
> patches.
> 
> Adjust the sole client, bridge_mdb.sh, as well.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  .../selftests/net/forwarding/bridge_mdb.sh    |  9 ++---
>  tools/testing/selftests/net/forwarding/lib.sh | 36 +++++++++++++------
>  2 files changed, 31 insertions(+), 14 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


