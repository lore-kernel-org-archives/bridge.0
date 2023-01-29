Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CAFEB4012D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3130D400EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/RrG8+2GzDsOsAIBF6eDzsvs9rII5iqkY1XaHqvkNRg=;
 b=slB4v7GfVVCDKkd+LJ+iBUuWRbUMJzf+9V/umfjvfn8r/EK/HE2dtoLYOvczDJl4AT
 W2alqhgdM1dfXBd8EDCgdSKkUtWcv9QNOpf9Mn1pi2wiJ3uUbb1GPB6cmNv2cXq3bYy/
 Co+Emm+vLCcV4V+j16kQd6sGcpP2nuSN2lZJ7x1PY1kw5OjkaNeOzCeYnPP25Q/H1bgR
 /X54LttEtS0bqwqhNFPHV8vjcX/MZzHAeZRPGahxKaun4MgZvgFJZ5bG8+xsl0eWUOsj
 cBphYCbGP72AcAAcDYcV/FAviHdfUzdU6Yv3yF/VqDrzH3WaQ6/6RCt55+9H98Y193Dd
 vVXQ==
Message-ID: <d4190cd6-f90f-ac51-1c1e-ddd0880e932c@blackwall.org>
Date: Sun, 29 Jan 2023 11:11:10 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1674752051.git.petrm@nvidia.com>
 <982c17c28b513bd3e6dd670fa2db13ec76bc4460.1674752051.git.petrm@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <982c17c28b513bd3e6dd670fa2db13ec76bc4460.1674752051.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 04/16] net: bridge: Add
 br_multicast_del_port_group()
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
> Since cleaning up the effects of br_multicast_new_port_group() just
> consists of delisting and freeing the memory, the function
> br_mdb_add_group_star_g() inlines the corresponding code. In the following
> patches, number of per-port and per-port-VLAN MDB entries is going to be
> maintained, and that counter will have to be updated. Because that logic
> is going to be hidden in the br_multicast module, introduce a new hook
> intended to again remove a newly-created group.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_mdb.c       |  3 +--
>  net/bridge/br_multicast.c | 11 +++++++++++
>  net/bridge/br_private.h   |  1 +
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


