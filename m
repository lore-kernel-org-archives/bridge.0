Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9248281E52
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D63FD820D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5Dk9oRwWoL6Eq4hgVuGxNfkU9whS5cyWy9FWflgjKWo=;
 b=DG1clRKvCrEsxzYopyxVfqz2ynaSB/i1pW0NcbwP3OAdNhXVEJBaj4gx/tQSEmgHpl
 76moVpcYec8yFX1LV4rOvEsz9PETyE5mVX+9Qfdaso+TUbbEP0HxVtJEpnq8KPGl9NOC
 QEw02HPDpGimTv+kvKl66aMPl4CjCHxgGRsBIi50aaGBp2NGecisznzAQOuum56XL7Ls
 AYWQn+ynEM4UMCwrtbZXZRB/eD2rj/HIBxVev5SU36+prdEOum482fLhkCt4dxhshmRK
 WJY2A+eO7GNipQfBVGUzmwg6pfKEhxF0DdU6ERR+W0+X0VGZbH3BC5xTLo1OqznX15jf
 3/Hw==
Message-ID: <a8d81917-c021-deb1-4121-927859d47da5@blackwall.org>
Date: Fri, 3 Feb 2023 11:02:37 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1675359453.git.petrm@nvidia.com>
 <ea90ca36a55f0ec3e0f1a20418f4c9e685a7a8ab.1675359453.git.petrm@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ea90ca36a55f0ec3e0f1a20418f4c9e685a7a8ab.1675359453.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 16/16] selftests: forwarding:
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

On 02/02/2023 19:59, Petr Machata wrote:
> Add a suite covering mcast_n_groups and mcast_max_groups bridge features.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     - Adjust the tests that check setting max below n and
>       reset of max on VLAN snooping enablement
>     - Make test naming uniform
>     - Enable testing of control path (IGMP/MLD) in
>       mcast_vlan_snooping bridge
>     - Reorganize the code so that test instances (per bridge
>       type and configuration type) always come right after
>       the test, in order of {d,q,qvs}{4,6}{cfg,ctl}.
>       Then groups of selftests are at the end of the file.
>       Similarly adjust invocation order of the tests.
> 
>  .../testing/selftests/net/forwarding/Makefile |    1 +
>  .../net/forwarding/bridge_mdb_max.sh          | 1336 +++++++++++++++++
>  2 files changed, 1337 insertions(+)
>  create mode 100755 tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


