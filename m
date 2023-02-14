Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A104C81E05
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E19E38137C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fpl2dYq09X1UimTogkpAO+pdBXIqBUdMeEeTg/7qSas=;
 b=Bg8GgDZY7kilURoRNLSzE7rxV3xwzXlJM55ZH1SFuchlelKg4/Oo2ByXZyYFUPpDax
 9Ju6E4HG3M6A+SBoj3mm1DCi5h38nSAxOxQcIVBUwkmszC1uj9DadSmk/AAGVd6B8zHk
 t70bGTz4hL1S82MoXdc7UpQsOOYDwEqKNbgvLD8Gkrc3zlxaNyieJY/tptgdf4lMKfOl
 qSHK0ls61o9vzdtYW4RmuFjluOFGVvl3IdigDrnZjuTxDTmdggijPGCfNzfpczqepD4a
 cz0HmuE6HZUh2La1hs25nVI/K16REIw7eMbVnw6HRdGInSwspQCzAqTkwMCniqKUK1G8
 jZYA==
Message-ID: <0a255859-9ec1-c808-d7d5-3500a6c49386@blackwall.org>
Date: Tue, 14 Feb 2023 10:40:52 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230211-kobj_type-net-v2-0-013b59e59bf3@weissschuh.net>
 <20230211-kobj_type-net-v2-1-013b59e59bf3@weissschuh.net>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230211-kobj_type-net-v2-1-013b59e59bf3@weissschuh.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next v2 1/2] net: bridge: make kobj_type
 structure constant
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

On 14/02/2023 06:23, Thomas Weißschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definition to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  net/bridge/br_if.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
> index ad13b48e3e08..24f01ff113f0 100644
> --- a/net/bridge/br_if.c
> +++ b/net/bridge/br_if.c
> @@ -269,7 +269,7 @@ static void brport_get_ownership(const struct kobject *kobj, kuid_t *uid, kgid_t
>  	net_ns_get_ownership(dev_net(p->dev), uid, gid);
>  }
>  
> -static struct kobj_type brport_ktype = {
> +static const struct kobj_type brport_ktype = {
>  #ifdef CONFIG_SYSFS
>  	.sysfs_ops = &brport_sysfs_ops,
>  #endif
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

