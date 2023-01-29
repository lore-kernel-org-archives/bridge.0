Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2FA6E8146B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F2418146A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4573WNrB5FF9KwFCy2MksCXmBgaLnWObBAuKFtrdwIo=;
 b=3Rm/xLsmR+ZsqU2licFREtxpDXVf4RkBEpthTk0ryZYfOrooi4j/eSOMdZ+sfvvr3w
 rKTacinZoadKM1PSA6WWWU9GTe+5ckkpopkFhZmwdn0o2TO6Vd+lX9xQVHzSujzCqgpZ
 vLrhwtPqhTtM0BLS2fUAHx7F88LFQr1sxZasR0qNehko8VJ/au9lg7Yke5dFdhka6RBO
 nbE2VxjuMPd7/RUU2rljrBQJ+pSfMrDuNTrMdeaJCE05/9iGQg4JxZqHS0JxQplKLr5/
 WDcT+JTvJ+JaC+ltsJsDHTNqJRDz9C3q/VD4ddkxI3G6es12RkYaG2SSzp0NIJK5xmmV
 pPYQ==
Message-ID: <e38b1c50-2e6a-b2b4-47d0-3ebc707b56a3@blackwall.org>
Date: Sun, 29 Jan 2023 12:12:48 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1674752051.git.petrm@nvidia.com>
 <b3e7988954d5db878b8e2c97638646b25ab0350c.1674752051.git.petrm@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <b3e7988954d5db878b8e2c97638646b25ab0350c.1674752051.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 16/16] selftests: forwarding:
 bridge_mdb_max: Add a new selftest
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
> Add a suite covering mcast_n_groups and mcast_max_groups bridge features.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  .../testing/selftests/net/forwarding/Makefile |   1 +
>  .../net/forwarding/bridge_mdb_max.sh          | 970 ++++++++++++++++++
>  2 files changed, 971 insertions(+)
>  create mode 100755 tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
> 

Nice test coverage!
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

